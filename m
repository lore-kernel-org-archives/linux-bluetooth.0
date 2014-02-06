Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 7/8] android/pan: Pass error in nap_remove_bridge
Date: Thu,  6 Feb 2014 16:28:41 +0100
Message-Id: <1391700522-9036-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
References: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Don't return EOPNOTSUPP but just pass error from errno.
---
 android/pan.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/pan.c b/android/pan.c
index 1cb82a1..418e2a4 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -146,10 +146,13 @@ static int nap_remove_bridge(void)
 		return -EOPNOTSUPP;
 
 	err = ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
+	if (err < 0)
+		err = -errno;
+
 	close(sk);
 
 	if (err < 0)
-		return -EOPNOTSUPP;
+		return err;
 
 	nap_dev.bridge = false;
 
-- 
1.8.3.2

