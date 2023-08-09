Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D97C001B0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 18:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjHISxZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 14:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbjHISxZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 14:53:25 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90227E71
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 11:53:22 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RLfMj0B31z49Q3M;
        Wed,  9 Aug 2023 21:53:20 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691607201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m1w46901Dikw7rzR1THILFMO66nhVb2KoRw2KxHwkp0=;
        b=QrQ2HCa6gn/svQkyHT76VrVsHpaq46+Sxibuxv2Zj5mrQwfIV66Yv+6zv8xvW6TEV3+wNw
        wzI5xlrsQFyEgdLvtL+rrZc7B9bRN31PL6ltQDlJ9apRvbZec+CMBtWUfN6oJkyGCuxwQy
        dK+MQ+zc8HP7cQY5yY6sUzT+JPvv3wvHVBApUc3qpPZaVe5BJcYsqQu34ep5cWnMdAorDz
        3oIZ2j1895RX+mEmor6lvvJK9n9emxT3fu1jPOu20SEftctdr1sqU33FY9F1gVIcyaocfE
        LJK+A4TiiJl0oA22V+5aosumZmygWaLHI9SCcRwpesO1PXc+hc2De8FK37PAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691607201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=m1w46901Dikw7rzR1THILFMO66nhVb2KoRw2KxHwkp0=;
        b=anc4y0pgeNfGW4rEBEbp5jsvi3AZyu1ebJ2xqTI/MYZnQly4/h/KRbMMY991ZvCnZrL0xQ
        cirBPCKFQVf4+jZ3AAzOxGkrVl/n+ypOLVNjAytOImP1kb4zXKik09XcVCh4ePe5BUFH+9
        R6cY23ra26YqIJ8GWy9pm6acwVlFSgRbU2MOVLyC1+dlmmNjQWjh3F0B1+rQDLAVb5ZAiM
        l6WH6B7qb4A6QxsECrGQP4nCWvXV6WnwPEA8vIcJFo8/JcGwY7DMVmcXu11leawA0dCRza
        WqwwwVEWIQ9UHJonVLkWdpg8mqWw//7Fqr5tvtGH8o/SZHOn8OyNUINCQJ8Wgg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691607201; a=rsa-sha256;
        cv=none;
        b=OMBNnXgploQHrM12GXyYe8XNTOu/reCsaNq88PbNyXPy5Cf/p3Ro/wGKM/1LmLwsOJ5Xcx
        cQb1Wtbv0HsOx/cjdzbzB+qM2fQz77im7u+Qi+V2I4U/KYJYPfUT2is6O63z66Hvb1ecxi
        2HU9bulbYiBvVO/oHk5t3UUOehWO5Fng4f30cSkHpNabU3y5lN0iqXq2SQyS6Cm3iBOLsJ
        8/rFzuUPH48EUokeD8tnkYmGJQkqioBoRzajKls3LKSWcS5mN7YX0BGARWh8LbeSQTdHbx
        xgrmc3hMfY+0SyzrZQdEnw/ceDNtuZqpB39ZjQcGKzf0eSU3jOo94FC5GbGKvQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ] adapter: wait for kernel exp features in adapter initialization
Date:   Wed,  9 Aug 2023 21:53:19 +0300
Message-ID: <429cbc5a4fcdb150c62cf368c928e1174016eefb.1691606987.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Things like BAP depend on ISO sockets being enabled in kernel.  It is
possible the MGMT commands enabling experimental kernel features do not
complete, before BAP etc. initialization and probing starts, in which
case BAP will be mostly nonfunctional.

This was observed to occur always when running BlueZ in a Fedora VM,
requiring bluetoothd restart after every boot for BAP to work,
log containing lines in the order:

bluetoothd[981]: src/adapter.c:read_exp_features_complete() 6fbaf188-05e0-496a-9885-d6ddfdb4e03e flags 0 action 1
bluetoothd[981]: src/adapter.c:read_info_complete() index 0 status 0x00
bluetoothd[981]: profiles/audio/bap.c:bap_probe() BAP requires ISO Socket which is not enabled
bluetoothd[981]: src/adapter.c:iso_socket_complete() ISO Socket successfully set

Fix by waiting in adapter initialization that all MGMT exp feature
requests are done, before proceeding to read adapter information.

Also fix canceling MGMT_OP_SET_EXP_FEATURE for ISO sockets.
---
 src/adapter.c | 90 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 71 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 004062e7c..608c06f9e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -331,6 +331,8 @@ struct btd_adapter {
 
 	bool is_default;		/* true if adapter is default one */
 
+	unsigned int set_exp_iso_id;
+	unsigned int exp_pending;
 	struct queue *exps;
 };
 
@@ -5782,6 +5784,8 @@ static void adapter_free(gpointer user_data)
 	g_queue_free(adapter->auths);
 	queue_destroy(adapter->exps, NULL);
 
+	adapter->exp_pending = 0;
+
 	/*
 	 * Unregister all handlers for this specific index since
 	 * the adapter bound to them is no longer valid.
@@ -5796,6 +5800,8 @@ static void adapter_free(gpointer user_data)
 	 * since the adapter bound to them is no longer valid.
 	 */
 	mgmt_cancel_index(adapter->mgmt, adapter->dev_id);
