Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4F3C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 28 Jan 2022 02:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345178AbiA1CHj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 27 Jan 2022 21:07:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345225AbiA1CHi (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 27 Jan 2022 21:07:38 -0500
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9D3C061714
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:07:38 -0800 (PST)
Received: by mail-il1-x131.google.com with SMTP id u5so4155318ilq.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 27 Jan 2022 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MqC+nzQKyDPuomICd2Bnj+jHvHssw2y5p8nmQKToMWI=;
        b=DN/y4elWN8VY1tVJ0moSdhl6mnK9V5B45CBi4Uw8eZ01t60oYAzizIIDz3ikq3FBLE
         vSnvAIhvYurdwD6liQsUpWLzNHDd+IGAO+nHU8XR/UTv5o+ofSARpggArRoirnQzBQjY
         Er5i3l3dNHK54i0Azo8uHznp2vcNIL7X+ZKWffywfi/DY9PmiF6j6g5Tkq151+mK3OyO
         yOdkkhouhiBVW7599SzY3xbGUfcKJ7kbnIf1fHK2IypotNu40gXJ4Z4n7Iz6qRBWZAG0
         9gJSfS5Ohhuf+0FwgtUAOK77l0VzpP96uIqY7qzjfDjq1DsUDhZnox1hWGa9nKBmphl5
         gmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MqC+nzQKyDPuomICd2Bnj+jHvHssw2y5p8nmQKToMWI=;
        b=jOSfduzQlXOTHreplbQ3BrDFolW8OLB+tX+1EUIhDBrLqQuAJ0SLRjU5dsexxeKEoM
         Hi6gCbrROy3APJtJO9L/X4ANMPnZGkdu9nkmPR6N013Zvi4XtokptvHeYKNijAxTJhq8
         +DGB4jEuhMyGjWka8SSEl+EeiWyukdgYWn5E/8LzTZTJHtqT9/AXPmw/1hZohLinkqmV
         xbaYZNMDv6QpNFUlRDaSDgJSsUHCMHxFgRmfuBdLZ6q+BO0nKuyo2xH+Rud/e/E/LVAu
         xcX4xQjg31wAgLh06IyO8KJO71VwvYwM5OOg4UV7MZoDsMoa9Ol3JFdW7FhpOLStgXOF
         yW1g==
X-Gm-Message-State: AOAM532VPNKsrL/bWhSEUkrs5pD8N7RLm7ra3GvRAwSTaiujgFDtE90l
        YECBZSpKI8BmxESXrskjSJl5VVADgdiveQ==
X-Google-Smtp-Source: ABdhPJw+Sk26GBoq+6zqKv4Ap5o16gb60UYbY2DWAQBRdB9QuoN07jc/P5J3oNcuidjLn7sY8DwjOg==
X-Received: by 2002:a05:6e02:12c7:: with SMTP id i7mr4756425ilm.138.1643335657755;
        Thu, 27 Jan 2022 18:07:37 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p5sm12306763iof.50.2022.01.27.18.07.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:07:37 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] adapter: Remove custom MGMT send/reply timeout
Date:   Thu, 27 Jan 2022 18:07:35 -0800
Message-Id: <20220128020735.3779202-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128020735.3779202-1-luiz.dentz@gmail.com>
References: <20220128020735.3779202-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This removes the custom MGMT send/reply timeout since bt_mgmt itself
can handle them itself and it actually start the timer only when the
command is actually sent to the kernel rather then when it is queued.

Fixes: https://github.com/bluez/bluez/issues/275
---
 src/adapter.c | 162 ++++----------------------------------------------
 1 file changed, 10 insertions(+), 152 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 9772e843a..72e98ba0a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -311,15 +311,6 @@ struct btd_adapter {
 
 	struct oob_handler *oob_handler;
 
-	unsigned int load_ltks_id;
-	unsigned int load_ltks_timeout;
-
-	unsigned int confirm_name_id;
-	unsigned int confirm_name_timeout;
-
-	unsigned int pair_device_id;
-	unsigned int pair_device_timeout;
-
 	unsigned int db_id;		/* Service event handler for GATT db */
 
 	bool is_default;		/* true if adapter is default one */
@@ -4134,21 +4125,6 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
 							adapter->dev_id);
 }
 
