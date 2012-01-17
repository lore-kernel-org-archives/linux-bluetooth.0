Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 04/11] Add macros for the possible link key types
Date: Tue, 17 Jan 2012 20:28:43 -0300
Message-Id: <1326842930-31623-4-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1326842930-31623-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 lib/hci.h |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/lib/hci.h b/lib/hci.h
index 48692fa..7f68ea0 100644
--- a/lib/hci.h
+++ b/lib/hci.h
@@ -293,6 +293,16 @@ enum {
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
+#define HCI_LK_INVALID			0xFF
+
 /* -----  HCI Commands ----- */
 
 /* Link Control */
-- 
1.7.8.1

