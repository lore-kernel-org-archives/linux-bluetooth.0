Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] make sure that PKG_CONFIG macros are defined
From: Marcel Holtmann <marcel@holtmann.org>
To: Stefan Seyfried <seife@suse.de>
Cc: BlueZ devel list <linux-bluetooth@vger.kernel.org>
In-Reply-To: <20090707102807.3f64f886@stoetzler>
References: <20090707102807.3f64f886@stoetzler>
Content-Type: text/plain
Date: Tue, 07 Jul 2009 10:21:02 -0700
Message-Id: <1246987262.3384.3.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Stefan,

> ---
>  configure.ac |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 8124c01..a08c972 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -8,6 +8,8 @@ m4_ifdef([AM_SILENT_RULES], [AM_SILENT_RULES([yes])])
>  
>  AM_MAINTAINER_MODE
>  
> +PKG_PROG_PKG_CONFIG
> +
>  AC_INIT_BLUEZ
>  
>  COMPILER_FLAGS

patch has been applied. Thanks.

Regards

Marcel