-static bool load_ltks_timeout(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	btd_error(adapter->dev_id, "Loading LTKs timed out for hci%u",
-							adapter->dev_id);
-
-	adapter->load_ltks_timeout = 0;
-
-	mgmt_cancel(adapter->mgmt, adapter->load_ltks_id);
-	adapter->load_ltks_id = 0;
-
-	return FALSE;
-}
-
 static void load_ltks_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -4160,11 +4136,6 @@ static void load_ltks_complete(uint8_t status, uint16_t length,
 				adapter->dev_id, mgmt_errstr(status), status);
 	}
 
-	adapter->load_ltks_id = 0;
-
-	timeout_remove(adapter->load_ltks_timeout);
-	adapter->load_ltks_timeout = 0;
-
 	DBG("LTKs loaded for hci%u", adapter->dev_id);
 }
 
@@ -4237,27 +4208,13 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
 		}
 	}
 
-	adapter->load_ltks_id = mgmt_send(adapter->mgmt,
-					MGMT_OP_LOAD_LONG_TERM_KEYS,
-					adapter->dev_id, cp_size, cp,
-					load_ltks_complete, adapter, NULL);
-
-	g_free(cp);
-
-	if (adapter->load_ltks_id == 0) {
+	if (!mgmt_send_timeout(adapter->mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS,
+			adapter->dev_id, cp_size, cp, load_ltks_complete,
+			adapter, NULL, 2))
 		btd_error(adapter->dev_id, "Failed to load LTKs for hci%u",
 							adapter->dev_id);
-		return;
-	}
 
-	/*
-	 * This timeout handling is needed since the kernel is stupid
-	 * and forgets to send a command complete response. However in
-	 * case of failures it does send a command status.
-	 */
-	adapter->load_ltks_timeout = timeout_add_seconds(2,
-						load_ltks_timeout, adapter,
-						NULL);
+	g_free(cp);
 }
 
 static void load_irks_complete(uint8_t status, uint16_t length,
@@ -5610,15 +5567,6 @@ static void adapter_free(gpointer user_data)
 		adapter->passive_scan_timeout = 0;
 	}
 
-	if (adapter->load_ltks_timeout > 0)
-		timeout_remove(adapter->load_ltks_timeout);
-
-	if (adapter->confirm_name_timeout > 0)
-		timeout_remove(adapter->confirm_name_timeout);
-
-	if (adapter->pair_device_timeout > 0)
-		timeout_remove(adapter->pair_device_timeout);
-
 	if (adapter->auth_idle_id)
 		g_source_remove(adapter->auth_idle_id);
 
@@ -6746,21 +6694,6 @@ const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
 	return &adapter->bdaddr;
 }
 
-static bool confirm_name_timeout(gpointer user_data)
-{
-	struct btd_adapter *adapter = user_data;
-
-	btd_error(adapter->dev_id, "Confirm name timed out for hci%u",
-							adapter->dev_id);
-
-	adapter->confirm_name_timeout = 0;
-
-	mgmt_cancel(adapter->mgmt, adapter->confirm_name_id);
-	adapter->confirm_name_id = 0;
-
-	return FALSE;
-}
-
 static void confirm_name_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -6770,13 +6703,9 @@ static void confirm_name_complete(uint8_t status, uint16_t length,
 		btd_error(adapter->dev_id,
 				"Failed to confirm name for hci%u: %s (0x%02x)",
 				adapter->dev_id, mgmt_errstr(status), status);
+		return;
 	}
 
-	adapter->confirm_name_id = 0;
-
-	timeout_remove(adapter->confirm_name_timeout);
-	adapter->confirm_name_timeout = 0;
-
 	DBG("Confirm name complete for hci%u", adapter->dev_id);
 }
 
@@ -6790,49 +6719,16 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	DBG("hci%d bdaddr %s name_known %u", adapter->dev_id, addr,
 								name_known);
 
