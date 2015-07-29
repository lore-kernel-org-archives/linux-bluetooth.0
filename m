Return-Path: <cyrus@holtmann.org>
From: Dohyun Pyun <dh79.pyun@samsung.com>
To: linux-bluetooth@vger.kernel.org, szymon.janc@tieto.com
Cc: steve.jun@samsung.com, DoHyun Pyun <dh79.pyun@samsung.com>
Subject: [PATCH BLUEZ] android/pan: Fix not NULL terminating parsed string
Date: Wed, 29 Jul 2015 15:24:48 +0900
Message-id: <1438151088-26152-1-git-send-email-dh79.pyun@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: DoHyun Pyun <dh79.pyun@samsung.com>

This patch prevents the possible not NULL terminating problem.
ifr_name's array size is IFNAMSIZ. So If BNEP_BRIDGE has IFNAMSIZ size,
the name string will be not NULL terminating.
---
 android/pan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 0bb576e..c40a6d3 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -88,7 +88,7 @@ static int set_forward_delay(int sk)
 	struct ifreq ifr;
 
 	memset(&ifr, 0, sizeof(ifr));
-	strncpy(ifr.ifr_name, BNEP_BRIDGE, IFNAMSIZ);
+	strncpy(ifr.ifr_name, BNEP_BRIDGE, IFNAMSIZ - 1);
 	ifr.ifr_data = (char *) args;
 
 	if (ioctl(sk, SIOCDEVPRIVATE, &ifr) < 0) {
-- 
1.8.1.2

