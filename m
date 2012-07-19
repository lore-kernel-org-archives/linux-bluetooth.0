Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: trivial: Fix mixing spaces and tabs in smp
Date: Thu, 19 Jul 2012 17:03:44 +0300
Message-Id: <1342706627-19129-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1342706627-19129-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change spaces to tabs in smp code

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/smp.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/smp.h b/include/net/bluetooth/smp.h
index ca356a7..50993a5 100644
--- a/include/net/bluetooth/smp.h
+++ b/include/net/bluetooth/smp.h
@@ -108,8 +108,8 @@ struct smp_cmd_security_req {
 #define SMP_CONFIRM_FAILED		0x04
 #define SMP_PAIRING_NOTSUPP		0x05
 #define SMP_ENC_KEY_SIZE		0x06
-#define SMP_CMD_NOTSUPP		0x07
-#define SMP_UNSPECIFIED		0x08
+#define SMP_CMD_NOTSUPP			0x07
+#define SMP_UNSPECIFIED			0x08
 #define SMP_REPEATED_ATTEMPTS		0x09
 
 #define SMP_MIN_ENC_KEY_SIZE		7
@@ -123,8 +123,8 @@ struct smp_chan {
 	struct l2cap_conn *conn;
 	u8		preq[7]; /* SMP Pairing Request */
 	u8		prsp[7]; /* SMP Pairing Response */
-	u8              prnd[16]; /* SMP Pairing Random (local) */
-	u8              rrnd[16]; /* SMP Pairing Random (remote) */
+	u8		prnd[16]; /* SMP Pairing Random (local) */
+	u8		rrnd[16]; /* SMP Pairing Random (remote) */
 	u8		pcnf[16]; /* SMP Pairing Confirm */
 	u8		tk[16]; /* SMP Temporary Key */
 	u8		enc_key_size;
-- 
1.7.9.5

