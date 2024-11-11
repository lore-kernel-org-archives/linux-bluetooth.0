Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7156919C552
	for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333192; cv=none; b=UKcaNZDAvvsVf8lLTm5IOvyeBRTNpiRm0QT892loMeXSpRCftxG3aGHmQcJR8CcgjFmcghhEdxUh2186fGoLBE5W3wP+bM9zCW+Y4lnV6iyVwIk6rYc1queZRC/qjq0RFe5roGJ3J6K552rHdyxlgzkMsn59sFvIzmuqj3vaw20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333192; c=relaxed/simple;
	bh=OzxRBuhG10OWbAjFbLprx6q7TMKrBEsJE9WRgICLqXg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Kp3JHDG5abB24v+vl2GBxPgqZKuoSB9d/ZYgzl7WOKV/GEdA7PPeXYAsvePTGi7tuo8FH8rLL8qMJrUfNmp68iffMykTG5FaurNBP4AwQ7twxC/ujt5CqELpmy89rSvTfYDDc0TVA+TBpJhbJE+CcMYSJFZ5vpyhlvBElkSrRlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu6avHk5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu6avHk5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e5a62031aso3476406b3a.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 05:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731333189; x=1731937989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZBQCdnyNW/1usM+jbJVPYlTidOMBlk9HA99MIV92RZA=;
        b=Bu6avHk5BuJebWU7WadTi4r0413GGclRvwEBQqbnmpFeEPKiegMBEgrW+Jg0WFLvgp
         MdfEBtK2EE4tiJj5ADvsP6MXHzFTTF6FJIbKGWw0t8I+t3wkeEaSiqpElxZARzQVR829
         vVPshYwfNKQFY7EIUyleNNzjMdhN8m81EG9QIbWDUL2p0JIEu3YLn4ZdCKI10TmLGPnx
         DFvKpXQMm+TmlnPpvVxq05M7wWwK6IjWCt1L7jXKPh8VLFGUb8CLW9UCsPAiLS7fSzbj
         ZD5pZqRm82us+VQL9J+Ib7lkcrjSYgmQHYH1MSDmX+VxeMcH70fMvbJsiXJRq7iBE1IN
         wLvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333189; x=1731937989;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZBQCdnyNW/1usM+jbJVPYlTidOMBlk9HA99MIV92RZA=;
        b=CR4RD8IBCH44ew+lYf0ac8EhZ2SSU1WhxpTCK/Ocwq7p/ymJ6s+6Q9gzVJjCY5zgV4
         AbEqWQOfb8+LA6UYGX0aIvHzaoflJ9/H+18MJw9UbmC2pKjevcC99PPSG0yGan+aRCtx
         ObZVDX+zwXGk+WcwOS/NeEXmWTeV/xawFO1owWdrtlURgDZPrHGSLEE1di8EXlKapUQR
         nU04FSZnK/brJJrTZTX9G9ERV8nrm8+YiXvs8Zvoh2p/6YyogDj/w3bb5h3I98mLQAy8
         BRPGCPqcn848jwiicITLVwz+bzVJvD1B1EUHbxWbQUmPFsLYpcQuHx824QEEx3mpKtg5
         mYbQ==
X-Gm-Message-State: AOJu0YzHwqfPhSIvRxWpA0/LXv4f49u4ma6wFq4WU7mirT/hWN+v7QGH
	Y+Hf1auo+HvAoa0IkUvB0WN4FgoAKLNgAIgyNXTtLfW1HKrJC5c05A54/FxE
X-Google-Smtp-Source: AGHT+IFKNwxfAcEQhP8WLbivjk70joCIldgVSaCFoULXG9SufACADyBdONwCp4QUy9h0Fqi4OcVc+Q==
X-Received: by 2002:a05:6a20:a11d:b0:1db:eccc:9249 with SMTP id adf61e73a8af0-1dc22b3ef9bmr16259598637.43.1731333189502;
        Mon, 11 Nov 2024 05:53:09 -0800 (PST)
Received: from [::1] ([2001:19f0:ac01:93b:5400:4ff:fe77:2098])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e99a5fd329sm10683680a91.37.2024.11.11.05.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 05:53:09 -0800 (PST)
From: Yuxin Wang <yuxinwang9999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Yuxin Wang <yuxinwang9999@gmail.com>
Subject: [PATCH BlueZ] advertising: Add scan response properties to LEAdvertisement1
Date: Mon, 11 Nov 2024 13:52:50 +0000
Message-Id: <20241111135250.2319622-1-yuxinwang9999@gmail.com>
X-Mailer: git-send-email 2.34.1
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
index bd121e5..ba70419 100644
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
@@ -832,15 +888,14 @@ static uint8_t *generate_adv_data(struct btd_adv_client *client,
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
 
@@ -1212,16 +1267,21 @@ static struct adv_parser {
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

