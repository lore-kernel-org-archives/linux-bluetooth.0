Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Make bcm_request_irq fail if no IRQ
 resource
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1499165876-18999-1-git-send-email-loic.poulain@gmail.com>
Date: Tue, 4 Jul 2017 14:12:44 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        ian@mnementh.co.uk
Message-Id: <8D4F453F-AF1B-4E7F-A9C6-5AF5D5B6524A@holtmann.org>
References: <1499165876-18999-1-git-send-email-loic.poulain@gmail.com>
To: Loic Poulain <loic.poulain@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> In case of no IRQ resource associated to the bcm_device, requesting
> IRQ should return an error in order to not enable low power mgmt.
> 
> Signed-off-by: Loic Poulain <loic.poulain@gmail.com>
> Reported-by: Ian Molton <ian@mnementh.co.uk>
> ---
> drivers/bluetooth/hci_bcm.c | 30 ++++++++++++++++--------------
> 1 file changed, 16 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

