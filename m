Return-Path: <hdegoede@redhat.com>
Subject: Re: [PATCH v3 5/9] Bluetooth: btrtl: Add support for a config
 filename postfix
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Jeremy Cline <jeremy@jcline.org>, linux-bluetooth@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20180710081117.25078-1-hdegoede@redhat.com>
 <20180710081117.25078-6-hdegoede@redhat.com>
 <330BDF4A-9729-4DFE-B9DA-F5A02EB6B09A@holtmann.org>
From: Hans de Goede <hdegoede@redhat.com>
Message-ID: <5ae41511-a919-7aa8-d3bd-a65dea7a0eae@redhat.com>
Date: Thu, 19 Jul 2018 18:12:23 +0200
MIME-Version: 1.0
In-Reply-To: <330BDF4A-9729-4DFE-B9DA-F5A02EB6B09A@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Thank you for the review of the other patches, I will prepare
a new version addressing your remarks on the other patches.

On 14-07-18 18:06, Marcel Holtmann wrote:
> Hi Hans,
> 
>> The contents of the rtl_bt/rtlXXXX_config.bin file may be board specific
>> allow the caller of btrtl_initialize to specify a postfix identifying
>> the board, which if specified will make btrtl_initialize look for
>> rtl_bt/rtlXXXX_config-<postfix>.bin instead.
> 
> frankly I do not get this patch. Where would the <postfix> come from? Is that something we would put into DT or where? I think you need a bit more explanation here.

As mentioned before this patch-set only adds support for ACPI
enumeration for now as I don't have hw to test the DT enumeration.

For ACPI enumeration I use the ACPI HID, as can be seen in the
"Bluetooth: hci_h5: Add vendor setup, open, and close callbacks"
patch which does:

+	if (has_acpi_companion(dev)) {
+		match = acpi_match_device(dev->driver->acpi_match_table, dev);
+		if (!match)
+			return -ENODEV;
+
+		h5->vnd = (const struct h5_vnd *)match->driver_data;
+		h5->id  = (char *)match->id;
+	}
+

And then the "Bluetooth: hci_h5: Add support for the RTL8723BS"
passes h5->id as postfix:

+static int h5_btrtl_setup(struct h5 *h5)
+{
+	struct btrtl_device_info *btrtl_dev;
+	struct sk_buff *skb;
+	__le32 baudrate_data;
+	u32 device_baudrate;
+	unsigned int controller_baudrate;
+	bool flow_control;
+	int err;
+
+	btrtl_dev = btrtl_initialize(h5->hu->hdev, h5->id);
+

For DT we could either use a property in the node
describing the BT device as postfix, or since we want
to have a unique per board name use the machine "compatible"
string as postfix.

Regards,

Hans
