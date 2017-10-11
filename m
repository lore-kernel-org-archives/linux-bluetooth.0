Return-Path: <linux-kernel-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH 1/2] Bluetooth: hci_bcm: fix build error without CONFIG_PM
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171011134640.3152236-1-arnd@arndb.de>
Date: Wed, 11 Oct 2017 20:11:23 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Loic Poulain <loic.poulain@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <C5624DEB-606C-4FAE-B70D-25EC2D0F3D86@holtmann.org>
References: <20171011134640.3152236-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arnd,

> This was introduced by the rework adding PM support:
> 
> drivers/bluetooth/hci_bcm.c: In function 'bcm_device_exists':
> drivers/bluetooth/hci_bcm.c:156:22: error: 'struct bcm_device' has no member named 'hu'
>  if (device && device->hu && device->hu->serdev)
>                      ^~
> 
> The pointer is not available otherwise, so I'm enclosing
> all references in an #ifdef here.
> 
> Fixes: 8a92056837fd ("Bluetooth: hci_bcm: Add (runtime)pm support to the serdev driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> drivers/bluetooth/hci_bcm.c | 4 ++++
> 1 file changed, 4 insertions(+)

both patches have been applied to bluetooth-next tree.

Regards

Marcel
