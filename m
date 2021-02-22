Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61EF4C433E0
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 05:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D4764EDE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 22 Feb 2021 05:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbhBVFT4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 22 Feb 2021 00:19:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhBVFTy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 22 Feb 2021 00:19:54 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DFFC061574
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 21:19:14 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id p136so15499879ybc.21
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Feb 2021 21:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=WtH19Oaz/op913fYgmEn1JZZSgU8VhJ1rZPWAmjEGGM=;
        b=YoA9hmNq2wIY/iFn11bCEz6TA/GLOzjgWsmrHjCvjsdggHYVvb/SsZeHUnGb1ISv+A
         7TN4TvRv9yZTYX5DFT+2sZeiFOufKkC3C5RSxQj0mxB8vHQ92r02DYueF34ZFc5ATvY+
         Er5grwMYPWAh9WKg3artXxjV70vGJAv+nCe6g8eZOZP0QvHQeAlFQZU3guFJlft2iNRz
         lYCEr2sRvs6vZt1BUOSSt6qYB8z22qgoeVvumg0AhqwzYPJZvyuvTxrs+l/HZ2NwVW2d
         0drQBbdxqi+j48FHuN7lpHGgHEKXE3v3atQtdNR41sI6O27EwbYFVWC3t5u0uH58pCRs
         fnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=WtH19Oaz/op913fYgmEn1JZZSgU8VhJ1rZPWAmjEGGM=;
        b=UCnBP8/tGB3dnEcufeUwlcsM/85pdVxPxUyryrvAspEWHbUPg2/94qZegBgOxL342q
         V/gDV8Wz9na+CALElOQsb8DIEcMl2Y760AbQZgV8dW2Mcea49CAJHbVvxZEnTq2sRf91
         nLWODyPkS64641Pplwz6AnXCN+Kju/tAXpBjejHV91VDfGpgrqM6IQPLgdwrY/HA4PzF
         oKWLTQHH73ckDAoF09LrNA1M3V3PKKtoSSUhNMinD0qvr13hj2mLbz+U8gHDoWgjG8eA
         wd50FDiRaLSlV4vj1BAl1C6jr7OJQYBHShjsWMvfjUC4tAqaDqrY8BhB//+SVCTshFrT
         0RCA==
X-Gm-Message-State: AOAM53068sPQaxeJJGfvhkOr04QPbwq2Y70becZrKcYHzAZUZPA5Q1v7
        IWpxtV+04nM5WZN727dBvkHwS4w2OqOm0fhZthku11QnHz5EBAkEIb4B4JPUGjIILtf3dwB5qke
        cEFVaYx4WT9H6uogDM58fygogwGzs/M0m04EARWjxchFtd203teFg/D3ait2J8sDumxKnL0VlUo
        RJ
X-Google-Smtp-Source: ABdhPJyCepy85c3AnVUAAABuJAjkeEJNlaZGiphyAbrNRetJCvfRyUsVkHn3kXA8tfpzXDsOEbCwN0xbiAPA
Sender: "apusaka via sendgmr" <apusaka@apusaka-p920.tpe.corp.google.com>
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:b:167:3326:108b:47b8])
 (user=apusaka job=sendgmr) by 2002:a5b:7cd:: with SMTP id t13mr5373426ybq.417.1613971153111;
 Sun, 21 Feb 2021 21:19:13 -0800 (PST)
Date:   Mon, 22 Feb 2021 13:18:45 +0800
Message-Id: <20210222131802.Bluez.1.Ic834b418cdbb81a6e9980632567fe9d7c23cd8d4@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.617.g56c4b15f3c-goog
Subject: [Bluez PATCH] adapter: Check whether adapter is pending powered
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

The powered setting of adapter is frequently being checked, but the
check only accounts for whether it currently is powered. When powering
off the adapter, there is a brief moment when the adapter is already
off kernel-wise, but powered property is still true.

If powered property is accessed at this time, some problems might
occur. For example, if RemoveDevice DBus API is called, we would still
carry out the request and remove the device from the user space, but
we would fail to remove it from the kernel, therefore resulting an
error when we want to re-pair the device.

This patch addresses this issue by also checking whether adapter is
being powered off when checking for powered.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
---

 src/adapter.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c1f976323e..fab01cee69 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -548,11 +548,10 @@ static void settings_changed(struct btd_adapter *adapter, uint32_t settings)
 		}
 	}
 
