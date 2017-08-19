Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: make device_type const
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1503134687-12193-1-git-send-email-bhumirks@gmail.com>
Date: Sat, 19 Aug 2017 11:56:17 +0200
Cc: julia.lawall@lip6.fr, "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        Netdev list <netdev@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Message-Id: <197CA699-327D-4BD7-A903-E46A2A7F9629@holtmann.org>
References: <1503134687-12193-1-git-send-email-bhumirks@gmail.com>
To: Bhumika Goyal <bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bhumika,

> Make these const as they are only stored in the type field of a device
> structure, which is const.
> Done using Coccinelle.
> 
> Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
> ---
> net/bluetooth/hci_sysfs.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
