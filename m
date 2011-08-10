Return-Path: <cyrus@holtmann.org>
From: Arek Lichwa <arkadiusz.lichwa@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Arek Lichwa <arkadiusz.lichwa@tieto.com>
Subject: [PATCH] Fix PTS DID test case TP/SDI/BV-03-I
Date: Wed, 10 Aug 2011 16:06:44 +0200
Message-ID: <1312985204-10311-1-git-send-email-arkadiusz.lichwa@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now it's allowed to specify arbitrary vendor ID assigner in main.conf
file to be able verify PTS against DID test case TP/SDI/BV-03-I.
Available supported vendor assigner's are: BT SIG (0x1) and
USB Implementer's Forum (0x2).
---
 src/hcid.h         |    2 +-
 src/main.conf      |    7 ++++---
 src/sdpd-server.c  |   18 +++++++-----------
 src/sdpd-service.c |   14 +++++++++++---
 src/sdpd.h         |    4 ++--
 5 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/src/hcid.h b/src/hcid.h
index ea038e9..60e0ede 100644
--- a/src/hcid.h
+++ b/src/hcid.h
@@ -42,7 +42,7 @@ struct main_opts {
 
 	uint8_t		mode;
 	uint8_t		discov_interval;
-	char		deviceid[15]; /* FIXME: */
+	char		deviceid[20]; /* FIXME: */
 };
 
 enum {
diff --git a/src/main.conf b/src/main.conf
index 8cd132f..76779ba 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -37,9 +37,10 @@ InitiallyPowered = true
 # Remember the previously stored Powered state when initializing adapters
 RememberPowered = true
 
-# Use vendor, product and version information for DID profile support.
-# The values are separated by ":" and VID, PID and version.
-#DeviceID = 1234:5678:abcd
+# Use vendor assigner, vendor, product and version information for DID profile
+# support. The values are separated by ":" and VID assigner, VID, PID and
+# version. The values need to be in hex format.
+#DeviceID = 2:1234:5678:abcd
 
 # Do reverse service discovery for previously unknown devices that connect to
 # us. This option is really only needed for qualification since the BITE tester
diff --git a/src/sdpd-server.c b/src/sdpd-server.c
index a92ae2c..e54c397 100644
--- a/src/sdpd-server.c
+++ b/src/sdpd-server.c
@@ -241,17 +241,13 @@ int start_sdp_server(uint16_t mtu, const char *did, uint32_t flags)
 	}
 
 	if (did && strlen(did) > 0) {
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
+		uint16_t vid = 0x0000, pid = 0x0000, ver = 0x0000, vid_assigner = 0x0000;
+		int result = EOF;
+		result = sscanf(did, "%4hx:%4hx:%4hx:%4hx", &vid_assigner, &vid, &pid, &ver);
+		if (result != EOF && result > 3) {
+			register_device_id(vid_assigner, vid, pid, ver);
+		} else {
+			info("DeviceID record not registered");
 		}
 	}
 
diff --git a/src/sdpd-service.c b/src/sdpd-service.c
index de11562..86f7d73 100644
--- a/src/sdpd-service.c
+++ b/src/sdpd-service.c
@@ -172,8 +172,8 @@ void register_server_service(void)
 	update_db_timestamp();
 }
 
-void register_device_id(const uint16_t vendor, const uint16_t product,
-						const uint16_t version)
+void register_device_id(const uint16_t vendor_assigner, const uint16_t vendor,
+                        const uint16_t product, const uint16_t version)
 {
 	const uint16_t spec = 0x0102, source = 0x0002;
 	const uint8_t primary = 1;
@@ -225,7 +225,15 @@ void register_device_id(const uint16_t vendor, const uint16_t product,
 	primary_data = sdp_data_alloc(SDP_BOOL, &primary);
 	sdp_attr_add(record, 0x0204, primary_data);
 
-	source_data = sdp_data_alloc(SDP_UINT16, &source);
+	/* check whether config's vendor ID assigner is valid
+	 * 0x0001 - BT SIG vendor id assigner
+	 * 0x0002 - USB Implementer's forum vendor id assigner (here default)
+	 */
+	if (vendor_assigner > 0 &&  vendor_assigner < 3)
+		source_data = sdp_data_alloc(SDP_UINT16, &vendor_assigner);
+	else
+		source_data = sdp_data_alloc(SDP_UINT16, &source);
+
 	sdp_attr_add(record, 0x0205, source_data);
 
 	update_db_timestamp();
diff --git a/src/sdpd.h b/src/sdpd.h
index 9f5415f..5ad44b2 100644
--- a/src/sdpd.h
+++ b/src/sdpd.h
@@ -53,8 +53,8 @@ int service_remove_req(sdp_req_t *req, sdp_buf_t *rsp);
 
 void register_public_browse_group(void);
 void register_server_service(void);
-void register_device_id(const uint16_t vendor, const uint16_t product,
-						const uint16_t version);
+void register_device_id(const uint16_t vendor_assigner, const uint16_t vendor,
+                        const uint16_t product, const uint16_t version);
 
 int record_sort(const void *r1, const void *r2);
 void sdp_svcdb_reset(void);
-- 
1.7.6.433.g1421f

