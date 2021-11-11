Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3048EC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 11:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1685A61215
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Nov 2021 11:55:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhKKL5w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Nov 2021 06:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbhKKL5v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Nov 2021 06:57:51 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27AC0613F5
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 03:55:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s189-20020a252cc6000000b005c1f206d91eso8906169ybs.14
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Nov 2021 03:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9VDEEEUEmKeFJhO4rWJQyaGH3pm3s/y7iCkRAwUfarY=;
        b=b2Hai8ltnONRVniamfpIpaGH3JCHalZmdTsUA0st0fkuGD4bJnQD8j4EYp42Z2lAVY
         74756AT+HQ7EiZFPnXAyOAYAThCeo5TrbUNKDN9l8f2tXYYe/zkAn11KZ8Aj5olR9K4U
         7Tm+1DwkPeZR2ijQZizIINBCVPozts4+chfvfnMLDEq/W5nBCxmKmSZzxE3NybCjNOE1
         AM4lCRxIWFFocjOhegLqCUvi3Oe58CzD7EjzWarxlUC9ZcZ6z7CvFE8vPSbzhZG8Jhuk
         9FThyWSKGpIMInbwC6EFdFQk64Cru2ET+VS0o0kYjMX3WZxufXEAPT+L46M+T/z0XuSQ
         pFNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9VDEEEUEmKeFJhO4rWJQyaGH3pm3s/y7iCkRAwUfarY=;
        b=rxQUoEizvVDl7pCNYpzPnskljowOMcMUa9U1cPzy8VxDHNfqTcF2CeFySDH0mf28K+
         3fxX1WZHsgLWUaC9kBzJc5qWHda2AM8VCui1IUd6DF8qqX3gD26za08QRApSjunJQGp0
         9secv/XAVwEncRmYKx3/0LdT2IKjVxVcQpfv9lBX4noMJBXu+dZ23JlFYlbpSLhXROTP
         5i3i3x3tbEOqWwMTicj2GTxfSKV2u/DJEtnCB+r0y9a950FAOqbLQQ9U/yTJGHY9x7Jp
         xttsJmrMsIsOePJX28YPVsK8ah0GbZPp3zimmIlbyPZ9O2tdqPLAqehrboFz7a+u08bw
         tblg==
X-Gm-Message-State: AOAM530zL0Ok7vA6tmLCX7SglLVkf8DVFzep6E9uNLnHNvVQpQYP3z4W
        3ztUX6EAJcxsCKbsRxysAI935QUo7WaB60+QSucdIeAcMiQL2ILpUkGOEdtzr8eG33qHlFP3e01
        0zsTFYpYXF9KwKnXBHRAL3u9aI9xd5oJsMajayTK1jVN48gfXtSE4zcYVS8ZUrzoBkFalowCj2h
        qX
X-Google-Smtp-Source: ABdhPJwWGAMbbJcnqUXFM2Or/GytKvdnhqUPaw6MniPeW42ZRmSJNrGD5VmkTIvjc4nWxN8O/g0Do3sS/pKn
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b87e:3eb:e17e:1273])
 (user=apusaka job=sendgmr) by 2002:a25:ae5b:: with SMTP id
 g27mr7882500ybe.175.1636631702015; Thu, 11 Nov 2021 03:55:02 -0800 (PST)
Date:   Thu, 11 Nov 2021 19:54:52 +0800
Message-Id: <20211111195423.Bluez.1.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: [Bluez PATCH 1/3] Listen and process remote name resolving failure
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Sonny Sasaka <sonnysasaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When Remote Name Resolve ends with failure, record this occurrence and
prevent remote name resolving for the same device for some time.
Increase the time duration for subsequent failures.

Reviewed-by: Sonny Sasaka <sonnysasaka@chromium.org>
Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---
Hi maintainers,

This is the patch series for remote name request as was discussed here.
https://patchwork.kernel.org/project/bluetooth/patch/20211028191805.1.I35b7f3a496f834de6b43a32f94b6160cb1467c94@changeid/
Please also review the corresponding kernel space change.

 lib/mgmt.h     |  7 ++++++-
 src/adapter.c  | 30 ++++++++++++++++++++++++------
 src/device.c   | 23 +++++++++++++++++++++++
 src/device.h   |  2 ++
 tools/btmgmt.c |  4 ++--
 5 files changed, 57 insertions(+), 9 deletions(-)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 0d1678f01d..c006793d84 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -299,10 +299,14 @@ struct mgmt_cp_stop_discovery {
 	uint8_t type;
 } __packed;
 
