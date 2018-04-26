Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: hci_ldisc: Provide a 'default' switch case
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1524695789-22139-1-git-send-email-festevam@gmail.com>
Date: Thu, 26 Apr 2018 11:32:34 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ development <linux-bluetooth@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Message-Id: <342ACB2D-5CCF-44E3-88AF-345058C08034@holtmann.org>
References: <1524695789-22139-1-git-send-email-festevam@gmail.com>
To: Fabio Estevam <festevam@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fabio,

> When both CONFIG_BT_HCIUART_INTEL and CONFIG_BT_HCIUART_BCM are not
> selected, sparse complains like this:
> 
> drivers/bluetooth/hci_ldisc.c:437:9: warning: switch with no cases
> 
> Fix the sparse warning by proving a default switch case.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
> ---
> drivers/bluetooth/hci_ldisc.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

