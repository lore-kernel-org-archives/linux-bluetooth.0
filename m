Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/4] Simplify ba2str function
Date: Fri, 4 Mar 2011 19:34:03 +0100
Message-ID: <1299263645-25329-3-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
References: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index d064f9e..f51e310 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -82,11 +82,8 @@ bdaddr_t *strtoba(const char *str)
 
 int ba2str(const bdaddr_t *ba, char *str)
 {
-	uint8_t b[6];
-
-	baswap((bdaddr_t *) b, ba);
 	return sprintf(str, "%2.2X:%2.2X:%2.2X:%2.2X:%2.2X:%2.2X",
-		b[0], b[1], b[2], b[3], b[4], b[5]);
+		ba->b[5], ba->b[4], ba->b[3], ba->b[2], ba->b[1], ba->b[0]);
 }
 
 int str2ba(const char *str, bdaddr_t *ba)
-- 
1.7.0.4

