Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] Bluetooth: btqca: remove null checks on edl->data as it is an array
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20160906121549.14144-1-colin.king@canonical.com>
Date: Tue, 6 Sep 2016 20:01:46 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <002919CC-E907-4A9D-AF4D-B26538000079@holtmann.org>
References: <20160906121549.14144-1-colin.king@canonical.com>
To: Colin King <colin.king@canonical.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Colin,

> edl->data is an array of __u8 so the null check is unneccessary,
> so remove it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
> drivers/bluetooth/btqca.c | 8 ++++----
> 1 file changed, 4 insertions(+), 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

