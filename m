Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F07DEE4993
	for <linux-bluetooth@archiver.kernel.org>; Sun, 20 Aug 2023 11:52:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjHTLwT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 20 Aug 2023 07:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjHTLwS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 20 Aug 2023 07:52:18 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C072D67
        for <linux-bluetooth@vger.kernel.org>; Sun, 20 Aug 2023 04:47:13 -0700 (PDT)
Received: from monolith.lan (unknown [185.77.218.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4RTDNt5t3xzyY4;
        Sun, 20 Aug 2023 14:47:10 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1692532031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YsGh9bSy+MtxORr2/lhtkdeQLYhyYsW1MmqLSEikG+8=;
        b=U4+d/PBJA2WfuqCTfqlBfSYsgt8GLkownzbX4MZW/qlC7IFQCthvRZH9nebVrsEw14Bo8H
        X16vS6Uw1mJFzNTKtMJSay2RNdXMiXQ1cvzNMb0OF2AU2JRtBlsXg2OQIZ2wiR6uIMqeLy
        jor6BwvZjJTB/A/1WsYsWpKnNSMLonU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1692532031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=YsGh9bSy+MtxORr2/lhtkdeQLYhyYsW1MmqLSEikG+8=;
        b=OaqNP3ZQN0wCT5vShgObxgdOa5bTgcyte7dEdrhwZnnEIENRZIUOEHgtpU4JdbZunROqju
        pgVRRzUbfM4KR1I6z6BQbIjY35i1OZGUDTMFcmgUeL2XYcUMXCzjPs+t9cCzeotpiXPEBl
        LIP++szpyLeVHkBCRUhTv2OwA3D5xRo=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1692532031; a=rsa-sha256; cv=none;
        b=EUSd3Gpi3qw4BYqjo5BfRDajbq+GRJHpkGwJkuFmhmLvpqnlnadwH4LH3AfTZ+4wHCmpWr
        rRnYZE/s7LSi7uzM6wsBQ3sz3rHkegvBrzYqUx00f1Ms1OMv9Bcd0cz6l8gqIxNSl6/xCy
        Pt6Ee+B0gFT/hzZLF0QyEHQ3HVHTYac=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2] adapter: wait for kernel exp features in adapter initialization
Date:   Sun, 20 Aug 2023 14:47:06 +0300
Message-ID: <00052eaeb78774fd7be365805203cb0c8b189243.1692531437.git.pav@iki.fi>
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

Notes:
    v2: use queue to store pending mgmt set exp request ids

 src/adapter.c | 135 +++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 107 insertions(+), 28 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 004062e7c..324b13e56 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -239,6 +239,11 @@ struct btd_adapter_pin_cb_iter {
 	/* When the iterator reaches the end, it is NULL and attempt is 0 */
 };
 
+struct exp_pending {
+	struct btd_adapter *adapter;
+	unsigned int id;
+};
+
 enum {
 	ADAPTER_POWER_STATE_OFF,
 	ADAPTER_POWER_STATE_ON,
@@ -331,6 +336,7 @@ struct btd_adapter {
 
 	bool is_default;		/* true if adapter is default one */
 
+	struct queue *exp_pending;
 	struct queue *exps;
 };
 
@@ -5754,6 +5760,16 @@ static void remove_discovery_list(struct btd_adapter *adapter)
 	adapter->discovery_list = NULL;
 }
 
+static void cancel_exp_pending(void *data)
+{
+	struct exp_pending *pending = data;
+	struct btd_adapter *adapter = pending->adapter;
+
+	pending->adapter = NULL;
+	mgmt_cancel(adapter->mgmt, pending->id);
+	g_free(pending);
+}
+
 static void adapter_free(gpointer user_data)
 {
 	struct btd_adapter *adapter = user_data;
@@ -5782,6 +5798,8 @@ static void adapter_free(gpointer user_data)
 	g_queue_free(adapter->auths);
 	queue_destroy(adapter->exps, NULL);
 
+	queue_destroy(adapter->exp_pending, cancel_exp_pending);
+
 	/*
 	 * Unregister all handlers for this specific index since
 	 * the adapter bound to them is no longer valid.
@@ -6848,6 +6866,7 @@ static struct btd_adapter *btd_adapter_new(uint16_t index)
 
 	adapter->auths = g_queue_new();
 	adapter->exps = queue_new();
+	adapter->exp_pending = queue_new();
 
 	return btd_adapter_ref(adapter);
 }
@@ -6895,6 +6914,8 @@ static void adapter_remove(struct btd_adapter *adapter)
 
 	g_slist_free(adapter->msd_callbacks);
 	adapter->msd_callbacks = NULL;
+
+	queue_remove_all(adapter->exp_pending, NULL, NULL, cancel_exp_pending);
 }
 
 const char *adapter_get_path(struct btd_adapter *adapter)
@@ -9824,10 +9845,38 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 	.func = _func, \
 }
 
+static void exp_complete(void *user_data);
+
+static bool exp_mgmt_send(struct btd_adapter *adapter, uint16_t opcode,
+			uint16_t index, uint16_t length, const void *param,
+			mgmt_request_func_t callback)
+{
+	struct exp_pending *pending;
+
+	pending = g_new0(struct exp_pending, 1);
+	pending->adapter = adapter;
+
+	if (!queue_push_tail(adapter->exp_pending, pending)) {
+		g_free(pending);
+		return false;
+	}
+
+	pending->id = mgmt_send(adapter->mgmt, opcode, index, length, param,
+					callback, pending, exp_complete);
+	if (!pending->id) {
+		queue_remove(adapter->exp_pending, pending);
+		g_free(pending);
+		return false;
+	}
+
+	return true;
+}
+
 static void set_exp_debug_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
-	struct btd_adapter *adapter = user_data;
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
 	uint8_t action;
 
 	if (status != 0) {
@@ -9852,9 +9901,9 @@ static void exp_debug_func(struct btd_adapter *adapter, uint8_t action)
 	memcpy(cp.uuid, debug_uuid.val, 16);
 	cp.action = action;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
-			set_exp_debug_complete, adapter, NULL) > 0)
+			set_exp_debug_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to set exp debug");
@@ -9877,7 +9926,8 @@ static void quality_report_func(struct btd_adapter *adapter, uint8_t action)
 static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
-	struct btd_adapter *adapter = user_data;
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
 	uint8_t action;
 
 	if (status != 0) {
@@ -9902,9 +9952,9 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint8_t action)
 	memcpy(cp.uuid, rpa_resolution_uuid.val, 16);
 	cp.action = action;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
-			set_rpa_resolution_complete, adapter, NULL) > 0)
+			set_rpa_resolution_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to set RPA Resolution");
@@ -9913,7 +9963,8 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint8_t action)
 static void codec_offload_complete(uint8_t status, uint16_t len,
 					const void *param, void *user_data)
 {
-	struct btd_adapter *adapter = user_data;
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
 	uint8_t action;
 
 	if (status != 0) {
@@ -9938,9 +9989,9 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 	memcpy(cp.uuid, codec_offload_uuid.val, 16);
 	cp.action = action;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
 			adapter->dev_id, sizeof(cp), &cp,
-			codec_offload_complete, adapter, NULL) > 0)
+			codec_offload_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
@@ -9949,7 +10000,8 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 static void iso_socket_complete(uint8_t status, uint16_t len,
 				const void *param, void *user_data)
 {
-	struct btd_adapter *adapter = user_data;
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
 	uint8_t action;
 
 	if (status != 0) {
@@ -9974,9 +10026,9 @@ static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
 	memcpy(cp.uuid, iso_socket_uuid.val, 16);
 	cp.action = action;
 
-	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+	if (exp_mgmt_send(adapter, MGMT_OP_SET_EXP_FEATURE,
 			MGMT_INDEX_NONE, sizeof(cp), &cp,
-			iso_socket_complete, adapter, NULL) > 0)
+			iso_socket_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to set ISO Socket");
@@ -10001,7 +10053,8 @@ static const struct exp_feat {
 static void read_exp_features_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct btd_adapter *adapter = user_data;
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
 	const struct mgmt_rp_read_exp_features_info *rp = param;
 	size_t feature_count = 0;
 	size_t i = 0;
@@ -10061,9 +10114,8 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 
 static void read_exp_features(struct btd_adapter *adapter)
 {
-	if (mgmt_send(adapter->mgmt, MGMT_OP_READ_EXP_FEATURES_INFO,
-			adapter->dev_id, 0, NULL, read_exp_features_complete,
-			adapter, NULL) > 0)
+	if (exp_mgmt_send(adapter, MGMT_OP_READ_EXP_FEATURES_INFO,
+			adapter->dev_id, 0, NULL, read_exp_features_complete))
 		return;
 
 	btd_error(adapter->dev_id, "Failed to read exp features info");
@@ -10389,6 +10441,43 @@ static void reset_adv_monitors(uint16_t index)
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
+	struct exp_pending *pending = user_data;
+	struct btd_adapter *adapter = pending->adapter;
+
+	if (!adapter)
+		return;  /* canceled */
+
+	queue_remove(adapter->exp_pending, pending);
+	g_free(pending);
+
+	if (queue_isempty(adapter->exp_pending)) {
+		read_info(adapter);
+		return;
+	}
+
+	DBG("index %u has %u pending MGMT EXP requests", adapter->dev_id,
+					queue_length(adapter->exp_pending));
+}
+
 static void index_added(uint16_t index, uint16_t length, const void *param,
 							void *user_data)
 {
@@ -10435,18 +10524,8 @@ static void index_added(uint16_t index, uint16_t length, const void *param,
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
+	if (queue_isempty(adapter->exp_pending))
+		read_info(adapter);
 }
 
 static void index_removed(uint16_t index, uint16_t length, const void *param,
-- 
2.41.0

