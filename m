Return-Path: <ianwmorrison@gmail.com>
To: marcel@holtmann.org, gustavo@padovan.org, johan.hedberg@gmail.com,
 "bluez mailin list (linux-bluetooth@vger.kernel.org)"
 <linux-bluetooth@vger.kernel.org>
Cc: hdegoede@redhat.com, =?UTF-8?Q?Fr=c3=a9d=c3=a9ric_Danis?=
 <frederic.danis.oss@gmail.com>
From: Ian W MORRISON <ianwmorrison@gmail.com>
Subject: [PATCH v3 1/2] Bluetooth: hci_bcm: Add support for MINIX Z83-4 based
 devices
Message-ID: <30dae6f5-b69e-352f-072d-2e1272cbbca8@gmail.com>
Date: Sat, 7 Oct 2017 17:15:25 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-bluetooth.vger.kernel.org>

The MINIX NEO Z83-4 and MINIX NEO Z83-4 Pro devices use an AP6255 chip for wifi and bluetooth. Bluetooth requires an ACPI device id of BCM2EA4 with BCM4345 rev C0 firmware.

This patch adds the device id and to use trigger type IRQF_TRIGGER_FALLING as defined by 'GpioInt' in the ACPI DSDT table:

    Device (BLT0)
    {
        Name (_HID, "BCM2EA4")  // _HID: Hardware ID
        Method (_STA, 0, NotSerialized)  // _STA: Status
        {
            Return (0x0F)
        }

        Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
        {
            Name (UBUF, ResourceTemplate ()
            {
                UartSerialBusV2 (0x0001C200, DataBitsEight, StopBitsOne,
                    0xFC, LittleEndian, ParityTypeNone, FlowControlHardware,
                    0x0020, 0x0020, "\\_SB.PCI0.URT1",
                    0x00, ResourceConsumer, , Exclusive,
                    )
                GpioInt (Level, ActiveLow, Exclusive, PullNone, 0x0000,
                    "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0005
                    }
                GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0007
                    }
                GpioIo (Exclusive, PullDefault, 0x0000, 0x0000, IoRestrictionOutputOnly,
                    "\\_SB.GPO1", 0x00, ResourceConsumer, ,
                    )
                    {   // Pin list
                        0x0004
                    }
            })
            Return (UBUF) /* \_SB_.PCI0.URT1.BLT0._CRS.UBUF */
        }
    }

Signed-off-by: ianwmorrison <ianwmorrison@gmail.com>
---
v2: make compatible with [PATCH v2 2/9] Bluetooth: hci_bcm: Fix setting of irq trigger type
v3: includes extract of ACPI DSDT table for BCM2EA4 device
---
 drivers/bluetooth/hci_bcm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index ab1455e63b92..77326eeb6146 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -726,6 +726,13 @@ static const struct dmi_system_id bcm_active_low_irq_dmi_table[] = {
 			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "ThinkPad 8"),
 		},
 	},
+	{
+		.ident = "MINIX Z83-4",
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "MINIX"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Z83-4"),
+		},
+	},
 	{ }
 };
 
@@ -934,6 +941,7 @@ static const struct acpi_device_id bcm_acpi_match[] = {
 	{ "BCM2E7C", (kernel_ulong_t)&acpi_bcm_int_last_gpios },
 	{ "BCM2E95", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ "BCM2E96", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
+	{ "BCM2EA4", (kernel_ulong_t)&acpi_bcm_int_first_gpios },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bcm_acpi_match);
-- 
2.11.0
