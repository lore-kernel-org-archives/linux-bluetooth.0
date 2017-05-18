Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_HCIUART_H4
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20170508093911.25228-1-tobias.regnery@gmail.com>
Date: Thu, 18 May 2017 14:00:12 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org, sre@kernel.org
Message-Id: <A0C595E3-DDDD-47D2-8FD9-68F677A0DE6D@holtmann.org>
References: <20170508093911.25228-1-tobias.regnery@gmail.com>
To: Tobias Regnery <tobias.regnery@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tobias,

> We see the following build failure with CONFIG_BT_HCIUART_NOKIA=y and
> CONFIG_BT_HCIUART_H4=n:
> 
> drivers/bluetooth/hci_nokia.c: In function 'nokia_recv':
> drivers/bluetooth/hci_nokia.c:644:18: error: implicit declaration of function 'h4_recv_buf' [-Werror=implicit-function-declaration]
> ...
> 
> Fix this by selecting the BT_HCIUART_H4 symbol like all the other users
> of the protocoll.
> 
> Fixes: 7bb318680e86 ("Bluetooth: add nokia driver")
> Signed-off-by: Tobias Regnery <tobias.regnery@gmail.com>
> ---
> drivers/bluetooth/Kconfig | 1 +
> 1 file changed, 1 insertion(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

