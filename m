Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix compiler warning with selftest duration calculation
Date: Fri,  6 Oct 2017 20:42:45 +0200
Message-Id: <20171006184245.5525-1-marcel@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

  CC      net/bluetooth/selftest.o
net/bluetooth/selftest.c: In function ‘bt_selftest_init’:
net/bluetooth/selftest.c:246:3: warning: ‘duration’ may be used uninitialized in this function [-Wmaybe-uninitialized]
   snprintf(test_ecdh_buffer, sizeof(test_ecdh_buffer),
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
     "PASS (%llu usecs)\n", duration);
     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
net/bluetooth/selftest.c:203:21: note: ‘duration’ was declared here
  unsigned long long duration;
                     ^~~~~~~~

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/selftest.c b/net/bluetooth/selftest.c
index 2d1519d0affa..03e3c89c3046 100644
--- a/net/bluetooth/selftest.c
+++ b/net/bluetooth/selftest.c
@@ -200,7 +200,7 @@ static int __init test_ecdh(void)
 {
 	struct crypto_kpp *tfm;
 	ktime_t calltime, delta, rettime;
-	unsigned long long duration;
+	unsigned long long duration = 0;
 	int err;
 
 	calltime = ktime_get();
-- 
2.13.6

