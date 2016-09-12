Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/8] core/device: Load stored attributes before initializing GATT client
Date: Mon, 12 Sep 2016 17:07:32 +0300
Message-Id: <1473689259-9523-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

During gatt_client_init service are requested to accept the connection
which may leads the driver to check existence of attributes.
---
 src/device.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index fd928fc..73bcc8f 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4823,12 +4823,12 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	dst = device_get_address(dev);
 	ba2str(dst, dstaddr);
 
-	gatt_client_init(dev);
-	gatt_server_init(dev, btd_gatt_database_get_db(database));
-
 	if (gatt_db_isempty(dev->db))
 		load_gatt_db(dev, srcaddr, dstaddr);
 
+	gatt_client_init(dev);
+	gatt_server_init(dev, btd_gatt_database_get_db(database));
+
 	/*
 	 * Remove the device from the connect_list and give the passive
 	 * scanning another chance to be restarted in case there are
-- 
2.7.4

