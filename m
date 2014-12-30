Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add timing information to SMP test case runs
Date: Tue, 30 Dec 2014 00:11:20 -0800
Message-Id: <1419927081-28551-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After successful completion of the SMP test cases, print the time it
took to run them.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3a4333b5801a..358264c0e785 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3259,8 +3259,12 @@ static int __init test_h6(struct crypto_hash *tfm_cmac)
 static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
 				struct crypto_hash *tfm_cmac)
 {
+	ktime_t calltime, delta, rettime;
+	unsigned long long duration;
 	int err;
 
+	calltime = ktime_get();
+
 	err = test_ah(tfm_aes);
 	if (err) {
 		BT_ERR("smp_ah test failed");
@@ -3309,7 +3313,11 @@ static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
 		return err;
 	}
 
-	BT_INFO("SMP test passed");
+	rettime = ktime_get();
+	delta = ktime_sub(rettime, calltime);
+	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
+
+	BT_INFO("SMP test passed in %lld usecs", duration);
 
 	return 0;
 }
-- 
2.1.0

