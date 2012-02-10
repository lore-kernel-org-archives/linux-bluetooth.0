Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ 11/22] scotest: Fix clang compiler warnings related to unaligned memory access
Date: Fri, 10 Feb 2012 18:39:56 -0300
Message-Id: <1328910007-25604-12-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328910007-25604-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/scotest.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/test/scotest.c b/test/scotest.c
index 17bd8a6..fc87f5e 100644
--- a/test/scotest.c
+++ b/test/scotest.c
@@ -269,8 +269,8 @@ static void send_mode(char *svr)
 
 	seq = 0;
 	while (1) {
-		*(uint32_t *) buf = htobl(seq);
-		*(uint16_t *) (buf + 4) = htobs(data_size);
+		bt_put_le32(seq, buf);
+		bt_put_le16(data_size, buf + 4);
 		seq++;
 
 		if (send(sk, buf, so.mtu, 0) <= 0) {
-- 
1.7.8.1

