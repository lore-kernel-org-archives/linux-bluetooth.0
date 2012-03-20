Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH V2 7/7] Move common code to sdp to avoid duplication
Date: Tue, 20 Mar 2012 17:27:27 +0100
Message-ID: <1332260847-20079-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
References: <1332260847-20079-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

LanguageBaseAttributeIDList is set from few places and each time static
function was copied and used for that. Move this funtion to sdp code
and use that instead of copying code.
---
 compat/sdp.c     |   16 +---------------
 lib/sdp.c        |   13 +++++++++++++
 lib/sdp_lib.h    |    2 ++
 network/server.c |   16 +---------------
 serial/proxy.c   |   16 +---------------
 tools/sdptool.c  |   20 +++-----------------
 6 files changed, 21 insertions(+), 62 deletions(-)

diff --git a/compat/sdp.c b/compat/sdp.c
index f384844..9ad8333 100644
--- a/compat/sdp.c
+++ b/compat/sdp.c
@@ -47,20 +47,6 @@
 static sdp_record_t *record = NULL;
 static sdp_session_t *session = NULL;
 
-static void add_lang_attr(sdp_record_t *r)
-{
-	sdp_lang_attr_t base_lang;
-	sdp_list_t *langs = 0;
-
-	/* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) */
-	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
-	base_lang.encoding = 106;
-	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
-	langs = sdp_list_append(0, &base_lang);
-	sdp_set_lang_attr(r, langs);
-	sdp_list_free(langs, 0);
-}
-
 static void epox_endian_quirk(unsigned char *data, int size)
 {
 	/* USAGE_PAGE (Keyboard)	05 07
@@ -448,7 +434,7 @@ int bnep_sdp_register(bdaddr_t *device, uint16_t role)
 	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	add_lang_attr(record);
+	sdp_add_lang_attr(record);
 
 	sdp_list_free(proto[0], NULL);
 	sdp_list_free(proto[1], NULL);
diff --git a/lib/sdp.c b/lib/sdp.c
index 57f630a..87fe5be 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -4789,3 +4789,16 @@ fail:
 	return -1;
 }
 
+void sdp_add_lang_attr(sdp_record_t *rec)
+{
+	sdp_lang_attr_t base_lang;
+	sdp_list_t *langs;
+
+	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
+	base_lang.encoding = 106;
+	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
+
+	langs = sdp_list_append(0, &base_lang);
+	sdp_set_lang_attr(rec, langs);
+	sdp_list_free(langs, NULL);
+}
diff --git a/lib/sdp_lib.h b/lib/sdp_lib.h
index 433e9ef..6e1eb91 100644
--- a/lib/sdp_lib.h
+++ b/lib/sdp_lib.h
@@ -624,6 +624,8 @@ void sdp_pattern_add_uuidseq(sdp_record_t *rec, sdp_list_t *seq);
 
 int sdp_send_req_w4_rsp(sdp_session_t *session, uint8_t *req, uint8_t *rsp, uint32_t reqsize, uint32_t *rspsize);
 
+void sdp_add_lang_attr(sdp_record_t *rec);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/network/server.c b/network/server.c
index 67d81e3..987cfca 100644
--- a/network/server.c
+++ b/network/server.c
@@ -110,20 +110,6 @@ static struct network_server *find_server(GSList *list, uint16_t id)
 	return NULL;
 }
 
-static void add_lang_attr(sdp_record_t *r)
-{
-	sdp_lang_attr_t base_lang;
-	sdp_list_t *langs = 0;
-
-	/* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) */
-	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
-	base_lang.encoding = 106;
-	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
-	langs = sdp_list_append(0, &base_lang);
-	sdp_set_lang_attr(r, langs);
-	sdp_list_free(langs, 0);
-}
-
 static sdp_record_t *server_record_new(const char *name, uint16_t id)
 {
 	sdp_list_t *svclass, *pfseq, *apseq, *root, *aproto;
@@ -232,7 +218,7 @@ static sdp_record_t *server_record_new(const char *name, uint16_t id)
 	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	add_lang_attr(record);
+	sdp_add_lang_attr(record);
 
 	sdp_attr_add_new(record, SDP_ATTR_SECURITY_DESC,
 				SDP_UINT16, &security_desc);
diff --git a/serial/proxy.c b/serial/proxy.c
index 736f690..ea5c29f 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -130,20 +130,6 @@ static void proxy_free(struct serial_proxy *prx)
 	g_free(prx);
 }
 
