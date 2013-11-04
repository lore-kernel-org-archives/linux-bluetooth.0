Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcin Kraglak <marcin.kraglak@tieto.com>
Subject: [PATCH] Fix incorrect result type in set_adapter_name
Date: Mon, 4 Nov 2013 10:31:38 +0100
Message-ID: <1383557498-7971-1-git-send-email-marcin.kraglak@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

diff --git a/android/adapter.c b/android/adapter.c
index af62b11..38dec9d 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -880,7 +880,7 @@ static void set_adapter_name_complete(uint8_t status, uint16_t length,
 	adapter_name_changed(rp->name);
 }
 
-static bool set_adapter_name(uint8_t *name, uint16_t len)
+static uint8_t set_adapter_name(uint8_t *name, uint16_t len)
 {
 	struct mgmt_cp_set_local_name cp;
 
@@ -890,11 +890,11 @@ static bool set_adapter_name(uint8_t *name, uint16_t len)
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_LOCAL_NAME, adapter->index,
 			sizeof(cp), &cp, set_adapter_name_complete, NULL,
 								NULL) > 0)
-		return true;
+		return HAL_STATUS_SUCCESS;
 
 	error("Failed to set name");
 
-	return false;
+	return HAL_STATUS_FAILED;
 }
 
 static void read_info_complete(uint8_t status, uint16_t length, const void *param,
-- 
1.8.4.1

