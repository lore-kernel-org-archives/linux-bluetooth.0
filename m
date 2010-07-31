Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org, johan.hedberg@gmail.com,
	marcel@holtmann.org, Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 4/6] Fix in logic to write EIR when SDP records are changed.
Date: Sat, 31 Jul 2010 04:45:10 -0700
Message-Id: <1280576713-1398-5-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
References: <1280576713-1398-1-git-send-email-ingas@codeaurora.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Whenver SDP service record is added/deleted/modified check for whether 
class of device needs to be updated as well. If the update is 
needed, proceed as before and new EIR will be written subsequently. 
If the class of device is already present, just update EIR and return.
---
 src/adapter.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 789a196..af60495 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -137,6 +137,8 @@ struct btd_adapter {
 	gint ref;
 };
 
+static void update_ext_inquiry_response(struct btd_adapter *adapter);
+
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 					guint interval);
 
@@ -216,11 +218,15 @@ static int adapter_set_service_classes(struct btd_adapter *adapter,
 	adapter->wanted_cod &= 0x00ffff;
 	adapter->wanted_cod |= (value << 16);
 
-	/* If we already have the CoD we want or the cache is enabled or an
-	 * existing CoD write is in progress just bail out */
-	if (adapter->current_cod == adapter->wanted_cod ||
-			adapter->cache_enable || adapter->pending_cod)
+	/* If the cache is enabled or an existing CoD write is in progress
+	 * just bail out */
+	if(adapter->cache_enable || adapter->pending_cod)
 		return 0;
+	/* If we already have the CoD we want, update EIR and return */
+	if (adapter->current_cod == adapter->wanted_cod) {
+		update_ext_inquiry_response(adapter);
+		return 0;
+	}
 
 	DBG("Changing service classes to 0x%06x", adapter->wanted_cod);
 
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
