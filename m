Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E82DC4338F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82B0610A0
	for <linux-bluetooth@archiver.kernel.org>; Mon,  2 Aug 2021 06:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbhHBGNq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 2 Aug 2021 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhHBGNp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 2 Aug 2021 02:13:45 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6407C06175F
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Aug 2021 23:13:36 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id q72-20020a17090a1b4eb0290177884285a6so8347072pjq.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Aug 2021 23:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gqdjgkdvhVGOQ8cQC92B+9Kplw3M+NU1zcw9w0/LQHU=;
        b=QXja4aG2zTw72q1Qjeia/mSJoruYhXkg2gmin9qu4ksYwLEOxX43vvvOBq8zh0ACV1
         7BEqmDfyJQs+QNF/g8OMNbgy5wr0LfrBAlk0e1XkkKKQ5qM1nu/DXHxP/8xNzz2Dnydy
         TPncXTMJA4Tb8ohyPSCJqCVNXT0pOqHhGRKm/tgDa34sEqBC2B1LsVNi+SXlWrzd3flT
         WTuHBCV0wqAvZEsAwH/DBZbqN2S7TVayxLLezBuVV1bhY9OO8vLrDyQZ6BLsx/g+/NMv
         lT5BYLAnhfQZ0TD3HQw7GFTIZqpi2t+gGK+DFPgjtONkREqPHd9zssRWJL7ttPAhky4a
         ykJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gqdjgkdvhVGOQ8cQC92B+9Kplw3M+NU1zcw9w0/LQHU=;
        b=GG3+ja/gDVgdiCwEF8Eiga9h4dGsWZCC9STKosg2WyUeeMia5c5gyMB5+sqbfRxUSs
         urcRTCkEIp64KVZ4FO/El+hQg87KWY55aXmwZmCHkbd15URS6/K/Fpi+9Uz4FZ5eDOP9
         ZvTHYYBRFrWQc/nHlwJo057W6HOlb94UVcTESIzELK9CTiYCraf1b1IQVnKP2A60AJDx
         TnwkzNa1Ikla4GtWFg7y3FNDBMEuOYAg14CdxDcgLwaPhG+HGwF0JZJJJSBujoUucHdG
         U7M1JkYpWfgK8uHYHzxGbHY/F53Z2O3vLY43f/CelIZCPPoUvDIIrneRlSo53toBiI85
         cVBw==
X-Gm-Message-State: AOAM531qIIb5nsZOPM1POQp9lALziD31OK+Qjf8Dbxd0HCNXyLOsQC9Z
        OHhiPGYtT/0cEpS/6zyhYSzr6khZ5pACkurmFtTbd/oaHfoQLHvklG/vLEmEIPOIX16x+J3ih43
        r9W2kUcyabB6U99i3D9wIxzi0ciRzltcHydPm/91e6S5vRx7BPiB/8JA84ZlrifjR6BZNd3hEpU
        K8oSpi7Ss9VBE=
X-Google-Smtp-Source: ABdhPJzQqCm+F+gmTzQ0Vux7wySsraxnbqAo0pTucgubJOhRw7W0sDZwHWQZXhiNxuwsb1RhP/YVEBFDX5tMnH4XDw==
X-Received: from howardchung-p920.tpe.corp.google.com ([2401:fa00:1:10:9f82:5515:89:f2cb])
 (user=howardchung job=sendgmr) by 2002:a17:90a:f293:: with SMTP id
 fs19mr334395pjb.0.1627884815962; Sun, 01 Aug 2021 23:13:35 -0700 (PDT)
Date:   Mon,  2 Aug 2021 14:12:48 +0800
In-Reply-To: <20210802061250.170975-1-howardchung@google.com>
Message-Id: <20210802141140.Bluez.v7.11.I570c860f59c8ed66ddb31aa54584ee08080aa10c@changeid>
Mime-Version: 1.0
References: <20210802061250.170975-1-howardchung@google.com>
X-Mailer: git-send-email 2.32.0.554.ge1b32706d8-goog
Subject: [Bluez PATCH v7 11/13] plugins/admin: add AffectedByPolicy property
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc:     Yun-Hao Chung <howardchung@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Yun-Hao Chung <howardchung@chromium.org>

This adds property to indicate if a device has any service that is being
blocked by admin policy.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
The following test steps were performed:
1. Set ServiceAllowList to []
2. Verify AffectedByPolicy of K830 is False
3. Set ServiceAllowList to
   ["1800"]
