Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E824AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6CCC63217
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 09:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhKOJbZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 04:31:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237664AbhKOJas (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 04:30:48 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE65C061200
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:27:52 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id y125-20020a25dc83000000b005c2326bf744so25665416ybe.21
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Nov 2021 01:27:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=91ciOFySGyuDGp8+cPG7rlk0H4CMpJHZ5FAL6tr2C1s=;
        b=Y35CzcjzdMgeCNFg4DGIZNjJMbr7YERqHFdAiW7+6y4VUVeDRYH64l/A2w2cpb09Uc
         C0VcUuzlNokXBOq/rz5vvVqfW/MD+ShqfTZNx9viVFgZj296MyDQfT4epKIbnoaBCeOI
         kIv9L00hQcQFcZ30CkwiTkDLdXAIaD3XX1bYJdI5g3M8C10PIE2sMOONfcWyqawn6Wx6
         o6wQ1iulShJbCa94/jYp4qb9HstGIZS38/mMVMincqCC61mT3exhIcgJG65ki35bYot0
         pb0QQzeBHSm/MhTMxJVzDxX7olto1tJs9jQmMWLL0qVzGnG0XH6GY6fPbDvOM68PyLxT
         h3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=91ciOFySGyuDGp8+cPG7rlk0H4CMpJHZ5FAL6tr2C1s=;
        b=vtWI9SShJKIiDewdoimSno9NMv6VMAzgz7cbCPS0MqsHiXduyt/8rLIWnXsq2Lyr7M
         ejgPXwTNZWd8scCxgB/D52576tjPbq9SHNFJ1qqf7OUZIdJ4PqsZz09dsJClLLu5PWw8
         NuRRDVSuk2bFCf6xBEFsx824y0UcKIXwxC43RwsqoLLmnfCQjjluYka8L9UteaQN1jXi
         5k5MrDvGc0r2LIBRsDG9I8e2ACiOxjFDubKna+/+fUgLBbW85sRrU1IXMmk905y23+G2
         U2EYCwBZkrj9jac59fkf+zO2tCn04ukzMRWhooGO6PZqTpCToUBsBd3Lzt4ZifcFTJwF
         86mQ==
X-Gm-Message-State: AOAM530ojmfpQ+IBNmRRGa1DkF7an6abNaoxQu5Kp2xbGJ0yhdRkEjy5
        njjA0ntqzN/uzWk5CuZrAGtYKjRYg/TvrpbmoJKMueu70WQlNqA7iFfzzx1sMAEqFrTkzF1DJre
        SyniGUcKY+LVv28Mzrwx7S2A15PjfD5/AoTHdz+YzeQDdRKWte9pU3uXZ52dGaGm5ZgO//BX9D8
        /7
X-Google-Smtp-Source: ABdhPJwzfweH5+ht2lUZJdIirIF9gXts1R1zy9+rO72d9XSCrCQEuIbTG+vOzZcS16RSk6lDNjC0JVdb0+ES
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:5c8f:7191:e5ca:14fb])
 (user=apusaka job=sendgmr) by 2002:a25:ac0b:: with SMTP id
 w11mr39004308ybi.163.1636968471932; Mon, 15 Nov 2021 01:27:51 -0800 (PST)
Date:   Mon, 15 Nov 2021 17:27:43 +0800
Message-Id: <20211115172714.Bluez.v3.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc1.387.gb447b232ab-goog
Subject: [Bluez PATCH v3 1/3] Listen and process remote name resolving failure
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When Remote Name Resolve ends with failure, record this occurrence and
prevent remote name resolving for the same device for some time.
Increase the time duration for subsequent failures.
---
Hi maintainers,

This is the patch series for remote name request as was discussed here.
https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/
Please also review the corresponding kernel space change.

Changes in v3:
* Rename MGMT const to align with the doc

