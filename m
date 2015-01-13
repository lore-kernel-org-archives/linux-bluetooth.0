Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Use %llu for printing duration details of selftests
Date: Mon, 12 Jan 2015 23:09:48 -0800
Message-Id: <1421132988-19922-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The duration variable for the selftests is unsigned long long and with
that use %llu instead of %lld when printing the results.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/selftest.c | 2 +-
 net/bluetooth/smp.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index 9c67315172cf..378f4064952c 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -184,7 +184,7 @@ static int __init test_ecdh(void)
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 
-	BT_INFO("ECDH test passed in %lld usecs", duration);
+	BT_INFO("ECDH test passed in %llu usecs", duration);
 
 	return 0;
 }
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 96c7d51a2753..379654e70e6f 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -3387,7 +3387,7 @@ static int __init run_selftests(struct crypto_blkcipher *tfm_aes,
 	delta = ktime_sub(rettime, calltime);
 	duration = (unsigned long long) ktime_to_ns(delta) >> 10;
 
-	BT_INFO("SMP test passed in %lld usecs", duration);
+	BT_INFO("SMP test passed in %llu usecs", duration);
 
 	return 0;
 }
-- 
2.1.0

