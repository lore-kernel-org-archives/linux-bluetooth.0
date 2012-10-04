Return-Path: <cyrus@holtmann.org>
Date: Thu, 4 Oct 2012 11:26:20 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org,
	Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH BlueZ 1/2] build-sys: Don't use deprecated AM_PROG_MKDIR_P
Message-ID: <20121004082620.GB25789@x220>
References: <1349332630-8901-1-git-send-email-lucas.de.marchi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1349332630-8901-1-git-send-email-lucas.de.marchi@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

On Thu, Oct 04, 2012, Lucas De Marchi wrote:
> AM_PROG_MKDIR_P is deprecated since:
> 
> configure.ac:23: warning: The 'AM_PROG_MKDIR_P' macro is deprecated, and will soon be removed.
> configure.ac:23: You should use the Autoconf-provided 'AC_PROG_MKDIR_P' macro instead,
> configure.ac:23: and use '$(MKDIR_P)' instead of '$(mkdir_p)'in your Makefile.am files.
> 
> We are already using $(MKDIR_P) so we just need to call the right macro.
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Both patches have been applied. Thanks.

Johan
