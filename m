Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: bfusb: Fix error path on firmware load
From: Marcel Holtmann <marcel@holtmann.org>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: linux-bluetooth@vger.kernel.org, padovan@profusion.mobi
Date: Wed, 26 Oct 2011 15:46:45 +0200
In-Reply-To: <1319620966-11193-1-git-send-email-dh.herrmann@googlemail.com>
References: <1319620966-11193-1-git-send-email-dh.herrmann@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1319636806.15441.258.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> When loading the usb-configuration we do not signal the end of configuration on
> memory allocation error. This patch moves the memory allocation to the top so
> every error path uses "goto error" now to correctly send the usb-ctrl message
> when detecting some error.
> 
> This also replaces GFP_ATOMIC with GFP_KERNEL as we are allowed to sleep here.
> 
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  drivers/bluetooth/bfusb.c |   13 +++++++------
>  1 files changed, 7 insertions(+), 6 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


