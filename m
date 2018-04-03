Return-Path: <linux-serial-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Remove irq-active-low DMI quirk for
 the Thinkpad 8
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180403153521.16349-1-hdegoede@redhat.com>
Date: Tue, 3 Apr 2018 17:47:34 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
Message-Id: <AC16AAC5-CFC0-4594-9CF1-9E7D29CF2D32@holtmann.org>
References: <20180403153521.16349-1-hdegoede@redhat.com>
To: Hans de Goede <hdegoede@redhat.com>
Sender: linux-serial-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Hans,

> Interrupts specified through an "Interrupt" ACPI resource (versus through
> a "GpioInt" resource) are now always assumed to be active low.
> 
> When this change was originally made the Thinkpad 8 quirk was kept around
> because it was uncertain if the Thinkpad 8 uses an "Interrupt" or a
> "GpioInt" resource.
> 
> Bug https://bugzilla.kernel.org/show_bug.cgi?id=196701 has a DSDT for the
> Thinkpad 8 attached and it uses an "Interrupt" resource, so the quirk is
> not necessary and the quirk, as well as the irq-active-low quirk handling
> code can be removed.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> drivers/bluetooth/hci_bcm.c | 20 --------------------
> 1 file changed, 20 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

