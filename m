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
Subject: [PATCH 0/3] bluetooth: hci_ll: Get MAC address from NVMEM
Date: Sun,  3 Dec 2017 21:21:19 -0600
Message-Id: <1512357682-8911-1-git-send-email-david@lechnology.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This series adds supporting getting the MAC address from a NVMEM provider
for "LL" HCI controllers (Texas Instruments).

The second patch is just cleaning things up before I add another similar
vendor-specific HCI command constant in the final patch.

David Lechner (3):
  dt-bindings: Add optional nvmem MAC address bindings to ti,wlink-st
  bluetooth: hci_ll: add constant for vendor-specific command
  bluetooth: hci_ll: Add optional nvmem MAC address source

 .../devicetree/bindings/net/ti,wilink-st.txt       |  4 ++
 drivers/bluetooth/hci_ll.c                         | 43 +++++++++++++++++++++-
 2 files changed, 45 insertions(+), 2 deletions(-)

-- 
2.7.4
