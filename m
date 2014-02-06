Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v3 3/8] android/pan: Move functions up to avoid forward declarations
Date: Thu,  6 Feb 2014 16:28:37 +0100
Message-Id: <1391700522-9036-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
References: <1391700522-9036-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pan.c | 132 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 66 insertions(+), 66 deletions(-)

diff --git a/android/pan.c b/android/pan.c
index b8d7404..d010e09 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -77,6 +77,72 @@ static struct {
 	.io = NULL,
 };
 
+static int set_forward_delay(void)
+{
+	int fd, ret;
+
+	fd = open(FORWARD_DELAY_PATH, O_RDWR);
+	if (fd < 0) {
+		int err = -errno;
+
+		error("pan: open forward delay file failed: %d (%s)",
+							-err, strerror(-err));
+
+		return err;
+	}
+
+	ret = write(fd, "0", sizeof("0"));
+	close(fd);
+
+	return ret;
+}
+
+static int nap_create_bridge(void)
+{
+	int sk, err;
+
+	DBG("%s", BNEP_BRIDGE);
+
+	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (sk < 0)
+		return -EOPNOTSUPP;
+
+	if (ioctl(sk, SIOCBRADDBR, BNEP_BRIDGE) < 0) {
+		err = -errno;
+		if (err != -EEXIST) {
+			close(sk);
+			return -EOPNOTSUPP;
+		}
+	}
+
+	err = set_forward_delay();
+	if (err < 0)
+		ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
+
+	close(sk);
+
+	return err;
+}
+
+static int nap_remove_bridge(void)
+{
+	int sk, err;
+
+	DBG("%s", BNEP_BRIDGE);
+
+	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
+	if (sk < 0)
+		return -EOPNOTSUPP;
+
+	err = ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
+	close(sk);
+
+	if (err < 0)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
 static int device_cmp(gconstpointer s, gconstpointer user_data)
 {
 	const struct pan_device *dev = s;
@@ -475,72 +541,6 @@ failed:
 	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
 }
 
-static int set_forward_delay(void)
-{
-	int fd, ret;
-
-	fd = open(FORWARD_DELAY_PATH, O_RDWR);
-	if (fd < 0) {
-		int err = -errno;
-
-		error("pan: open forward delay file failed: %d (%s)",
-							-err, strerror(-err));
-
-		return err;
-	}
-
-	ret = write(fd, "0", sizeof("0"));
-	close(fd);
-
-	return ret;
-}
-
-static int nap_create_bridge(void)
-{
-	int sk, err;
-
-	DBG("%s", BNEP_BRIDGE);
-
-	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
-	if (sk < 0)
-		return -EOPNOTSUPP;
-
-	if (ioctl(sk, SIOCBRADDBR, BNEP_BRIDGE) < 0) {
-		err = -errno;
-		if (err != -EEXIST) {
-			close(sk);
-			return -EOPNOTSUPP;
-		}
-	}
-
-	err = set_forward_delay();
-	if (err < 0)
-		ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
-
-	close(sk);
-
-	return err;
-}
-
-static int nap_remove_bridge(void)
-{
-	int sk, err;
-
-	DBG("%s", BNEP_BRIDGE);
-
-	sk = socket(AF_INET, SOCK_STREAM | SOCK_CLOEXEC, 0);
-	if (sk < 0)
-		return -EOPNOTSUPP;
-
-	err = ioctl(sk, SIOCBRDELBR, BNEP_BRIDGE);
-	close(sk);
-
-	if (err < 0)
-		return -EOPNOTSUPP;
-
-	return 0;
-}
-
 static void destroy_nap_device(void)
 {
 	DBG("");
-- 
1.8.3.2

