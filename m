Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB3D5C2E0
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 16:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467390; cv=none; b=Wl3SXZ+r9lFw6/i5ZkFNSKLbXr1CxvJtzARHwF8+o06Tet8X7GrkZoHyLvHEeUm+XjFoy1hZCIQrndFxlMsDz3fM9L5ENs8suox/1lPuqMSXzMVyDX2aEy7BWqpLORg0FOQMZVviGi6r8HYvxfs4+bMEbplXiJfloVZuZgY/e9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467390; c=relaxed/simple;
	bh=J/KFPpdHFdd5inMJDO9F66n7wU2hLz3k+SAYxcNuvXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ioJqJb5tP4Es0nJQrlQCDvEipldSObBY6pTjDeLU6ilCU9sLw09Axsvt0zIX1W0iCyheQ8nwjD5AzGHWaubFC3DkSNlCBuqi1XjNFvvYpgLu4oW7TsPdiM37xhu8cdlENlRjMvojtK9Z1mfFg49+8RKOtmQFQkb8NWtVamYLthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRFn4QK7; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRFn4QK7"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso2646503a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 08:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732467388; x=1733072188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqRtX6s+RTv+KwNBOIlKFv5T8N7Xdnz0yQRJOU+0V5A=;
        b=hRFn4QK7Cylk22hlFnu6DuP5YIbsF/nbPC8XvpeQ78uxZ9AbPGcBgThRU1M1XPMm41
         ajP0pGS947IeisKPdx0RTD6k0d97ThWH5ySyAr5t6nAU2B+MD/IwPpTFdKb1BEggI1Hh
         TJCe+2AbJiv6tDlNOT6wGp8XhZGBNa06dMiA7qjvrhpTpgf3D4KxWBQIEVyIYZkxLQfw
         qwETtdnUzAUpWoxEMV1E2Iuh9tqqJ98RG7tVvk//t14uKrzukoTI2mBT7EnsWjXY8EPr
         iAm1Xz4JBqrZEdxE3xQiAsY3tAc1qcPldIhBdcVU9iBJ3YmBk+3B7b9/HjVllszR7nLx
         lr6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732467388; x=1733072188;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqRtX6s+RTv+KwNBOIlKFv5T8N7Xdnz0yQRJOU+0V5A=;
        b=GH6TWchNNuEASpHFaTQXmDuwN4OQ+HbaItJ4rV0lXbzGtWMzncPTICFU8JR/V0VNgG
         VeGvK5HcG6GmscosfOyIMjzajynHVPl01XZQrePZIqg2dnQbXnLCmI8mRRfDHBtyGjbm
         cGK9ZRdbLhIH8yGPpMfUQt+MhLWT2ARRv+XWRbH2sSosJNa02O04tgRrezRB+lEL5bMB
         C+9bk8RXRZ2xjET5Dk/t/g1zn7Vxqke74z9D25vdMu5WoIfrqm0rQkMwXDw+oBy3kXXf
         rvKwSMIkCh+8XQy56QucECRIlmtcDbFQIXuBwrwWzJrzMDvtoRSzBB5B9ZJzTQQtgRLr
         rnbQ==
X-Gm-Message-State: AOJu0YynDMshGIe4k3lX98b46n0U7Yh6DHA7vYP0RViEFO0IQqEhYPlJ
	2AgMuXWGPpaai1GD4Te1qKlMWVvap/Y11txN3x8hp8MH9jUTgJLGUI5KbA==
X-Gm-Gg: ASbGnctwO4yDBO8wX8CnHuAzCEplFrL+mGgx6F1Glgh4p2V3oQMJ4vuMh6/ZfVUVn+7
	brcWJ7XSx1gjedhnue+RzO06Q5+tV17pzZOBfZSkDZrMvPkyCfjJdjhUAEXF5cnuzKPNyzLDuds
	WmW50U3KMxEwdxx1lZcEXIEz3UQHlARVS2TmktMchVndUcMgyo1NbQop6Wcgz6RkULGUCKbdhlH
	C7n7O/e0pM+p6EJLjhFi9qmro5jswDi3Tw/VYQOHmgxK8Lo6g==
X-Google-Smtp-Source: AGHT+IGuXc6FjY1Z1BMM0/LSBvcS3LTjFhY17Yos6frSb9oN67CVvqV6AV+N7cqz5TYWT7KsyD/5wg==
X-Received: by 2002:a05:6a20:a11a:b0:1db:e3f6:560 with SMTP id adf61e73a8af0-1e09e40a0edmr15304108637.13.1732467387832;
        Sun, 24 Nov 2024 08:56:27 -0800 (PST)
