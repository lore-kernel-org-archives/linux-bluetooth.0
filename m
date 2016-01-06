Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: don't send data to firmware while processing suspend
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1452090878-19586-2-git-send-email-akarwar@marvell.com>
Date: Wed, 6 Jan 2016 07:24:07 -0800
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chin-Ran Lo <crlo@marvell.com>
Message-Id: <99551394-8D9D-4D08-9010-DE1D00851B79@holtmann.org>
References: <1452090878-19586-1-git-send-email-akarwar@marvell.com> <1452090878-19586-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> Usually when driver sends data to firmware it receives TX_DONE
> (DN_LD_HOST_INT_STATUS) interrupt from firmware right away.
> It's also observed that some times the fireware could delay
> sending DN_LD_HOST_INT_STATUS interrupt. If driver sends data to
> firmware during suspend processing and the TX_DONE interrupt is
> delayed, it may come back at wrong time when SDIO host driver is
> in the middle of suspending.
> 
> Block any data from stack while suspending. Also skip sending
> data that are already in driver tx_queue.
> 
> Don't purge the skb queue on suspend to avoid intermittent music
> after system resumes from S3.
> 
> Signed-off-by: Chin-Ran Lo <crlo@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  |  1 +
> drivers/bluetooth/btmrvl_main.c | 11 +++++++++--
> drivers/bluetooth/btmrvl_sdio.c |  3 ++-
> 3 files changed, 12 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

