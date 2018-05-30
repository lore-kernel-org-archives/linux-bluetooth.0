Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH 08/13] Bluetooth: hci_serdev: Move
 serdev_device_close/open into common hci_serdev code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180527190457.2632-9-hdegoede@redhat.com>
Date: Wed, 30 May 2018 08:48:21 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        robh@kernel.org, Jeremy Cline <jeremy@jcline.org>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Message-Id: <06A21F1F-1554-4D44-99E0-1B7C5E97876D@holtmann.org>
References: <20180527190457.2632-1-hdegoede@redhat.com>
 <20180527190457.2632-9-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Make hci_uart_register_device() and hci_uart_unregister_device() call
> serdev_device_close()/open() themselves instead of relying on the various
> hci_uart drivers to do this for them.
> 
> Besides reducing code complexity, this also ensures correct error checking
> of serdev_device_open(), which was missing in a few drivers.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c    | 10 +---------
> drivers/bluetooth/hci_ll.c     |  3 ---
> drivers/bluetooth/hci_nokia.c  |  3 ---
> drivers/bluetooth/hci_serdev.c |  9 ++++++++-
> 4 files changed, 9 insertions(+), 16 deletions(-)

this patch has been cherry-picked and applied to bluetooth-next tree.

Regards

Marcel

