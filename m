Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: support Marvell Bluetooth device SD8887
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412073933-7760-2-git-send-email-akarwar@marvell.com>
Date: Tue, 30 Sep 2014 14:16:45 +0200
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, patila@marvell.com,
	huxm@marvell.com, Kevin Gan <ganhy@marvell.com>,
	Cathy Luo <cluo@marvell.com>
Message-Id: <E5A748D5-787B-40F6-8580-A1C581BD8DB4@holtmann.org>
References: <1412073933-7760-1-git-send-email-akarwar@marvell.com> <1412073933-7760-2-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> This patch adds driver support for marvell SD8887 chip.
> 
> Signed-off-by: Xinming Hu <huxm@marvell.com>
> Signed-off-by: Kevin Gan <ganhy@marvell.com>
> Signed-off-by: Cathy Luo <cluo@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/Kconfig       |  4 ++--
> drivers/bluetooth/btmrvl_sdio.c | 32 ++++++++++++++++++++++++++++++++
> 2 files changed, 34 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

