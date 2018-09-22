%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	by: Ehsan Emamjomeh-Zadeh
%%	http://www-scf.usc.edu/~emamjome/
%%
%%	Contact information:
%%		emamjome[at]usc[dot]edu
%%		ehsan7069[at]gmail[dot]com
%%
%%	current version: 3.2
%%	last update: Nov. 30, 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% (originally developed by Miklos Csuros)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	HELP:
%%
%%		* In each category,
%%		you could itemize using the followings:
%%			\itemBold[1]
%%			\itemEmph[1]
%%			\itemBullet
%%			\itemNoBullet
%%		Warning:
%%		Don't use different types of items
%%		in one category!
%%
%%		* Use the following commands
%%		to name the months:
%%			\January, \February, \March,
%%			\April, \May, \June,
%%			\July, \August, \September,
%%			\October, \November, \December.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\ProvidesClass{resume}[2015/07/31 resume]
\NeedsTeXFormat{LaTeX2e}
\LoadClass{article}

\RequirePackage{ifthen}
\RequirePackage{xspace}
\RequirePackage{datetime}
\RequirePackage[orig, american, cleanlook]{isodate}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{url} \urlstyle{rm}
\RequirePackage{tikz} \usetikzlibrary{calc}

\newlength{\pushNameDown}
\newlength{\spaceAfterContactInfo}
\newlength{\spaceBetweenCategories}
\newlength{\spaceBetweenItems}
\newlength{\marginBeforeBullets}
\newlength{\categorySeparatorMargin}
\newlength{\categorySeparatorHeight}
\newlength{\categorySeparatorWidth}

\setlength{\textheight}{\paperheight}
\setlength{\textwidth}{\paperwidth}
\addtolength{\textwidth}{-.75\oddsidemargin}
\addtolength{\textwidth}{\marginparwidth}
\addtolength{\textwidth}{\marginparsep}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%	Feel free to modify the lengths
%%	(margins, etc.)
%%	specified here.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\addtolength{\textheight}{-60mm}
\setlength{\pushNameDown}{-10mm}
\setlength{\spaceAfterContactInfo}{-4mm}

\addtolength{\textwidth}{-75mm}

\setlength{\topmargin}{-10mm}
\setlength{\oddsidemargin}{20mm}
\setlength{\evensidemargin}{\oddsidemargin}

\setlength{\marginparsep}{5mm}
\setlength{\marginparwidth}{30mm}
\addtolength{\marginparwidth}{-\marginparsep}

\setlength{\marginBeforeBullets}{5mm}
\setlength{\spaceBetweenCategories}{0mm}
%% only for itemBold and itemEmph:
\setlength{\spaceBetweenItems}{0mm}

%% to control category seperators:
\def\insertCategorySeparators{true} % either true or false
\setlength{\categorySeparatorMargin}{2mm}
\setlength{\categorySeparatorHeight}{10mm}
\setlength{\categorySeparatorWidth}{\textwidth}
\addtolength{\categorySeparatorWidth}{\marginparwidth}
\addtolength{\categorySeparatorWidth}{\marginparsep}

