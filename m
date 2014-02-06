Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 8/8] android/pan: Bring bridge interface down before removing it
Date: Thu,  6 Feb 2014 16:28:42 +0100
Message-Id: <1391700522-9036-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
References: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Otherwise bridge will be 'in use' and won't be removed.
---
 android/pan.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/android/pan.c b/android/pan.c
index 418e2a4..bcbb3d8 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -132,6 +132,31 @@ static int nap_create_bridge(void)
 	return err;
 }
 
+static int bridge_if_down(void)
+{
+	struct ifreq ifr;
+	int sk, err;
+
+	sk = socket(AF_INET, SOCK_DGRAM, 0);
+
+	memset(&ifr, 0, sizeof(ifr));
+	strncpy(ifr.ifr_name, BNEP_BRIDGE, IF_NAMESIZE - 1);
+
+	ifr.ifr_flags &= ~IFF_UP;
+
+	/* Bring down the interface */
+	err = ioctl(sk, SIOCSIFFLAGS, (caddr_t) &ifr);
+
+	close(sk);
+
+	if (err < 0) {
+		error("pan: Could not bring down %s", BNEP_BRIDGE);
+		return err;
+	}
+
+	return 0;
+}
+
 static int nap_remove_bridge(void)
 {
 	int sk, err;
@@ -141,6 +166,8 @@ static int nap_remove_bridge(void)
 	if (!nap_dev.bridge)
 		return 0;
 
+	bridge_if_down();
+
 	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
 	if (sk < 0)
 		return -EOPNOTSUPP;
-- 
1.8.3.2

