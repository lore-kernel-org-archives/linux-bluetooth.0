Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 05/11] shared/att: Add BT_ATT_DEFAULT_LE_MTU macro.
Date: Wed, 20 Aug 2014 13:15:31 -0700
Message-Id: <1408565737-8187-6-git-send-email-armansito@chromium.org>
In-Reply-To: <1408565737-8187-1-git-send-email-armansito@chromium.org>
References: <1408565737-8187-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved the ATT_DEFAULT_LE_MTU to att-types.h to make it public.
---
 src/shared/att-types.h | 2 ++
 src/shared/att.c       | 6 +++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 1637f6f..b85c969 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -23,6 +23,8 @@
 
 #include <stdint.h>
 
+#define BT_ATT_DEFAULT_LE_MTU 23
+
 /* ATT protocol opcodes */
 #define BT_ATT_OP_ERROR_RSP	      		0x01
 #define BT_ATT_OP_MTU_REQ			0x02
diff --git a/src/shared/att.c b/src/shared/att.c
index 68a57f9..58c03d4 100644
--- a/src/shared/att.c
+++ b/src/shared/att.c
@@ -35,8 +35,8 @@
 #include "src/shared/timeout.h"
 #include "lib/uuid.h"
 #include "src/shared/att.h"
+#include "src/shared/att-types.h"
 
-#define ATT_DEFAULT_LE_MTU		23
 #define ATT_MIN_PDU_LEN			1  /* At least 1 byte for the opcode. */
 #define ATT_OP_CMD_MASK			0x40
 #define ATT_OP_SIGNED_MASK		0x80
@@ -698,7 +698,7 @@ struct bt_att *bt_att_new(int fd)
 
 	att->fd = fd;
 
-	att->mtu = ATT_DEFAULT_LE_MTU;
+	att->mtu = BT_ATT_DEFAULT_LE_MTU;
 	att->buf = malloc(att->mtu);
 	if (!att->buf)
 		goto fail;
@@ -833,7 +833,7 @@ bool bt_att_set_mtu(struct bt_att *att, uint16_t mtu)
 	if (!att)
 		return false;
 
-	if (mtu < ATT_DEFAULT_LE_MTU)
+	if (mtu < BT_ATT_DEFAULT_LE_MTU)
 		return false;
 
 	buf = malloc(mtu);
-- 
2.1.0.rc2.206.gedb03e5

