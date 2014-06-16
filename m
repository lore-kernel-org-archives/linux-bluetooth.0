Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/6] Bluetooth: Convert SMP flags into an enum
Date: Mon, 16 Jun 2014 11:00:32 +0300
Message-Id: <1402905633-470-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
References: <1402905633-470-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no reason to have explicit values for these flags. Convert them
to an enum to be consistent with other similar flags.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 1d03949fe928..513a92cb0356 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -35,11 +35,13 @@
 
 #define AUTH_REQ_MASK   0x07
 
-#define SMP_FLAG_TK_VALID	1
-#define SMP_FLAG_CFM_PENDING	2
-#define SMP_FLAG_MITM_AUTH	3
-#define SMP_FLAG_COMPLETE	4
-#define SMP_FLAG_INITIATOR	5
+enum {
+	SMP_FLAG_TK_VALID,
+	SMP_FLAG_CFM_PENDING,
+	SMP_FLAG_MITM_AUTH,
+	SMP_FLAG_COMPLETE,
+	SMP_FLAG_INITIATOR,
+};
 
 struct smp_chan {
 	struct l2cap_conn *conn;
-- 
1.9.3

