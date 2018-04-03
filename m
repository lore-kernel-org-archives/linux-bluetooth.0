Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH resend] Bluetooth: hci_bcm: Add broken-irq dmi blacklist
 and add Meegopad T08 to it
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180403144020.14819-1-hdegoede@redhat.com>
Date: Tue, 3 Apr 2018 16:44:26 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-acpi@vger.kernel.org
Message-Id: <994F66BC-E46C-4A49-8572-4A194E029CD0@holtmann.org>
References: <20180403144020.14819-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> The Meegopad T08 hdmi-stick (think Intel computestick) has a brcm43430
> wifi/bt combo chip. The BCM2E90 ACPI device describing the BT part does
> contain a valid ActiveLow GpioInt entry, but the GPIO it points to never
> goes low, so either the IRQ pin is not connected, or the ACPI resource-
> table points to the wrong GPIO.
> 
> Eitherway things will not work if we try to use the specified IRQ, this
> commits adds a DMI based broken-irq blacklist and disables use of the IRQ
> and thus also runtime-pm for devices on this list.
> 
> This blacklist starts with the the Meegopad T08, fixing bluetooth not
> working on this hdmi-stick. Since this is not a battery powered device
> the loss of runtime-pm is not really an issue.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 23 +++++++++++++++++++++++
> 1 file changed, 23 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