\reversemarginpar

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\titleFont}[1]{%
\begin{LARGE}\textbf{\textit{#1}}\end{LARGE}}
\newcommand{\categoryNameFont}[1]{%
\raggedright{\textsc{#1}}}

\renewcommand{\labelitemi}{$\diamond$}
\renewcommand{\labelitemii}{$\cdot$}

\newlength{\titleWidth}
\newlength{\contactInfoWidth}

\newcommand{\contactInfo}[2]{%
	\gdef\@contactInfoLeft{#1}%
	\gdef\@contactInfoRight{#2}}

%% category environment:

\newcommand\categorySeparator[1]{
\ifthenelse{\equal{\insertCategorySeparators}{true}}%
{	\tikz[baseline = (categorySeparatorNode.base)]%
	{\node(categorySeparatorNode)
	[text width = \marginparwidth,%
	inner sep = \categorySeparatorMargin,%
	align=left]{#1};
		\draw[line cap=round]%
		($ (categorySeparatorNode.north west) - (0, \categorySeparatorHeight) $)--%
		(categorySeparatorNode.north west)--%
		($ (categorySeparatorNode.north west) + (\categorySeparatorWidth, 0) $);
	}
}{#1}}

\newif{\if@firstitem}
\newenvironment{category}[1]%
{\@firstitemtrue
	\def\makecategorytitle{%
	\marginpar{\categorySeparator{%
	\categoryNameFont{\hyphenchar\font=-1 #1}}}}
	\par
	\begin{list}{}{%
		\setlength{\leftmargin}{\marginBeforeBullets}
		\setlength{\parsep}{0mm}
	}}
	{\vspace*{\spaceBetweenCategories}\end{list}}

%% \itemBold[1]
\newcommand*{\itemBold}[1]{%
	\if@firstitem
		{\item[\labelitemi]{\textbf{#1}}\makecategorytitle} %
	\else
		{\vspace*{\spaceBetweenItems}
		\item[\labelitemi]{\textbf{#1}}} %
	\fi
	\@firstitemfalse}

%% \itemEmph[1]
\newcommand*{\itemEmph}[1]{%
   \if@firstitem
      {\item[\labelitemi]{\textit{#1}}\makecategorytitle} %
   \else
      {\vspace*{\spaceBetweenItems}
      \item[\labelitemi]{\textit{#1}}} %
   \fi
   \@firstitemfalse}

%% \itemBullet
\newcommand{\itemBullet}{%
	\if@firstitem
		\item[\labelitemi] \leavevmode\makecategorytitle %
	\else
		\item[\labelitemi] %
	\fi
	\@firstitemfalse}

%% \itemNoBullet
\newcommand{\itemNoBullet}{
	\if@firstitem
		\item[] \leavevmode\makecategorytitle %
	\else
		\item[] %
	\fi
	\@firstitemfalse}

%% \maketitle

\renewcommand{\maketitle}{%
	\setlength{\titleWidth}{\textwidth}
	\setlength{\contactInfoWidth}{.5\textwidth}
	\begingroup
	\if@twocolumn
		\ifnum \col@number=\@ne
			\@makeresumetitle
		\else
			\twocolumn[\@makeresumetitle]%
		\fi
	\else
		\newpage
		\global\@topnum\z@
		\@makeresumetitle
	\fi
	\thispagestyle{empty}
	\endgroup
	\if@twoside
		\markboth{\@author}{\@author}
	\else
		\markright{\hfill\@author\hfill}
	\fi
	\pagestyle{myheadings}
	\renewcommand{\thepage}{}
	
	\setcounter{footnote}{0}%
  	\let\thanks\relax
	\let\maketitle\relax\let\@makeresumetitle\relax
	\gdef\@thanks{}\gdef\@author{}\gdef\@title{}}
  
\def\@makeresumetitle{%
	\newpage
	\null
	\def\@moveleft{\hspace*{-\marginparwidth}\hspace*{-\marginparsep}}
	\begin{center}
	\vspace*{\pushNameDown}
	\@moveleft\makebox[\titleWidth]{\titleFont{\@author}}\\
	\end{center}
	\@moveleft
	\parbox[t]{\contactInfoWidth}{%
	\begin{flushleft}\@contactInfoLeft\end{flushleft}}\hfill%
	\parbox[t]{\contactInfoWidth}{%
	\begin{flushright}\@contactInfoRight\end{flushright}}
	\par
	\vskip \spaceAfterContactInfo}

%% months:

\def \January {Jan.\xspace}
\def \February {Feb.\xspace}
\def \March {Mar.\xspace}
\def \April {Apr.\xspace}
\def \May {May\xspace}
\def \June {June\xspace}
\def \July {July\xspace}
\def \August {Aug.\xspace}
\def \September {Sept.\xspace}
\def \October {Oct.\xspace}
\def \November {Nov.\xspace}
\def \December {Dec.\xspace}

\makeatletter
\def\month@english{\ifcase\month\or
	\January\or
	\February\or
	\March\or
	\April\or
	\May\or
	\June\or
	\July\or
	\August\or
	\September\or
	\October\or
	\November\or
	\December\or
\fi}\makeatother

