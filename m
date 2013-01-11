Return-Path: <cyrus@holtmann.org>
Message-ID: <1357864284.1806.80.camel@aeonflux>
Subject: Re: [PATCH BlueZ 1/2] build: Fix --disable-optimization configure
 option
From: Marcel Holtmann <marcel@holtmann.org>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 10 Jan 2013 16:31:24 -0800
In-Reply-To: <1357659987-4219-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357659987-4219-1-git-send-email-anderson.lizardo@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

> On commit cc9e4e7cae0379864ea06038d92bf7ecc192bba7, this flag was
> mistakenly replaced with the behavior of the old --enable-fortify
> option.
> 
> This patch restores the "-O0" flag when --disable-optimization is used.
> 
> Unfortunately, this is not enough to disable build optimization. By
> default, autoconf adds -O2 to CFLAGS if the compiler is GCC. AM_CFLAGS
> (where -O0 is added with --disable-optimization) is passed as argument
> to GCC before autoconf CFLAGS, so it is not possible to override the
> default -O2. One solution is to use:
> 
> CFLAGS= ./configure --disable-optimization
> 
> i.e. remove -O2 from CFLAGS, and let autoconf add -O0.
> ---
>  acinclude.m4 |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied.

Regards

Marcel


