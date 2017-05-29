Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix discarding valid events if the addres is updated
Date: Mon, 29 May 2017 17:47:02 +0300
Message-Id: <20170529144702.22295-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If a device gets paired while connected and that causes
device_update_addr dev->bdaddr gets overwritten with identity address
but some parts of the code may still use the initial address used to
connect so this makes device_addr_type_cmp check both addresses.
---
 src/device.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 8693eb8..50e7f23 100644
--- a/src/device.c
+++ b/src/device.c
@@ -175,6 +175,8 @@ struct csrk_info {
 struct btd_device {
 	int ref_count;
 
+	bdaddr_t	conn_bdaddr;
+	uint8_t		conn_bdaddr_type;
 	bdaddr_t	bdaddr;
 	uint8_t		bdaddr_type;
 	char		*path;
@@ -2592,6 +2594,9 @@ void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type)
 		return;
 	}
 
+	bacpy(&dev->conn_bdaddr, &dev->bdaddr);
+	dev->conn_bdaddr_type = dev->bdaddr_type;
+
 	/* If this is the first connection over this bearer */
 	if (bdaddr_type == BDADDR_BREDR)
 		device_set_bredr_support(dev);
@@ -4046,8 +4051,11 @@ int device_addr_type_cmp(gconstpointer a, gconstpointer b)
 	if (!dev->le)
 		return -1;
 
-	if (addr->bdaddr_type != dev->bdaddr_type)
+	if (addr->bdaddr_type != dev->bdaddr_type) {
+		if (addr->bdaddr_type == dev->conn_bdaddr_type)
+			return bacmp(&dev->conn_bdaddr, &addr->bdaddr);
 		return -1;
+	}
 
 	return cmp;
 }
-- 
2.9.4