-	if (changed_mask & MGMT_SETTING_LE) {
-		if ((adapter->current_settings & MGMT_SETTING_POWERED) &&
+	if ((changed_mask & MGMT_SETTING_LE) &&
+				btd_adapter_get_powered(adapter) &&
 				(adapter->current_settings & MGMT_SETTING_LE))
-			trigger_passive_scanning(adapter);
-	}
+		trigger_passive_scanning(adapter);
 
 	if (changed_mask & MGMT_SETTING_DISCOVERABLE) {
 		g_dbus_emit_property_changed(dbus_conn, adapter->path,
@@ -1795,7 +1794,7 @@ static void trigger_start_discovery(struct btd_adapter *adapter, guint delay)
 	 *
 	 * This is safe-guard and should actually never trigger.
 	 */
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return;
 
 	adapter->discovery_idle_timeout = g_timeout_add_seconds(delay,
@@ -2286,7 +2285,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 
 	DBG("sender %s", sender);
 
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return btd_error_not_ready(msg);
 
 	is_discovering = get_discovery_client(adapter, sender, &client);
@@ -2586,7 +2585,7 @@ static DBusMessage *set_discovery_filter(DBusConnection *conn,
 
 	DBG("sender %s", sender);
 
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return btd_error_not_ready(msg);
 
 	if (MGMT_VERSION(mgmt_version, mgmt_revision) < MGMT_VERSION(1, 8))
@@ -2643,7 +2642,7 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 
 	DBG("sender %s", sender);
 
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return btd_error_not_ready(msg);
 
 	list = g_slist_find_custom(adapter->discovery_list, sender,
@@ -2999,7 +2998,7 @@ static void property_set_discoverable(const GDBusPropertyTable *property,
 	struct btd_adapter *adapter = user_data;
 
 	if (adapter->discoverable_timeout > 0 &&
-			!(adapter->current_settings & MGMT_SETTING_POWERED)) {
+			!btd_adapter_get_powered(adapter)) {
 		g_dbus_pending_property_error(id, ERROR_INTERFACE ".Failed",
 								"Not Powered");
 		return;
@@ -3250,7 +3249,7 @@ static DBusMessage *remove_device(DBusConnection *conn,
 	if (!list)
 		return btd_error_does_not_exist(msg);
 
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return btd_error_not_ready(msg);
 
 	device = list->data;
@@ -3401,7 +3400,7 @@ static DBusMessage *connect_device(DBusConnection *conn,
 
 	DBG("sender %s", dbus_message_get_sender(msg));
 
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return btd_error_not_ready(msg);
 
 	dbus_message_iter_init(msg, &iter);
@@ -4802,7 +4801,8 @@ bool btd_adapter_get_pairable(struct btd_adapter *adapter)
 
 bool btd_adapter_get_powered(struct btd_adapter *adapter)
 {
-	if (adapter->current_settings & MGMT_SETTING_POWERED)
+	if ((adapter->current_settings & MGMT_SETTING_POWERED) &&
+			!(adapter->pending_settings & MGMT_SETTING_POWERED))
 		return true;
 
 	return false;
@@ -4893,7 +4893,7 @@ int adapter_connect_list_add(struct btd_adapter *adapter,
 							adapter->system_name);
 
 done:
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return 0;
 
 	trigger_passive_scanning(adapter);
@@ -4930,7 +4930,7 @@ void adapter_connect_list_remove(struct btd_adapter *adapter,
 		return;
 	}
 
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return;
 
 	trigger_passive_scanning(adapter);
@@ -7194,7 +7194,7 @@ int btd_cancel_authorization(guint id)
 
 int btd_adapter_restore_powered(struct btd_adapter *adapter)
 {
-	if (adapter->current_settings & MGMT_SETTING_POWERED)
+	if (btd_adapter_get_powered(adapter))
 		return 0;
 
 	set_mode(adapter, MGMT_OP_SET_POWERED, 0x01);
@@ -7229,7 +7229,7 @@ void btd_adapter_register_msd_cb(struct btd_adapter *adapter,
 int btd_adapter_set_fast_connectable(struct btd_adapter *adapter,
 							gboolean enable)
 {
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return -EINVAL;
 
 	set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, enable ? 0x01 : 0x00);
@@ -7241,7 +7241,7 @@ int btd_adapter_read_clock(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 				int which, int timeout, uint32_t *clock,
 				uint16_t *accuracy)
 {
-	if (!(adapter->current_settings & MGMT_SETTING_POWERED))
+	if (!btd_adapter_get_powered(adapter))
 		return -EINVAL;
 
 	return -ENOSYS;
@@ -8709,7 +8709,7 @@ load:
 
 	/* retrieve the active connections: address the scenario where
 	 * the are active connections before the daemon've started */
-	if (adapter->current_settings & MGMT_SETTING_POWERED)
+	if (btd_adapter_get_powered(adapter))
 		load_connections(adapter);
 
 	adapter->initialized = TRUE;
@@ -9507,7 +9507,7 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (adapter->stored_discoverable && !adapter->discoverable_timeout)
 		set_discoverable(adapter, 0x01, 0);
 
-	if (adapter->current_settings & MGMT_SETTING_POWERED)
+	if (btd_adapter_get_powered(adapter))
 		adapter_start(adapter);
 
 	return;
-- 
2.30.0.617.g56c4b15f3c-goog

