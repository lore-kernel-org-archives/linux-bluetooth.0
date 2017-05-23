Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: btintel: Add MODULE_FIRMWARE entries for iBT
 3.5 controllers
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170523164625.21298-1-j@bitron.ch>
Date: Tue, 23 May 2017 10:56:21 -0700
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <158ADB44-39C4-4CD8-8827-90CAF6E80B13@holtmann.org>
References: <20170523164625.21298-1-j@bitron.ch>
To: =?utf-8?Q?J=C3=BCrg_Billeter?= <j@bitron.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Juerg,

> The iBT 3.5 controllers (Intel 8265, Windstorm Peak) need
> intel/ibt-12-16.sfi and intel/ibt-12-16.ddc firmware files from
> linux-firmware repository.
> 
> Signed-off-by: Jürg Billeter <j@bitron.ch>
> ---
> drivers/bluetooth/btintel.c | 2 ++
> 1 file changed, 2 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel
