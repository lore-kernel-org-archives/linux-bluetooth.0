Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [PATCH] Bluetooth: btmrvl: indicate pscan scheduling instant in a debug event
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1396302104-11582-1-git-send-email-bzhao@marvell.com>
Date: Tue, 1 Jul 2014 23:24:50 +0200
Cc: Linux Bluetooth mailing list <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Scott James Remnant <keybuk@chromium.org>,
	Avinash Patil <patila@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <998FB51B-91B7-43C9-9771-9348963A9FDB@holtmann.org>
References: <1396302104-11582-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> A vendor specific command is sent to firmware during
> initialization to enable this feature. This command is for
> SD8897 only.
> 
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  |  1 +
> drivers/bluetooth/btmrvl_main.c | 19 +++++++++++++++++++
> drivers/bluetooth/btmrvl_sdio.c |  5 +++++
> drivers/bluetooth/btmrvl_sdio.h |  2 ++
> 4 files changed, 27 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

