Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 16:13:56 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Add new plugin to set adapter class
Message-ID: <20100906131356.GA9958@jh-x301>
References: <1283770089.7529.9.camel@localhost.localdomain>
 <20100906111516.GA23167@jh-x301>
 <1283771863.7529.10.camel@localhost.localdomain>
 <20100906113031.GA23586@jh-x301>
 <1283774756.7529.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283774756.7529.11.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Sep 06, 2010, Bastien Nocera wrote:
> OK. Patch that actually applies to master attached. Was conflicting with
> another non-upstreamed patch.
> 
> From: Bastien Nocera <hadess@hadess.net>
> Date: Mon, 6 Sep 2010 11:44:31 +0100
> Subject: [PATCH] Add new plugin to set adapter class
> 
> This time based on the kernel exported DMI, rather than calling
> out to HAL. The HAL plugin can still be preferred with
> --enable-hal=yes passed to configure.
> ---
>  Makefile.am          |    7 ++
>  acinclude.m4         |    7 ++-
>  plugins/formfactor.c |  151 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 164 insertions(+), 1 deletions(-)
>  create mode 100644 plugins/formfactor.c

Thanks. The patch is now upstream.

Johan
