Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH V4 1/7] Parse config DeviceID string on bluetoothd startup
Date: Wed, 28 Mar 2012 12:03:13 +0200
Message-ID: <1332928999-14224-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of parsing config DeviceID string on sdp server startup, parse
it in main while reading config file. This allow to store logical DID
values in main_opts (instead of raw config string) and make use of them
in bluetoothd code.
---
 src/hcid.h         |    6 +++++-
 src/main.c         |   20 +++++++++++++++++---
 src/sdpd-server.c  |   19 ++++---------------
 src/sdpd-service.c |   20 +++++++++++---------
 src/sdpd.h         |    5 ++---
 5 files changed, 39 insertions(+), 31 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index df2829a..2c1cbff 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -42,7 +42,11 @@ struct main_opts {
 
 	uint8_t		mode;
 	uint8_t		discov_interval;
-	char		deviceid[15]; /* FIXME: */
+
+	uint16_t	did_source;
+	uint16_t	did_vendor;
+	uint16_t	did_product;
+	uint16_t	did_version;
 };
 
 enum {
diff --git a/src/main.c b/src/main.c
index f01e070..4e0cb5a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -87,6 +87,21 @@ static GKeyFile *load_config(const char *file)
 	return keyfile;
 }
 
+static void parse_did(const char *did)
+{
+	int result;
+	uint16_t vendor, product, version = 0x0000; /* version is optional */
+
+	result = sscanf(did, "%4hx:%4hx:%4hx", &vendor, &product, &version);
+	if (result == EOF || result < 2)
+		return;
+
+	main_opts.did_source = 0x0002;
+	main_opts.did_vendor = vendor;
+	main_opts.did_product = product;
+	main_opts.did_version = version;
+}
+
 static void parse_config(GKeyFile *config)
 {
 	GError *err = NULL;
@@ -192,8 +207,7 @@ static void parse_config(GKeyFile *config)
 		g_clear_error(&err);
 	} else {
 		DBG("deviceid=%s", str);
-		strncpy(main_opts.deviceid, str,
-					sizeof(main_opts.deviceid) - 1);
+		parse_did(str);
 		g_free(str);
 	}
 
@@ -516,7 +530,7 @@ int main(int argc, char *argv[])
 		}
 	}
 
-	start_sdp_server(mtu, main_opts.deviceid, SDP_SERVER_COMPAT);
+	start_sdp_server(mtu, SDP_SERVER_COMPAT);
 
 	/* Loading plugins has to be done after D-Bus has been setup since
 	 * the plugins might wanna expose some paths on the bus. However the
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index a92ae2c..1d9509e 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -45,6 +45,7 @@
 
 #include <glib.h>
 
+#include "hcid.h"
 #include "log.h"
 #include "sdpd.h"
 
@@ -227,7 +228,7 @@ static gboolean io_accept_event(GIOChannel *chan, GIOCondition cond, gpointer da
 	return TRUE;
 }
 
-int start_sdp_server(uint16_t mtu, const char *did, uint32_t flags)
+int start_sdp_server(uint16_t mtu, uint32_t flags)
 {
 	int compat = flags & SDP_SERVER_COMPAT;
 	int master = flags & SDP_SERVER_MASTER;
@@ -240,20 +241,8 @@ int start_sdp_server(uint16_t mtu, const char *did, uint32_t flags)
 		return -1;
 	}
 
-	if (did && strlen(did) > 0) {
-		const char *ptr = did;
-		uint16_t vid = 0x0000, pid = 0x0000, ver = 0x0000;
-
-		vid = (uint16_t) strtol(ptr, NULL, 16);
-		ptr = strchr(ptr, ':');
-		if (ptr) {
-			pid = (uint16_t) strtol(ptr + 1, NULL, 16);
-			ptr = strchr(ptr + 1, ':');
-			if (ptr)
-				ver = (uint16_t) strtol(ptr + 1, NULL, 16);
-			register_device_id(vid, pid, ver);
-		}
-	}
+	if (main_opts.did_source > 0)
+		register_device_id();
 
 	io = g_io_channel_unix_new(l2cap_sock);
 	g_io_channel_set_close_on_unref(io, TRUE);
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index de11562..eb4b74c 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -44,6 +44,7 @@
 #include <glib.h>
 #include <dbus/dbus.h>
 
+#include "hcid.h"
 #include "sdpd.h"
 #include "log.h"
 #include "adapter.h"
@@ -172,10 +173,9 @@ void register_server_service(void)
 	update_db_timestamp();
 }
 
-void register_device_id(const uint16_t vendor, const uint16_t product,
-						const uint16_t version)
+void register_device_id(void)
 {
-	const uint16_t spec = 0x0102, source = 0x0002;
+	const uint16_t spec = 0x0102;
 	const uint8_t primary = 1;
 	sdp_list_t *class_list, *group_list, *profile_list;
 	uuid_t class_uuid, group_uuid;
@@ -184,9 +184,11 @@ void register_device_id(const uint16_t vendor, const uint16_t product,
 	sdp_profile_desc_t profile;
 	sdp_record_t *record = sdp_record_alloc();
 
-	info("Adding device id record for %04x:%04x", vendor, product);
+	info("Adding device id record for %04x:%04x:%04x", main_opts.did_vendor,
+				main_opts.did_product, main_opts.did_version);
 
-	btd_manager_set_did(vendor, product, version);
+	btd_manager_set_did(main_opts.did_vendor, main_opts.did_product,
+							main_opts.did_version);
 
 	record->handle = sdp_next_handle();
 
@@ -213,19 +215,19 @@ void register_device_id(const uint16_t vendor, const uint16_t product,
 	spec_data = sdp_data_alloc(SDP_UINT16, &spec);
 	sdp_attr_add(record, 0x0200, spec_data);
 
-	vendor_data = sdp_data_alloc(SDP_UINT16, &vendor);
+	vendor_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_vendor);
 	sdp_attr_add(record, 0x0201, vendor_data);
 
-	product_data = sdp_data_alloc(SDP_UINT16, &product);
+	product_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_product);
 	sdp_attr_add(record, 0x0202, product_data);
 
-	version_data = sdp_data_alloc(SDP_UINT16, &version);
+	version_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_version);
 	sdp_attr_add(record, 0x0203, version_data);
 
 	primary_data = sdp_data_alloc(SDP_BOOL, &primary);
 	sdp_attr_add(record, 0x0204, primary_data);
 
-	source_data = sdp_data_alloc(SDP_UINT16, &source);
+	source_data = sdp_data_alloc(SDP_UINT16, &main_opts.did_source);
 	sdp_attr_add(record, 0x0205, source_data);
 
 	update_db_timestamp();
diff --git a/src/sdpd.h b/src/sdpd.h
index 9f5415f..83d2b03 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -53,8 +53,7 @@ int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp);
 
 void register_public_browse_group(void);
 void register_server_service(void);
-void register_device_id(const uint16_t vendor, const uint16_t product,
-						const uint16_t version);
+void register_device_id(void);
 
 int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
@@ -74,7 +73,7 @@ uint32_t sdp_get_time(void);
 #define SDP_SERVER_COMPAT (1 << 0)
 #define SDP_SERVER_MASTER (1 << 1)
 
-int start_sdp_server(uint16_t mtu, const char *did, uint32_t flags);
+int start_sdp_server(uint16_t mtu, uint32_t flags);
 void stop_sdp_server(void);
 
 int add_record_to_server(const bdaddr_t *src, sdp_record_t *rec);
-- 
on behalf of ST-Ericsson

