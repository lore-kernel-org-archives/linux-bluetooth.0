Return-Path: <cyrus@holtmann.org>
From: Inga Stotland <ingas@codeaurora.org>
To: linux-bluetooth@vger.kernel.org
Cc: rshaffer@codeaurora.org,
	johan.hedberg@gmail.com,
	marcel@holtmann.org,
	Inga Stotland <ingas@codeaurora.org>
Subject: [PATCH 5/7] Fix in logic to write EIR when SDP records are changed.
Date: Tue,  3 Aug 2010 17:03:55 -0700
Message-Id: <1280880237-2296-6-git-send-email-ingas@codeaurora.org>
In-Reply-To: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
References: <1280880237-2296-1-git-send-email-ingas@codeaurora.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Whenever SDP service record is added/deleted/modified check for whether
class of device needs to be updated as well. If the update is
needed, proceed as before: new EIR will be written subsequently.
If the class of device is already present, just update EIR and return.
---
 src/adapter.c |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 4615326..e1f3051 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -137,6 +137,8 @@ struct btd_adapter {
 	gint ref;
 };
 
+static void update_ext_inquiry_response(struct btd_adapter *adapter);
+
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 					guint interval);
 
@@ -216,12 +218,17 @@ static int adapter_set_service_classes(struct btd_adapter *adapter,
 	adapter->wanted_cod &= 0x00ffff;
 	adapter->wanted_cod |= (value << 16);
 
-	/* If we already have the CoD we want or the cache is enabled or an
-	 * existing CoD write is in progress just bail out */
-	if (adapter->current_cod == adapter->wanted_cod ||
-			adapter->cache_enable || adapter->pending_cod)
+	/* If the cache is enabled or an existing CoD write is in progress
+	 * just bail out */
+	if (adapter->cache_enable || adapter->pending_cod)
 		return 0;
 
+	/* If we already have the CoD we want, update EIR and return */
+	if (adapter->current_cod == adapter->wanted_cod) {
+		update_ext_inquiry_response(adapter);
+		return 0;
+	}
+
 	DBG("Changing service classes to 0x%06x", adapter->wanted_cod);
 
 	err = adapter_ops->set_class(adapter->dev_id, adapter->wanted_cod);
-- 
1.7.2

-- 
Inga Stotland
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
