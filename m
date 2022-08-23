Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D47AC25B08
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Aug 2022 04:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiHWEQ7 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Aug 2022 00:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHWEQ6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Aug 2022 00:16:58 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3710481ED
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:16:56 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id ng1-20020a17090b1a8100b001f4f9f69d48so10689907pjb.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Aug 2022 21:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=iSos4qj3o67rgNRBFaKfbufXzPS5AJRf3A4QhYe1xJ4=;
        b=Xx7a0swIOuncKNS6zk0/d2SBtNhwBZR/eo6XnNamE8HZfvBBJfJpCafnro75MdiNpz
         IbZbyHznDucRJyJbd4uIx1+jC/6JauYNm3J8DEisI/NFrPO9xlSCZyN0tGELstNXJc3H
         W9Nu++bZrJEq4VMMMtSL9GWOCntmt4QfAq6KQt2GBAejMOqC/YYiPhZlzEPCA0jBkr84
         oVQ9dDvbloJU8UFvr3v8gzW4fqWBx30GRQ0VYvfGvOnxwV/SOSKqpRj5TObn5S55u+e0
         xiQ0s0As7rTkZ9jXqKaykOpjHjnr+EpBwbZIhWJg88tzSmPEbfut01glq48lAJzloupm
         vKDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=iSos4qj3o67rgNRBFaKfbufXzPS5AJRf3A4QhYe1xJ4=;
        b=X8CMl9f0/me4FNOhfFa/itnb2riyJmlXj/YZtNhIgJTgB8T3VHRa9OC+6p0iQHSMOO
         gs2RXc4dxtzBESHUC7LkdkodBr6JBXZw8qAbIt6SqarHN2Nnpi1azNe3C4o0tcAcAhpz
         oNxfmygr27744A60j/RJHXHIvxLheV7sWNSI//1z4rceyp3DO/I5MKGNW3FP+TeyRH0e
         tyPZPaxUbpPoaX5B0Yq1KiHku4vs2u8qy5l3xytx7co3dbjYxUJlvPapwqxjKvfPxA/3
         x+BYtVrFyS3Ul49AvsG4mWw6wzeZ03in+Oo+uHJko9LOvHyclDxytBZca0MS4j1H7mZO
         F+Wg==
X-Gm-Message-State: ACgBeo0lthCHkUCJ7Dq7AUVOpRcsWn+CS1JHNfHVRNRkjoalVCkOR8q3
        Copv7KimhErGWH1FxfPoIxikez3RS7JC2j2sDPT+TnKwsoCk0DHIKu/+Gy0alexcEL0xKbZRBtZ
        mFo2rbZ94B5+7iNsqNzBGXKYsyEfXePQuqxoP5iY0YAnvDPeIhw9le2kHPPGXnDW0CjlG5WRYpR
        oi
X-Google-Smtp-Source: AA6agR4Q/0oJStkGSt3VtzOgiOaE29R8iaevO/dBlVIG5ktGheciWCVJAs8ippCpOiDmPpIpJHWCJn+Z/N5G
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:aa4:997c:9497:366e])
 (user=apusaka job=sendgmr) by 2002:a05:6a00:1252:b0:536:de0d:1d16 with SMTP
 id u18-20020a056a00125200b00536de0d1d16mr3859309pfi.82.1661228216347; Mon, 22
 Aug 2022 21:16:56 -0700 (PDT)
Date:   Tue, 23 Aug 2022 12:15:56 +0800
Message-Id: <20220823121541.Bluez.v2.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [Bluez PATCH v2] adapter: Reset pending settings when receiving MGMT error
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

We set the pending settings flag when sending MGMT_SETTING_*
commands to the MGMT layer and clear them when receiving a
successful reply, but we don't clear them when receiving an error
reply. This might cause a setting to be stuck in pending state.

Therefore, also clear the pending flag when receiving error.
Furthermore, this patch also postpones setting the pending flag
until we queue the MGMT command in order to avoid setting it too
soon but we return early.

This was caught during power off test, where MGMT_OP_SET_POWERED
returns Authentication Failed because disconnection takes too long.
Future attempts to switch power will then be ignored.

< HCI Command: Disconnect (0x01|0x0006) plen 3   #17916 [hci0] 12.502908
        Handle: 512
        Reason: Remote Device Terminated due to Power Off (0x15)
