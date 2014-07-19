Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH v2 1/2] Bluetooth: add public address configuration for Marvell USB devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1405720027-28676-1-git-send-email-bzhao@marvell.com>
Date: Sat, 19 Jul 2014 02:37:16 +0200
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>,
	Avinash Patil <patila@marvell.com>,
	Chin-Ran Lo <crlo@marvell.com>, Xinming Hu <huxm@marvell.com>
Message-Id: <2B11DC0A-F901-4E80-AC50-D8666FC415BD@holtmann.org>
References: <1405720027-28676-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> Implemented .set_bdaddr handler provided by bluetooth stack for
> Marvell devices for public address configuration.
> A reboot restores the bdaddr to its original address.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> v2: use memcpy instead of bacpy
> 
> drivers/bluetooth/btusb.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

