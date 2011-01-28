Return-Path: <cyrus@holtmann.org>
Date: Fri, 28 Jan 2011 07:37:29 +0200
From: Ville Tervo <ville.tervo@nokia.com>
To: ext Sheldon Demario <sheldon.demario@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 1/6] Include check to readline lib on acinlude.m4
Message-ID: <20110128053729.GM874@null>
References: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1296155342-31956-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sheldon,

On Thu, Jan 27, 2011 at 04:08:57PM -0300, ext Sheldon Demario wrote:
> ---
>  acinclude.m4 |    7 +++++++
>  1 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/acinclude.m4 b/acinclude.m4
> index ecf4b4b..f27d4eb 100644
> --- a/acinclude.m4
> +++ b/acinclude.m4
> @@ -153,6 +153,13 @@ AC_DEFUN([AC_PATH_SNDFILE], [
>  	AC_SUBST(SNDFILE_LIBS)
>  ])
>  
> +AC_DEFUN([AC_PATH_READLINE], [
> +	AC_CHECK_LIB(readline, main,
> +		[ readline_found=yes
> +		 AC_SUBST(READLINE_LIBS, "-lreadline")
> +		], readline_found=no)
> +])
> +

This doesn't check if header files exists.

>  AC_DEFUN([AC_PATH_OUI], [
>  	AC_ARG_WITH(ouifile,
>  		    AS_HELP_STRING([--with-ouifile=PATH],[Path to the oui.txt file @<:@auto@:>@]),

-- 
Ville
