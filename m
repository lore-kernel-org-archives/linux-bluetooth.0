Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [PATCH -next] Bluetooth: hci_bcsp: Use setup_timer instead of
 init_timer and data fields
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1476802878-5593-1-git-send-email-weiyj.lk@gmail.com>
Date: Tue, 18 Oct 2016 17:05:46 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <6E4E35A1-0005-4E63-8581-5ECF1C245640@holtmann.org>
References: <1476802878-5593-1-git-send-email-weiyj.lk@gmail.com>
To: Wei Yongjun <weiyj.lk@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Wei,

> Use setup_timer function instead of initializing timer with the function
> and data fields
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
> drivers/bluetooth/hci_bcsp.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)

didn't I just apply this patch?

Regards

Marcel

