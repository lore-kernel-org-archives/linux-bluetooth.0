Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D11C28D13
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Aug 2022 04:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbiHVEyQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Aug 2022 00:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiHVEyP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Aug 2022 00:54:15 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94701F2E8
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 21:54:13 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3360c0f0583so169360647b3.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Aug 2022 21:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=0UCpCk7kfWDJtYvreVOQFYHPgPiCo5d56aUPAsU2AOE=;
        b=QKTG18kOD3kbrtrTry+WrK9XQvAtGnK+H9NuW8RffYzvHbZyHcekXZznY+b4dOspI2
         AJG8ogpopAVnTYqB/16YhjdloXFLuQbkFj26CakuWmteBiD9r1ZeHHHj4e+UKaKVhC29
         wo9g7OiY13Vo6BfnnACmG/sQBy/gTWEarDDtBsn86InOgODJnyRjCbZEMomKczadDo80
         URm1inrluGcoLHAbpeQPPFKbH5H5KOHoX62ZWR/cY2RQIfhDchr+jP/z9/pA3f66tFRs
         GZ5D7LhfsPrRNjmpFWgEp2H+3WmusUCzG8KcWyFtFEwn4XPHNCUJehySrdWgbuCddsPY
         qC+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=0UCpCk7kfWDJtYvreVOQFYHPgPiCo5d56aUPAsU2AOE=;
        b=GKiANR13UsC/MIkB2/d0Xt30snvt4l0Al0lrcTUtqxzOl02Lkid8A0ltEPA23Nv0V6
         X6TnVQz+QDte8rYJY8B7Jq6lcp0QFezNz8V0GI9ipebAwuQa8teoHzDFwzpfOGpkehBN
         zopGN7G2zjy9us1fltEICSHPdiJh4omG3B7HCkKAQMv2K9jJwbmWX8Zlg8If/sUsrwyS
         Vsq3E9grx3PqZu/Nzs52dNo7vV2te19liNPpICuDLQ88wjzCouPEi/fFHObpyW3M5vX9
         RY6XKRBtI0PDrK1G0KlJbWmRw2/oZ3vre4mgcHsNXsyUS0p8QrscIO8vDyhDaeiVa55Z
         9KBQ==
X-Gm-Message-State: ACgBeo2ETz2NdjFBBkd0ddJrjwYGwf9NG8T3q3ccVJVVo8e8Zeg8GJOZ
        e3PbMEt4ShYPVqvye6ihEtAWRNR2PWKjVtKuvJa1jRn8DUHYIeX9z+nFHIF1Nn1JluIxA4IPxVW
        ivIZKJ9P3zXelHzCXvWh4wqlKFNr8RUCTEmpmjL5nQF2bpG3K0Ea+Zw6PF+38cVZuXcz6zO6ILG
        ad
X-Google-Smtp-Source: AA6agR641u4NI7BjT+wceyw+CXO1IT612+wBNJ3pMyHYHu00CxhR2yygdGw+lg2rZYAiS8FqPXGpQ+mISDVV
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:17:9732:c819:4bfc:92ae])
 (user=apusaka job=sendgmr) by 2002:a0d:edc2:0:b0:338:957:a719 with SMTP id
 w185-20020a0dedc2000000b003380957a719mr14186205ywe.132.1661144053082; Sun, 21
 Aug 2022 21:54:13 -0700 (PDT)
Date:   Mon, 22 Aug 2022 12:53:53 +0800
Message-Id: <20220822125221.Bluez.1.I541cbea9d6295f531c796bf3bda96b22db76bc19@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [Bluez PATCH] adapter: Reset pending settings when receiving MGMT error
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
commands to the MGMT layer and clear them when receiving success
reply, but we don't clear them when receiving error reply. This
might cause a setting to be stuck in pending state.

Therefore, also clear the pending flag when receiving error.
Furthermore, this patch also postpone setting the pending flag
until we queue the MGMT command in order to avoid setting it too
soon but we return early.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>

---

 src/adapter.c | 45 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index ec26aab1a7..4da1fcc3e5 100644
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
@@ -699,15 +707,23 @@ static bool set_mode(struct btd_adapter *adapter, uint16_t opcode,
 		break;
 	}
 
-	adapter->pending_settings |= setting;
-
 	DBG("sending set mode command for index %u", adapter->dev_id);
 
+	data = g_try_new0(struct set_mode_data, 1);
+	if (!data)
+		goto failed;
+
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
 
+failed:
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
 							adapter->dev_id);
 
@@ -718,6 +734,7 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
 							uint16_t timeout)
 {
 	struct mgmt_cp_set_discoverable cp;
+	struct set_mode_data *data;
 
 	memset(&cp, 0, sizeof(cp));
 	cp.val = mode;
@@ -734,11 +751,19 @@ static bool set_discoverable(struct btd_adapter *adapter, uint8_t mode,
 									mode);
 	}
 
+	data = g_try_new0(struct set_mode_data, 1);
+	if (!data)
+		goto failed;
+
+	data->adapter = adapter;
+	data->setting = 0;
+
 	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_DISCOVERABLE,
 				adapter->dev_id, sizeof(cp), &cp,
-				set_mode_complete, adapter, NULL) > 0)
+				set_mode_complete, data, g_free) > 0)
 		return true;
 
+failed:
 	btd_error(adapter->dev_id, "Failed to set mode for index %u",
 							adapter->dev_id);
 
@@ -2877,6 +2902,7 @@ static gboolean property_get_mode(struct btd_adapter *adapter,
 
 struct property_set_data {
 	struct btd_adapter *adapter;
+	uint32_t setting;
 	GDBusPendingPropertySet id;
 };
 
@@ -2901,6 +2927,8 @@ static void property_set_mode_complete(uint8_t status, uint16_t length,
 
 		g_dbus_pending_property_error(data->id, dbus_err,
 							mgmt_errstr(status));
+
+		adapter->pending_settings &= ~data->setting;
 		return;
 	}
 
@@ -2969,8 +2997,6 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
 
 	mode = (enable == TRUE) ? 0x01 : 0x00;
 
-	adapter->pending_settings |= setting;
-
 	switch (setting) {
 	case MGMT_SETTING_POWERED:
 		opcode = MGMT_OP_SET_POWERED;
@@ -3024,11 +3050,14 @@ static void property_set_mode(struct btd_adapter *adapter, uint32_t setting,
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

