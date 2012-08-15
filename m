Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ v2 03/14] core: add compare function for bdaddr in a struct btd_device
Date: Wed, 15 Aug 2012 11:50:42 -0300
Message-Id: <1345042253-15053-4-git-send-email-jprvita@openbossa.org>
In-Reply-To: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
References: <1345042253-15053-1-git-send-email-jprvita@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a utility function similar to device_address_cmp but comparing
bdaddr instead of the string representing the address. This way is
possible to avoid allocating two buffers to temporarily hold the
strings, two sprintf() calls to generate the strings from the bdaddr
arrays, and a string comparison, substituting all of it for one memcmp()
call.
---
 src/device.c | 5 +++++
 src/device.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index dad9c79..24b9065 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1228,6 +1228,11 @@ gint device_address_cmp(struct btd_device *device, const gchar *address)
 	return strcasecmp(addr, address);
 }
 
+gint device_bdaddr_cmp(struct btd_device *device, bdaddr_t *bdaddr)
+{
+	return bacmp(&device->bdaddr, bdaddr);
+}
+
 static gboolean record_has_uuid(const sdp_record_t *rec,
 				const char *profile_uuid)
 {
diff --git a/src/device.h b/src/device.h
index 26e17f7..2b2e6d8 100644
--- a/src/device.h
+++ b/src/device.h
@@ -45,6 +45,7 @@ uint16_t btd_device_get_product(struct btd_device *device);
 uint16_t btd_device_get_version(struct btd_device *device);
 void device_remove(struct btd_device *device, gboolean remove_stored);
 gint device_address_cmp(struct btd_device *device, const gchar *address);
+gint device_bdaddr_cmp(struct btd_device *device, bdaddr_t *bdaddr);
 int device_browse_primary(struct btd_device *device, DBusConnection *conn,
 				DBusMessage *msg, gboolean secure);
 int device_browse_sdp(struct btd_device *device, DBusConnection *conn,
-- 
1.7.11.2

