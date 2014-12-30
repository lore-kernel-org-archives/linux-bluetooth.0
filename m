Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Add timing information to ECDH test case runs
Date: Tue, 30 Dec 2014 00:11:21 -0800
Message-Id: <1419927081-28551-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After successful completion of the ECDH test cases, print the time it
took to run them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/selftest.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index a7602b3d0b0d..9c67315172cf 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -156,8 +156,12 @@ static int __init test_ecdh_sample(const u8 priv_a[32], const u8 priv_b[32],
 
 static int __init test_ecdh(void)
 {
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
 	int err;
 
+	calltime = ktime_get();
+
 	err = test_ecdh_sample(priv_a_1, priv_b_1, pub_a_1, pub_b_1, dhkey_1);
 	if (err) {
 		BT_ERR("ECDH sample 1 failed");
@@ -176,7 +180,11 @@ static int __init test_ecdh(void)
 		return err;
 	}
 
-	BT_INFO("ECDH test passed");
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	BT_INFO("ECDH test passed in %lld usecs", duration);
 
 	return 0;
 }
-- 
2.1.0