Received: from [::1] ([2001:19f0:ac01:93b:5400:4ff:fe77:2098])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e25cesm4986381a12.28.2024.11.24.08.56.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 08:56:27 -0800 (PST)
From: Yuxin Wang <yuxinwang9999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Yuxin Wang <yuxinwang9999@gmail.com>
Subject: [PATCH BlueZ 1/2] advertising: Add scan response properties to LEAdvertisement1
Date: Sun, 24 Nov 2024 16:55:38 +0000
Message-Id: <20241124165539.2913146-2-yuxinwang9999@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241124165539.2913146-1-yuxinwang9999@gmail.com>
References: <20241124165539.2913146-1-yuxinwang9999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This update introduces a few properties to org.bluez.LEAdvertisement1
for manipulating Scan Response Data, similar to the existing properties
for Advertising Data.

Resolves: https://github.com/bluez/bluez/issues/667
---
 doc/org.bluez.LEAdvertisement.rst |  37 ++++++++-
 src/advertising.c                 | 132 ++++++++++++++++++++++--------
 2 files changed, 130 insertions(+), 39 deletions(-)

diff --git a/doc/org.bluez.LEAdvertisement.rst b/doc/org.bluez.LEAdvertisement.rst
index d3f9cc4..40be2ff 100644
--- a/doc/org.bluez.LEAdvertisement.rst
+++ b/doc/org.bluez.LEAdvertisement.rst
@@ -75,13 +75,14 @@ dict ManufacturerData
 array{string} SolicitUUIDs
 ``````````````````````````
 
-	Array of UUIDs to include in "Service Solicitation" Advertisement Data.
+	List of UUIDs to include in the "Service Solicitation" field of the
+	Advertising Data.
 
 dict ServiceData
 ````````````````
 
-	Service Data elements to include. The keys are the UUID to associate
-	with the data.
+	Service Data elements to include in the Advertising Data. The keys
+	are the UUID to associate with the data.
 
 dict Data
 `````````
@@ -101,6 +102,36 @@ dict Data
 		<Transport Discovery> <Organization Flags...>
 		0x26                   0x01         0x01...
 
+array{string} ScanResponseServiceUUIDs
+``````````````````````````````````````
+
+	List of UUIDs to include in the "Service UUID" field of the Scan
+	Response Data.
+
+dict ScanResponseManufacturerData
+`````````````````````````````````
+
+	Manufacturer Data fields to include in the Scan Response Data. Keys
+	are the Manufacturer ID to associate with the data.
+
+array{string} ScanResponseSolicitUUIDs
+``````````````````````````````````````
+
+	List of UUIDs to include in the "Service Solicitation" field of the
+	Scan Response Data.
+
+dict ScanResponseServiceData
+````````````````````````````
+
+	Service Data elements to include in the Scan Response Data. The keys
+	are the UUID to associate with the data.
+
+dict ScanResponseData
+`````````````````````
+
+	Scan Response Data to include. Key is the advertising type and value is
+	the data as byte array.
+
 bool Discoverable
 `````````````````
 
diff --git a/src/advertising.c b/src/advertising.c
index 2fc6f91..7cdcc62 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -255,13 +255,12 @@ static bool parse_type(DBusMessageIter *iter, struct btd_adv_client *client)
 	return false;
 }
 
