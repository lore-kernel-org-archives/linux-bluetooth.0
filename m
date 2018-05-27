Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	robh@kernel.org,
	Jeremy Cline <jeremy@jcline.org>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH 00/13] Bluetooth: Add RTL8723BS support
Date: Sun, 27 May 2018 21:04:44 +0200
Message-Id: <20180527190457.2632-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

Here is a series of patches adding support for RTL8723BS' bluetooth
component through serdev enumration.

This builds on the great work done on this by Martin Blumenstingl
which makes the btrtl.c code also support firmware+config loading
for the RTL8723BS, as well as Jeremy's Cline work to add ACPI
enumeration support on top of this.

I've tested this series on several Intel boards with a RTL8723BS
chip. As such this series only hooks up ACPI enumerated devices.

Adding support for devicetree enumeration using the bindings already
defined for this by Martin should be trivial for someone who has
the necessary hardware to develop this.

Regards,

Hans
