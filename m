Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 09/22] rctest: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:39:54 -0300
Message-Id: <1328910007-25604-10-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/rctest.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/rctest.c b/test/rctest.c
index 4d7c90a..ef86291 100644
--- a/test/rctest.c
+++ b/test/rctest.c
@@ -536,8 +536,8 @@ static void do_send(int sk)
 
 	seq = 0;
 	while ((num_frames == -1) || (num_frames-- > 0)) {
-		*(uint32_t *) buf = htobl(seq);
-		*(uint16_t *) (buf + 4) = htobs(data_size);
+		bt_put_le32(seq, buf);
+		bt_put_le16(data_size, buf + 4);
 		seq++;
 
 		if (send(sk, buf, data_size, 0) <= 0) {
-- 
1.7.8.1

