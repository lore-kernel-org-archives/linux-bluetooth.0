Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: mediatek: Fix memory leak
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180814151031.GA25096@embeddedor.com>
Date: Tue, 21 Aug 2018 16:57:11 +0200
Cc: Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Message-Id: <E5153D2C-A52F-4BA8-8B79-A19338BDC12D@holtmann.org>
References: <20180814151031.GA25096@embeddedor.com>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> In case memory resources for *fw* were allocated, release them before
> return.
> 
> Addresses-Coverity-ID: 1472611 ("Resource leak")
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> drivers/bluetooth/btmtkuart.c | 8 +++++---
> 1 file changed, 5 insertions(+), 3 deletions(-)

patch has been applied to bluetooth-stable tree.

Regards

Marcel
