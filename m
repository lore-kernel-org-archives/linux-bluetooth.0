Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 4.16 REGRESSION fix 0/2] Bluetooth: Fix hci_bcm BT devices getting stuck in runtime-suspended status
Date: Wed, 14 Mar 2018 23:06:01 +0100
Message-Id: <20180314220603.7559-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi All,

See the individual commit messages for the what and why of this series
only patch 1/2 is really necessary to fix the regression.

The regression changes a theoretical race window in the hci_bcm IRQ
handling into a real one and the first patch reverts the offending commit
making the race window a theoretical thing again (we would need a 5 second
stall in the right place to trigger it).

The second patch in the series contains a simple fix closing the theoretical
race window, this was tested with the regression still in place and it does
successfully get things unstuck after hitting the race. I guess this can
wait for 4.17, but I'm sending this out as a series as the patches were
developed in tandem.

This series was tested on an Asus T100CHI with a bcm43241b4 wifi/bt combo
chip. 

Regards,

Hans
