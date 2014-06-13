Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/2] btio: Fix typo in error message
Date: Fri, 13 Jun 2014 11:34:25 +0200
Message-Id: <1402652066-15094-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/btio/btio.c b/btio/btio.c
index 5f91171..15057f6 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1087,7 +1087,7 @@ parse_opts:
 
 			if (getsockopt(sock, SOL_BLUETOOTH, BT_SNDMTU,
 							&l2o.omtu, &len) < 0) {
-				ERROR_FAILED(err, "getsockopt(BT_RCVMTU)",
+				ERROR_FAILED(err, "getsockopt(BT_SNDMTU)",
 									errno);
 				return FALSE;
 			}
-- 
1.9.1

