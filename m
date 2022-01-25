Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B83DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 25 Jan 2022 02:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354535AbiAYCeG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 24 Jan 2022 21:34:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3417924AbiAYCLr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 24 Jan 2022 21:11:47 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7886C055A8E
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 17:05:01 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 187so16744059pga.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 24 Jan 2022 17:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=9pkVpEpaLdFLYFcvifx+HBGUrsNqMy94PdAG+dQJiO8=;
        b=OlKy7333w1nQmGAfEEMQOQnSOXBZ//g/ihT+cSawToipQZlhGiJseTwsa3GsE2GTA0
         jVRXE6ZvHwFBJHN0qPRwAz00FDPJhwk23S2m55OiGgU5Q19kn5PuplmtKhJmtjMR6dyX
         T62Qpk+8+XrdEsi7DNRb729i1Capx+1353I9vrQvbCpMu9NZuiwxj696Xk/S1g1XSWbL
         cOrkLy0aj0GqvX5uFUXzJr9dLPhPejO4eBDk4l2q/U/6hmLxh6Fq/Di8wo4M6tbXtV2u
         9q1FDW+w0jT3prynTm5mPxIfYDUBOx905YOWUWxrmSnL43OkImACrjTclAiSR5jNUj8g
         tvng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pkVpEpaLdFLYFcvifx+HBGUrsNqMy94PdAG+dQJiO8=;
        b=3pWBEuljZ7/GD2cby4lzhTAsGEp3HWHjigrKzNDYQ54mUZFmfAaa+pmFFsprP3nsX0
         6n/jZ/B8Jea2zO653G+kw7vudTFDb3mvYjfVzpRmeq7ww67WzKNRG+NeT8FeLxx1Ox+R
         5lrtHaFwxU0Bz3BcY5J6LDsZasqcFk7tBNmnUyiL8XEPnNRWxrSBJYPojcjF2YQ19uoR
         mqkQCpDux35N01boEy7jcnAQrpBtJqmVk0w2uHAN7q558+XxuZVRvtcRmIzZ3rabL8I5
         DstnW7GUR8YpZ86Few8Y6FAWlz6v7TQuoBkEZLKGnruZVf2zjW1PjEds27g7jQ1o/0Yv
         W2rg==
X-Gm-Message-State: AOAM5317RM+xdxUM8emTiZebGHAvx2FIxO2/Sd2BS9VQ5HX+AZlk4YMI
        mBBuKvf/+8PFc3Nmp0c1Cv1qkMmYIgipiQ==
X-Google-Smtp-Source: ABdhPJyEfBc+Y1DO1H68s9gx1VhWYAqxrxXmXvbqQHRF1gcvUKPenY567yAanOnWmk9V5ig1qGal/Q==
X-Received: by 2002:a63:210:: with SMTP id 16mr13887497pgc.26.1643072700523;
        Mon, 24 Jan 2022 17:05:00 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id oo9sm498037pjb.15.2022.01.24.17.04.59
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 17:05:00 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] adapter: Remove custom MGMT send/reply timeout
Date:   Mon, 24 Jan 2022 17:04:58 -0800
Message-Id: <20220125010458.2326473-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125010458.2326473-1-luiz.dentz@gmail.com>
References: <20220125010458.2326473-1-luiz.dentz@gmail.com>
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
 src/adapter.c | 160 +++-----------------------------------------------
 1 file changed, 9 insertions(+), 151 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 42a9256a4..89b70e88a 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -318,15 +318,6 @@ struct btd_adapter {
 
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
@@ -4141,21 +4132,6 @@ static void load_link_keys(struct btd_adapter *adapter, GSList *keys,
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
@@ -4167,11 +4143,6 @@ static void load_ltks_complete(uint8_t status, uint16_t length,
 				adapter->dev_id, mgmt_errstr(status), status);
 	}
 
-	adapter->load_ltks_id = 0;
-
-	timeout_remove(adapter->load_ltks_timeout);
-	adapter->load_ltks_timeout = 0;
-
 	DBG("LTKs loaded for hci%u", adapter->dev_id);
 }
 
@@ -4244,27 +4215,13 @@ static void load_ltks(struct btd_adapter *adapter, GSList *keys)
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
+	if (!mgmt_send(adapter->mgmt, MGMT_OP_LOAD_LONG_TERM_KEYS,
+			adapter->dev_id, cp_size, cp, load_ltks_complete,
+			adapter, NULL))
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
@@ -5617,15 +5574,6 @@ static void adapter_free(gpointer user_data)
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
 
@@ -6753,21 +6701,6 @@ const bdaddr_t *btd_adapter_get_address(struct btd_adapter *adapter)
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
@@ -6777,13 +6710,9 @@ static void confirm_name_complete(uint8_t status, uint16_t length,
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
 
@@ -6797,49 +6726,16 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
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
+	if (!mgmt_reply(adapter->mgmt, MGMT_OP_CONFIRM_NAME,
 					adapter->dev_id, sizeof(cp), &cp,
-					confirm_name_complete, adapter, NULL);
-
-	if (adapter->confirm_name_id == 0) {
+					confirm_name_complete, adapter, NULL))
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
@@ -8113,21 +8009,6 @@ static void free_pair_device_data(void *user_data)
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
@@ -8137,13 +8018,6 @@ static void pair_device_complete(uint8_t status, uint16_t length,
 
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
@@ -8171,12 +8045,6 @@ static void pair_device_complete(uint8_t status, uint16_t length,
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
@@ -8208,10 +8076,10 @@ int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
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
@@ -8220,16 +8088,6 @@ int adapter_bonding_attempt(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
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

