Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org, grzegorz.kolodziejczyk@tieto.com
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ] tools/bneptest: Fix not NULL terminating parsed string
Date: Wed, 29 Jul 2015 15:18:54 +0900
Message-id: <1438150734-25746-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

This patch prevents the possible not NULL terminating problem.
ifr_name's array size is IFNAMSIZ. So If bridge has IFNAMSIZ size,
the name string will be not NULL terminating.
---
 tools/bneptest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bneptest.c b/tools/bneptest.c
index a7d5815..1404252 100644
--- a/tools/bneptest.c
+++ b/tools/bneptest.c
@@ -89,7 +89,7 @@ static int set_forward_delay(int sk)
 	struct ifreq ifr;
 
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy(ifr.ifr_name, bridge, IFNAMSIZ);
+	strncpy(ifr.ifr_name, bridge, IFNAMSIZ - 1);
 	ifr.ifr_data = (char *) args;
 
 	if (ioctl(sk, SIOCDEVPRIVATE, &ifr) < 0) {
-- 
1.8.1.2

