Return-Path: <cyrus@holtmann.org>
From: Antonio Ospite <ospite@studenti.unina.it>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>
Subject: [PATCH BlueZ 2/2] adapter: add a btd_create_stored_device() call
Date: Sun, 24 Feb 2013 10:54:45 +0100
Message-Id: <1361699686-12341-3-git-send-email-ospite@studenti.unina.it>
In-Reply-To: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
References: <1361699686-12341-1-git-send-email-ospite@studenti.unina.it>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a new btd_* call to add a new device to the database of known
devices.

This is particularly useful to register Bluetooth devices using
a non-Bluetooth mechanism (e.g. USB-pairing in the case of Playstation
peripherals).

The interface uses a btd_ prefix and relies only on native C types in
order to be more easily used by _external_ plugins.

External plugins can only use symbols marked as "global" in
src/bluetooth.ver, this patch avoids making global these symbols:

  store_sdp_record
  str2ba
  adapter_get_device
  device_set_name
  device_set_temporary
  device_set_trusted
---
 src/adapter.h |   11 +++++++++++
 src/adapter.c |   52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/src/adapter.h b/src/adapter.h
index cb6d0d6..13aadb5 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -207,3 +207,14 @@ void adapter_store_cached_name(const bdaddr_t *local, const bdaddr_t *peer,
 void btd_adapter_for_each_device(struct btd_adapter *adapter,
 			void (*cb)(struct btd_device *device, void *data),
 			void *data);
+
+int btd_create_stored_device(char *adapter_address,
+			     char *device_address,
+			     char *name,
+			     uint16_t vendor_id_source,
+			     uint16_t vendor_id,
+			     uint16_t product_id,
+			     uint16_t version_id,
+			     const char *uuid,
+			     char *sdp_record,
+			     bool trusted);
diff --git a/src/adapter.c b/src/adapter.c
index 5eac84f..7aee8f3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6196,3 +6196,55 @@ void adapter_shutdown(void)
 	if (!adapter_remaining)
 		btd_exit();
 }
+
+int btd_create_stored_device(char *adapter_address,
+			     char *device_address,
+			     char *name,
+			     uint16_t vendor_id_source,
+			     uint16_t vendor_id,
+			     uint16_t product_id,
+			     uint16_t version_id,
+			     const char *uuid,
+			     char *sdp_record,
+			     bool trusted)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	bdaddr_t dst;
+	int ret = 0;
+
+	store_sdp_record(adapter_address, device_address, 0x10000, sdp_record);
+
+	str2ba(device_address, &dst);
+
+	adapter = btd_adapter_get_default();
+	if (adapter == NULL) {
+		DBG("Failed to get the adapter");
+		ret = -EPERM;
+		goto out;
+	}
+
+	/* This will create the device if necessary */
+	device = adapter_get_device(adapter, &dst, BDADDR_BREDR);
+	if (device == NULL) {
+		DBG("Failed to get the device");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	if (name)
+		device_set_name(device, name);
+
+	btd_device_set_pnpid(device, vendor_id_source,
+			vendor_id, product_id, version_id);
+
+	if (uuid)
+		btd_device_add_uuid(device, uuid);
+
+	device_set_temporary(device, FALSE);
+
+	if (trusted)
+		device_set_trusted(device, TRUE);
+out:
+	return ret;
+}
-- 
1.7.10.4

