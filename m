Return-Path: <j@bitron.ch>
From: =?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=BCrg=20Billeter?= <j@bitron.ch>
Subject: [PATCH] Bluetooth: btintel: Add MODULE_FIRMWARE entries for iBT 3.5 controllers
Date: Tue, 23 May 2017 18:46:25 +0200
Message-Id: <20170523164625.21298-1-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

The iBT 3.5 controllers (Intel 8265, Windstorm Peak) need
intel/ibt-12-16.sfi and intel/ibt-12-16.ddc firmware files from
linux-firmware repository.

Signed-off-by: J=C3=BCrg Billeter <j@bitron.ch>
---
 drivers/bluetooth/btintel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index fce154855718..d32e109bd5cb 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -575,3 +575,5 @@ MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_FIRMWARE("intel/ibt-11-5.sfi");
 MODULE_FIRMWARE("intel/ibt-11-5.ddc");
+MODULE_FIRMWARE("intel/ibt-12-16.sfi");
+MODULE_FIRMWARE("intel/ibt-12-16.ddc");
--=20
2.13.0
