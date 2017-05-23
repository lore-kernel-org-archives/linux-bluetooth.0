Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_ll: Fix download_firmware() return when
 __hci_cmd_sync fails
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170522135042.10921-1-guodong.xu@linaro.org>
Date: Tue, 23 May 2017 07:18:53 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Message-Id: <437A34F3-F22D-45AC-81D3-45B57E86C952@holtmann.org>
References: <20170522135042.10921-1-guodong.xu@linaro.org>
To: Guodong Xu <guodong.xu@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guodong,

> When __hci_cmd_sync() fails, download_firmware() should also fail, and
> the same error value should be returned as PTR_ERR(skb).
> 
> Without this fix, download_firmware() will return a success when it actually
> failed in __hci_cmd_sync().
> 
> Fixes: 371805522f87 ("bluetooth: hci_uart: add LL protocol serdev driver support")
> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> ---
> drivers/bluetooth/hci_ll.c | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
