Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 09/15] scotest: Fix compilation errors due to unaligned memory access
Date: Fri, 31 Aug 2012 10:36:19 +0200
Message-ID: <1346402185-9487-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
References: <1346402185-9487-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix following build errors on ARM.

  CC     test/scotest.o
test/scotest.c: In function send_mode:
test/scotest.c:272:4: error: cast increases required alignment of
	target type [-Werror=cast-align]
test/scotest.c:273:4: error: cast increases required alignment of
	target type [-Werror=cast-align]
cc1: all warnings being treated as errors
make[1]: *** [test/scotest.o] Error 1
make: *** [all] Error 2

Change-Id: Ib0fb15e000f333bce4228e96762ee2c849c580d9
---
 test/scotest.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/test/scotest.c b/test/scotest.c
index 17bd8a6..de65edf 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -269,8 +269,9 @@ static void send_mode(char *svr)
 
 	seq = 0;
 	while (1) {
-		*(uint32_t *) buf = htobl(seq);
-		*(uint16_t *) (buf + 4) = htobs(data_size);
+		bt_put_le32(seq, buf);
+		bt_put_le16(data_size, buf + 4);
+
 		seq++;
 
 		if (send(sk, buf, so.mtu, 0) <= 0) {
-- 
1.7.9.5

