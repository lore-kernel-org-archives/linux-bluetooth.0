Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/7] android/gatt: Use proper address when connecting
Date: Mon, 23 Jun 2014 16:28:33 +0200
Message-Id: <1403533714-5188-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
References: <1403533714-5188-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device was using RPA but address was resolved IDA must be used.
---
 android/bluetooth.c | 14 ++++++++++++++
 android/bluetooth.h |  2 ++
 android/gatt.c      | 15 +++++++++++++--
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 61bee90..f8c2688 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1436,6 +1436,20 @@ bool bt_is_device_le(const bdaddr_t *addr)
 	return dev->le;
 }
 
+const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type)
+{
+	struct device *dev;
+
+	dev = find_device(addr);
+	if (!dev)
+		return NULL;
+
+	if (type)
+		*type = dev->bdaddr_type;
+
+	return &dev->bdaddr;
+}
+
 const char *bt_get_adapter_name(void)
 {
 	return adapter.name;
diff --git a/android/bluetooth.h b/android/bluetooth.h
index eb50fe1..dde477d 100644
--- a/android/bluetooth.h
+++ b/android/bluetooth.h
@@ -76,3 +76,5 @@ void bt_update_sign_counter(const bdaddr_t *addr, enum bt_csrk_type type);
 void bt_store_gatt_ccc(const bdaddr_t *addr, uint16_t value);
 
 uint16_t bt_get_gatt_ccc(const bdaddr_t *addr);
+
+const bdaddr_t *bt_get_id_addr(const bdaddr_t *addr, uint8_t *type);
diff --git a/android/gatt.c b/android/gatt.c
index 32853fa..af83d96 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1423,6 +1423,8 @@ static int connect_le(struct gatt_device *dev)
 	GIOChannel *io;
 	GError *gerr = NULL;
 	char addr[18];
+	const bdaddr_t *bdaddr;
+	uint8_t bdaddr_type;
 
 	ba2str(&dev->bdaddr, addr);
 
@@ -1437,6 +1439,15 @@ static int connect_le(struct gatt_device *dev)
 	sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
 								BT_IO_SEC_LOW;
 
+	if (dev->bdaddr_type == BDADDR_LE_RANDOM) {
+		bdaddr = bt_get_id_addr(&dev->bdaddr, &bdaddr_type);
+		if (!bdaddr)
+			return -EINVAL;
+	} else {
+		bdaddr = &dev->bdaddr;
+		bdaddr_type = dev->bdaddr_type;
+	}
+
 	/*
 	 * This connection will help us catch any PDUs that comes before
 	 * pairing finishes
@@ -1445,8 +1456,8 @@ static int connect_le(struct gatt_device *dev)
 			BT_IO_OPT_SOURCE_BDADDR,
 			&adapter_addr,
 			BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
-			BT_IO_OPT_DEST_BDADDR, &dev->bdaddr,
-			BT_IO_OPT_DEST_TYPE, dev->bdaddr_type,
+			BT_IO_OPT_DEST_BDADDR, bdaddr,
+			BT_IO_OPT_DEST_TYPE, bdaddr_type,
 			BT_IO_OPT_CID, ATT_CID,
 			BT_IO_OPT_SEC_LEVEL, sec_level,
 			BT_IO_OPT_INVALID);
-- 
1.9.3

