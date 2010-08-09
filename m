Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: HCI devices are either BR/EDR or AMP radios
From: Marcel Holtmann <marcel@holtmann.org>
To: David Vrabel <david.vrabel@csr.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4C604F37.4020706@csr.com>
References: <4C604F37.4020706@csr.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 09 Aug 2010 17:39:46 -0400
Message-ID: <1281389986.12579.199.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> HCI transport drivers may not know what type of radio an AMP device has
> so only say whether they're BR/EDR or AMP devices.
> 
> Signed-off-by: David Vrabel <david.vrabel@csr.com>
> ---
>   include/net/bluetooth/hci.h |    2 +-
>   net/bluetooth/hci_sysfs.c   |    4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)

a little bit different version that also fixes the Marvell driver has
been applied to my tree. Thanks.

Regards

Marcel


