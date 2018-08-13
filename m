Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH] Bluetooth: mediatek: pass correct size to h4_recv_buf()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180813093235.hksi2c2ev37j4gji@kili.mountain>
Date: Mon, 13 Aug 2018 16:00:42 +0200
Cc: Sean Wang <sean.wang@mediatek.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org
Message-Id: <059C8611-913E-4667-9918-510AE1E47705@holtmann.org>
References: <20180813093235.hksi2c2ev37j4gji@kili.mountain>
To: Dan Carpenter <dan.carpenter@oracle.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Dan,

> We're supposed to pass the number of elements in the mtk_recv_pkts, not
> the number of bytes.
> 
> Fixes: 7237c4c9ec92 ("Bluetooth: mediatek: Add protocol support for MediaTek serial devices")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

patch has been applied to bluetooth-next tree.

Regards

Marcel
