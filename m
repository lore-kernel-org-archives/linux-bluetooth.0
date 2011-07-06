Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ v2 4/9] Define macros for link key types
Date: Wed,  6 Jul 2011 17:10:36 -0300
Message-Id: <1309983041-23744-5-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
References: <y>
 <1309983041-23744-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.h |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 51184ee..dc4b36b 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -293,6 +293,19 @@ enum {
 #define HCI_LM_RELIABLE	0x0010
 #define HCI_LM_SECURE	0x0020
 
+/* Link Key types */
+#define HCI_LK_COMBINATION		0x00
+#define HCI_LK_LOCAL_UNIT		0x01
+#define HCI_LK_REMOTE_UNIT		0x02
+#define HCI_LK_DEBUG_COMBINATION	0x03
+#define HCI_LK_UNAUTH_COMBINATION	0x04
+#define HCI_LK_AUTH_COMBINATION		0x05
+#define HCI_LK_CHANGED_COMBINATION	0x06
+/* The spec doesn't define types for SMP keys */
+#define HCI_LK_SMP_LTK			0x81
+#define HCI_LK_SMP_IRK			0x82
+#define HCI_LK_SMP_CSRK			0x83
+
 /* -----  HCI Commands ----- */
 
 /* Link Control */
-- 
1.7.6