-	/*
-	 * If the kernel does not answer the confirm name command with
-	 * a command complete or command status in time, this might
-	 * race against another device found event that also requires
-	 * to confirm the name. If there is a pending command, just
-	 * cancel it to be safe here.
-	 */
-	if (adapter->confirm_name_id > 0) {
-		btd_warn(adapter->dev_id,
-				"Found pending confirm name for hci%u",
-							adapter->dev_id);
-		mgmt_cancel(adapter->mgmt, adapter->confirm_name_id);
-	}
-
-	if (adapter->confirm_name_timeout > 0) {
-		timeout_remove(adapter->confirm_name_timeout);
-		adapter->confirm_name_timeout = 0;
-	}
-
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
 	cp.addr.type = bdaddr_type;
 	cp.name_known = name_known;
 
-	adapter->confirm_name_id = mgmt_reply(adapter->mgmt,
-					MGMT_OP_CONFIRM_NAME,
-					adapter->dev_id, sizeof(cp), &cp,
-					confirm_name_complete, adapter, NULL);
-
-	if (adapter->confirm_name_id == 0) {
+	if (!mgmt_reply_timeout(adapter->mgmt, MGMT_OP_CONFIRM_NAME,
+				adapter->dev_id, sizeof(cp), &cp,
+				confirm_name_complete, adapter, NULL, 2))
 		btd_error(adapter->dev_id, "Failed to confirm name for hci%u",
 							adapter->dev_id);
-		return;
-	}
-
-	/*
-	 * This timeout handling is needed since the kernel is stupid
-	 * and forgets to send a command complete response. However in
-	 * case of failures it does send a command status.
-	 */
-	adapter->confirm_name_timeout = timeout_add_seconds(2,
-						confirm_name_timeout, adapter,
-						NULL);
 }
 
 static void adapter_msd_notify(struct btd_adapter *adapter,
@@ -8106,21 +8002,6 @@ static void free_pair_device_data(void *user_data)
 	g_free(data);
 }
 
-static bool pair_device_timeout(gpointer user_data)
-{
-	struct pair_device_data *data = user_data;
-	struct btd_adapter *adapter = data->adapter;
-
-	btd_error(adapter->dev_id, "Pair device timed out for hci%u",
-							adapter->dev_id);
-
-	adapter->pair_device_timeout = 0;
-
-	adapter_cancel_bonding(adapter, &data->bdaddr, data->addr_type);
-
-	return FALSE;
-}
-
 static void pair_device_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -8130,13 +8011,6 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 
 	DBG("%s (0x%02x)", mgmt_errstr(status), status);
 
-	adapter->pair_device_id = 0;
-
-	if (adapter->pair_device_timeout > 0) {
-		timeout_remove(adapter->pair_device_timeout);
-		adapter->pair_device_timeout = 0;
-	}
-
 	/* Workaround for a kernel bug
 	 *
 	 * Broken kernels may reply to device pairing command with command
@@ -8164,12 +8038,6 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 int adapter_create_bonding(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 					uint8_t addr_type, uint8_t io_cap)
 {
-	if (adapter->pair_device_id > 0) {
-		btd_error(adapter->dev_id,
-			"Unable pair since another pairing is in progress");
-		return -EBUSY;
-	}
-
 	suspend_discovery(adapter);
 
 	return adapter_bonding_attempt(adapter, bdaddr, addr_type, io_cap);
@@ -8201,10 +8069,10 @@ int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	bacpy(&data->bdaddr, bdaddr);
 	data->addr_type = addr_type;
 
-	id = mgmt_send(adapter->mgmt, MGMT_OP_PAIR_DEVICE,
+	id = mgmt_send_timeout(adapter->mgmt, MGMT_OP_PAIR_DEVICE,
 				adapter->dev_id, sizeof(cp), &cp,
 				pair_device_complete, data,
-				free_pair_device_data);
+				free_pair_device_data, BONDING_TIMEOUT);
 
 	if (id == 0) {
 		btd_error(adapter->dev_id, "Failed to pair %s for hci%u",
@@ -8213,16 +8081,6 @@ int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 		return -EIO;
 	}
 
-	adapter->pair_device_id = id;
-
-	/* Due to a bug in the kernel it is possible that a LE pairing
-	 * request never times out. Therefore, add a timer to clean up
-	 * if no response arrives
-	 */
-	adapter->pair_device_timeout = timeout_add_seconds(BONDING_TIMEOUT,
-						pair_device_timeout, data,
-						NULL);
-
 	return 0;
 }
 
-- 
2.34.1

