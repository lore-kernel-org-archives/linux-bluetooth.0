Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD27D16BE17
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 16:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997125; cv=none; b=Da5WATeHi0GAor8yS0uPeLUnBWJD5he0SN/i1nfMkcxTrOZPaTBH7HQdIdxvHc4Mahhb9URCGn0JBRGJAmWTImUzjz1r3A95k/11H7GTjOYgM+PNMIuv0ECJavVXG5aZGK35ls1gzfjWexJrRJH+fLlwAB34qXIBzrQIII2qAhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997125; c=relaxed/simple;
	bh=eFirWf/afuKiUP+3Xrhi9lXyWVCKOWVUECl7ccbL5c0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mbBsaEV4AirywGEkg0ZbO55/x0d4Lm/cWxl2tHaEY/QhvWGd8N+z+OOwdWLeioa5XsL9UUxmXH6Kg8xhOjq7w4C5lE++cFj32dgyCumKU6pfXIHRzTCnn+mtmaub3slQPKyxgNDSk3VVycTrCt/vLsS9CFSqqkytbeJviJOcdc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpYJA2Za; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpYJA2Za"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-724a5d042c0so2381322a34.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 08:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737997121; x=1738601921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fGH94CUUeiMNu2lLaPT+eQOMS9znh+baxUtidGvrw5Y=;
        b=HpYJA2ZaJFfMWKVAf7Arh+YWvjBAC4xurGbzWWkkOrDI6re43Z9EmtXZ7/To4CVati
         eniqQhrSTM2MjlhjXul7eKMjtgG4uGk2be/sy/Gx8oYov3/Kyh8cf245x7bSmuH9vM9L
         DrGl4Usgi+VKw50gFX2+iCKeOfC26JMHHcmsP0mBafGTThyCg6WjITcnoZqrbMw7wyei
         joLG+vByUTHJ5DWH8awMPjBBy8PY+Wq72P3DZm7cLuwEcv45F/5SQzEK630ospjpqpiw
         IHyohjQwvH7l9nYUkcXIF/IUZ+5Y3jjniP3D47aXAxybuqIc0NL42WUJ44e2vuE3u6ma
         FHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997121; x=1738601921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fGH94CUUeiMNu2lLaPT+eQOMS9znh+baxUtidGvrw5Y=;
        b=ezXsfJS7eqiIDrHaYuIjUcITHCtCPJYSLbpiZfVYUYNN2gi5A1CuHT6AeFt+RR2PGX
         h7eP31rLFW9AEA7cUiP/sd+dRw4NjiAeVmi/t1YD9XS/0YU8hwrKbTe2sQcSgshZrjCl
         ojs6t2/hekReTnZ+FPptra+N4xGI2vtXb5bKfLR8fGUaWtPpFgZiN+tcKQuYflI+F3bO
         PQVKF3+YMPSx1l9jGG4nNi41IkNYHhRzSPpaF8zzZIUgtW8V061arapHq5EExuDp/QjF
         vxJZzBOoKWd+icTEkd8J9jio2g2Nt+NnkSTRkhgeEOZ9lbsoBLS68lbRHknsE7rWq161
         DMEA==
X-Gm-Message-State: AOJu0Yy5/027wvvkuyv09avzckNvdud9c85gL8p/ilx8YaTIGSW2s0Km
	c4yKJxYtSgye9BGrV0kHglq61R2hHkYXuexjdO6begEWHofqieu1fbhirQmo
X-Gm-Gg: ASbGncsyomz0hRr6IvARtCD5Q/sMSm+z/c807h+PjRS10WI9axzwq1e8+pJd2HiYSGo
	Lq2KB2eOJjMJYNjvkZ5auJLvuLdQf84VekAGeogjAiWsLk0UvLx2WEXOl4nITkrRH7k8jVQd4GO
	TJr13eXIHJqbPvdiwQavCa4tKPAyrw1BGrOKyr6pED/NuTxOkxWFSWGMd3oxjJ9nCi/NpjZAW2u
	B4Mwyhn4Ysl08rW9Fk8PjD4j917vaAj5v8iCt0n69LNdGY1VfsWuLIYSsI7G3HFkesSyMS6MMMh
	gp6nS6jW5sRKCGhdK5q1o5MM1jOAZBGTIEh38QEjBoI9joFEkBI8
X-Google-Smtp-Source: AGHT+IEXEILu8eg1yalHo50gUmE1uew8aPPCzrqaq6FXlBZ88Wlr1mfI9tymjrMKtEy1xbxDbrIIDQ==
X-Received: by 2002:a05:6830:6e06:b0:71e:1ca5:fc94 with SMTP id 46e09a7af769-7249dafe3bbmr26401703a34.28.1737997120853;
        Mon, 27 Jan 2025 08:58:40 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecf88fd0sm2294827a34.47.2025.01.27.08.58.39
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:58:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] advertising: Add scan response support in bluetoothctl
Date: Mon, 27 Jan 2025 11:58:33 -0500
Message-ID: <20250127165833.866133-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250127165833.866133-1-luiz.dentz@gmail.com>
References: <20250127165833.866133-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yuxin Wang <yuxinwang9999@gmail.com>

