Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Simplify bachk function
Date: Wed, 2 Mar 2011 11:19:27 +0100
Message-ID: <1299061167-8323-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 4af2ef6..875119b 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -118,33 +118,24 @@ int ba2oui(const bdaddr_t *ba, char *str)
 
 int bachk(const char *str)
 {
-	char tmp[18], *ptr = tmp;
-
 	if (!str)
 		return -1;
 
 	if (strlen(str) != 17)
 		return -1;
 
-	memcpy(tmp, str, 18);
-
-	while (*ptr) {
-		*ptr = toupper(*ptr);
-		if (*ptr < '0'|| (*ptr > '9' && *ptr < 'A') || *ptr > 'F')
+	while (*str) {
+		if (!isxdigit(*str++))
 			return -1;
-		ptr++;
 
-		*ptr = toupper(*ptr);
-		if (*ptr < '0'|| (*ptr > '9' && *ptr < 'A') || *ptr > 'F')
+		if (!isxdigit(*str++))
 			return -1;
-		ptr++;
 
-		*ptr = toupper(*ptr);
-		if (*ptr == 0)
+		if (*str == 0)
 			break;
-		if (*ptr != ':')
+
+		if (*str++ != ':')
 			return -1;
-		ptr++;
 	}
 
 	return 0;
-- 
1.7.0.4
on behalf of ST-Ericsson
