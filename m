Return-Path: <cyrus@holtmann.org>
Date: Mon, 6 Sep 2010 19:10:57 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Make the path to oui.txt a compile-time option
Message-ID: <20100906161057.GA25826@jh-x301>
References: <1283784432.7529.24.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1283784432.7529.24.camel@localhost.localdomain>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bastien,

On Mon, Sep 06, 2010, Bastien Nocera wrote:
> From b96d9394aa850be86ca368aeaeec3bc24c00bce1 Mon Sep 17 00:00:00 2001
> From: Bastien Nocera <hadess@hadess.net>
> Date: Mon, 6 Sep 2010 15:43:48 +0100
> Subject: [PATCH] Make the path to oui.txt a compile-time option
> 
> This avoids bluetoothd trying to load oui.txt from multiple locations
> and cause SELinux AVC denials by accessing files it's not supposed
> to touch.
> ---
>  acinclude.m4 |    8 ++++++++
>  configure.ac |    1 +
>  src/oui.c    |   14 +++-----------
>  3 files changed, 12 insertions(+), 11 deletions(-)

Seems like a good idea. The patch is now upstream.

Johan
