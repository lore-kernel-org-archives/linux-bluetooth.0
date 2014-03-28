Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: [PATCH 1/2] Bluetooth: btmrvl: separate write-to-clear function from interrupt handler
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1395981043-2541-1-git-send-email-bzhao@marvell.com>
Date: Fri, 28 Mar 2014 00:10:06 -0700
Cc: linux-bluetooth@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Amitkumar Karwar <akarwar@marvell.com>
Message-Id: <03F7A083-7D4A-46B4-B628-2499614DCB45@holtmann.org>
References: <1395981043-2541-1-git-send-email-bzhao@marvell.com>
To: Bing Zhao <bzhao@marvell.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> This patch improves readability and makes future changes easier.
> 
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 53 +++++++++++++++++++++++++----------------
> 1 file changed, 32 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

