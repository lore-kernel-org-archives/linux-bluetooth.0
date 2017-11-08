Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH] Bluetooth: Use common error handling code in bt_init()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <cc83ce48-c0a4-1b83-8fdc-a474eb102fe0@users.sourceforge.net>
Date: Wed, 8 Nov 2017 08:34:28 +0100
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-Id: <7A6D341D-2ABC-417C-8808-A907E61F08E6@holtmann.org>
References: <cc83ce48-c0a4-1b83-8fdc-a474eb102fe0@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Markus,

> * Improve jump targets so that a bit of exception handling can be better
>  reused at the end of this function.
> 
> * Adjust five condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> net/bluetooth/af_bluetooth.c | 38 +++++++++++++++++---------------------
> 1 file changed, 17 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
