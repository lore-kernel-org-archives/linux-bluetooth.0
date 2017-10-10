Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.0 \(3445.1.7\))
Subject: Re: [PATCH v3 1/2] Bluetooth: hci_bcm: Add support for MINIX Z83-4
 based devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <30dae6f5-b69e-352f-072d-2e1272cbbca8@gmail.com>
Date: Tue, 10 Oct 2017 10:13:34 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "bluez mailin list (linux-bluetooth@vger.kernel.org)"
        <linux-bluetooth@vger.kernel.org>, hdegoede@redhat.com,
        =?utf-8?Q?Fr=C3=A9d=C3=A9ric_Danis?= <frederic.danis.oss@gmail.com>
Message-Id: <8A4E38C1-B631-4D87-8357-9777DFEAC958@holtmann.org>
References: <30dae6f5-b69e-352f-072d-2e1272cbbca8@gmail.com>
To: Ian W MORRISON <ianwmorrison@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ian,

> The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices use an AP6255 chip for wifi and bluetooth. Bluetooth requires an ACPI device id of BCM2EA4 with BCM4345 rev C0 firmware.
> 
> This patch adds the device id and to use trigger type IRQF_TRIGGER_FALLING as defined by 'GpioInt' in the ACPI DSDT table:
> 
>    Device (BLT0)
>    {
>        Name (_HID, "BCM2EA4")  // _HID: Hardware ID
>        Method (_STA, 0, NotSerialized)  // _STA: Status
>        {
>            Return (0x0F)
>        }
> 
>        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
>        {
>            Name (UBUF, ResourceTemplate ()
>            {
>                UartSerialBusV2 (0x0001C200, DataBitsEight, StopBitsOne,
>                    0xFC, LittleEndian, ParityTypeNone, FlowControlHardware,
>                    0x0020, 0x0020, "\\_SB.PCI0.URT1",
>                    0x00, ResourceConsumer, , Exclusive,
>                    )
>                GpioInt (Level, ActiveLow, Exclusive, PullNone, 0x0000,
>                    "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                    )
>                    {   // Pin list
>                        0x0005
>                    }
>                GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                    "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                    )
>                    {   // Pin list
>                        0x0007
>                    }
>                GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
>                    "\\_SB.GPO1", 0x00, ResourceConsumer, ,
>                    )
>                    {   // Pin list
>                        0x0004
>                    }
>            })
>            Return (UBUF) /* \_SB_.PCI0.URT1.BLT0._CRS.UBUF */
>        }
>    }
> 
> Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
> ---
> v2: make compatible with [PATCH v2 2/9] Bluetooth: hci_bcm: Fix setting of irq trigger type
> v3: includes extract of ACPI DSDT table for BCM2EA4 device
> ---
> drivers/bluetooth/hci_bcm.c | 8 ++++++++
> 1 file changed, 8 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

