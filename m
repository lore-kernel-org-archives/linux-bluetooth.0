Return-Path: <david@lechnology.com>
From: David Lechner <david@lechnology.com>
To: devicetree@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Cc: David Lechner <david@lechnology.com>,
	Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] Bluetooth: hci_ll: Get BD address from NVMEM 
Date: Tue, 12 Dec 2017 15:59:15 -0600
Message-Id: <1513115958-23761-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This series adds supporting getting the BD address from a NVMEM provider
for "LL" HCI controllers (Texas Instruments).

v3 changes:
* Additional comments on why swapping bytes is needed.
* Fixed comment style and trailing whitespace.
* Rework error handling for nvmem cell code.

v2 changes:
* Fixed typos in dt-bindings
* Use "bd-address" instead of "mac-address"
* Updated dt-bindings to specify the byte order of "bd-address"
* New patch "Bluetooth: hci_ll: add support for setting public address"
* Dropped patch "Bluetooth: hci_ll: add constant for vendor-specific command"
  that is already in bluetooth-next
* Rework error handling
* Use bdaddr_t, bacmp and other bluetooth utils

David Lechner (3):
  Bluetooth: hci_ll: add support for setting public address
  dt-bindings: Add optional nvmem BD address bindings to ti,wlink-st
  Bluetooth: hci_ll: Add optional nvmem BD address source

 .../devicetree/bindings/net/ti,wilink-st.txt       |  5 ++
 drivers/bluetooth/hci_ll.c                         | 77 ++++++++++++++++++++++
 2 files changed, 82 insertions(+)

-- 
2.7.4
