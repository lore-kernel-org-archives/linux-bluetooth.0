Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] Bluetooth: Add device tree compatible for TI CC2560
Date: Tue, 12 Dec 2017 18:29:29 -0600
Message-Id: <1513124971-23717-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This series updates the bindings TI WiLink 7/8 Bluetooth to add TI CC256x
chips as well. A compatible string is also added to the hci_ll driver for
TI CC2560.

David Lechner (2):
  dt-bindings: net: add TI CC2560 Bluetooth chip
  Bluetooth: hci_ll: add "ti,cc2560" compatible string

 .../bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt}     | 13 +++++++++++--
 drivers/bluetooth/hci_ll.c                                  |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)
 rename Documentation/devicetree/bindings/net/{ti,wilink-st.txt => ti-bluetooth.txt} (78%)

-- 
2.7.4
