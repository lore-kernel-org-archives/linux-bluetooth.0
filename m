Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 08/22] l2test: Fix clang compiler warning related to unaligned memory access
Date: Fri, 10 Feb 2012 18:39:53 -0300
Message-Id: <1328910007-25604-9-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/l2test.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/test/l2test.c b/test/l2test.c
index c5bc3d3..9792a40 100644
--- a/test/l2test.c
+++ b/test/l2test.c
@@ -784,7 +784,7 @@ static void recv_mode(int sk)
 			}
 
 			/* Check sequence */
-			sq = btohl(*(uint32_t *) buf);
+			sq = bt_get_le32(buf);
 			if (seq != sq) {
 				syslog(LOG_INFO, "seq missmatch: %d -> %d", seq, sq);
 				seq = sq;
@@ -792,7 +792,7 @@ static void recv_mode(int sk)
 			seq++;
 
 			/* Check length */
-			l = btohs(*(uint16_t *) (buf + 4));
+			l = bt_get_le16(buf + 4);
 			if (len != l) {
 				syslog(LOG_INFO, "size missmatch: %d -> %d", len, l);
 				continue;
@@ -851,8 +851,8 @@ static void do_send(int sk)
 
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
-		*(uint32_t *) buf = htobl(seq);
-		*(uint16_t *) (buf + 4) = htobs(data_size);
+		bt_put_le32(seq, buf);
+		bt_put_le16(data_size, buf + 4);
 		seq++;
 
 		sent = 0;
-- 
1.7.8.1

