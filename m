Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: fix firmware dump issue
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1442583641-3182-1-git-send-email-akarwar@marvell.com>
Date: Fri, 18 Sep 2015 17:48:58 +0200
Cc: linux-bluetooth@vger.kernel.org, Cathy Luo <cluo@marvell.com>,
	Nachiket Kukade <kukaden@marvell.com>
Message-Id: <46DC23D3-C024-413B-8123-5D0F8FD5718F@holtmann.org>
References: <1442583641-3182-1-git-send-email-akarwar@marvell.com>
To: Amitkumar Karwar <akarwar@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Amitkumar,

> First firmware dump attempt from user works fine, but firmware goes
> into bad state after this. Subsequent attempts fails.
> 
> As required by the firmware dump implementation, this change writes
> FW_DUMP_READ_DONE value to dump ctrl register to address this issue.
> 
> Signed-off-by: Nachiket Kukade <kukaden@marvell.com>
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 6 ++++++
> 1 file changed, 6 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

