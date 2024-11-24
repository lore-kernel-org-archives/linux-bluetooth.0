Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F418872F
	for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732467392; cv=none; b=GPYB0+x2xQJ+OYe84QIXVVA75uqkAQN4jSeuNUymr/Ema/Fk9ndRARQLQTjSeKkReKx3MzoszXdgVXbXYecWc0BHvBWXkOYXoIMyYYqOMietHyJJLc8a6nX7BC4k5GPeyUQjTaTV+T+ydB2I6GDpidA8mqZmJJJrSyLlOScMBTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732467392; c=relaxed/simple;
	bh=BCWO8dN5qrimkj5S6QNbNi+c00Pgig6WIzPI9YvhNTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cv1IBNrAfX7JrFVy6Zrx6fuTtC/GQmmjbOBmVZIvHynn1ouhOn1qs55DHVviIz9Y6JsSmKzCbjOdzlVvB928sKb5U49szdA3b1rjofBuNAciATfXcDjHUY1+cZE94y+KjiVzp6uyzdG/4iM5w4rmkqKpCOprLooDWor3z3/rJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MB1TBT5X; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB1TBT5X"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ee6edc47abso2646507a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 24 Nov 2024 08:56:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732467389; x=1733072189; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qdWOg2JNjKZG3nKs6hj3pWYPlNHJgtO3aTV4B/CJBII=;
        b=MB1TBT5XvKRcrF1+pMzh/E8ab0vIMJyjKZ6wDidQOVvlOg3iLf4K1sm9FkD47yz/yg
         ZQ8WJ9U/Cld8/BJ/DI1LIA/9Rs6Py8emqFlg6zde0y16yQ0mLiFiys5XnKAMvy9kWdqn
         YDojt7nZZA0EtFti3J1cIeBxB4kIEh7Ki6jlYwkTS2ia+cTktXNhbd9eL8CTUQ1bqNs8
         tr+YpAoU5eH8xHhSVaZLOb2RND5h3V8MT4BI1es+d0sRqJx6um4E9h05J2ZBrw75YgpL
         4Avy7/YqAJcaSzQUgNrFf3zCFol2C7qSEbJgkAE1Ur6HkGp23ZICR9Sdr2P2VKHLHOiw
         3mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732467389; x=1733072189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qdWOg2JNjKZG3nKs6hj3pWYPlNHJgtO3aTV4B/CJBII=;
        b=vprnpOT1V3W4jD1mD3p1pIWPAqiXpy/CI3KVKhHHBhRJbcRCAK5uR3Y2uyh8gWBKku
         vJ0EUttUs35keO0tTn9XEfIkEo7oUPr9GC+4jK3F+NU0SX6oKoyfCfcnTfiSGMZwtWfw
         60WS2JzhVAX1xXJDeRoSenqCOR1LOy2Hbut85csx4OZtlkYTPlN5PQl4fvRmRYQSqoXe
         zHn73sKLbPy6+aEwuJ3Ez7WgUgO20Et5dC3Wmd8APdwcOSZj1auhN+9o3WW7QNyLeqN4
         mRELYGCASRFR6BaQSkNty0dsFmuP0GxTXjQsNcvGMG3FQd4H9vnuhNxUjmxpLXlv5rGt
         uK9w==
X-Gm-Message-State: AOJu0Yxtp2eWNnixVPUWOUJv+fiI3qN3ZmvKm6EILB3nEqxxDoiSwzsh
	RslggExn0LyWZ3506FTCkJF7zj7SgEvEtithyG2MDOuo4pJkrPn4L6zXQA==
X-Gm-Gg: ASbGncvK6QehhbyRQQF98nPUEp+CeYdLi4yj0oYHOxil/+kCwMAN5cjWBvkuHs3bBWr
	mAaoHZIapWg/ay6zWtRbALAYMpZuJ6hOm/qw6b7EvfGvhnoWNyLkpmaP2wKGlCclPBHZHS6BAJC
	hbc3FxlnV+OZuSqRflhNIUYatG1eK8vGmovilKErfUqCa3yesszeSJfUuXpJaxR3dFaRULxANni
	8ypbCyMD78b8iUGYmcCdrvoHPvzFUuMNucSyhs0JnD+0adDuA==
X-Google-Smtp-Source: AGHT+IFuCz05lxLN6GAPopN1BP6VRShRwK2J3zW7DpiHYcovN90cluocL2CodlO8hOP90Qx6ZH+Qgw==
X-Received: by 2002:a05:6a20:2590:b0:1db:e3a2:eaba with SMTP id adf61e73a8af0-1e09e409b11mr14460738637.11.1732467388833;
        Sun, 24 Nov 2024 08:56:28 -0800 (PST)
