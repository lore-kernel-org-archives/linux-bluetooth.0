Return-Path: <cyrus@holtmann.org>
From: Arek Lichwa <arkadiusz.lichwa@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Subject: [PATCH] did: Make VID assigner configurable.
Date: Fri, 19 Aug 2011 16:00:38 +0200
Message-ID: <1313762438-15609-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The organization that assigns VID now can be configurable
in main.conf file under DeviceID key.
Available assigners are: BTSig and USB impl forum.
---
 src/hcid.h         |    2 +-
 src/main.conf      |    9 +++++--
 src/sdpd-server.c  |   54 ++++++++++++++++++++++++++++++++++++++++++---------
 src/sdpd-service.c |   11 +++++----
 src/sdpd.h         |    4 +-
 5 files changed, 59 insertions(+), 21 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index ea038e9..74df74c 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -42,7 +42,7 @@ struct main_opts {
 
 	uint8_t		mode;
 	uint8_t		discov_interval;
-	char		deviceid[15]; /* FIXME: */
+	char		deviceid[25]; /* FIXME: */
 };
 
 enum {
diff --git a/src/main.conf b/src/main.conf
index 8cd132f..55b95bf 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -37,9 +37,12 @@ InitiallyPowered = true
 # Remember the previously stored Powered state when initializing adapters
 RememberPowered = true
 
-# Use vendor, product and version information for DID profile support.
-# The values are separated by ":" and VID, PID and version.
-#DeviceID = 1234:5678:abcd
+# Use assigner, vendor, product and version information for DID profile
+# support. The values are separated by ":" and assigner, VID, PID and version.
+# The minimum valid data is VID:PID.
+# If assigner organization is missed, the "bluetooth" is default. Alternative
+# is "usb". The VID, PID, version are in hex format, max 4 digits each.
+#DeviceID = bluetooth:1234:5678:ABCD
 
 # Do reverse service discovery for previously unknown devices that connect to
 # us. This option is really only needed for qualification since the BITE tester
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index a92ae2c..402782d 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -241,17 +241,51 @@ int start_sdp_server(uint16_t mtu, const char *did, uint32_t flags)
 	}
 
 	if (did && strlen(did) > 0) {
+		struct did_assigner_org_t {
+				const char *assigner_org_name;
+				unsigned char id;
+		};
+		const struct did_assigner_org_t assigner_org[] =
+						{{"bluetooth", 1}, {"usb", 2}};
+		size_t n_elem = sizeof(assigner_org) / sizeof(assigner_org[0]);
+
 		const char *ptr = did;
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
+		unsigned short m;
+		unsigned short did_register_data[4] =
+		{ /*bluetooth*/ 1, /*vid*/ 0, /*pid*/ 0, /*ver*/ 0 };
+
+		char **tokens = NULL;
+		tokens = g_strsplit(ptr, ":", 4);
+
+		if (tokens) {
+			unsigned int len = g_strv_length(tokens);
+			/* update did_register_data[0] */
+			if (len == 4) {
+				for (m = 0; tokens[0][0] && m < n_elem; m++) {
+					if (strcasecmp(g_strstrip(tokens[0]),
+							assigner_org[m].assigner_org_name) == 0) {
+						did_register_data[0] = assigner_org[m].id;
+						break;
+					}
+				}
+			}
+			/* update did_register_data[1,2,3] */
+			if (len == 4) {
+				for (m = 1; m < len; m++)
+					sscanf(g_strstrip(tokens[m]),
+							"%4hx", &did_register_data[m]);
+			} else if (len > 1 && len < 4) {
+				for (m = 1; m < len+1; m++)
+					sscanf(g_strstrip(tokens[m-1]),
+							"%4hx", &did_register_data[m]);
+			}
+
+			g_strfreev(tokens);
+			if (len > 1)
+				register_device_id(did_register_data[0],
+							did_register_data[1],
+							did_register_data[2],
+							did_register_data[3]);
 		}
 	}
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index de11562..80c6166 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -172,10 +172,10 @@ void register_server_service(void)
 	update_db_timestamp();
 }
 
-void register_device_id(const uint16_t vendor, const uint16_t product,
-						const uint16_t version)
+void register_device_id(const uint16_t assigner_org, const uint16_t vendor,
+						const uint16_t product,	const uint16_t version)
 {
-	const uint16_t spec = 0x0102, source = 0x0002;
+	const uint16_t spec = 0x0102;
 	const uint8_t primary = 1;
 	sdp_list_t *class_list, *group_list, *profile_list;
 	uuid_t class_uuid, group_uuid;
@@ -184,7 +184,8 @@ void register_device_id(const uint16_t vendor, const uint16_t product,
 	sdp_profile_desc_t profile;
 	sdp_record_t *record = sdp_record_alloc();
 
-	info("Adding device id record for %04x:%04x", vendor, product);
+	info("Adding device id record for %04x:%04x:%04x:%04x",
+			assigner_org, vendor, product, version);
 
 	btd_manager_set_did(vendor, product, version);
 
@@ -225,7 +226,7 @@ void register_device_id(const uint16_t vendor, const uint16_t product,
 	primary_data = sdp_data_alloc(SDP_BOOL, &primary);
 	sdp_attr_add(record, 0x0204, primary_data);
 
-	source_data = sdp_data_alloc(SDP_UINT16, &source);
+	source_data = sdp_data_alloc(SDP_UINT16, &assigner_org);
 	sdp_attr_add(record, 0x0205, source_data);
 
 	update_db_timestamp();
diff --git a/src/sdpd.h b/src/sdpd.h
index 9f5415f..87dba51 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -53,8 +53,8 @@ int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp);
 
 void register_public_browse_group(void);
 void register_server_service(void);
-void register_device_id(const uint16_t vendor, const uint16_t product,
-						const uint16_t version);
+void register_device_id(const uint16_t assigner_org, const uint16_t vendor,
+						const uint16_t product,	const uint16_t version);
 
 int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
-- 
1.7.6.433.g1421f