4. Verify AffectedByPolicy of K830 is False
5. Set ServiceAllowList to ["1800","1801","180A","180F","1812"]
6. Verify AffectedByPolicy of K830 is True

(no changes since v1)

 plugins/admin.c | 73 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 71 insertions(+), 2 deletions(-)

diff --git a/plugins/admin.c b/plugins/admin.c
index 37dae77ac448..653195a0e20b 100644
--- a/plugins/admin.c
+++ b/plugins/admin.c
@@ -46,6 +46,7 @@ static struct btd_admin_policy {
 struct device_data {
 	struct btd_device *device;
 	char *path;
+	bool affected;
 };
 
 static struct btd_admin_policy *admin_policy_new(struct btd_adapter *adapter)
@@ -139,6 +140,27 @@ static bool service_allowlist_set(struct btd_admin_policy *admin_policy,
 	return true;
 }
 
+static void update_device_affected(void *data, void *user_data)
+{
+	struct device_data *dev_data = data;
+	bool affected;
+
+	if (!dev_data) {
+		error("Unexpected NULL device_data when updating device");
+		return;
+	}
+
+	affected = !btd_device_all_services_allowed(dev_data->device);
+
+	if (affected == dev_data->affected)
+		return;
+
+	dev_data->affected = affected;
+
+	g_dbus_emit_property_changed(dbus_conn, dev_data->path,
+			ADMIN_POLICY_STATUS_INTERFACE, "AffectedByPolicy");
+}
+
 static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					DBusMessage *msg, void *user_data)
 {
@@ -167,6 +189,8 @@ static DBusMessage *set_service_allowlist(DBusConnection *conn,
 					ADMIN_POLICY_STATUS_INTERFACE,
 					"ServiceAllowList");
 
+	queue_foreach(devices, update_device_affected, NULL);
+
 	return dbus_message_new_method_return(msg);
 }
 
@@ -226,6 +250,28 @@ static bool device_data_match(const void *a, const void *b)
 	return data->device == dev;
 }
 
+static gboolean property_get_affected_by_policy(
+					const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct device_data *data = user_data;
+
+	if (!data) {
+		error("Unexpected error: device_data is NULL");
+		return FALSE;
+	}
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN,
+							&data->affected);
+
+	return TRUE;
+}
+
+static const GDBusPropertyTable admin_policy_device_properties[] = {
+	{ "AffectedByPolicy", "b", property_get_affected_by_policy },
+	{ }
+};
+
 static void free_device_data(void *data)
 {
 	struct device_data *device_data = data;
@@ -308,11 +354,33 @@ static void admin_policy_device_added(struct btd_adapter *adapter,
 
 	data->device = device;
 	data->path = g_strdup(device_get_path(device));
+	data->affected = !btd_device_all_services_allowed(data->device);
+
+	if (!g_dbus_register_interface(dbus_conn, data->path,
+					ADMIN_POLICY_STATUS_INTERFACE,
+					NULL, NULL,
+					admin_policy_device_properties,
+					data, remove_device_data)) {
+		btd_error(btd_adapter_get_index(adapter),
+			"Admin Policy Status interface init failed on path %s",
+						device_get_path(device));
+		free_device_data(data);
+		return;
+	}
+
 	queue_push_tail(devices, data);
 
 	DBG("device_data for %s added", data->path);
 }
 
+static void unregister_device_data(void *data, void *user_data)
+{
+	struct device_data *dev_data = data;
+
+	g_dbus_unregister_interface(dbus_conn, dev_data->path,
+						ADMIN_POLICY_STATUS_INTERFACE);
+}
+
 static void admin_policy_device_removed(struct btd_adapter *adapter,
 						struct btd_device *device)
 {
@@ -321,7 +389,7 @@ static void admin_policy_device_removed(struct btd_adapter *adapter,
 	data = queue_find(devices, device_data_match, device);
 
 	if (data)
-		remove_device_data(data);
+		unregister_device_data(data, NULL);
 }
 
 static struct btd_adapter_driver admin_policy_driver = {
@@ -347,7 +415,8 @@ static void admin_exit(void)
 	DBG("");
 
 	btd_unregister_adapter_driver(&admin_policy_driver);
-	queue_destroy(devices, free_device_data);
+	queue_foreach(devices, unregister_device_data, NULL);
+	queue_destroy(devices, g_free);
 
 	if (policy_data)
 		admin_policy_free(policy_data);
-- 
2.32.0.554.ge1b32706d8-goog

