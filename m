Return-Path: <cyrus@holtmann.org>
Message-ID: <1330034716.3392.10.camel@aeonflux>
Subject: Re: [PATCH] Bluetooth: Check capabilities in BR/EDR and LE-Only
 discovery
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Thu, 23 Feb 2012 23:05:16 +0100
In-Reply-To: <1330031367-10614-1-git-send-email-andre.guedes@openbossa.org>
References: <1330031367-10614-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch add an extra check for BR/EDR and LE-Only discovery.
> This way, we are able to return error immediately if the discovery
> type requested is not supported by the device.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/mgmt.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

so besides my other comment, this patch can go in as is and we have to
add an extra patch to handle interleaved once we talked through what's
the best approach.

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