+	if (adapter->set_exp_iso_id)
+		mgmt_cancel(adapter->mgmt, adapter->set_exp_iso_id);
 
 	mgmt_unref(adapter->mgmt);
 
@@ -6895,6 +6901,8 @@ static void adapter_remove(struct btd_adapter *adapter)
 
 	g_slist_free(adapter->msd_callbacks);
 	adapter->msd_callbacks = NULL;
+
+	adapter->exp_pending = 0;
 }
 
 const char *adapter_get_path(struct btd_adapter *adapter)
@@ -9824,6 +9832,8 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 	.func = _func, \
 }
 
+static void exp_complete(void *user_data);
+
 static void set_exp_debug_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
@@ -9854,8 +9864,10 @@ static void exp_debug_func(struct btd_adapter *adapter, uint8_t action)
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
-			set_exp_debug_complete, adapter, NULL) > 0)
+			set_exp_debug_complete, adapter, exp_complete) > 0) {
+		++adapter->exp_pending;
 		return;
+	}
 
 	btd_error(adapter->dev_id, "Failed to set exp debug");
 }
@@ -9904,8 +9916,11 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint8_t action)
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
-			set_rpa_resolution_complete, adapter, NULL) > 0)
+			set_rpa_resolution_complete, adapter,
+			exp_complete) > 0) {
+		++adapter->exp_pending;
 		return;
+	}
 
 	btd_error(adapter->dev_id, "Failed to set RPA Resolution");
 }
@@ -9940,12 +9955,22 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
-			codec_offload_complete, adapter, NULL) > 0)
+			codec_offload_complete, adapter, exp_complete) > 0) {
+		++adapter->exp_pending;
 		return;
+	}
 
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
 }
 
+static void iso_socket_done(void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	adapter->set_exp_iso_id = 0;
+	exp_complete(adapter);
+}
+
 static void iso_socket_complete(uint8_t status, uint16_t len,
 				const void *param, void *user_data)
 {
@@ -9969,15 +9994,20 @@ static void iso_socket_complete(uint8_t status, uint16_t len,
 static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
 {
 	struct mgmt_cp_set_exp_feature cp;
+	unsigned int id;
 
 	memset(&cp, 0, sizeof(cp));
 	memcpy(cp.uuid, iso_socket_uuid.val, 16);
 	cp.action = action;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
-			MGMT_INDEX_NONE, sizeof(cp), &cp,
-			iso_socket_complete, adapter, NULL) > 0)
+	id = mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE, MGMT_INDEX_NONE,
+			sizeof(cp), &cp, iso_socket_complete, adapter,
+			iso_socket_done);
+	if (id > 0) {
+		adapter->set_exp_iso_id = id;
+		++adapter->exp_pending;
 		return;
+	}
 
 	btd_error(adapter->dev_id, "Failed to set ISO Socket");
 }
@@ -10063,8 +10093,10 @@ static void read_exp_features(struct btd_adapter *adapter)
 {
 	if (mgmt_send(adapter->mgmt, MGMT_OP_READ_EXP_FEATURES_INFO,
 			adapter->dev_id, 0, NULL, read_exp_features_complete,
-			adapter, NULL) > 0)
+			adapter, exp_complete) > 0) {
+		++adapter->exp_pending;
 		return;
+	}
 
 	btd_error(adapter->dev_id, "Failed to read exp features info");
 }
@@ -10389,6 +10421,36 @@ static void reset_adv_monitors(uint16_t index)
 	error("Failed to reset Adv Monitors");
 }
 
+static void read_info(struct btd_adapter *adapter)
+{
+	DBG("sending read info command for index %u", adapter->dev_id);
+
+	if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, adapter->dev_id, 0, NULL,
+					read_info_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id,
+			"Failed to read controller info for index %u",
+			adapter->dev_id);
+
+	adapter_list = g_list_remove(adapter_list, adapter);
+
+	btd_adapter_unref(adapter);
+}
+
+static void exp_complete(void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+
+	adapter->exp_pending--;
+
+	DBG("index %u has %u pending MGMT EXP requests", adapter->dev_id,
+							adapter->exp_pending);
+
+	if (!adapter->exp_pending)
+		read_info(adapter);
+}
+
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -10435,18 +10497,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
 	 */
 	adapter_list = g_list_append(adapter_list, adapter);
 
-	DBG("sending read info command for index %u", index);
-
-	if (mgmt_send(mgmt_primary, MGMT_OP_READ_INFO, index, 0, NULL,
-					read_info_complete, adapter, NULL) > 0)
-		return;
-
-	btd_error(adapter->dev_id,
-			"Failed to read controller info for index %u", index);
-
-	adapter_list = g_list_remove(adapter_list, adapter);
-
-	btd_adapter_unref(adapter);
+	if (!adapter->exp_pending)
+		read_info(adapter);
 }
 
 static void index_removed(uint16_t index, uint16_t length, const void *param,
-- 
2.41.0

