%
% brownletter.cls -- a document class for writing letters with Brown letterhead 
%
% Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)
%
% Notes:
%
% 1. This class can be used for creating letters with Brown logo at the
%    header and CS department address at the footer (as in standard Brown
%    letterhead stationery).
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If Brown logo is to be included in the head, then the file
%    brownlogo.eps must be provided. Otherwise, the logo is omitted.
% 5. For example usage, please see brownletter_example.tex
% 
% Please contact tatbul@cs.brown.edu to report any problems or bugs.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{brownletter}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\DeclareGraphicsExtensions{.eps}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Ref}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0 in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{2}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{2}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{2}

\newsavebox{\departmenthead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

\savebox{\departmenthead}{\ixcmrmn
 	\includegraphics[scale=0.20]{LP-School-Of-AI-black.png}
}

\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
    \includegraphics[scale=0.07]{LP-School-Of-AI-black.png} 
    ~bit.ly/LaPazSchoolOfAI
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{2 cm}
    \setlength{\headsep}{2 cm}
    \renewcommand{\@oddhead}{}
    \renewcommand{\@oddfoot}{\usebox{\emptyfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{\usebox{\emptyfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        {\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            \@date 
            \end{tabular}\par
        }%
     \fi
     {\raggedright \toname \\ \toaddress \par}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.02\textwidth}\parbox{0.98\textwidth}{\raggedright
    \ignorespaces #1\\[1\medskipamount]%
    \vspace{2 cm}
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}