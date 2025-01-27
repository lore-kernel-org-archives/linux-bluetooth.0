Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3DF015B99E
	for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737997122; cv=none; b=SaaQI2NTL2u1npbr79+ZMyeA0jeiPbdy1q0Y4MelO1vjBnZAoc8Hdf8ErJmgEHBXdBn4vEM4IpZ9Mq7oq+UC3SwDXPA7ErpUAeKzGVZ6eGgplMsJSAZCKR9vOVZ7GNMDjA7gNJC8e+Jum/0YO65GYhOsCz3FmoJCpeel9J0rpB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737997122; c=relaxed/simple;
	bh=qsvefXJsOjNPK/FiYhgY00NP0b0IxxpSWOZ3jAE8Qa4=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H/F+od5mGvLIe8FvOMptnaXy1/tB3sK3WBBE++vrIIftS+ub+LuejUaW4k9vlmIkijNA7a/RXonEPzsS1Ae6jJZYzZU6EchqFn0HiqGmMPQJ10SxdZmyrCuv/sK0oHtfZum7ocXlt1lkoatUIxS+pwDMunx+dKrVlC/ZOiZP8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2APZ4Or; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2APZ4Or"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2adc2b6837eso1317159fac.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Jan 2025 08:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737997119; x=1738601919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7tJPu5shhntk9vUea5NwO8hZYCbmNWjhdH5Ho2rBRQY=;
        b=R2APZ4Or8eoUj1qCAUvPf+p6Tybb3xN4Bu7JXKdKJbnGKcmKiP6LKwt2FAo7Ojy6G2
         dmhBltbNXZoj8fx+NcRlcA2jgGxcOQvjhKi4SiftkgtVA1pOSDcCih5shq9qtZXsP4aR
         nv/Kn4ASaa1cahruf+6QGYrbO0/7K4Cmiqn5eCelPlJw2IEbxn/SN+7GPMW1vi1y8FgD
         Jv1vd2CLCDGoobMtxYaUvbmN4hwTV8896X7osKACmqDF+EZOgIcx9YG7107MEFDuvXrK
         ZZqnjxlDmVvpDw7w0u2B4QktbYxzt7uBeHj8f5V+Lpv8omRTnNhhZj11ZcjflkWJUN8j
         9WPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737997119; x=1738601919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7tJPu5shhntk9vUea5NwO8hZYCbmNWjhdH5Ho2rBRQY=;
        b=BeN0p4onCqbSHAoro/4CupKIX25qv+6732co300EyG73otFzPrMK+oi19D88OmZIkD
         VKm6+Rm2b22w3ILvPqAfaue2HrWjknF+RjG6vtNEIZFVeZQjVUKh+kT6130aS4ptMrMw
         aFNIwA7LMcRlzYmbzotSmuUxk4PQ/fU/BwgymztQvr3YlqCElegZsOHOYDePEJFyp5kI
         WrkSw4zYu82UwLZBdhjFClD2b6sJXyu/+18Ph4M9h+u27f5/11srKjbaF1B4Q1znyH+f
         KQn/ZdDHBgjeJYBNybt/xsxdaGK2RAX+35m/OlDTvT0A+q08I/YAjv5xeDisJHlR4krs
         JF/w==
X-Gm-Message-State: AOJu0Yyfct/oBCobFjkuBNiZzCY7IvSKrivxIjVpE7tAT7uzZ6BVbuNC
	83BA9wYferz3Hugv3Hfq/nu3ArkxXBgKLINinUCjqhs36v4YwwgDKOgo9cI+
