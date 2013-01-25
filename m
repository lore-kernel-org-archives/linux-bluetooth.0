Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 2/6] device: Fix memory leak while storing GATT capable devices
Date: Fri, 25 Jan 2013 00:07:03 -0300
Message-Id: <1359083227-13122-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1359083227-13122-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_uuid2string() returns a newly allocated string, and so it should
be free'd.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 893e4bb..6c4455b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2814,6 +2814,8 @@ static void store_services(struct btd_device *device)
 
 	sdp_uuid16_create(&uuid, GATT_PRIM_SVC_UUID);
 	prim_uuid = bt_uuid2string(&uuid);
+	if (prim_uuid == NULL)
+		return;
 
 	ba2str(adapter_get_address(adapter), src_addr);
 	ba2str(&device->bdaddr, dst_addr);
@@ -2862,6 +2864,7 @@ static void store_services(struct btd_device *device)
 		g_file_set_contents(filename, data, length, NULL);
 	}
 
+	g_free(prim_uuid);
 	g_free(data);
 	g_key_file_free(key_file);
 }
-- 
1.8.1.1

