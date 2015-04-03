Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 21/27] android/hog: Strip btio dependencies
Date: Fri,  3 Apr 2015 15:43:50 +0200
Message-Id: <1428068636-13073-22-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

bt_io_get from btio library is used only to get address of adapter
and connected hid device. We can just simply pass this addresses
using bt_hog_new argument list. It's temporary solution, just to
be able to move the code to profiles/input.
---
 android/hidhost.c |  3 ++-
 android/hog.c     | 36 +++++++++++++++++-------------------
 android/hog.h     | 10 ++++++----
 unit/test-hog.c   |  7 ++++++-
 4 files changed, 31 insertions(+), 25 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index e1392f6..f9b7c24 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -860,7 +860,8 @@ static void hog_conn_cb(const bdaddr_t *addr, int err, void *attrib)
 	if (!dev->hog) {
 		/* TODO: Get device details */
 		dev->hog = bt_hog_new_default("bluez-input-device", dev->vendor,
-					dev->product, dev->version, 0);
+					dev->product, dev->version, addr,
+					&adapter_addr, 0);
 		if (!dev->hog) {
 			error("HoG: unable to create session");
 			goto fail;
diff --git a/android/hog.c b/android/hog.c
index eaac097..d7a00ba 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -54,8 +54,6 @@
 #include "attrib/gattrib.h"
 #include "attrib/gatt.h"
 
-#include "btio/btio.h"
-
 #include "android/scpp.h"
 #include "android/dis.h"
 #include "android/bas.h"
@@ -77,9 +75,12 @@
 #define HOG_REPORT_MAP_MAX_SIZE        512
 #define HID_INFO_SIZE			4
 
+static bdaddr_t	adapter_addr;
+
 struct bt_hog {
 	int			ref_count;
 	uint16_t		service_handle;
+	bdaddr_t		device_addr;
 	char			*name;
 	uint16_t		vendor;
 	uint16_t		product;
@@ -692,22 +693,13 @@ static bool uhid_create(struct bt_hog *hog, const uint8_t *value, uint16_t vlen)
 {
 	struct uhid_event ev;
 	int err;
-	GError *gerr = NULL;
 
 	/* create uHID device */
 	memset(&ev, 0, sizeof(ev));
 	ev.type = UHID_CREATE;
 
-	bt_io_get(g_attrib_get_channel(hog->attrib), &gerr,
-			BT_IO_OPT_SOURCE, ev.u.create.phys,
-			BT_IO_OPT_DEST, ev.u.create.uniq,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("Failed to connection details: %s", gerr->message);
-		g_error_free(gerr);
-		return false;
-	}
-
+	ba2str(&adapter_addr, (char *) ev.u.create.phys);
+	ba2str(&hog->device_addr, (char *) ev.u.create.uniq);
 	strcpy((char *) ev.u.create.name, hog->name);
 	ev.u.create.vendor = hog->vendor;
 	ev.u.create.product = hog->product;
@@ -886,15 +878,18 @@ static void hog_free(void *data)
 }
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
-					uint16_t product, uint16_t version,
-					uint16_t service_handle)
+				uint16_t product, uint16_t version,
+				const bdaddr_t *addr, const bdaddr_t *adapter,
+				uint16_t service_handle)
 {
-	return bt_hog_new(-1, name, vendor, product, version, service_handle);
+	return bt_hog_new(-1, name, vendor, product, version, addr, adapter,
+								service_handle);
 }
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
-					uint16_t product, uint16_t version,
-					uint16_t service_handle)
+				uint16_t product, uint16_t version,
+				const bdaddr_t *addr, const bdaddr_t *adapter,
+				uint16_t service_handle)
 {
 	struct bt_hog *hog;
 
@@ -922,6 +917,8 @@ struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
 	hog->vendor = vendor;
 	hog->product = product;
 	hog->version = version;
+	bacpy(&hog->device_addr, addr);
+	bacpy(&adapter_addr, adapter);
 
 	if (service_handle)
 		hog->service_handle = service_handle;
@@ -1022,7 +1019,8 @@ static void hog_attach_hog(struct bt_hog *hog, uint16_t service_handle)
 	}
 
 	instance = bt_hog_new(hog->uhid_fd, hog->name, hog->vendor,
-				hog->product, hog->version, service_handle);
+				hog->product, hog->version, &hog->device_addr,
+				&adapter_addr, service_handle);
 	if (!instance)
 		return;
 
diff --git a/android/hog.h b/android/hog.h
index cfe6873..8fe8422 100644
--- a/android/hog.h
+++ b/android/hog.h
@@ -24,12 +24,14 @@
 struct bt_hog;
 
 struct bt_hog *bt_hog_new_default(const char *name, uint16_t vendor,
-					uint16_t product, uint16_t version,
-					uint16_t service_handle);
+				uint16_t product, uint16_t version,
+				const bdaddr_t *addr, const bdaddr_t *adapter,
+				uint16_t service_handle);
 
 struct bt_hog *bt_hog_new(int fd, const char *name, uint16_t vendor,
-					uint16_t product, uint16_t version,
-					uint16_t service_handle);
+				uint16_t product, uint16_t version,
+				const bdaddr_t *addr, const bdaddr_t *adapter,
+				uint16_t service_handle);
 
 struct bt_hog *bt_hog_ref(struct bt_hog *hog);
 void bt_hog_unref(struct bt_hog *hog);
diff --git a/unit/test-hog.c b/unit/test-hog.c
index 5794c5e..16805e7 100644
--- a/unit/test-hog.c
+++ b/unit/test-hog.c
@@ -32,6 +32,8 @@
 
 #include <glib.h>
 
+#include "lib/bluetooth.h"
+
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
 
@@ -179,6 +181,8 @@ static struct context *create_context(gconstpointer data)
 	uint16_t vendor = 0x0002;
 	uint16_t product = 0x0001;
 	uint16_t version = 0x0001;
+	const bdaddr_t *device_addr = NULL;
+	const bdaddr_t *adapter_addr = NULL;
 
 	context = g_new0(struct context, 1);
 	err = socketpair(AF_UNIX, SOCK_SEQPACKET | SOCK_CLOEXEC, 0, sv);
@@ -196,7 +200,8 @@ static struct context *create_context(gconstpointer data)
 	fd = open("/dev/null", O_WRONLY | O_CLOEXEC);
 	g_assert(fd > 0);
 
-	context->hog = bt_hog_new(fd, name, vendor, product, version, 0);
+	context->hog = bt_hog_new(fd, name, vendor, product, version,
+						device_addr, adapter_addr, 0);
 	g_assert(context->hog);
 
 	channel = g_io_channel_unix_new(sv[1]);
-- 
1.9.1

