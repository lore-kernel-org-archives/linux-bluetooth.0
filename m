Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.2 \(3112\))
Subject: Re: [PATCH] Bluetooth: btmrvl_sdio: fix firmware activation failure
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1457408407-39841-1-git-send-email-wnhuang@google.com>
Date: Tue, 8 Mar 2016 10:28:34 -0800
Cc: Linux Bluetooth <linux-bluetooth@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, snanda@chromium.org,
	djkurtz@chromium.org, Amitkumar Karwar <akarwar@marvell.com>,
	Wei-Ning Huang <wnhuang@google.com>,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Message-Id: <60634578-DDB9-4D87-B95B-488C5837B153@holtmann.org>
References: <1457408407-39841-1-git-send-email-wnhuang@google.com>
To: Wei-Ning Huang <wnhuang@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei-Ning,

> In some case, the btmrvl_sdio firmware would fail to active within the
> polling time. Increase the polling interval to 100 msec to fix the
> issue.
> 
> Signed-off-by: Wei-Ning Huang <wnhuang@chromium.org>
> Signed-off-by: Wei-Ning Huang <wnhuang@google.com>
> ---
> drivers/bluetooth/btmrvl_sdio.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