Received: from [::1] ([2001:19f0:ac01:93b:5400:4ff:fe77:2098])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcc1e25cesm4986381a12.28.2024.11.24.08.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Nov 2024 08:56:28 -0800 (PST)
From: Yuxin Wang <yuxinwang9999@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Yuxin Wang <yuxinwang9999@gmail.com>
Subject: [PATCH BlueZ 2/2] advertising: Add scan response support in bluetoothctl
Date: Sun, 24 Nov 2024 16:55:39 +0000
Message-Id: <20241124165539.2913146-3-yuxinwang9999@gmail.com>
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

Add commands in the bluetoothctl advertising submenu to manage
scan response data.
---
 client/advertising.c              | 486 +++++++++++++++++++++++-------
 client/advertising.h              |  25 +-
 client/bluetoothctl-advertise.rst |  39 +++
 client/main.c                     |  95 +++++-
 4 files changed, 515 insertions(+), 130 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 4a98121..46af2e0 100644
--- a/client/advertising.c
+++ b/client/advertising.c
@@ -59,11 +59,13 @@ static struct ad {
 	uint16_t duration;
 	uint16_t timeout;
 	uint16_t discoverable_to;
-	char **uuids;
-	size_t uuids_len;
-	struct service_data service;
-	struct manufacturer_data manufacturer;
-	struct data data;
+	char **uuids[AD_TYPE_COUNT];
+	size_t uuids_len[AD_TYPE_COUNT];
+	char **solicit[AD_TYPE_COUNT];
+	size_t solicit_len[AD_TYPE_COUNT];
+	struct service_data service[AD_TYPE_COUNT];
+	struct manufacturer_data manufacturer[AD_TYPE_COUNT];
+	struct data data[AD_TYPE_COUNT];
 	bool discoverable;
 	bool tx_power;
 	bool name;
@@ -111,7 +113,7 @@ static void register_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_close_container(iter, &dict);
 }
 
-static void print_uuid(const char *uuid)
+static void print_uuid(const char *prefix, const char *uuid)
 {
 	const char *text;
 
@@ -130,37 +132,70 @@ static void print_uuid(const char *uuid)
 				str[sizeof(str) - 4] = '.';
 		}
 
-		bt_shell_printf("UUID: %s(%s)\n", str, uuid);
+		bt_shell_printf("%s: %s(%s)\n", prefix, str, uuid);
 	} else
-		bt_shell_printf("UUID: (%s)\n", uuid ? uuid : "");
+		bt_shell_printf("%s: (%s)\n", prefix, uuid ? uuid : "");
+}
+
+static const struct {
+    const char* uuid[AD_TYPE_COUNT];
+    const char* solicit[AD_TYPE_COUNT];
+    const char* service[AD_TYPE_COUNT];
+    const char* manufacturer[AD_TYPE_COUNT];
+    const char* data[AD_TYPE_COUNT];
+} ad_names = {
+    .uuid = { "UUID", "Scan Response UUID" },
+    .solicit = { "Solicit UUID", "Scan Response Solicit UUID" },
+    .service = { "UUID", "Scan Response UUID" },
+    .manufacturer = { "Manufacturer", "Scan Response Manufacturer" },
+    .data = { "Data", "Scan Response Data" }
+};
+
+static void print_ad_uuids(int type)
+{
+	char **uuid;
+
+	for (uuid = ad.uuids[type]; uuid && *uuid; uuid++)
+		print_uuid(ad_names.uuid[type], *uuid);
 }
 
