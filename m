Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v2 0/2] SSP MITM protection for General Bonding
Date: Thu, 30 May 2013 11:26:54 +0200
Message-Id: <1369906016-17006-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

I'm reworking Timo's patch originally submitted as "[RFC] Bluetooth: Fix missing MITM protection when being responding LM".

The proposal is to use MITM protection for General Bonding exactly as for Dedicated Bonding (patch 2/2). I can't think of any reason why the current implementation has different policies, leading to not using MITM protection for General Bonding even if the I/O capabilities make it possible.

The proposal is therefore to make both bonding types equal.

Another alternative would be to toggle this behavior through a mgmt API setting.

Mikel Astiz (1):
  Bluetooth: Use defines instead of integer literals

Timo Mueller (1):
  Bluetooth: Use MITM protection when responding LM

 net/bluetooth/hci_event.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

-- 
1.8.1.4

