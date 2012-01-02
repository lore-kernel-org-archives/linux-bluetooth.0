Return-Path: <cyrus@holtmann.org>
Message-ID: <1325543072.1965.402.camel@aeonflux>
Subject: Re: [PATCH 2/2] Bluetooth: Queue adv_work on system workqueue
From: Marcel Holtmann <marcel@holtmann.org>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Date: Mon, 02 Jan 2012 14:24:32 -0800
In-Reply-To: <1325542691-6235-2-git-send-email-andre.guedes@openbossa.org>
References: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
	 <1325542691-6235-2-git-send-email-andre.guedes@openbossa.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

> This patch queues hdev->adv_work on the system-wide workqueue
> instead of on hdev->workqueue. This way we keep only tx/rx works
> on hdev->workqueue.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

Acked-by: Marcel Holtmann <marcel@holtmann.org>

Regards

Marcel