> HCI Event: Command Status (0x0f) plen 4        #17917 [hci0] 12.503185
      Disconnect (0x01|0x0006) ncmd 1
        Status: Success (0x00)
@ MGMT Event: Command Status (0x0002) plen 3   {0x0001} [hci0] 14.519491
      Set Powered (0x0005)
        Status: Authentication Failed (0x05)
= bluetoothd: Failed to set mode: Authentication Failed (0x05) 14.520042
= bluetoothd: adapter /org/bluez/hci0 set power to 0           14.813533
> HCI Event: Disconnect Complete (0x05) plen 4   #17918 [hci0] 16.509043
        Status: Success (0x00)
        Handle: 512
        Reason: Connection Timeout (0x08)

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

Changes in v2:
* Update commit message with btsnoop log
* Fix memory leak

 src/adapter.c | 39 +++++++++++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec26aab1a7..b453e86a03 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -640,14 +640,21 @@ static void new_settings_callback(uint16_t index, uint16_t length,
 	settings_changed(adapter, settings);
 }
 
+struct set_mode_data {
+	struct btd_adapter *adapter;
+	uint32_t setting;
+};
+
 static void set_mode_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
-	struct btd_adapter *adapter = user_data;
+	struct set_mode_data *data = user_data;
+	struct btd_adapter *adapter = data->adapter;
 
 	if (status != MGMT_STATUS_SUCCESS) {
 		btd_error(adapter->dev_id, "Failed to set mode: %s (0x%02x)",
 						mgmt_errstr(status), status);
+		adapter->pending_settings &= ~data->setting;
 		return;
 	}
 
@@ -677,6 +684,7 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 {
 	struct mgmt_mode cp;
 	uint32_t setting = 0;
+	struct set_mode_data *data;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.val = mode;
@@ -699,15 +707,20 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 		break;
 	}
 
-	adapter->pending_settings |= setting;
-
 	DBG("sending set mode command for index %u", adapter->dev_id);
 
+	data = g_new0(struct set_mode_data, 1);
+	data->adapter = adapter;
+	data->setting = setting;
+
 	if (mgmt_send(adapter->mgmt, opcode,
 				adapter->dev_id, sizeof(cp), &cp,
-				set_mode_complete, adapter, NULL) > 0)
+				set_mode_complete, data, g_free) > 0) {
+		adapter->pending_settings |= setting;
 		return true;
+	}
 
+	g_free(data);
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
 							adapter->dev_id);
 
@@ -718,6 +731,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
 							uint16_t timeout)
 {
 	struct mgmt_cp_set_discoverable cp;
+	struct set_mode_data *data;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.val = mode;
@@ -734,11 +748,16 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
 									mode);
 	}
 
+	data = g_new0(struct set_mode_data, 1);
+	data->adapter = adapter;
+	data->setting = 0;
+
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DISCOVERABLE,
 				adapter->dev_id, sizeof(cp), &cp,
-				set_mode_complete, adapter, NULL) > 0)
+				set_mode_complete, data, g_free) > 0)
 		return true;
 
+	g_free(data);
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
 							adapter->dev_id);
 
@@ -2877,6 +2896,7 @@ static gboolean property_get_mode(struct btd_adapter *adapter,
 
 struct property_set_data {
 	struct btd_adapter *adapter;
+	uint32_t setting;
 	GDBusPendingPropertySet id;
 };
 
@@ -2901,6 +2921,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 
 		g_dbus_pending_property_error(data->id, dbus_err,
 							mgmt_errstr(status));
+
+		adapter->pending_settings &= ~data->setting;
 		return;
 	}
 
@@ -2969,8 +2991,6 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 	mode = (enable == TRUE) ? 0x01 : 0x00;
 
-	adapter->pending_settings |= setting;
-
 	switch (setting) {
 	case MGMT_SETTING_POWERED:
 		opcode = MGMT_OP_SET_POWERED;
@@ -3024,11 +3044,14 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 		goto failed;
 
 	data->adapter = adapter;
+	data->setting = setting;
 	data->id = id;
 
 	if (mgmt_send(adapter->mgmt, opcode, adapter->dev_id, len, param,
-			property_set_mode_complete, data, g_free) > 0)
+			property_set_mode_complete, data, g_free) > 0) {
+		adapter->pending_settings |= setting;
 		return;
+	}
 
 	g_free(data);
 
-- 
2.37.1.595.g718a3a8f04-goog