-static void add_lang_attr(sdp_record_t *r)
-{
-	sdp_lang_attr_t base_lang;
-	sdp_list_t *langs = 0;
-
-	/* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) */
-	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
-	base_lang.encoding = 106;
-	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
-	langs = sdp_list_append(0, &base_lang);
-	sdp_set_lang_attr(r, langs);
-	sdp_list_free(langs, 0);
-}
-
 static sdp_record_t *proxy_record_new(const char *uuid128, uint8_t channel)
 {
 	sdp_list_t *apseq, *aproto, *profiles, *proto[2], *root, *svclass_id;
@@ -186,7 +172,7 @@ static sdp_record_t *proxy_record_new(const char *uuid128, uint8_t channel)
 	aproto = sdp_list_append(NULL, apseq);
 	sdp_set_access_protos(record, aproto);
 
-	add_lang_attr(record);
+	sdp_add_lang_attr(record);
 
 	sdp_set_info_attr(record, "Serial Proxy", NULL, "Serial Proxy");
 
diff --git a/tools/sdptool.c b/tools/sdptool.c
index 1a89245..db9ac0d 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -1148,20 +1148,6 @@ typedef struct {
 	uint8_t network;
 } svc_info_t;
 
-static void add_lang_attr(sdp_record_t *r)
-{
-	sdp_lang_attr_t base_lang;
-	sdp_list_t *langs = 0;
-
-	/* UTF-8 MIBenum (http://www.iana.org/assignments/character-sets) */
-	base_lang.code_ISO639 = (0x65 << 8) | 0x6e;
-	base_lang.encoding = 106;
-	base_lang.base_offset = SDP_PRIMARY_LANG_BASE;
-	langs = sdp_list_append(0, &base_lang);
-	sdp_set_lang_attr(r, langs);
-	sdp_list_free(langs, 0);
-}
-
 static int add_sp(sdp_session_t *session, svc_info_t *si)
 {
 	sdp_list_t *svclass_id, *apseq, *proto[2], *profiles, *root, *aproto;
@@ -1203,7 +1189,7 @@ static int add_sp(sdp_session_t *session, svc_info_t *si)
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_access_protos(&record, aproto);
 
-	add_lang_attr(&record);
+	sdp_add_lang_attr(&record);
 
 	sdp_set_info_attr(&record, "Serial Port", "BlueZ", "COM Port");
 
@@ -2312,7 +2298,7 @@ static int add_hid_keyb(sdp_session_t *session, svc_info_t *si)
 	root = sdp_list_append(0, &root_uuid);
 	sdp_set_browse_groups(&record, root);
 
-	add_lang_attr(&record);
+	sdp_add_lang_attr(&record);
 
 	sdp_uuid16_create(&hidkb_uuid, HID_SVCLASS_ID);
 	svclass_id = sdp_list_append(0, &hidkb_uuid);
@@ -2490,7 +2476,7 @@ static int add_hid_wiimote(sdp_session_t *session, svc_info_t *si)
 	aproto = sdp_list_append(0, apseq);
 	sdp_set_add_access_protos(&record, aproto);
 
-	add_lang_attr(&record);
+	sdp_add_lang_attr(&record);
 
 	sdp_set_info_attr(&record, "Nintendo RVL-CNT-01",
 					"Nintendo", "Nintendo RVL-CNT-01");
-- 
on behalf of ST-Ericsson

