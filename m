Return-Path: <cyrus@holtmann.org>
Subject: Re: Patch to improve cupsdir detection
From: Bastien Nocera <hadess@hadess.net>
To: Pacho Ramos <pachoramos@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
In-Reply-To: <1283854723.24491.3.camel@localhost.localdomain>
References: <1283854723.24491.3.camel@localhost.localdomain>
Content-Type: text/plain; charset="ISO-8859-1"
Date: Tue, 07 Sep 2010 13:48:17 +0100
Message-ID: <1283863697.7529.42.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2010-09-07 at 12:18 +0200, Pacho Ramos wrote:
> Hello
> 
> Since really a lot of time we are shipping in Gentoo attached patch to
> adapt cupsdir to our cups installations (that uses /usr/libexec/cups
> instead of /usr/lib) :
> diff --git a/Makefile.tools b/Makefile.tools
> index d9a2425..a382e05 100644
> --- a/Makefile.tools
> +++ b/Makefile.tools
> @@ -122,7 +122,7 @@ EXTRA_DIST += tools/dfubabel.1 tools/avctrl.8
>  
> 
>  if CUPS
> -cupsdir = $(libdir)/cups/backend
> +cupsdir = `cups-config --serverbin`/backend
>  
>  cups_PROGRAMS = cups/bluetooth
> 
> I send this to inform you about it and, if possible, get it
> upstreamed :-)

Given that the cups backend doesn't actually require the cups headers or
development packages, you'd need to check for cups-config existing, and
then use a nice default if not present.

This should be done in acinclude.m4, with a new macro, which will get
added to the generated configure.

Cheers

