Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/2] btio: Fix not setting getsockopt optlen for BT_SNDMTU
Date: Fri, 13 Jun 2014 11:34:26 +0200
Message-Id: <1402652066-15094-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1402652066-15094-1-git-send-email-szymon.janc@tieto.com>
References: <1402652066-15094-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 btio/btio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/btio/btio.c b/btio/btio.c
index 15057f6..50760f0 100644
--- a/btio/btio.c
+++ b/btio/btio.c
@@ -1085,6 +1085,7 @@ parse_opts:
 				break;
 			}
 
+			len = sizeof(l2o.omtu);
 			if (getsockopt(sock, SOL_BLUETOOTH, BT_SNDMTU,
 							&l2o.omtu, &len) < 0) {
 				ERROR_FAILED(err, "getsockopt(BT_SNDMTU)",
-- 
1.9.1

