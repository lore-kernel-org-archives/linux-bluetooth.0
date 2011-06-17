Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v2] build: Add support for systemd service configuration
From: Marcel Holtmann <marcel@holtmann.org>
To: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 16 Jun 2011 21:15:08 -0700
In-Reply-To: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1308275200-17393-1-git-send-email-lucas.demarchi@profusion.mobi>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308284110.2196.29.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lucas,

>  .gitignore               |    1 +
>  Makefile.am              |    8 +++++++-
>  configure.ac             |   11 ++++++++++-
>  src/bluetooth.service.in |   12 ++++++++++++
>  4 files changed, 30 insertions(+), 2 deletions(-)
>  create mode 100644 src/bluetooth.service.in
> 
> diff --git a/.gitignore b/.gitignore
> index 2ef7cb5..2ce99e7 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -93,3 +93,4 @@ doc/version.xml
>  doc/xml
>  doc/html
>  src/bluetoothd.8
> +src/bluetooth.service
> diff --git a/Makefile.am b/Makefile.am
> index 4659c80..85f3d5f 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -35,6 +35,12 @@ conf_DATA =
>  statedir = $(localstatedir)/lib/bluetooth
>  
>  state_DATA =
> +
> +if SYSTEMD
> +systemdunitdir = @SYSTEMD_UNITDIR@
> +
> +systemdunit_DATA = src/bluetooth.service
> +endif
>  endif
>  
>  plugindir = $(libdir)/bluetooth/plugins
> @@ -385,7 +391,7 @@ pkgconfigdir = $(libdir)/pkgconfig
>  
>  pkgconfig_DATA = bluez.pc
>  
> -DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules
> +DISTCHECK_CONFIGURE_FLAGS = --disable-udevrules --with-systemdunitdir=

can we please do it the same way I did it for oFono and ConnMan. I have
no idea what you are doing here. If --with-systemdunitdir is not given,
then it should be disabled and it should be that by default.

Regards

Marcel


