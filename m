Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 07/15] rctest: Fix compilation errors due to unaligned memory access
Date: Fri, 31 Aug 2012 10:36:17 +0200
Message-ID: <1346402185-9487-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build errors on ARM.

  CC     test/rctest.o
test/rctest.c: In function do_send:
test/rctest.c:539:4: error: cast increases required alignment of target
	type [-Werror=cast-align]
test/rctest.c:540:4: error: cast increases required alignment of target
	type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [test/rctest.o] Error 1

Change-Id: Ied636b0926fba2fece1ae3fbbdeff73bed764de9
---
 test/rctest.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index 4d7c90a..43ae09d 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -536,8 +536,9 @@ static void do_send(int sk)
 
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
-		*(uint32_t *) buf = htobl(seq);
-		*(uint16_t *) (buf + 4) = htobs(data_size);
+		bt_put_le32(seq, buf);
+		bt_put_le16(data_size, buf + 4);
+
 		seq++;
 
 		if (send(sk, buf, data_size, 0) <= 0) {
-- 
1.7.9.5

