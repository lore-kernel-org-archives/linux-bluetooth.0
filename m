Return-Path: <sre@kernel.org>
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>,
	linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCHv4 0/2] Nokia H4+ support
Date: Thu, 13 Apr 2017 02:26:57 +0200
Message-Id: <20170413002659.25821-1-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

Here is the fourth revision of the nokia bluetooth patchset. Compared
to the previous one the following things have changed:

 * Drop patch 1-8 (applied by Marcel) and update Cc/To for patchset
 * Order includes in the driver alphabetically
 * Explicitly include <linux/of.h> in the nokia bluetooth driver

-- Sebastian

Sebastian Reichel (2):
  dt-bindings: net: bluetooth: Add nokia-bluetooth
  Bluetooth: add nokia driver

 .../devicetree/bindings/net/nokia-bluetooth.txt    |  51 ++
 drivers/bluetooth/Kconfig                          |  12 +
 drivers/bluetooth/Makefile                         |   2 +
 drivers/bluetooth/hci_nokia.c                      | 820 +++++++++++++++++++++
 4 files changed, 885 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/nokia-bluetooth.txt
 create mode 100644 drivers/bluetooth/hci_nokia.c

-- 
2.11.0
