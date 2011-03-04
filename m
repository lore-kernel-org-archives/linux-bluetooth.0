Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/4] Fix str2ba behaviour on malformed bt address
Date: Fri, 4 Mar 2011 19:34:04 +0100
Message-ID: <1299263645-25329-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
References: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

str2ba could create bogus bt address from malformed string. Return
all zeros bt address on malformed string.
---
 lib/bluetooth.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index f51e310..d943fdc 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -88,19 +88,18 @@ int ba2str(const bdaddr_t *ba, char *str)
 
 int str2ba(const char *str, bdaddr_t *ba)
 {
-	uint8_t b[6];
-	const char *ptr = str;
+	bdaddr_t b;
 	int i;
 
-	for (i = 0; i < 6; i++) {
-		b[i] = (uint8_t) strtol(ptr, NULL, 16);
-		if (i != 5 && !(ptr = strchr(ptr, ':')))
-			ptr = ":00:00:00:00:00";
-		ptr++;
+	if (bachk(str) < 0) {
+		memset(ba, 0, sizeof(*ba));
+		return -1;
 	}
 
-	baswap(ba, (bdaddr_t *) b);
+	for (i = 0; i < 6; i++, str += 3)
+		b.b[i] = strtol(str, NULL, 16);
 
+	baswap(ba, &b);
 	return 0;
 }
 
-- 
1.7.0.4

