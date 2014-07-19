Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 2/2] Bluetooth: btmrvl: add public address configuration support
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405720027-28676-2-git-send-email-bzhao@marvell.com>
Date: Sat, 19 Jul 2014 02:37:14 +0200
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Chin-Ran Lo <crlo@marvell.com>, Xinming Hu <huxm@marvell.com>
Message-Id: <A8077388-A2C4-4234-B042-F00D492561D4@holtmann.org>
References: <1405720027-28676-1-git-send-email-bzhao@marvell.com> <1405720027-28676-2-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> .set_bdaddr handler is implemented for public address configuration.
> A reboot restores the bdaddr to its original address.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> v2: use memcpy instead of bacpy;
>    use __hci_cmd_sync() instead of btmrvl_send_sync_cmd()
> 
> drivers/bluetooth/btmrvl_drv.h  |  1 +
> drivers/bluetooth/btmrvl_main.c | 24 ++++++++++++++++++++++++
> 2 files changed, 25 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