-static void print_ad_uuids(void)
+static void print_ad_solicit(int type)
 {
 	char **uuid;
 
-	for (uuid = ad.uuids; uuid && *uuid; uuid++)
-		print_uuid(*uuid);
+	for (uuid = ad.solicit[type]; uuid && *uuid; uuid++)
+		print_uuid(ad_names.solicit[type], *uuid);
 }
 
 static void print_ad(void)
 {
-	print_ad_uuids();
+	int type;
 
-	if (ad.service.uuid) {
-		print_uuid(ad.service.uuid);
-		bt_shell_hexdump(ad.service.data.data, ad.service.data.len);
-	}
+	for (type = AD_TYPE_AD; type <= AD_TYPE_SRD; type++) {
+		print_ad_uuids(type);
+		print_ad_solicit(type);
 
-	if (ad.manufacturer.data.len) {
-		bt_shell_printf("Manufacturer: %u\n", ad.manufacturer.id);
-		bt_shell_hexdump(ad.manufacturer.data.data,
-						ad.manufacturer.data.len);
-	}
+		if (ad.service[type].uuid) {
+			print_uuid(ad_names.service[type], 
+						ad.service[type].uuid);
+			bt_shell_hexdump(ad.service[type].data.data, 
+						ad.service[type].data.len);
+		}
+
+		if (ad.manufacturer[type].data.len) {
+			bt_shell_printf("%s: %u\n", ad_names.manufacturer[type],
+						ad.manufacturer[type].id);
+			bt_shell_hexdump(ad.manufacturer[type].data.data,
+						ad.manufacturer[type].data.len);
+		}
 
-	if (ad.data.valid) {
-		bt_shell_printf("Data Type: 0x%02x\n", ad.data.type);
-		bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
+		if (ad.data[type].valid) {
+			bt_shell_printf("%s Type: 0x%02x\n", 
+						ad_names.data[type], 
+						ad.data[type].type);
+			bt_shell_hexdump(ad.data[type].data.data, 
+						ad.data[type].data.len);
+		}
 	}
 
 	bt_shell_printf("Tx Power: %s\n", ad.tx_power ? "on" : "off");
@@ -228,12 +263,13 @@ static gboolean get_type(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean uuids_exists(const GDBusPropertyTable *property, void *data)
+static gboolean uuids_exists(int type, const GDBusPropertyTable *property,
+								void *data)
 {
-	return ad.uuids_len != 0;
+	return ad.uuids_len[type] != 0;
 }
 
-static gboolean get_uuids(const GDBusPropertyTable *property,
+static gboolean get_uuids(int type, const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter array;
@@ -241,55 +277,149 @@ static gboolean get_uuids(const GDBusPropertyTable *property,
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
 
-	for (i = 0; i < ad.uuids_len; i++)
+	for (i = 0; i < ad.uuids_len[type]; i++)
 		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
-							&ad.uuids[i]);
+						&ad.uuids[type][i]);
 
 	dbus_message_iter_close_container(iter, &array);
 
 	return TRUE;
 }
 
-static gboolean service_data_exists(const GDBusPropertyTable *property,
+static gboolean ad_uuids_exists(const GDBusPropertyTable *property, void *data)
+{
+	return uuids_exists(AD_TYPE_AD, property, data);
+}
+
+static gboolean get_ad_uuids(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	return get_uuids(AD_TYPE_AD, property, iter, user_data);
+}
+
+static gboolean sr_uuids_exists(const GDBusPropertyTable *property, void *data)
+{
+	return uuids_exists(AD_TYPE_SRD, property, data);
+}
+
+static gboolean get_sr_uuids(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	return get_uuids(AD_TYPE_SRD, property, iter, user_data);
+}
+
+static gboolean solicit_uuids_exists(int type,
+				const GDBusPropertyTable *property, void *data)
+{
+	return ad.solicit_len[type] != 0;
+}
+
+static gboolean get_solicit_uuids(int type, const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	DBusMessageIter array;
+	size_t i;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "as", &array);
+
+	for (i = 0; i < ad.solicit_len[type]; i++)
+		dbus_message_iter_append_basic(&array, DBUS_TYPE_STRING,
+						&ad.solicit[type][i]);
+
+	dbus_message_iter_close_container(iter, &array);
+
+	return TRUE;
+}
+
+static gboolean ad_solicit_uuids_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	return solicit_uuids_exists(AD_TYPE_AD, property, data);
+}
+
+static gboolean get_ad_solicit_uuids(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	return get_solicit_uuids(AD_TYPE_AD, property, iter, user_data);
+}
+
+static gboolean sr_solicit_uuids_exists(const GDBusPropertyTable *property,
 								void *data)
 {
-	return ad.service.uuid != NULL;
+	return solicit_uuids_exists(AD_TYPE_SRD, property, data);
 }
 
-static gboolean get_service_data(const GDBusPropertyTable *property,
+static gboolean get_sr_solicit_uuids(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	return get_solicit_uuids(AD_TYPE_SRD, property, iter, user_data);
+}
+
+static gboolean service_data_exists(int type,
+				const GDBusPropertyTable *property, void *data)
+{
+	return ad.service[type].uuid != NULL;
+}
+
+static gboolean get_service_data(int type, const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
-	struct ad_data *data = &ad.service.data;
+	struct ad_data *data = &ad.service[type].data;
 	uint8_t *val = data->data;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{sv}", &dict);
 
-	g_dbus_dict_append_array(&dict, ad.service.uuid, DBUS_TYPE_BYTE, &val,
-								data->len);
+	g_dbus_dict_append_array(&dict, ad.service[type].uuid, DBUS_TYPE_BYTE,
+							&val, data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
 
 	return TRUE;
 }
 
-static gboolean manufacturer_data_exists(const GDBusPropertyTable *property,
+static gboolean ad_service_data_exists(const GDBusPropertyTable *property,
 								void *data)
 {
-	return ad.manufacturer.id != 0;
+	return service_data_exists(AD_TYPE_AD, property, data);
 }
 
-static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
-					DBusMessageIter *iter, void *user_data)
+static gboolean get_ad_service_data(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	return get_service_data(AD_TYPE_AD, property, iter, user_data);
+}
+
+static gboolean sr_service_data_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	return service_data_exists(AD_TYPE_SRD, property, data);
+}
+
+static gboolean get_sr_service_data(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
+{
+	return get_service_data(AD_TYPE_SRD, property, iter, user_data);
+}
+
+static gboolean manufacturer_data_exists(int type,
+				const GDBusPropertyTable *property, void *data)
+{
+	return ad.manufacturer[type].id != 0;
+}
+
+static gboolean get_manufacturer_data(int type,
+				const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
-	struct ad_data *data = &ad.manufacturer.data;
+	struct ad_data *data = &ad.manufacturer[type].data;
 	uint8_t *val = data->data;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{qv}", &dict);
 
 	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_UINT16,
-					&ad.manufacturer.id,
+					&ad.manufacturer[type].id,
 					DBUS_TYPE_BYTE, &val, data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
@@ -297,6 +427,30 @@ static gboolean get_manufacturer_data(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean ad_manufacturer_data_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	return manufacturer_data_exists(AD_TYPE_AD, property, data);
+}
+
+static gboolean get_ad_manufacturer_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	return get_manufacturer_data(AD_TYPE_AD, property, iter, user_data);
+}
+
+static gboolean sr_manufacturer_data_exists(const GDBusPropertyTable *property,
+								void *data)
+{
+	return manufacturer_data_exists(AD_TYPE_SRD, property, data);
+}
+
+static gboolean get_sr_manufacturer_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	return get_manufacturer_data(AD_TYPE_SRD, property, iter, user_data);
+}
+
 static gboolean includes_exists(const GDBusPropertyTable *property, void *data)
 {
 	return ad.tx_power || ad.name || ad.appearance || ad.rsi;
@@ -394,28 +548,51 @@ static gboolean get_timeout(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
-static gboolean data_exists(const GDBusPropertyTable *property, void *data)
+static gboolean data_exists(int type, const GDBusPropertyTable *property,
+								void *data)
 {
-	return ad.data.valid;
+	return ad.data[type].valid;
 }
 
-static gboolean get_data(const GDBusPropertyTable *property,
+static gboolean get_data(int type, const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
 	DBusMessageIter dict;
-	struct ad_data *data = &ad.data.data;
+	struct ad_data *data = &ad.data[type].data;
 	uint8_t *val = data->data;
 
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY, "{yv}", &dict);
 
-	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_BYTE, &ad.data.type,
-					DBUS_TYPE_BYTE, &val, data->len);
+	g_dbus_dict_append_basic_array(&dict, DBUS_TYPE_BYTE,
+			&ad.data[type].type, DBUS_TYPE_BYTE, &val, data->len);
 
 	dbus_message_iter_close_container(iter, &dict);
 
 	return TRUE;
 }
 
+static gboolean ad_data_exists(const GDBusPropertyTable *property, void *data)
+{
+	return data_exists(AD_TYPE_AD, property, data);
+}
+
+static gboolean get_ad_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	return get_data(AD_TYPE_AD, property, iter, user_data);
+}
+
+static gboolean sr_data_exists(const GDBusPropertyTable *property, void *data)
+{
+	return data_exists(AD_TYPE_SRD, property, data);
+}
+
+static gboolean get_sr_data(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *user_data)
+{
+	return get_data(AD_TYPE_SRD, property, iter, user_data);
+}
+
 static gboolean get_discoverable(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -487,11 +664,23 @@ static gboolean get_max_interval(const GDBusPropertyTable *property,
 
 static const GDBusPropertyTable ad_props[] = {
 	{ "Type", "s", get_type },
-	{ "ServiceUUIDs", "as", get_uuids, NULL, uuids_exists },
-	{ "ServiceData", "a{sv}", get_service_data, NULL, service_data_exists },
-	{ "ManufacturerData", "a{qv}", get_manufacturer_data, NULL,
-						manufacturer_data_exists },
-	{ "Data", "a{yv}", get_data, NULL, data_exists },
+	{ "ServiceUUIDs", "as", get_ad_uuids, NULL, ad_uuids_exists },
+	{ "SolicitUUIDs", "as", get_ad_solicit_uuids, NULL,
+						ad_solicit_uuids_exists },
+	{ "ServiceData", "a{sv}", get_ad_service_data, NULL,
+						ad_service_data_exists },
+	{ "ManufacturerData", "a{qv}", get_ad_manufacturer_data, NULL,
+						ad_manufacturer_data_exists },
+	{ "Data", "a{yv}", get_ad_data, NULL, ad_data_exists },
+	{ "ScanResponseServiceUUIDs", "as", get_sr_uuids, NULL,
+						sr_uuids_exists },
+	{ "ScanResponseSolicitUUIDs", "as", get_sr_solicit_uuids, NULL,
+						sr_solicit_uuids_exists },
+	{ "ScanResponseServiceData", "a{sv}", get_sr_service_data, NULL,
+						sr_service_data_exists },
+	{ "ScanResponseManufacturerData", "a{qv}", get_sr_manufacturer_data,
+					NULL, sr_manufacturer_data_exists },
+	{ "ScanResponseData", "a{yv}", get_sr_data, NULL, sr_data_exists },
 	{ "Discoverable", "b", get_discoverable, NULL, NULL },
 	{ "DiscoverableTimeout", "q", get_discoverable_timeout, NULL,
 						discoverable_timeout_exists },
@@ -582,50 +771,109 @@ void ad_unregister(DBusConnection *conn, GDBusProxy *manager)
 	}
 }
 
-static void ad_clear_uuids(void)
+static const struct {
+    const char* uuid[AD_TYPE_COUNT];
+    const char* solicit[AD_TYPE_COUNT];
+    const char* service[AD_TYPE_COUNT];
+    const char* manufacturer[AD_TYPE_COUNT];
+    const char* data[AD_TYPE_COUNT];
+} prop_names = {
+    .uuid = { "ServiceUUIDs", 	"ScanResponseServiceUUIDs" },
+    .solicit = { "SolicitUUIDs", "ScanResponseSolicitUUIDs" },
+    .service = { "ServiceData", "ScanResponseServiceData" },
+    .manufacturer = { "ManufacturerData", "ScanResponseManufacturerData" },
+    .data = { "Data", "ScanResponseData" }
+};
+
+static void ad_clear_uuids(int type)
 {
-	g_strfreev(ad.uuids);
-	ad.uuids = NULL;
-	ad.uuids_len = 0;
+	g_strfreev(ad.uuids[type]);
+	ad.uuids[type] = NULL;
+	ad.uuids_len[type] = 0;
 }
 
-void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[])
+void ad_advertise_uuids(DBusConnection *conn, int type, int argc, char *argv[])
 {
 	if (argc < 2 || !strlen(argv[1])) {
-		print_ad_uuids();
+		print_ad_uuids(type);
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
 
-	ad_clear_uuids();
+	ad_clear_uuids(type);
 
-	ad.uuids = g_strdupv(&argv[1]);
-	if (!ad.uuids) {
+	ad.uuids[type] = g_strdupv(&argv[1]);
+	if (!ad.uuids[type]) {
 		bt_shell_printf("Failed to parse input\n");
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
 
-	ad.uuids_len = g_strv_length(ad.uuids);
+	ad.uuids_len[type] = g_strv_length(ad.uuids[type]);
 
-	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							prop_names.uuid[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_disable_uuids(DBusConnection *conn)
+void ad_disable_uuids(DBusConnection *conn, int type)
 {
-	if (!ad.uuids)
+	if (!ad.uuids[type])
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
-	ad_clear_uuids();
-	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceUUIDs");
+	ad_clear_uuids(type);
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							prop_names.uuid[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void ad_clear_service(void)
+static void ad_clear_solicit(int type)
 {
-	g_free(ad.service.uuid);
-	memset(&ad.service, 0, sizeof(ad.service));
+	g_strfreev(ad.solicit[type]);
+	ad.solicit[type] = NULL;
+	ad.solicit_len[type] = 0;
+}
+
+void ad_advertise_solicit(DBusConnection *conn, int type,
+							int argc, char *argv[])
+{
+	if (argc < 2 || !strlen(argv[1])) {
+		print_ad_solicit(type);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	ad_clear_solicit(type);
+
+	ad.solicit[type] = g_strdupv(&argv[1]);
+	if (!ad.solicit[type]) {
+		bt_shell_printf("Failed to parse input\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	ad.solicit_len[type] = g_strv_length(ad.solicit[type]);
+
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+						prop_names.solicit[type]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+void ad_disable_solicit(DBusConnection *conn, int type)
+{
+	if (!ad.solicit[type])
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+
+	ad_clear_solicit(type);
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+						prop_names.solicit[type]);
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void ad_clear_service(int type)
+{
+	g_free(ad.service[type].uuid);
+	memset(&ad.service[type], 0, sizeof(ad.service[type]));
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -658,15 +906,17 @@ static bool ad_add_data(struct ad_data *data, int argc, char *argv[])
 	return true;
 }
 
-void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
+void ad_advertise_service(DBusConnection *conn, int type,
+							int argc, char *argv[])
 {
 	struct ad_data data;
 
 	if (argc < 2 || !strlen(argv[1])) {
-		if (ad.service.uuid) {
-			print_uuid(ad.service.uuid);
-			bt_shell_hexdump(ad.service.data.data,
-						ad.service.data.len);
+		if (ad.service[type].uuid) {
+			print_uuid(ad_names.service[type],
+						ad.service[type].uuid);
+			bt_shell_hexdump(ad.service[type].data.data,
+						ad.service[type].data.len);
 		}
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 	}
@@ -674,46 +924,49 @@ void ad_advertise_service(DBusConnection *conn, int argc, char *argv[])
 	if (!ad_add_data(&data, argc - 2, argv + 2))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	ad_clear_service();
+	ad_clear_service(type);
 
-	ad.service.uuid = g_strdup(argv[1]);
-	ad.service.data = data;
+	ad.service[type].uuid = g_strdup(argv[1]);
+	ad.service[type].data = data;
 
-	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+						prop_names.service[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_disable_service(DBusConnection *conn)
+void ad_disable_service(DBusConnection *conn, int type)
 {
-	if (!ad.service.uuid)
+	if (!ad.service[type].uuid)
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
-	ad_clear_service();
-	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "ServiceData");
+	ad_clear_service(type);
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+						prop_names.service[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void ad_clear_manufacturer(void)
+static void ad_clear_manufacturer(int type)
 {
-	memset(&ad.manufacturer, 0, sizeof(ad.manufacturer));
+	memset(&ad.manufacturer[type], 0, sizeof(ad.manufacturer[type]));
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
+void ad_advertise_manufacturer(DBusConnection *conn, int type,
+							int argc, char *argv[])
 {
 	char *endptr = NULL;
 	long int val;
 	struct ad_data data;
 
 	if (argc < 2 || !strlen(argv[1])) {
-		if (ad.manufacturer.data.len) {
-			bt_shell_printf("Manufacturer: %u\n",
-						ad.manufacturer.id);
-			bt_shell_hexdump(ad.manufacturer.data.data,
-						ad.manufacturer.data.len);
+		if (ad.manufacturer[type].data.len) {
+			bt_shell_printf("%s: %u\n", ad_names.manufacturer[type],
+						ad.manufacturer[type].id);
+			bt_shell_hexdump(ad.manufacturer[type].data.data,
+						ad.manufacturer[type].data.len);
 		}
 
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -728,45 +981,48 @@ void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[])
 	if (!ad_add_data(&data, argc - 2, argv + 2))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	ad_clear_manufacturer();
-	ad.manufacturer.id = val;
-	ad.manufacturer.data = data;
+	ad_clear_manufacturer(type);
+	ad.manufacturer[type].id = val;
+	ad.manufacturer[type].data = data;
 
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
-							"ManufacturerData");
+						prop_names.manufacturer[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_disable_manufacturer(DBusConnection *conn)
+void ad_disable_manufacturer(DBusConnection *conn, int type)
 {
-	if (!ad.manufacturer.id && !ad.manufacturer.data.len)
+	if (!ad.manufacturer[type].id && !ad.manufacturer[type].data.len)
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
-	ad_clear_manufacturer();
+	ad_clear_manufacturer(type);
 	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
-							"ManufacturerData");
+						prop_names.manufacturer[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-static void ad_clear_data(void)
+static void ad_clear_data(int type)
 {
-	memset(&ad.data, 0, sizeof(ad.data));
+	memset(&ad.data[type], 0, sizeof(ad.data[type]));
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_advertise_data(DBusConnection *conn, int argc, char *argv[])
+void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[])
 {
 	char *endptr = NULL;
 	long int val;
 	struct ad_data data;
 
 	if (argc < 2 || !strlen(argv[1])) {
-		if (ad.data.data.len) {
-			bt_shell_printf("Type: 0x%02x\n", ad.data.type);
-			bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
+		if (ad.data[type].data.len) {
+			bt_shell_printf("%s Type: 0x%02x\n",
+							ad_names.data[type],
+							ad.data[type].type);
+			bt_shell_hexdump(ad.data[type].data.data,
+							ad.data[type].data.len);
 		}
 
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
@@ -781,23 +1037,25 @@ void ad_advertise_data(DBusConnection *conn, int argc, char *argv[])
 	if (!ad_add_data(&data, argc - 2, argv + 2))
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 
-	ad_clear_data();
-	ad.data.valid = true;
-	ad.data.type = val;
-	ad.data.data = data;
+	ad_clear_data(type);
+	ad.data[type].valid = true;
+	ad.data[type].type = val;
+	ad.data[type].data = data;
 
-	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Data");
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							prop_names.data[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
 
-void ad_disable_data(DBusConnection *conn)
+void ad_disable_data(DBusConnection *conn, int type)
 {
-	if (!ad.data.type && !ad.data.data.len)
+	if (!ad.data[type].type && !ad.data[type].data.len)
 		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 
-	ad_clear_data();
-	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE, "Data");
+	ad_clear_data(type);
+	g_dbus_emit_property_changed(conn, AD_PATH, AD_IFACE,
+							prop_names.data[type]);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
diff --git a/client/advertising.h b/client/advertising.h
index 145ac80..9d124c7 100644
--- a/client/advertising.h
+++ b/client/advertising.h
@@ -8,15 +8,24 @@
  *
  */
 
+#define AD_TYPE_AD	0
+#define AD_TYPE_SRD	1
+#define AD_TYPE_COUNT	2
+
 void ad_register(DBusConnection *conn, GDBusProxy *manager, const char *type);
 void ad_unregister(DBusConnection *conn, GDBusProxy *manager);
 
-void ad_advertise_uuids(DBusConnection *conn, int argc, char *argv[]);
-void ad_disable_uuids(DBusConnection *conn);
-void ad_advertise_service(DBusConnection *conn, int argc, char *argv[]);
-void ad_disable_service(DBusConnection *conn);
-void ad_advertise_manufacturer(DBusConnection *conn, int argc, char *argv[]);
-void ad_disable_manufacturer(DBusConnection *conn);
+void ad_advertise_uuids(DBusConnection *conn, int type, int argc, char *argv[]);
+void ad_disable_uuids(DBusConnection *conn, int type);
+void ad_advertise_solicit(DBusConnection *conn, int type,
+							int argc, char *argv[]);
+void ad_disable_solicit(DBusConnection *conn, int type);
+void ad_advertise_service(DBusConnection *conn, int type,
+							int argc, char *argv[]);
+void ad_disable_service(DBusConnection *conn, int type);
+void ad_advertise_manufacturer(DBusConnection *conn, int type,
+							int argc, char *argv[]);
+void ad_disable_manufacturer(DBusConnection *conn, int type);
 void ad_advertise_tx_power(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_name(DBusConnection *conn, bool value);
 void ad_advertise_appearance(DBusConnection *conn, bool value);
@@ -24,8 +33,8 @@ void ad_advertise_local_name(DBusConnection *conn, const char *name);
 void ad_advertise_local_appearance(DBusConnection *conn, long int *value);
 void ad_advertise_duration(DBusConnection *conn, long int *value);
 void ad_advertise_timeout(DBusConnection *conn, long int *value);
-void ad_advertise_data(DBusConnection *conn, int argc, char *argv[]);
-void ad_disable_data(DBusConnection *conn);
+void ad_advertise_data(DBusConnection *conn, int type, int argc, char *argv[]);
+void ad_disable_data(DBusConnection *conn, int type);
 void ad_advertise_discoverable(DBusConnection *conn, dbus_bool_t *value);
 void ad_advertise_discoverable_timeout(DBusConnection *conn, long int *value);
 void ad_advertise_secondary(DBusConnection *conn, const char *value);
diff --git a/client/bluetoothctl-advertise.rst b/client/bluetoothctl-advertise.rst
index 4b56324..008f800 100644
--- a/client/bluetoothctl-advertise.rst
+++ b/client/bluetoothctl-advertise.rst
@@ -31,6 +31,12 @@ Set/Get advertise uuids.
 :Example: **# uuids 0x12345678**
 :Example: **# uuids 90f95193-35de-4306-a6e9-699328f15059**
 
+solicit
+-------
+
+Set/Get advertise solicit uuids.
+:Usage: **# solicit [all/uuid1 uuid2 ...]**
+
 service
 -------
 
@@ -71,6 +77,39 @@ To get the currently set data use the command data without any arguments.
 :Usage: **# data [type] [data=xx xx ...]**
 :Example: **# data 0x0C 01 0x0F 13**
 
+sr-uuids
+--------
+
+Set/Get scan response uuids.
+
+:Usage: **# sr-uuids [all/uuid1 uuid2 ...]**
+
+sr-solicit
+----------
+
+Set/Get scan response solicit uuids.
+:Usage: **# sr-solicit [all/uuid1 uuid2 ...]**
+
+sr-service
+----------
+
+Set/Get scan response service data.
+
+:Usage: **# sr-service [uuid] [data=xx xx ...]**
+
+sr-manufacturer
+---------------
+
+Set/Get scan response manufacturer data.
+
+:Usage: **# sr-manufacturer [id] [data=xx xx ...]**
+
+sr-data
+-------
+
+Set/Get scan response data.
+:Usage: **# sr-data [type] [data=xx xx ...]**
+
 discoverable
 ------------
 
diff --git a/client/main.c b/client/main.c
index 3f8143d..3485e1a 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2538,22 +2538,52 @@ static char *ad_generator(const char *text, int state)
 
 static void cmd_advertise_uuids(int argc, char *argv[])
 {
-	ad_advertise_uuids(dbus_conn, argc, argv);
+	ad_advertise_uuids(dbus_conn, AD_TYPE_AD, argc, argv);
+}
+
+static void cmd_advertise_solicit(int argc, char *argv[])
+{
+	ad_advertise_solicit(dbus_conn, AD_TYPE_AD, argc, argv);
 }
 
 static void cmd_advertise_service(int argc, char *argv[])
 {
-	ad_advertise_service(dbus_conn, argc, argv);
+	ad_advertise_service(dbus_conn, AD_TYPE_AD, argc, argv);
 }
 
 static void cmd_advertise_manufacturer(int argc, char *argv[])
 {
-	ad_advertise_manufacturer(dbus_conn, argc, argv);
+	ad_advertise_manufacturer(dbus_conn, AD_TYPE_AD, argc, argv);
 }
 
 static void cmd_advertise_data(int argc, char *argv[])
 {
-	ad_advertise_data(dbus_conn, argc, argv);
+	ad_advertise_data(dbus_conn, AD_TYPE_AD, argc, argv);
+}
+
+static void cmd_advertise_sr_uuids(int argc, char *argv[])
+{
+	ad_advertise_uuids(dbus_conn, AD_TYPE_SRD, argc, argv);
+}
+
+static void cmd_advertise_sr_solicit(int argc, char *argv[])
+{
+	ad_advertise_solicit(dbus_conn, AD_TYPE_SRD, argc, argv);
+}
+
+static void cmd_advertise_sr_service(int argc, char *argv[])
+{
+	ad_advertise_service(dbus_conn, AD_TYPE_SRD, argc, argv);
+}
+
+static void cmd_advertise_sr_manufacturer(int argc, char *argv[])
+{
+	ad_advertise_manufacturer(dbus_conn, AD_TYPE_SRD, argc, argv);
+}
+
+static void cmd_advertise_sr_data(int argc, char *argv[])
+{
+	ad_advertise_data(dbus_conn, AD_TYPE_SRD, argc, argv);
 }
 
 static void cmd_advertise_discoverable(int argc, char *argv[])
@@ -2753,22 +2783,52 @@ static void cmd_advertise_rsi(int argc, char *argv[])
 
 static void ad_clear_uuids(void)
 {
-	ad_disable_uuids(dbus_conn);
+	ad_disable_uuids(dbus_conn, AD_TYPE_AD);
+}
+
+static void ad_clear_solicit(void)
+{
+	ad_disable_solicit(dbus_conn, AD_TYPE_AD);
 }
 
 static void ad_clear_service(void)
 {
-	ad_disable_service(dbus_conn);
+	ad_disable_service(dbus_conn, AD_TYPE_AD);
 }
 
 static void ad_clear_manufacturer(void)
 {
-	ad_disable_manufacturer(dbus_conn);
+	ad_disable_manufacturer(dbus_conn, AD_TYPE_AD);
 }
 
 static void ad_clear_data(void)
 {
-	ad_disable_data(dbus_conn);
+	ad_disable_data(dbus_conn, AD_TYPE_AD);
+}
+
+static void ad_clear_sr_uuids(void)
+{
+	ad_disable_uuids(dbus_conn, AD_TYPE_SRD);
+}
+
+static void ad_clear_sr_solicit(void)
+{
+	ad_disable_solicit(dbus_conn, AD_TYPE_SRD);
+}
+
+static void ad_clear_sr_service(void)
+{
+	ad_disable_service(dbus_conn, AD_TYPE_SRD);
+}
+
+static void ad_clear_sr_manufacturer(void)
+{
+	ad_disable_manufacturer(dbus_conn, AD_TYPE_SRD);
+}
+
+static void ad_clear_sr_data(void)
+{
+	ad_disable_data(dbus_conn, AD_TYPE_SRD);
 }
 
 static void ad_clear_tx_power(void)
@@ -2819,9 +2879,15 @@ static void ad_clear_interval(void)
 
 static const struct clear_entry ad_clear[] = {
 	{ "uuids",		ad_clear_uuids },
+	{ "solicit",		ad_clear_solicit },
 	{ "service",		ad_clear_service },
 	{ "manufacturer",	ad_clear_manufacturer },
 	{ "data",		ad_clear_data },
+	{ "sr-uuids",		ad_clear_sr_uuids },
+	{ "sr-solicit",		ad_clear_sr_solicit },
+	{ "sr-service",		ad_clear_sr_service },
+	{ "sr-manufacturer",	ad_clear_sr_manufacturer },
+	{ "sr-data",		ad_clear_sr_data },
 	{ "tx-power",		ad_clear_tx_power },
 	{ "name",		ad_clear_name },
 	{ "appearance",		ad_clear_appearance },
@@ -2922,6 +2988,8 @@ static const struct bt_shell_menu advertise_menu = {
 	.entries = {
 	{ "uuids", "[uuid1 uuid2 ...]", cmd_advertise_uuids,
 			"Set/Get advertise uuids" },
+	{ "solicit", "[uuid1 uuid2 ...]", cmd_advertise_solicit,
+			"Set/Get advertise solicit uuids" },
 	{ "service", "[uuid] [data=xx xx ...]", cmd_advertise_service,
 			"Set/Get advertise service data" },
 	{ "manufacturer", "[id] [data=xx xx ...]",
@@ -2929,6 +2997,17 @@ static const struct bt_shell_menu advertise_menu = {
 			"Set/Get advertise manufacturer data" },
 	{ "data", "[type] [data=xx xx ...]", cmd_advertise_data,
 			"Set/Get advertise data" },
+	{ "sr-uuids", "[uuid1 uuid2 ...]", cmd_advertise_sr_uuids,
+			"Set/Get scan response uuids" },
+	{ "sr-solicit", "[uuid1 uuid2 ...]", cmd_advertise_sr_solicit,
+			"Set/Get scan response solicit uuids" },
+	{ "sr-service", "[uuid] [data=xx xx ...]", cmd_advertise_sr_service,
+			"Set/Get scan response service data" },
+	{ "sr-manufacturer", "[id] [data=xx xx ...]",
+			cmd_advertise_sr_manufacturer,
+			"Set/Get scan response manufacturer data" },
+	{ "sr-data", "[type] [data=xx xx ...]", cmd_advertise_sr_data,
+			"Set/Get scan response data" },
 	{ "discoverable", "[on/off]", cmd_advertise_discoverable,
 			"Set/Get advertise discoverable" },
 	{ "discoverable-timeout", "[seconds]",
-- 
2.39.5

