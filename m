Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/2 RESEND] Bluetooth: btmrvl: implement read-to-clear for SD8897 interrupts
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1396043679-4574-1-git-send-email-bzhao@marvell.com>
Date: Fri, 28 Mar 2014 19:37:35 -0700
Cc: bt <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Avinash Patil <patila@marvell.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <A1E5F7CA-66E6-46FE-81ED-23D7A5F963EA@holtmann.org>
References: <1396043679-4574-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> For SD8897, CMD52 write_to_clear may have missing interrupts
> under certain corner case condition. Use CMD53 read-to-clear
> to fix the problem.
> 
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btmrvl_drv.h  |  2 ++
> drivers/bluetooth/btmrvl_main.c | 17 ++++++++++++++
> drivers/bluetooth/btmrvl_sdio.c | 52 ++++++++++++++++++++++++++++++++++++++++-
> drivers/bluetooth/btmrvl_sdio.h |  3 +++
> 4 files changed, 73 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

