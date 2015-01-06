Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH v2 3/4] Bluetooth: btmrvl: add surprise_removed flag
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1420100022-4134-3-git-send-email-akarwar@marvell.com>
Date: Tue, 6 Jan 2015 07:21:14 -0800
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Avinash Patil <patila@marvell.com>,
	Cathy Luo <cluo@marvell.com>, Marc Yang <yangyang@marvell.com>
Message-Id: <CCB98AFC-074E-4846-8318-1B4EAA42BA3E@holtmann.org>
References: <1420100022-4134-1-git-send-email-akarwar@marvell.com> <1420100022-4134-3-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This flag will be set in unload path to make sure that we skip
> sending further commands, ignore interrupts and stop main thread
> when unload starts.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  | 1 +
> drivers/bluetooth/btmrvl_main.c | 9 +++++++--
> drivers/bluetooth/btmrvl_sdio.c | 4 ++++
> 3 files changed, 12 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

