Return-Path: <Tudor.Ambarus@microchip.com>
From: Tudor Ambarus <tudor.ambarus@microchip.com>
To: <marcel@holtmann.org>, <linux-bluetooth@vger.kernel.org>
CC: <linux-crypto@vger.kernel.org>, Tudor Ambarus
	<tudor.ambarus@microchip.com>
Subject: [RESEND RFC PATCH 0/2] Bluetooth: let the crypto subsystem generate the ecc privkey
Date: Mon, 25 Sep 2017 13:23:54 +0300
Message-ID: <20170925102356.4427-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

That Bluetooth SMP knows about the private key is pointless, since the
detection of debug key usage is actually via the public key portion.
With this patch set, the Bluetooth SMP will stop keeping a copy of the
ecdh private key, except when using debug keys. This way we let the
crypto subsystem to generate and handle the ecdh private key,
potentially benefiting of hardware ecc private key generation and
retention.

Tested with selftest and with btmon and smp-tester on top of hci_vhci,
with ecdh done in both software and hardware (through atmel-ecc driver).
All tests passed.


Tudor Ambarus (2):
  Bluetooth: move ecdh allocation outside of ecdh_helper
  Bluetooth: let the crypto subsystem generate the ecc privkey

 net/bluetooth/ecdh_helper.c | 134 ++++++++++++++++++--------------------------
 net/bluetooth/ecdh_helper.h |   8 ++-
 net/bluetooth/selftest.c    |  29 +++++++---
 net/bluetooth/smp.c         | 120 +++++++++++++++++++++++++--------------
 4 files changed, 157 insertions(+), 134 deletions(-)

-- 
2.9.4
