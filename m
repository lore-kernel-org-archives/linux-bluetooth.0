Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.2 \(3445.5.20\))
Subject: Re: [PATCH] Bluetooth: 6lowpan: Fix disconnect bug in 6lowpan
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1516160848-471-1-git-send-email-yi2010.guo@samsung.com>
Date: Mon, 22 Jan 2018 13:05:09 +0100
Cc: Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Message-Id: <7811FEDD-2495-43ED-8745-F2E5235BE1E2@holtmann.org>
References: <CGME20180117034755epcas5p1437f6831b91eb594a1106f0960204b81@epcas5p1.samsung.com>
 <1516160848-471-1-git-send-email-yi2010.guo@samsung.com>
To: Guo Yi <yi2010.guo@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Guo,

> This patch fix the bluetooth 6lowpan disconnect fail bug.
> 
> The type of the same address type have different define value in HCI layer
> and L2CAP layer.That makes disconnect fail due to wrong network type.User
> will not be able to disconnect from console with the network type that used
> in connect.
> 
> This patch add a var lookup_type, and covert the channel address type to
> HCI address type. By these means, user can disconnect successfuly.
> 
> Signed-off-by: Guo Yi <yi2010.guo@samsung.com>
> ---
> net/bluetooth/6lowpan.c | 9 ++++++++-
> 1 file changed, 8 insertions(+), 1 deletion(-)

this patch does not apply to bluetooth-next tree.

Regards

Marcel
