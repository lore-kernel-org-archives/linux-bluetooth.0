Return-Path: <cyrus@holtmann.org>
Date: Sun, 29 May 2011 22:04:31 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: Remove obsolete code in hidd
Message-ID: <20110529190431.GD32088@dell.ger.corp.intel.com>
References: <1306419283.2010.245.camel@novo.hadess.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1306419283.2010.245.camel@novo.hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Thu, May 26, 2011, Bastien Nocera wrote:
> Heya,
> 
> This code has now been in the kernel for a while.
> 
> Cheers

> From 3a22abd3eb4b8b428bb76069c46d5e8ac2cebb10 Mon Sep 17 00:00:00 2001
> From: Bastien Nocera <hadess@hadess.net>
> Date: Thu, 5 May 2011 19:41:07 +0100
> Subject: [PATCH] Remove obsolete Sixaxis enablement in hidd
> 
> Seeing as this is now handled in the kernel.
> ---
>  compat/hidd.c |   12 ------------
>  1 files changed, 0 insertions(+), 12 deletions(-)

Applied, thanks.

In the future, I'd prefer if you could prefix patch email subjects with
[PATCH] (easier for me to spot them) and send the patch inline instead
of as an attachment (so I can use the same steps in mutt for applying
all patches). git send-email would do both of these for you for free.

Johan
