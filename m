Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Don't disable LE scan when started by external tools
Date: Tue, 29 Mar 2011 11:39:40 -0300
Message-Id: <1301409581-16057-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes the automatic LE scan disabling when it is not
triggered through the StartDiscovery() method.
---
 src/adapter.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index efe7db3..f719adc 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -2827,8 +2827,10 @@ void adapter_set_state(struct btd_adapter *adapter, int state)
 		break;
 	case STATE_LE_SCAN:
 		/* Scanning enabled */
-		adapter->stop_discov_id = g_timeout_add(5120,
-						stop_scanning, adapter);
+		if (adapter->disc_sessions)
+			adapter->stop_discov_id = g_timeout_add(5120,
+								stop_scanning,
+								adapter);
 
 		/* For dual mode: don't send "Discovering = TRUE"  */
 		if (bredr_capable(adapter) == TRUE)
-- 
1.7.4.1

