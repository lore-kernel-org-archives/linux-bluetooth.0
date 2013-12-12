Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: [PATCH 2/2] Bluetooth: Fix test for lookup_dev return value
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1386834801-1635-2-git-send-email-johan.hedberg@gmail.com>
Date: Thu, 12 Dec 2013 09:01:13 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <BFE1B94A-BC85-4724-9084-47E7B7773B92@holtmann.org>
References: <1386834801-1635-1-git-send-email-johan.hedberg@gmail.com> <1386834801-1635-2-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The condition wouldn't have previously caused -ENOENT to be returned if
> dev was NULL. The proper condition should be if (!dev || !dev->netdev).
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> net/bluetooth/6lowpan.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

