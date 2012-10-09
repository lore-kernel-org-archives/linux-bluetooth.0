Return-Path: <cyrus@holtmann.org>
Message-ID: <1349807669.27233.103.camel@aeonflux>
Subject: Re: [RFC obexd 02/11] build: Add --enable-fuse for gobexfuse
From: Marcel Holtmann <marcel@holtmann.org>
To: =?UTF-8?Q?Micha=C5=82?= Poczwardowski <dmp0x7c5@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Date: Tue, 09 Oct 2012 20:34:29 +0200
In-Reply-To: <1349806556-1978-2-git-send-email-dmp0x7c5@gmail.com>
References: <1349806556-1978-1-git-send-email-dmp0x7c5@gmail.com>
	 <1349806556-1978-2-git-send-email-dmp0x7c5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

>  Makefile.am  |    9 +++++++++
>  configure.ac |   15 +++++++++++++++
>  2 files changed, 24 insertions(+), 0 deletions(-)
> 
> diff --git a/Makefile.am b/Makefile.am
> index 724dd5d..95b99a6 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -132,6 +132,15 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
>  client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
>  endif
>  
> +if FUSE
> +bin_PROGRAMS = fuse/gobexfuse

I rather call this obexfuse or similar. I don't want to have any "g"
prefixes in the future anymore.

Regards

Marcel