X-Gm-Gg: ASbGncuQSJseEZUKx2A8jh88lTq0+HHRb6iYKyugkhAYp0Uf+ryUQJ1exQlXlBZk17e
	OwFwznrGzdjY7U2ELgrdaCLL88HL28YggwGCSHPp980voT3Eps3BcRYCVdkegU2rXwkNeg2BckS
	FXc9yoSSaNuoT9/5UMn7hldhHv8z/xxqw1enfes0Ondvjoox2mguUZ8P/fIhIGpaYggVK76xZNd
	Oxw2I+qupDeWyS7o6oGI7hNOOIWf+XwGL9QK0KeynWia92dyi39SNrWyb6sGrDToEVElw56BJ1W
	/xQ5VWxlpPQxaNTRgqGBr40F3vIFHwZzvYrHzqD7YXH2B+UexbkD
X-Google-Smtp-Source: AGHT+IGs8vsgIW1XOw10in8psCVvJZeNOF+tX5vaxwm9ZUuQrr9UQ/z64WSUjeCsc+uipkEnATARCQ==
X-Received: by 2002:a05:6871:880c:b0:29e:67cd:1a8f with SMTP id 586e51a60fabf-2b1c0cdc000mr23151349fac.37.1737997119021;
        Mon, 27 Jan 2025 08:58:39 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-724ecf88fd0sm2294827a34.47.2025.01.27.08.58.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 08:58:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] advertising: Add scan response properties to LEAdvertisement1
Date: Mon, 27 Jan 2025 11:58:32 -0500
Message-ID: <20250127165833.866133-2-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This update introduces a few properties to org.bluez.LEAdvertisement1
for manipulating Scan Response Data, similar to the existing properties
for Advertising Data.

Fixes: https://github.com/bluez/bluez/issues/667
---
 src/advertising.c | 140 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 104 insertions(+), 36 deletions(-)

diff --git a/src/advertising.c b/src/advertising.c
index 2fc6f917dd12..4476d7cd53a5 100644
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
 					struct btd_adv_client *client)
+{
+	return parse_service_uuids(iter, client->data);
+}
+
+static bool parse_service_uuids_sr(DBusMessageIter *iter,
+					struct btd_adv_client *client)
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
 					struct btd_adv_client *client)
+{
+	return parse_manufacturer_data(iter, client->data);
+}
+
+static bool parse_manufacturer_data_sr(DBusMessageIter *iter,
+					struct btd_adv_client *client)
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
 
@@ -1215,18 +1270,24 @@ static bool parse_tx_power(DBusMessageIter *iter,
 static struct adv_parser {
 	const char *name;
 	bool (*func)(DBusMessageIter *iter, struct btd_adv_client *client);
+	bool experimental;
 } parsers[] = {
 	{ "Type", parse_type },
-	{ "ServiceUUIDs", parse_service_uuids },
-	{ "SolicitUUIDs", parse_solicit_uuids },
-	{ "ManufacturerData", parse_manufacturer_data },
-	{ "ServiceData", parse_service_data },
+	{ "ServiceUUIDs", parse_service_uuids_ad },
+	{ "ScanResponseServiceUUIDs", parse_service_uuids_sr, true },
+	{ "SolicitUUIDs", parse_solicit_uuids_ad },
+	{ "ScanResponseSolicitUUIDs", parse_solicit_uuids_sr, true },
+	{ "ManufacturerData", parse_manufacturer_data_ad },
+	{ "ScanResponseManufacturerData", parse_manufacturer_data_sr, true },
+	{ "ServiceData", parse_service_data_ad },
+	{ "ScanResponseServiceData", parse_service_data_sr, true },
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
@@ -1246,6 +1307,13 @@ static void properties_changed(GDBusProxy *proxy, const char *name,
 		if (strcmp(parser->name, name))
 			continue;
 
+		/* Ignore experimental parsers if the experimental flag is not
+		 * set.
+		 */
+		if (parser->experimental && !(g_dbus_get_flags() &
+					G_DBUS_FLAG_ENABLE_EXPERIMENTAL))
+			continue;
+
 		if (parser->func(iter, client)) {
 			refresh_advertisement(client, NULL);
 
-- 
2.48.1

