Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 02/20] lib: Remove bt_put_le16()
Date: Thu, 13 Mar 2014 17:22:30 -0300
Message-Id: <1394742168-31073-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hidhost.c |  3 ++-
 lib/bluetooth.h   | 10 ----------
 src/eir.c         |  3 ++-
 tools/l2test.c    |  4 +++-
 tools/rctest.c    |  4 +++-
 tools/scotest.c   |  4 +++-
 6 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index 4226f69..81e7eb8 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -38,6 +38,7 @@
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
 #include "src/shared/mgmt.h"
+#include "src/shared/util.h"
 #include "src/sdp-client.h"
 #include "src/uuid-helper.h"
 #include "profiles/input/uhid_copy.h"
@@ -1066,7 +1067,7 @@ static void bt_hid_get_report(const void *buf, uint16_t len)
 
 	if (cmd->buf_size > 0) {
 		req[0] = req[0] | HID_GET_REPORT_SIZE_FIELD;
-		bt_put_le16(cmd->buf_size, &req[2]);
+		put_le16(cmd->buf_size, &req[2]);
 	}
 
 	fd = g_io_channel_unix_get_fd(dev->ctrl_io);
diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 61c1f9a..8865c00 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -222,11 +222,6 @@ static inline void bt_put_be32(uint32_t val, const void *ptr)
 	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
 }
 
-static inline void bt_put_le16(uint16_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint16_t *) ptr);
-}
-
 static inline void bt_put_be16(uint16_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
@@ -283,11 +278,6 @@ static inline void bt_put_be32(uint32_t val, const void *ptr)
 	bt_put_unaligned(val, (uint32_t *) ptr);
 }
 
-static inline void bt_put_le16(uint16_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_16(val), (uint16_t *) ptr);
-}
-
 static inline void bt_put_be16(uint16_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint16_t *) ptr);
diff --git a/src/eir.c b/src/eir.c
index cc1c5dd..be83718 100644
--- a/src/eir.c
+++ b/src/eir.c
@@ -37,6 +37,7 @@
 #include <bluetooth/hci.h>
 #include <bluetooth/sdp.h>
 
+#include "src/shared/util.h"
 #include "uuid-helper.h"
 #include "eir.h"
 
@@ -473,7 +474,7 @@ int eir_create_oob(const bdaddr_t *addr, const char *name, uint32_t cod,
 	eir_total_len += eir_optional_len;
 
 	/* store total length */
-	bt_put_le16(eir_total_len, data);
+	put_le16(eir_total_len, data);
 
 	return eir_total_len;
 }
diff --git a/tools/l2test.c b/tools/l2test.c
index 0993f74..8e62227 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -47,6 +47,8 @@
 #include <bluetooth/hci_lib.h>
 #include <bluetooth/l2cap.h>
 
+#include "src/shared/util.h"
+
 #define NIBBLE_TO_ASCII(c)  ((c) < 0x0a ? (c) + 0x30 : (c) + 0x57)
 
 #define BREDR_DEFAULT_PSM	0x1011
@@ -977,7 +979,7 @@ static void do_send(int sk)
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
 		bt_put_le32(seq, buf);
-		bt_put_le16(data_size, buf + 4);
+		put_le16(data_size, buf + 4);
 
 		seq++;
 
diff --git a/tools/rctest.c b/tools/rctest.c
index 9281392..98fe792 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -47,6 +47,8 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
+#include "src/shared/util.h"
+
 /* Test modes */
 enum {
 	SEND,
@@ -568,7 +570,7 @@ static void do_send(int sk)
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
 		bt_put_le32(seq, buf);
-		bt_put_le16(data_size, buf + 4);
+		put_le16(data_size, buf + 4);
 
 		seq++;
 
diff --git a/tools/scotest.c b/tools/scotest.c
index 227287d..13b9602 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -40,6 +40,8 @@
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/sco.h>
 
+#include "src/shared/util.h"
+
 /* Test modes */
 enum {
 	SEND,
@@ -346,7 +348,7 @@ static void send_mode(char *svr)
 	seq = 0;
 	while (1) {
 		bt_put_le32(seq, buf);
-		bt_put_le16(data_size, buf + 4);
+		put_le16(data_size, buf + 4);
 
 		seq++;
 
-- 
1.8.3.1