-static bool parse_service_uuids(DBusMessageIter *iter,
-					struct btd_adv_client *client)
+static bool parse_service_uuids(DBusMessageIter *iter, struct bt_ad *ad)
 {
 	DBusMessageIter ariter;
 
 	if (!iter) {
-		bt_ad_clear_service_uuid(client->data);
+		bt_ad_clear_service_uuid(ad);
 		return true;
 	}
 
@@ -270,7 +269,7 @@ static bool parse_service_uuids(DBusMessageIter *iter,
 
 	dbus_message_iter_recurse(iter, &ariter);
 
-	bt_ad_clear_service_uuid(client->data);
+	bt_ad_clear_service_uuid(ad);
 
 	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
 		const char *uuid_str;
@@ -283,7 +282,7 @@ static bool parse_service_uuids(DBusMessageIter *iter,
 		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
 			goto fail;
 
-		if (!bt_ad_add_service_uuid(client->data, &uuid))
+		if (!bt_ad_add_service_uuid(ad, &uuid))
 			goto fail;
 
 		dbus_message_iter_next(&ariter);
@@ -292,17 +291,28 @@ static bool parse_service_uuids(DBusMessageIter *iter,
 	return true;
 
 fail:
-	bt_ad_clear_service_uuid(client->data);
+	bt_ad_clear_service_uuid(ad);
 	return false;
 }
 
-static bool parse_solicit_uuids(DBusMessageIter *iter,
+static bool parse_service_uuids_ad(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_service_uuids(iter, client->data);
+}
+
+static bool parse_service_uuids_sr(DBusMessageIter *iter,
 					struct btd_adv_client *client)
+{
+	return parse_service_uuids(iter, client->scan);
+}
+
+static bool parse_solicit_uuids(DBusMessageIter *iter, struct bt_ad *ad)
 {
 	DBusMessageIter ariter;
 
 	if (!iter) {
-		bt_ad_clear_solicit_uuid(client->data);
+		bt_ad_clear_solicit_uuid(ad);
 		return true;
 	}
 
@@ -311,7 +321,7 @@ static bool parse_solicit_uuids(DBusMessageIter *iter,
 
 	dbus_message_iter_recurse(iter, &ariter);
 
-	bt_ad_clear_solicit_uuid(client->data);
+	bt_ad_clear_solicit_uuid(ad);
 
 	while (dbus_message_iter_get_arg_type(&ariter) == DBUS_TYPE_STRING) {
 		const char *uuid_str;
@@ -324,7 +334,7 @@ static bool parse_solicit_uuids(DBusMessageIter *iter,
 		if (bt_string_to_uuid(&uuid, uuid_str) < 0)
 			goto fail;
 
-		if (!bt_ad_add_solicit_uuid(client->data, &uuid))
+		if (!bt_ad_add_solicit_uuid(ad, &uuid))
 			goto fail;
 
 		dbus_message_iter_next(&ariter);
@@ -333,17 +343,28 @@ static bool parse_solicit_uuids(DBusMessageIter *iter,
 	return true;
 
 fail:
-	bt_ad_clear_solicit_uuid(client->data);
+	bt_ad_clear_solicit_uuid(ad);
 	return false;
 }
 
-static bool parse_manufacturer_data(DBusMessageIter *iter,
+static bool parse_solicit_uuids_ad(DBusMessageIter *iter,
 					struct btd_adv_client *client)
+{
+	return parse_solicit_uuids(iter, client->data);
+}
+
+static bool parse_solicit_uuids_sr(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_solicit_uuids(iter, client->scan);
+}
+
+static bool parse_manufacturer_data(DBusMessageIter *iter, struct bt_ad *ad)
 {
 	DBusMessageIter entries;
 
 	if (!iter) {
-		bt_ad_clear_manufacturer_data(client->data);
+		bt_ad_clear_manufacturer_data(ad);
 		return true;
 	}
 
@@ -352,7 +373,7 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
 
 	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_manufacturer_data(client->data);
+	bt_ad_clear_manufacturer_data(ad);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -383,7 +404,7 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
 
 		DBG("Adding ManufacturerData for %04x", manuf_id);
 
-		if (!bt_ad_add_manufacturer_data(client->data, manuf_id,
+		if (!bt_ad_add_manufacturer_data(ad, manuf_id,
 							manuf_data, len))
 			goto fail;
 
@@ -393,17 +414,28 @@ static bool parse_manufacturer_data(DBusMessageIter *iter,
 	return true;
 
 fail:
-	bt_ad_clear_manufacturer_data(client->data);
+	bt_ad_clear_manufacturer_data(ad);
 	return false;
 }
 
-static bool parse_service_data(DBusMessageIter *iter,
+static bool parse_manufacturer_data_ad(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_manufacturer_data(iter, client->data);
+}
+
+static bool parse_manufacturer_data_sr(DBusMessageIter *iter,
 					struct btd_adv_client *client)
+{
+	return parse_manufacturer_data(iter, client->scan);
+}
+
+static bool parse_service_data(DBusMessageIter *iter, struct bt_ad *ad)
 {
 	DBusMessageIter entries;
 
 	if (!iter) {
-		bt_ad_clear_service_data(client->data);
+		bt_ad_clear_service_data(ad);
 		return true;
 	}
 
@@ -412,7 +444,7 @@ static bool parse_service_data(DBusMessageIter *iter,
 
 	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_service_data(client->data);
+	bt_ad_clear_service_data(ad);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -447,7 +479,7 @@ static bool parse_service_data(DBusMessageIter *iter,
 
 		DBG("Adding ServiceData for %s", uuid_str);
 
-		if (!bt_ad_add_service_data(client->data, &uuid, service_data,
+		if (!bt_ad_add_service_data(ad, &uuid, service_data,
 									len))
 			goto fail;
 
@@ -457,10 +489,22 @@ static bool parse_service_data(DBusMessageIter *iter,
 	return true;
 
 fail:
-	bt_ad_clear_service_data(client->data);
+	bt_ad_clear_service_data(ad);
 	return false;
 }
 
+static bool parse_service_data_ad(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_service_data(iter, client->data);
+}
+
+static bool parse_service_data_sr(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_service_data(iter, client->scan);
+}
+
 static bool set_rsi(struct btd_adv_client *client)
 {
 	struct bt_crypto *crypto;
@@ -667,12 +711,12 @@ static bool parse_timeout(DBusMessageIter *iter,
 	return true;
 }
 
-static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *client)
+static bool parse_data(DBusMessageIter *iter, struct bt_ad *ad)
 {
 	DBusMessageIter entries;
 
 	if (!iter) {
-		bt_ad_clear_data(client->data);
+		bt_ad_clear_data(ad);
 		return true;
 	}
 
@@ -681,7 +725,7 @@ static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *client)
 
 	dbus_message_iter_recurse(iter, &entries);
 
-	bt_ad_clear_data(client->data);
+	bt_ad_clear_data(ad);
 
 	while (dbus_message_iter_get_arg_type(&entries)
 						== DBUS_TYPE_DICT_ENTRY) {
@@ -712,7 +756,7 @@ static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *client)
 
 		DBG("Adding Data for type 0x%02x len %u", type, len);
 
-		if (!bt_ad_add_data(client->data, type, data, len))
+		if (!bt_ad_add_data(ad, type, data, len))
 			goto fail;
 
 		dbus_message_iter_next(&entries);
@@ -721,10 +765,22 @@ static bool parse_data(DBusMessageIter *iter, struct btd_adv_client *client)
 	return true;
 
 fail:
-	bt_ad_clear_data(client->data);
+	bt_ad_clear_data(ad);
 	return false;
 }
 
+static bool parse_data_ad(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_data(iter, client->data);
+}
+
+static bool parse_data_sr(DBusMessageIter *iter,
+					struct btd_adv_client *client)
+{
+	return parse_data(iter, client->scan);
+}
+
 static bool set_flags(struct btd_adv_client *client, uint8_t flags)
 {
 	/* Set BR/EDR Not Supported for LE only */
@@ -837,15 +893,14 @@ static uint8_t *generate_adv_data(struct btd_adv_client *client,
 static uint8_t *generate_scan_rsp(struct btd_adv_client *client,
 						uint32_t *flags, size_t *len)
 {
-	if (!client->name) {
+	if (client->name) {
+		*flags &= ~MGMT_ADV_FLAG_LOCAL_NAME;
+		bt_ad_add_name(client->scan, client->name);
+	} else if (bt_ad_is_empty(client->scan)) {
 		*len = 0;
 		return NULL;
 	}
 
-	*flags &= ~MGMT_ADV_FLAG_LOCAL_NAME;
-
-	bt_ad_add_name(client->scan, client->name);
-
 	return bt_ad_generate(client->scan, len);
 }
 
@@ -1217,16 +1272,21 @@ static struct adv_parser {
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
 } parsers[] = {
 	{ "Type", parse_type },
-	{ "ServiceUUIDs", parse_service_uuids },
-	{ "SolicitUUIDs", parse_solicit_uuids },
-	{ "ManufacturerData", parse_manufacturer_data },
-	{ "ServiceData", parse_service_data },
+	{ "ServiceUUIDs", parse_service_uuids_ad },
+	{ "ScanResponseServiceUUIDs", parse_service_uuids_sr },
+	{ "SolicitUUIDs", parse_solicit_uuids_ad },
+	{ "ScanResponseSolicitUUIDs", parse_solicit_uuids_sr },
+	{ "ManufacturerData", parse_manufacturer_data_ad },
+	{ "ScanResponseManufacturerData", parse_manufacturer_data_sr },
+	{ "ServiceData", parse_service_data_ad },
+	{ "ScanResponseServiceData", parse_service_data_sr },
 	{ "Includes", parse_includes },
 	{ "LocalName", parse_local_name },
 	{ "Appearance", parse_appearance },
 	{ "Duration", parse_duration },
 	{ "Timeout", parse_timeout },
-	{ "Data", parse_data },
+	{ "Data", parse_data_ad },
+	{ "ScanResponseData", parse_data_sr },
 	{ "Discoverable", parse_discoverable },
 	{ "DiscoverableTimeout", parse_discoverable_timeout },
 	{ "SecondaryChannel", parse_secondary },
-- 
2.39.5

