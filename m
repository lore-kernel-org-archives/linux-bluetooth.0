Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <par-gunnar.p.hjalmdahl@stericsson.com>,
	<henrik.possung@stericsson.com>,
	Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Fix small memleak in hciemu
Date: Fri, 4 Mar 2011 19:32:36 +0100
Message-ID: <1299263556-25236-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 test/hciemu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/test/hciemu.c b/test/hciemu.c
index 5227766..9eed9d9 100644
--- a/test/hciemu.c
+++ b/test/hciemu.c
@@ -1023,7 +1023,7 @@ static int getbdaddrbyname(char *str, bdaddr_t *ba)
 
 	if (n == 5) {
 		/* BD address */
-		baswap(ba, strtoba(str));
+		str2ba(str, ba);
 		return 0;
 	}
 
-- 
1.7.0.4
on behalf of ST-Ericsson
