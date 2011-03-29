Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 2/2] Fix missing Discovering signal when scanning
Date: Tue, 29 Mar 2011 11:39:41 -0300
Message-Id: <1301409581-16057-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1301409581-16057-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1301409581-16057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Discovery signal should have the same behaviour for both scenarios:
external and D-Bus clients. For LE scan not triggered through the
StartDiscovery() method, Discovery property is not being sent to
indicate that a discovery session has started. Signal indicating
that the session has finished is sent properly.
---
 src/adapter.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index f719adc..031e141 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2827,14 +2827,15 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 		break;
 	case STATE_LE_SCAN:
 		/* Scanning enabled */
-		if (adapter->disc_sessions)
+		if (adapter->disc_sessions) {
 			adapter->stop_discov_id = g_timeout_add(5120,
 								stop_scanning,
 								adapter);
 
-		/* For dual mode: don't send "Discovering = TRUE"  */
-		if (bredr_capable(adapter) == TRUE)
-			return;
+			/* For dual mode: don't send "Discovering = TRUE"  */
+			if (bredr_capable(adapter) == TRUE)
+				return;
+		}
 
 		/* LE only */
 		discov_active = TRUE;
-- 
1.7.4.1

