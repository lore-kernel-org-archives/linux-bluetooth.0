Return-Path: <cyrus@holtmann.org>
Date: Mon, 2 Jan 2012 22:28:00 -0200
From: Gustavo Padovan <padovan@profusion.mobi>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH 2/2] Bluetooth: Queue adv_work on system workqueue
Message-ID: <20120103002800.GD1472@joana>
References: <1325542691-6235-1-git-send-email-andre.guedes@openbossa.org>
 <1325542691-6235-2-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1325542691-6235-2-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

* Andre Guedes <andre.guedes@openbossa.org> [2012-01-02 19:18:11 -0300]:

> This patch queues hdev->adv_work on the system-wide workqueue
> instead of on hdev->workqueue. This way we keep only tx/rx works
> on hdev->workqueue.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/hci_event.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)

All applied, thanks.

	Gustavo
