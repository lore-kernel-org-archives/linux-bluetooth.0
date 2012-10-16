Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 7/8] Simplify str2ba function
Date: Tue, 16 Oct 2012 12:12:58 +0200
Message-ID: <1350382379-30489-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
References: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Reverse loop iteration so that baswap call is not needed.

---
 lib/bluetooth.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index d092d01..d9360dc 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -82,7 +82,6 @@ int ba2str(const bdaddr_t *ba, char *str)
 
 int str2ba(const char *str, bdaddr_t *ba)
 {
-	bdaddr_t b;
 	int i;
 
 	if (bachk(str) < 0) {
@@ -90,10 +89,8 @@ int str2ba(const char *str, bdaddr_t *ba)
 		return -1;
 	}
 
-	for (i = 0; i < 6; i++, str += 3)
-		b.b[i] = strtol(str, NULL, 16);
-
-	baswap(ba, &b);
+	for (i = 5; i >= 0; i--, str += 3)
+		ba->b[i] = strtol(str, NULL, 16);
 
 	return 0;
 }
-- 
1.7.9.5

