Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 04/20] lib: Remove bt_put_le32()
Date: Thu, 13 Mar 2014 17:22:32 -0300
Message-Id: <1394742168-31073-5-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.h | 10 ----------
 tools/l2test.c  |  2 +-
 tools/rctest.c  |  2 +-
 tools/scotest.c |  2 +-
 4 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/lib/bluetooth.h b/lib/bluetooth.h
index 8865c00..cb6f563 100644
--- a/lib/bluetooth.h
+++ b/lib/bluetooth.h
@@ -212,11 +212,6 @@ static inline void bt_put_be64(uint64_t val, const void *ptr)
 	bt_put_unaligned(bswap_64(val), (uint64_t *) ptr);
 }
 
-static inline void bt_put_le32(uint32_t val, const void *ptr)
-{
-	bt_put_unaligned(val, (uint32_t *) ptr);
-}
-
 static inline void bt_put_be32(uint32_t val, const void *ptr)
 {
 	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
@@ -268,11 +263,6 @@ static inline void bt_put_be64(uint64_t val, const void *ptr)
 	bt_put_unaligned(val, (uint64_t *) ptr);
 }
 
-static inline void bt_put_le32(uint32_t val, const void *ptr)
-{
-	bt_put_unaligned(bswap_32(val), (uint32_t *) ptr);
-}
-
 static inline void bt_put_be32(uint32_t val, const void *ptr)
 {
 	bt_put_unaligned(val, (uint32_t *) ptr);
diff --git a/tools/l2test.c b/tools/l2test.c
index 8e62227..a9fc642 100644
--- a/tools/l2test.c
+++ b/tools/l2test.c
@@ -978,7 +978,7 @@ static void do_send(int sk)
 
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
-		bt_put_le32(seq, buf);
+		put_le32(seq, buf);
 		put_le16(data_size, buf + 4);
 
 		seq++;
diff --git a/tools/rctest.c b/tools/rctest.c
index 98fe792..2c7e45b 100644
--- a/tools/rctest.c
+++ b/tools/rctest.c
@@ -569,7 +569,7 @@ static void do_send(int sk)
 
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
-		bt_put_le32(seq, buf);
+		put_le32(seq, buf);
 		put_le16(data_size, buf + 4);
 
 		seq++;
diff --git a/tools/scotest.c b/tools/scotest.c
index 13b9602..e5530d9 100644
--- a/tools/scotest.c
+++ b/tools/scotest.c
@@ -347,7 +347,7 @@ static void send_mode(char *svr)
 
 	seq = 0;
 	while (1) {
-		bt_put_le32(seq, buf);
+		put_le32(seq, buf);
 		put_le16(data_size, buf + 4);
 
 		seq++;
-- 
1.8.3.1

