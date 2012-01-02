Return-Path: <cyrus@holtmann.org>
Message-ID: <1325543037.1965.401.camel@aeonflux>
Subject: Re: [PATCH 1/2] Bluetooth: Fix adv_work delay
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:23:57 -0800
In-Reply-To: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
References: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch fixes the adv_work delay. It should be set to ADV_
> CLEAR_TIMEOUT instead of (jiffies + ADV_CLEAR_TIMEOUT) since
> queue_delayed_work() receives the number of jiffies to wait
> before queueing. It also removes the unnecessary cancel_delayed_
> work_sync() call in case LE scan has been disabled.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


