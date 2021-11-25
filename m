Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D5EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 25 Nov 2021 07:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353482AbhKYHL5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:11:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346698AbhKYHJ4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 25 Nov 2021 02:09:56 -0500
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2AAFC0613DD
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:39 -0800 (PST)
Received: by mail-qk1-x749.google.com with SMTP id bp17-20020a05620a459100b0045e893f2ed8so5320875qkb.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Nov 2021 23:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SdCX7U5RfV227kEctgivJbJaXCmsb3Y16woIC7AjaLs=;
        b=Iq42RY6SkaiieVkrtqmXzMEh0f6lQZWepdNaMCCfhM57q8ttu8xcrl9PhWB2PI+bZJ
         mct38bGEswnd4RqfqZkcAuMncKrcA9TjLMswwxaqwHf9QDs/2tGoil3Rr/9bsgBRyp24
         MCzbgcnFnqnfPJyV5u5nbdX6wb/FmJkdkCOtAK2loHqKKqT5MYO2bCo/zBe/A7FrjdG1
         p2rmJemKbIXRinl07+UCjKnd0zq+5Whmc8pvtQr3XkWdQ/Vd/C7nNdCfFolCp64wnxt/
         NNz2UkDxn/dMFpMuVm2w1cIDmejsO4QmVtRK9/uxzXkJJn6mzN9G+B+9p5nIyQnPyOqT
         ts7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SdCX7U5RfV227kEctgivJbJaXCmsb3Y16woIC7AjaLs=;
        b=dBLS3EFphZFJvGuKjcFTXMF6SJ2y3uuTJ1hNDYWN2rVjPWbFI7pImzHkrirbiSZtk0
         gkj50tUJPNrp1wz5mU9ZJPKeGIKV4GSUwXY52L4tyX2MgkvdAUc1df6IxrSNh1twd2JN
         1SB7LtlGG9OvL0FSoe/fRhrOWm9rqMmLLTugNXLaTyUp14U9p36CNBJEn1sDcOuA/ueo
         ZHCeG8UtOsP0pnfdmMWMJ8hThkufdCRgxo+MFBrt6vSi+2SRuGmUlOdNHNvfUZbtdAWV
         TQoPv/mUfUmrSyaUjKfkj9CrHQAOIbT/k1UUPTsYEIhISY1CxrMTE3ory0TVdThwVuHE
         RQog==
X-Gm-Message-State: AOAM530PTtZ8KONsBqt2MzGCA6Y96UH/za/3yLm8l20s+dq738O8RtB5
        jGBd6U2v6efVRwRo2zH0wWHSmYPsLDlFTe7hSSHJ7lH/3NszfS5avDHWfzRfkn8x8E29fWrljCr
        PZ3UxGy5XZhFEAEajB8i9IxWuRsZvO3mKOuSA3h2Y9qyImtzmHx+18rVx2lyE3h9sSG5wvLgF3v
        ti
X-Google-Smtp-Source: ABdhPJwYd3S1tQd0Koy0pEkRDXv9EkXoRv82km+Ov6/XzvppLMfn6t8B76nhDhsqOGSJjEMO36XOeenU4JFa
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:a5d9:6769:9abb:6b2])
 (user=apusaka job=sendgmr) by 2002:a5b:802:: with SMTP id x2mr4190008ybp.164.1637823999013;
 Wed, 24 Nov 2021 23:06:39 -0800 (PST)
Date:   Thu, 25 Nov 2021 15:06:24 +0800
In-Reply-To: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
Message-Id: <20211125150558.Bluez.v4.2.I9fc087b25433a9347b2d8c8ff7a25fadf448ef49@changeid>
Mime-Version: 1.0
References: <20211125150558.Bluez.v4.1.I78857808e0b20c6e4dd934b174d3f1106fe3402d@changeid>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [Bluez PATCH v4 2/5] Listen and process remote name resolving failure
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

When Remote Name Resolve ends with failure, record this occurrence and
prevent remote name resolving for the same device for some time.

Reviewed-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4:
* Use CLOCK_MONOTONIC for timekeeping.
* Constant waiting time between retries instead of increasing.
* Fix conflict merge with adv_monitor.c

Changes in v3:
* Rename MGMT const to align with the doc.

Changes in v2:
* Stay silent instead of sending MGMT_OP_CONFIRM_NAME with DONT_CARE flag.

 src/adapter.c     | 16 +++++++++++++---
 src/adapter.h     |  1 +
 src/adv_monitor.c |  7 +++++--
 src/device.c      | 27 +++++++++++++++++++++++++++
 src/device.h      |  2 ++
 5 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 98616f17d2..c49f42cfbb 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -6979,6 +6979,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm, bool legacy,
 					bool not_connectable,
