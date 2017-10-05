Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.6\))
Subject: Re: [PATCH v2 9/9] Bluetooth: hci_bcm: Add (runtime)pm support to the
 serdev driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171004184343.7855-9-hdegoede@redhat.com>
Date: Thu, 5 Oct 2017 12:45:09 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>,
        Sebastian Reichel <sre@kernel.org>, robh@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <DFCF661F-6FE0-4449-A169-D71ED9282074@holtmann.org>
References: <20171004184343.7855-1-hdegoede@redhat.com>
 <20171004184343.7855-9-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Make the serdev driver use struct bcm_device as its driver data and share
> all the pm / GPIO / IRQ related code paths with the platform driver.
> 
> After this commit the 2 drivers are in essence the same and the serdev
> driver interface can be used for all ACPI enumerated HCI UARTs.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 118 +++++++++++++++++++++++++-------------------
> 1 file changed, 68 insertions(+), 50 deletions(-)

all 9 patches have been applied to bluetooth-next tree.

Regards

Marcel