Add commands in the bluetoothctl advertising submenu to manage
scan response data.
---
 client/advertising.c              | 488 +++++++++++++++++++++++-------
 client/advertising.h              |  25 +-
 client/bluetoothctl-advertise.rst |  39 +++
 client/main.c                     |  95 +++++-
 4 files changed, 516 insertions(+), 131 deletions(-)

diff --git a/client/advertising.c b/client/advertising.c
index 4a98121a4f93..382ae420e663 100644
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
 }
 
-static void print_ad_uuids(void)
+static const struct {
+	const char *uuid[AD_TYPE_COUNT];
+	const char *solicit[AD_TYPE_COUNT];
+	const char *service[AD_TYPE_COUNT];
+	const char *manufacturer[AD_TYPE_COUNT];
+	const char *data[AD_TYPE_COUNT];
+} ad_names = {
+	.uuid = { "UUID", "Scan Response UUID" },
+	.solicit = { "Solicit UUID", "Scan Response Solicit UUID" },
+	.service = { "UUID", "Scan Response UUID" },
+	.manufacturer = { "Manufacturer", "Scan Response Manufacturer" },
+	.data = { "Data", "Scan Response Data" }
+};
+
+static void print_ad_uuids(int type)
 {
 	char **uuid;
 
-	for (uuid = ad.uuids; uuid && *uuid; uuid++)
-		print_uuid(*uuid);
+	for (uuid = ad.uuids[type]; uuid && *uuid; uuid++)
+		print_uuid(ad_names.uuid[type], *uuid);
+}
+
+static void print_ad_solicit(int type)
+{
+	char **uuid;
+
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
+					ad.service[type].uuid);
+			bt_shell_hexdump(ad.service[type].data.data,
+						ad.service[type].data.len);
+		}
 
-	if (ad.data.valid) {
-		bt_shell_printf("Data Type: 0x%02x\n", ad.data.type);
-		bt_shell_hexdump(ad.data.data.data, ad.data.data.len);
+		if (ad.manufacturer[type].data.len) {
+			bt_shell_printf("%s: %u\n", ad_names.manufacturer[type],
+						ad.manufacturer[type].id);
+			bt_shell_hexdump(ad.manufacturer[type].data.data,
+						ad.manufacturer[type].data.len);
+		}
+
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
-								void *data)
+static gboolean ad_uuids_exists(const GDBusPropertyTable *property, void *data)
 {
-	return ad.service.uuid != NULL;
+	return uuids_exists(AD_TYPE_AD, property, data);
 }
 
-static gboolean get_service_data(const GDBusPropertyTable *property,
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
+								void *data)
+{
+	return solicit_uuids_exists(AD_TYPE_SRD, property, data);
+}
+
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
+	const char *uuid[AD_TYPE_COUNT];
+	const char *solicit[AD_TYPE_COUNT];
+	const char *service[AD_TYPE_COUNT];
+	const char *manufacturer[AD_TYPE_COUNT];
+	const char *data[AD_TYPE_COUNT];
+} prop_names = {
+	.uuid = { "ServiceUUIDs", "ScanResponseServiceUUIDs" },
+	.solicit = { "SolicitUUIDs", "ScanResponseSolicitUUIDs" },
+	.service = { "ServiceData", "ScanResponseServiceData" },
+	.manufacturer = { "ManufacturerData", "ScanResponseManufacturerData" },
+	.data = { "Data", "ScanResponseData" }
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
index 145ac80452d2..9d124c7af83d 100644
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
index 226ec6605372..52422bc3571a 100644
--- a/client/bluetoothctl-advertise.rst
+++ b/client/bluetoothctl-advertise.rst
@@ -31,6 +31,12 @@ Set/Get advertise uuids.
 :Example: **> uuids 0x12345678**
 :Example: **> uuids 90f95193-35de-4306-a6e9-699328f15059**
 
+solicit
+-------
+
+Set/Get advertise solicit uuids.
+:Usage: **# solicit [all/uuid1 uuid2 ...]**
+
 service
 -------
 
@@ -71,6 +77,39 @@ To get the currently set data use the command data without any arguments.
 :Usage: **> data [type] [data=xx xx ...]**
 :Example: **> data 0x0C 01 0x0F 13**
 
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
index 322326ab9b80..feb21a1163d2 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2575,22 +2575,52 @@ static char *ad_generator(const char *text, int state)
 
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
@@ -2790,22 +2820,52 @@ static void cmd_advertise_rsi(int argc, char *argv[])
 
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
@@ -2856,9 +2916,15 @@ static void ad_clear_interval(void)
 
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
@@ -2959,6 +3025,8 @@ static const struct bt_shell_menu advertise_menu = {
 	.entries = {
 	{ "uuids", "[uuid1 uuid2 ...]", cmd_advertise_uuids,
 			"Set/Get advertise uuids" },
+	{ "solicit", "[uuid1 uuid2 ...]", cmd_advertise_solicit,
+			"Set/Get advertise solicit uuids" },
 	{ "service", "[uuid] [data=xx xx ...]", cmd_advertise_service,
 			"Set/Get advertise service data" },
 	{ "manufacturer", "[id] [data=xx xx ...]",
@@ -2966,6 +3034,17 @@ static const struct bt_shell_menu advertise_menu = {
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
2.48.1