+					bool name_resolve_failed,
 					const uint8_t *data, uint8_t data_len,
 					bool monitoring)
 {
@@ -7076,6 +7077,9 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 
 	device_set_legacy(dev, legacy);
 
+	if (name_resolve_failed)
+		device_name_resolve_fail(dev);
+
 	if (adapter->filtered_discovery)
 		device_set_rssi_with_delta(dev, rssi, 0);
 	else
@@ -7146,7 +7150,10 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 	if (g_slist_find(adapter->discovery_found, dev))
 		return;
 
-	if (confirm)
+	/* If name is unknown but it's not allowed to resolve, don't send
+	 * MGMT_OP_CONFIRM_NAME.
+	 */
+	if (confirm && (name_known || device_is_name_resolve_allowed(dev)))
 		confirm_name(adapter, bdaddr, bdaddr_type, name_known);
 
 	adapter->discovery_found = g_slist_prepend(adapter->discovery_found,
@@ -7196,8 +7203,9 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	uint32_t flags;
 	bool confirm_name;
 	bool legacy;
-	char addr[18];
 	bool not_connectable;
+	bool name_resolve_failed;
+	char addr[18];
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter->dev_id,
@@ -7227,10 +7235,12 @@ static void device_found_callback(uint16_t index, uint16_t length,
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
 	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
+	name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
 
 	btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
 					ev->addr.type, ev->rssi, confirm_name,
-					legacy, not_connectable, eir, eir_len,
+					legacy, not_connectable,
+					name_resolve_failed, eir, eir_len,
 					false);
 }
 
diff --git a/src/adapter.h b/src/adapter.h
index 2815d4613f..35deb1d117 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -92,6 +92,7 @@ void btd_adapter_update_found_device(struct btd_adapter *adapter,
 					uint8_t bdaddr_type, int8_t rssi,
 					bool confirm, bool legacy,
 					bool not_connectable,
+					bool name_resolve_failed,
 					const uint8_t *data, uint8_t data_len,
 					bool monitored);
 
diff --git a/src/adv_monitor.c b/src/adv_monitor.c
index bf7f2bed3b..602830e30b 100644
--- a/src/adv_monitor.c
+++ b/src/adv_monitor.c
@@ -1585,8 +1585,9 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 	uint32_t flags;
 	bool confirm_name;
 	bool legacy;
-	char addr[18];
 	bool not_connectable;
+	bool name_resolve_failed;
+	char addr[18];
 
 	if (length < sizeof(*ev)) {
 		btd_error(adapter_id,
@@ -1613,10 +1614,12 @@ static void adv_monitor_device_found_callback(uint16_t index, uint16_t length,
 	confirm_name = (flags & MGMT_DEV_FOUND_CONFIRM_NAME);
 	legacy = (flags & MGMT_DEV_FOUND_LEGACY_PAIRING);
 	not_connectable = (flags & MGMT_DEV_FOUND_NOT_CONNECTABLE);
+	name_resolve_failed = (flags & MGMT_DEV_FOUND_NAME_REQUEST_FAILED);
 
 	btd_adapter_update_found_device(adapter, &ev->addr.bdaddr,
 					ev->addr.type, ev->rssi, confirm_name,
-					legacy, not_connectable, ad_data,
+					legacy, not_connectable,
+					name_resolve_failed, ad_data,
 					ad_data_len, true);
 
 	if (handle) {
diff --git a/src/device.c b/src/device.c
index 6b398bd396..a83cb61f8c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -79,6 +79,8 @@
 #define GATT_INCLUDE_UUID_STR "2802"
 #define GATT_CHARAC_UUID_STR "2803"
 
+#define NAME_RESOLVE_RETRY_DELAY	300 /* seconds */
+
 static DBusConnection *dbus_conn = NULL;
 static unsigned service_state_cb_id;
 
@@ -272,6 +274,8 @@ struct btd_device {
 
 	GIOChannel	*att_io;
 	guint		store_id;
+
+	time_t		name_resolve_failed_time;
 };
 
 static const uint16_t uuid_list[] = {
@@ -4389,6 +4393,29 @@ bool device_name_known(struct btd_device *device)
 	return device->name[0] != '\0';
 }
 
+bool device_is_name_resolve_allowed(struct btd_device *device)
+{
+	struct timespec now;
+
+	if (!device)
+		return false;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	return now.tv_sec >= device->name_resolve_failed_time +
+						NAME_RESOLVE_RETRY_DELAY;
+}
+
+void device_name_resolve_fail(struct btd_device *device)
+{
+	struct timespec now;
+
+	if (!device)
+		return;
+
+	clock_gettime(CLOCK_MONOTONIC, &now);
+	device->name_resolve_failed_time = now.tv_sec;
+}
+
 void device_set_class(struct btd_device *device, uint32_t class)
 {
 	if (device->class == class)
diff --git a/src/device.h b/src/device.h
index b37a0a3d21..071576d6b3 100644
--- a/src/device.h
+++ b/src/device.h
@@ -25,6 +25,8 @@ void btd_device_device_set_name(struct btd_device *device, const char *name);
 void device_store_cached_name(struct btd_device *dev, const char *name);
 void device_get_name(struct btd_device *device, char *name, size_t len);
 bool device_name_known(struct btd_device *device);
+bool device_is_name_resolve_allowed(struct btd_device *device);
+void device_name_resolve_fail(struct btd_device *device);
 void device_set_class(struct btd_device *device, uint32_t class);
 void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 							uint8_t bdaddr_type);
-- 
2.34.0.rc2.393.gf8c9666880-goog