+#define MGMT_CONFIRM_NAME_UNKNOWN	0
+#define MGMT_CONFIRM_NAME_KNOWN		1
+#define MGMT_CONFIRM_NAME_DONT_CARE	2
+
 #define MGMT_OP_CONFIRM_NAME		0x0025
 struct mgmt_cp_confirm_name {
 	struct mgmt_addr_info addr;
-	uint8_t name_known;
+	uint8_t name_state;
 } __packed;
 struct mgmt_rp_confirm_name {
 	struct mgmt_addr_info addr;
@@ -856,6 +860,7 @@ struct mgmt_ev_auth_failed {
 #define MGMT_DEV_FOUND_CONFIRM_NAME	0x01
 #define MGMT_DEV_FOUND_LEGACY_PAIRING	0x02
 #define MGMT_DEV_FOUND_NOT_CONNECTABLE	0x04
+#define MGMT_DEV_FOUND_NAME_RESOLVE_FAIL 0x10
 
 #define MGMT_EV_DEVICE_FOUND		0x0012
 struct mgmt_ev_device_found {
diff --git a/src/adapter.c b/src/adapter.c
index d0d38621b8..9a43ca4ca5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6796,7 +6796,8 @@ static void confirm_name_complete(uint8_t status, uint16_t length,
 }
 
 static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
-					uint8_t bdaddr_type, bool name_known)
+					uint8_t bdaddr_type, bool name_known,
+					bool name_resolve_allowed)
 {
 	struct mgmt_cp_confirm_name cp;
 	char addr[18];
@@ -6827,7 +6828,13 @@ static void confirm_name(struct btd_adapter *adapter, const bdaddr_t *bdaddr,
 	memset(&cp, 0, sizeof(cp));
 	bacpy(&cp.addr.bdaddr, bdaddr);
 	cp.addr.type = bdaddr_type;
-	cp.name_known = name_known;
+
+	if (name_known)
+		cp.name_state = MGMT_CONFIRM_NAME_KNOWN;
+	else if (name_resolve_allowed)
+		cp.name_state = MGMT_CONFIRM_NAME_UNKNOWN;
+	else
+		cp.name_state = MGMT_CONFIRM_NAME_DONT_CARE;
 
 	adapter->confirm_name_id = mgmt_reply(adapter->mgmt,
 					MGMT_OP_CONFIRM_NAME,
@@ -6989,12 +6996,13 @@ static void update_found_devices(struct btd_adapter *adapter,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm, bool legacy,
 					bool not_connectable,
+					bool name_resolve_fail,
 					const uint8_t *data, uint8_t data_len)
 {
 	struct btd_device *dev;
 	struct bt_ad *ad = NULL;
 	struct eir_data eir_data;
-	bool name_known, discoverable;
+	bool name_known, discoverable, name_resolve_allowed;
 	char addr[18];
 	bool duplicate = false;
 	struct queue *matched_monitors = NULL;
@@ -7081,6 +7089,9 @@ static void update_found_devices(struct btd_adapter *adapter,
 
 	device_set_legacy(dev, legacy);
 
+	if (name_resolve_fail)
+		device_name_resolve_fail(dev);
+
 	if (adapter->filtered_discovery)
 		device_set_rssi_with_delta(dev, rssi, 0);
 	else
@@ -7151,8 +7162,11 @@ static void update_found_devices(struct btd_adapter *adapter,
 	if (g_slist_find(adapter->discovery_found, dev))
 		return;
 
-	if (confirm)
-		confirm_name(adapter, bdaddr, bdaddr_type, name_known);
+	if (confirm) {
+		name_resolve_allowed = device_name_resolve_allowed(dev);
+		confirm_name(adapter, bdaddr, bdaddr_type, name_known,
+							name_resolve_allowed);
+	}
 
 	adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
 									dev);
@@ -7201,6 +7215,8 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	uint32_t flags;
 	bool confirm_name;
 	bool legacy;
+	bool not_connectable;
+	bool name_resolve_fail;
 	char addr[18];
 
 	if (length < sizeof(*ev)) {
@@ -7230,10 +7246,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
 
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
+	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
+	name_resolve_fail = (flags & MGMT_DEV_FOUND_NAME_RESOLVE_FAIL);
 
 	update_found_devices(adapter, &ev->addr.bdaddr, ev->addr.type,
 					ev->rssi, confirm_name, legacy,
-					flags & MGMT_DEV_FOUND_NOT_CONNECTABLE,
+					not_connectable, name_resolve_fail,
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
diff --git a/tools/btmgmt.c b/tools/btmgmt.c
index 42ef9acefa..14d05efa45 100644
--- a/tools/btmgmt.c
+++ b/tools/btmgmt.c
@@ -667,9 +667,9 @@ static void device_found(uint16_t index, uint16_t len, const void *param,
 		memset(&cp, 0, sizeof(cp));
 		memcpy(&cp.addr, &ev->addr, sizeof(cp.addr));
 		if (resolve_names)
-			cp.name_known = 0;
+			cp.name_state = MGMT_CONFIRM_NAME_UNKNOWN;
 		else
-			cp.name_known = 1;
+			cp.name_state = MGMT_CONFIRM_NAME_DONT_CARE;
 
 		mgmt_reply(mgmt, MGMT_OP_CONFIRM_NAME, index, sizeof(cp), &cp,
 						confirm_name_rsp, NULL, NULL);
-- 
2.34.0.rc0.344.g81b53c2807-goog

