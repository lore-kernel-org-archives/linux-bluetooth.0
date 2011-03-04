Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/4] Simplify ba2oui function
Date: Fri, 4 Mar 2011 19:34:02 +0100
Message-ID: <1299263645-25329-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
References: <1299263645-25329-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/bluetooth.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/lib/bluetooth.c b/lib/bluetooth.c
index 875119b..d064f9e 100644
--- a/lib/bluetooth.c
+++ b/lib/bluetooth.c
@@ -109,11 +109,7 @@ int str2ba(const char *str, bdaddr_t *ba)
 
 int ba2oui(const bdaddr_t *ba, char *str)
 {
-	uint8_t b[6];
-
-	baswap((bdaddr_t *) b, ba);
-
-	return sprintf(str, "%2.2X-%2.2X-%2.2X", b[0], b[1], b[2]);
+	return sprintf(str, "%2.2X-%2.2X-%2.2X", ba->b[5], ba->b[4], ba->b[3]);
 }
 
 int bachk(const char *str)
-- 
1.7.0.4

