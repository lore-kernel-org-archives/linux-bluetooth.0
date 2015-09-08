Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] core/device: Only reload database if empty
Date: Tue,  8 Sep 2015 15:23:42 +0300
Message-Id: <1441715022-20327-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1441715022-20327-1-git-send-email-luiz.dentz@gmail.com>
References: <1441715022-20327-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

There is no need to reload the database once it has been populated.
---
 src/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 2102f23..8184508 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4717,7 +4717,8 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	dst = device_get_address(dev);
 	ba2str(dst, dstaddr);
 
-	load_gatt_db(dev, srcaddr, dstaddr);
+	if (gatt_db_isempty(dev->db))
+		load_gatt_db(dev, srcaddr, dstaddr);
 
 	gatt_client_init(dev);
 	gatt_server_init(dev, btd_gatt_database_get_db(database));
-- 
2.4.3

