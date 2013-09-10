Return-Path: <cyrus@holtmann.org>
Date: Tue, 10 Sep 2013 16:48:34 +0100
From: Gustavo Padovan <gustavo@padovan.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Use GFP_KERNEL when cloning SKB in a workqueue
Message-ID: <20130910154834.GD1916@joana>
References: <1378257067-52933-1-git-send-email-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1378257067-52933-1-git-send-email-marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

2013-09-03 Marcel Holtmann <marcel@holtmann.org>:

> There is no need to use GFP_ATOMIC with skb_clone() when the code is
> executed in a workqueue.
> 
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>  net/bluetooth/hci_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch has been applied to bluetooth-next. Thanks.

	Gustavo
