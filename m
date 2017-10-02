Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Sebastian Reichel <sre@kernel.org>,
	robh@kernel.org,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 0/9] Bluetooth: hci_bcm: Add (runtime)pm support to the serdev drv
Date: Mon,  2 Oct 2017 17:23:47 +0200
Message-Id: <20171002152356.4714-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

The ACPI subsys is going to move over to instantiating ACPI enumerated
HCIs as serdevs, rather then as platform devices.

This means that the serdev driver paths of hci_bcm.c also need to start
supporting (runtime)pm through GPIOs and a host-wake IRQ.

This series makes most of the code in hci_bcm.c indepdenent from how
the hci was instantiated and then more or less unifies the platform
and serdev drivers, adding (runtime)pm / GPIO / IRQ support to the
serdev driver.

Besides adding (runtime)pm support, GPIO control in general is necessary
to e.g. keep the ACPI BCM2E7E id used with the BCM4356A2 wifi/bt combo
on the GPD pocket working after moving over to serdev enumeration.

I've chosen to keep the platform enumeration based code paths in place
for now. This way we can first merge this series and then, once this
series is in place, the first 2 patches of Frédéric Danis RFC series
for ACPI serdev support can be merged without causing any regressions.

Once the ACPI serdev support is merged a follow up patch removing the
platform-device related code can be submitted.

Note the 2nd patch in this series is a resend of a bug-fix I submitted
a couple of days ago, I've included that with the series to avoid
conflicts when applying the series without that fix.

Regards,

Hans
