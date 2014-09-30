Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: rename definitions from 88xx to 8897
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1412073933-7760-1-git-send-email-akarwar@marvell.com>
Date: Tue, 30 Sep 2014 14:16:48 +0200
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>, patila@marvell.com,
	huxm@marvell.com
Message-Id: <59082E04-E9EF-4B1D-8673-9F303684565F@holtmann.org>
References: <1412073933-7760-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> Register offsets are different for SD8897 and newer chip SD8887.
> We can not have common btmrvl_sdio_card_reg map for them.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

