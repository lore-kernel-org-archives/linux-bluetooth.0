Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Improve the logic when emitting Discovering signal
Date: Tue, 29 Mar 2011 16:26:29 -0300
Message-Id: <1301426790-3762-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 031e141..69fd5be 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2826,19 +2826,18 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 			return;
 		break;
 	case STATE_LE_SCAN:
-		/* Scanning enabled */
-		if (adapter->disc_sessions) {
-			adapter->stop_discov_id = g_timeout_add(5120,
-								stop_scanning,
-								adapter);
+		discov_active = TRUE;
 
-			/* For dual mode: don't send "Discovering = TRUE"  */
-			if (bredr_capable(adapter) == TRUE)
-				return;
-		}
+		if (!adapter->disc_sessions)
+			break;
 
-		/* LE only */
-		discov_active = TRUE;
+		/* Scanning enabled */
+		adapter->stop_discov_id = g_timeout_add(5120, stop_scanning,
+							adapter);
+
+		/* For dual mode: don't send "Discovering = TRUE"  */
+		if (bredr_capable(adapter) == TRUE)
+			return;
 
 		break;
 	case STATE_IDLE:
-- 
1.7.4.1

