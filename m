Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: btqcomsmd: Fix skb double free corruption
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1511359397-25523-1-git-send-email-loic.poulain@linaro.org>
Date: Tue, 28 Nov 2017 09:44:58 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <35EBE8FA-D41F-4447-8D37-88F42329225F@holtmann.org>
References: <1511359397-25523-1-git-send-email-loic.poulain@linaro.org>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> In case of hci send frame failure, skb is still owned
> by the caller (hci_core) and then should not be freed.
> 
> This fixes crash on dragonboard-410c when sending SCO
> packet. skb is freed by both btqcomsmd and hci_core.
> 
> Fixes: 1511cc750c3d ("Bluetooth: Introduce Qualcomm WCNSS SMD based HCI driver")
> Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
> ---
> drivers/bluetooth/btqcomsmd.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

