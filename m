Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 2/2] Bluetooth: btmrvl: implement read-to-clear for SD8897 interrupts
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395981043-2541-2-git-send-email-bzhao@marvell.com>
Date: Fri, 28 Mar 2014 00:09:43 -0700
Cc: bt <linux-bluetooth@vger.kernel.org>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <E92D9A61-D66B-4D57-8C12-BBC640E12CD3@holtmann.org>
References: <1395981043-2541-1-git-send-email-bzhao@marvell.com> <1395981043-2541-2-git-send-email-bzhao@marvell.com>
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

Applying: Bluetooth: btmrvl: implement read-to-clear for SD8897 interrupts
Applying: Bluetooth: btmrvl: separate write-to-clear function from interrupt handler
error: patch failed: drivers/bluetooth/btmrvl_sdio.c:684
error: drivers/bluetooth/btmrvl_sdio.c: patch does not apply
Patch failed at 0002 Bluetooth: btmrvl: separate write-to-clear function from interrupt handler

Regards

Marcel

