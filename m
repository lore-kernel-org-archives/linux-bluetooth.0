Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: Delete error messages for failed memory
 allocations in two functions
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <0afbfdb7-48f1-4d15-d5bd-8ea40b1eb52a@users.sourceforge.net>
Date: Mon, 22 May 2017 10:25:48 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Message-Id: <A01E2BDB-7FD3-4258-9F6F-941EFA76935E@holtmann.org>
References: <0afbfdb7-48f1-4d15-d5bd-8ea40b1eb52a@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hallo Markus,

> Omit two extra messages for memory allocation failures in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
> net/bluetooth/ecdh_helper.c | 11 +++--------
> 1 file changed, 3 insertions(+), 8 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