Changes in v2:
* Stay silent instead of sending MGMT_OP_CONFIRM_NAME with DONT_CARE flag.

 lib/mgmt.h    |  1 +
 src/adapter.c | 15 +++++++++++++--
 src/device.c  | 23 +++++++++++++++++++++++
 src/device.h  |  2 ++
 4 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0d1678f01d..d860b27401 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -856,6 +856,7 @@ struct mgmt_ev_auth_failed {
 #define MGMT_DEV_FOUND_CONFIRM_NAME	0x01
 #define MGMT_DEV_FOUND_LEGACY_PAIRING	0x02
 #define MGMT_DEV_FOUND_NOT_CONNECTABLE	0x04
+#define MGMT_DEV_FOUND_NAME_REQUEST_FAILED 0x10
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
diff --git a/src/adapter.c b/src/adapter.c
index d0d38621b8..6100448b5f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6989,6 +6989,7 @@ static void update_found_devices(struct btd_adapter *adapter,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm, bool legacy,
 					bool not_connectable,
+					bool name_resolve_failed,
 					const uint8_t *data, uint8_t data_len)
 {
 	struct btd_device *dev;
@@ -7081,6 +7082,9 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_set_legacy(dev, legacy);
 
+	if (name_resolve_failed)
+		device_name_resolve_fail(dev);
+
 	if (adapter->filtered_discovery)
 		device_set_rssi_with_delta(dev, rssi, 0);
 	else
@@ -7151,7 +7155,10 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (g_slist_find(adapter->discovery_found, dev))
 		return;
 
-	if (confirm)
+	/* If name is unknown but it's not allowed to resolve, don't send
+	 * MGMT_OP_CONFIRM_NAME.
+	 */
+	if (confirm && (name_known || device_name_resolve_allowed(dev)))
 		confirm_name(adapter, bdaddr, bdaddr_type, name_known);
 
 	adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
@@ -7201,6 +7208,8 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	uint32_t flags;
 	bool confirm_name;
 	bool legacy;
+	bool not_connectable;
+	bool name_resolve_failed;
 	char addr[18];
 
 	if (length < sizeof(*ev)) {
@@ -7230,10 +7239,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
 
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
+	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
+	name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
 
 	update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
 					ev->rssi, confirm_name, legacy,
-					flags & MGMT_DEV_FOUND_NOT_CONNECTABLE,
+					not_connectable, name_resolve_failed,
 					eir, eir_len);
 }
 
diff --git a/src/device.c b/src/device.c
index fdc2d50a47..699faeba3b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -79,6 +79,8 @@
 #define GATT_INCLUDE_UUID_STR "2802"
 #define GATT_CHARAC_UUID_STR "2803"
 
+#define NAME_RESOLVE_RETRY_DELAY	120 /* seconds */
+
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
 
@@ -272,6 +274,9 @@ struct btd_device {
 
 	GIOChannel	*att_io;
 	guint		store_id;
+
+	time_t		name_resolve_earliest_allow_time;
+	uint8_t		name_resolve_fail_count;
 };
 
 static const uint16_t uuid_list[] = {
@@ -4361,6 +4366,24 @@ bool device_name_known(struct btd_device *device)
 	return device->name[0] != '\0';
 }
 
+bool device_name_resolve_allowed(struct btd_device *device)
+{
+	return time(NULL) >= device->name_resolve_earliest_allow_time;
+}
+
+void device_name_resolve_fail(struct btd_device *device)
+{
+	if (!device)
+		return;
+
+	/* Punish this device by not allowing name resolve for some time.
+	 * increase punishment time for subsequent failures.
+	 */
+	device->name_resolve_fail_count++;
+	device->name_resolve_earliest_allow_time = time(NULL) +
+		NAME_RESOLVE_RETRY_DELAY * device->name_resolve_fail_count;
+}
+
 void device_set_class(struct btd_device *device, uint32_t class)
 {
 	if (device->class == class)
diff --git a/src/device.h b/src/device.h
index 5f615cb4b6..76d79855f8 100644
--- a/src/device.h
+++ b/src/device.h
@@ -25,6 +25,8 @@ void btd_device_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
+bool device_name_resolve_allowed(struct btd_device *device);
+void device_name_resolve_fail(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
-- 
2.34.0.rc1.387.gb447b232ab-goog

