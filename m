Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/2] Fix empty parameter list in functions declarations
Date: Wed, 18 May 2011 08:42:46 +0200
Message-ID: <1305700967-13217-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/sdp.c           |    2 +-
 src/log.c           |    2 +-
 src/log.h           |    2 +-
 src/sdpd-database.c |    2 +-
 test/avtest.c       |    2 +-
 tools/avinfo.c      |    2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/sdp.c b/lib/sdp.c
index 2425b1e..a48ee14 100644
--- a/lib/sdp.c
+++ b/lib/sdp.c
@@ -3111,7 +3111,7 @@ int sdp_record_update(sdp_session_t *session, const sdp_record_t *rec)
 	return sdp_device_record_update(session, BDADDR_ANY, rec);
 }
 
-sdp_record_t *sdp_record_alloc()
+sdp_record_t *sdp_record_alloc(void)
 {
 	sdp_record_t *rec = malloc(sizeof(sdp_record_t));
 
diff --git a/src/log.c b/src/log.c
index 494ff5d..6fbbba9 100644
--- a/src/log.c
+++ b/src/log.c
@@ -86,7 +86,7 @@ static gboolean is_enabled(struct btd_debug_desc *desc)
 	return 0;
 }
 
-void __btd_toggle_debug()
+void __btd_toggle_debug(void)
 {
 	struct btd_debug_desc *desc;
 
diff --git a/src/log.h b/src/log.h
index 14e9bfd..78bbdd8 100644
--- a/src/log.h
+++ b/src/log.h
@@ -28,7 +28,7 @@ void btd_debug(const char *format, ...) __attribute__((format(printf, 1, 2)));
 
 void __btd_log_init(const char *debug, int detach);
 void __btd_log_cleanup(void);
-void __btd_toggle_debug();
+void __btd_toggle_debug(void);
 
 struct btd_debug_desc {
 	const char *file;
diff --git a/src/sdpd-database.c b/src/sdpd-database.c
index 08f542f..dd492bf 100644
--- a/src/sdpd-database.c
+++ b/src/sdpd-database.c
@@ -90,7 +90,7 @@ static void access_free(void *p)
 /*
  * Reset the service repository by deleting its contents
  */
-void sdp_svcdb_reset()
+void sdp_svcdb_reset(void)
 {
 	sdp_list_free(service_db, (sdp_free_func_t) sdp_record_free);
 	sdp_list_free(access_db, access_free);
diff --git a/test/avtest.c b/test/avtest.c
index 168326f..541b3cd 100644
--- a/test/avtest.c
+++ b/test/avtest.c
@@ -714,7 +714,7 @@ static void do_avctp_send(int sk, int invalid)
 		dump_avctp_header(hdr);
 }
 
-static void usage()
+static void usage(void)
 {
 	printf("avtest - Audio/Video testing ver %s\n", VERSION);
 	printf("Usage:\n"
diff --git a/tools/avinfo.c b/tools/avinfo.c
index 7f76c03..63b0da6 100644
--- a/tools/avinfo.c
+++ b/tools/avinfo.c
@@ -604,7 +604,7 @@ static int l2cap_connect(bdaddr_t *src, bdaddr_t *dst)
 	return sk;
 }
 
-static void usage()
+static void usage(void)
 {
 	printf("avinfo - Audio/Video Info Tool ver %s\n", VERSION);
 	printf("Usage:\n"
-- 
on behalf of ST-Ericsson

