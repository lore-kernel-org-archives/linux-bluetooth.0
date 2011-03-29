Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Add constant for interleaved discovery window
Date: Tue, 29 Mar 2011 16:26:30 -0300
Message-Id: <1301426790-3762-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1301426790-3762-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1301426790-3762-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   10 +++++++---
 1 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 69fd5be..32ec71d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -59,6 +59,9 @@
 #include "attrib-server.h"
 #include "att.h"
 
+/* Interleaved discovery window: 5.12 sec */
+#define GAP_INTER_DISCOV_WIN		5120
+
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
 #define EIR_GEN_DISC                0x02 /* LE General Discoverable Mode */
@@ -2831,11 +2834,12 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 		if (!adapter->disc_sessions)
 			break;
 
-		/* Scanning enabled */
-		adapter->stop_discov_id = g_timeout_add(5120, stop_scanning,
+		/* Stop scanning after TGAP(100)/2 */
+		adapter->stop_discov_id = g_timeout_add(GAP_INTER_DISCOV_WIN,
+							stop_scanning,
 							adapter);
 
-		/* For dual mode: don't send "Discovering = TRUE"  */
+		/* For dual mode: don't send "Discovering = TRUE" (twice) */
 		if (bredr_capable(adapter) == TRUE)
 			return;
 
-- 
1.7.4.1

