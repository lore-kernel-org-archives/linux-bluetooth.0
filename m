Return-Path: <jhovold@gmail.com>
Sender: Johan Hovold <jhovold@gmail.com>
From: Johan Hovold <johan@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 0/2] Bluetooth: fix hci-uart crashes
Date: Wed, 29 Mar 2017 18:15:26 +0200
Message-Id: <20170329161528.17843-1-johan@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Not every tty has a class device and this could be used to trigger
NULL-pointer dereferences in two hci-uart drivers that lacked the
required sanity checks.

Johan


Johan Hovold (2):
  Bluetooth: hci_bcm: add missing tty-device sanity check
  Bluetooth: hci_intel: add missing tty-device sanity check

 drivers/bluetooth/hci_bcm.c   |  5 ++++-
 drivers/bluetooth/hci_intel.c | 13 ++++++++++++-
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.12.2
