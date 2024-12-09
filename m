Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4572319AA63
	for <linux-bluetooth@vger.kernel.org>; Mon,  9 Dec 2024 20:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733777931; cv=none; b=lRdAX1ZDBkSQOyEQ+QYYm/ecv8YxT69kAHFLYFexv3twE7E5RF04Zwj9tlO/bd9PlOqaWwdyKcGD8GCpM/bRzm9VQlZchMfOhENJbskikHHlIFXdnuN35LMRin8+jbwYCqFvUMw8d8kZv1dexFs9fuLJqE9R1Xq6b97kKuzm6zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733777931; c=relaxed/simple;
	bh=S7gQYM/Op0F+uU3QgA7rDPFpJw9qEcuHXsqg49KFSYQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GiXpGFMVBWfNALsr6q1oWMMz1/Be/5xEa0t+07fvN+u8PuuqpbcbcjTvyKN2PChyR3hyxNktdMCNx5q3mseq2l+sHsrGkh9UaFrLZYgO6QjByuGC9bYL8fxFXB6XaT4SRizcA8aGxBwnyRZZG00TGutmxHakt213p+dXuT6ereU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IOdr1Q+o; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IOdr1Q+o"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e3a26de697fso1676744276.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Dec 2024 12:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733777927; x=1734382727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X2S5S1i4ryt7vfT0CYbROzGaWy7EJyhEKdAnCABifqg=;
        b=IOdr1Q+ogN2/sAZmWP4xXq9EAH8qr7sB9KpzfvqDt9/iYRQQAILixdbFbgDTzyGtQL
         U7L05OSt3g9sxnLVG308+izkzCiK5YK58hEqFDGIF6iEo8DE1ZVJXk9DX3nLYd5+13sK
         KjrRQnw59dj24fxzxyhvaidZSZeg25t2SDyWyAEC7N0TOwb9Td4KN5oTpdNHfEdNfzaG
         3hyMf9qEvVumInHKF2Z8ZSKhF+AlgQGrY/rQQNmyGYA+ipQHo1tdIh7z0hqU7Ft82zNv
         eSYSlKc7CedHFC+EuNox0nxTZTKwHC2a5CK+OC1FMXy96MBnQzVJmIIKaLMZY5Z4/Lwi
         NwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733777927; x=1734382727;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X2S5S1i4ryt7vfT0CYbROzGaWy7EJyhEKdAnCABifqg=;
        b=RUNBkO9iVEZ7G3QsDX/FuF/sGZV0btzcdDvorh821LjNRfGIUOy7XE+Wf9J9hP5TOI
         JYrJMEtNSLKvN5tqq0Su1W+gCyCPwXKfhSWHILk4rJj8hDgJVOxociaF6os5T/QYTohJ
         TSibB0aOgOp5gVUygmL7yEJoPS7ErI+BQ10F2Wq6D/3QREJ7UjKbbn/1b6GdQFGW7ADS
         B3307sBWWLcBQLDd4zjzxmLVFqCYz4wnO0mwBY9eSFdsi6bAPgtlyQbD2pXDvIsMcUve
         bCSe73/JtZbK8DFpS4QJXRMYu/tq4UTF/6oXbvchUPIT5z7BcBvKfk/JPmS9pWHir49Q
         PP5A==
X-Gm-Message-State: AOJu0YzHhLZ3rut0iZWt/pd+J791XmGPxK91XiQEGkmnJNy9vRKmv7bY
	Z8uxVsxhAd3+TZk7r4qDtdzBMMGW2RDtHRTVRNUubzrsiRoaUEu5jr5xRQ==
X-Gm-Gg: ASbGncu+mtCBQ5AjmZpL8H4sGGwT+bdu/7yzkzN8/B0SpRkDFvOgCjTQrANSPwiXDoJ
	xtNANCBwC9wTCuVt2GZZLBEJ71B+Kuw9pRcpGMjWlM7hb48ENeInujrnr7K4boSxMGOyB0EBQvh
	MDIMk4EpcMTzo5jz7YrAE6PdzD7OzwMOzyyZq5ftrjKXNMUmZBGXbXK3IAgDAgrE9UZmaIYSHuS
	vGH0cZwdBG583spe/Dt1pGA6LOLOTwPWbRr5Nx4qyS+fycZ5u9aNlO38n3Sjd6Ey/xslrnNpBW4
	BK13XHT59NHoF5lVoZu7SAR+bQ==
X-Google-Smtp-Source: AGHT+IHdaI5cANxAMjnRBlzkS3IbeExFqJdERkHIulhlOJtShz8YHUiCGvarVcw8lWVx7h0CV1DGcw==
X-Received: by 2002:a05:6902:72b:b0:e38:8ded:b008 with SMTP id 3f1490d57ef6-e3a59afe897mr2272119276.13.1733777927519;
        Mon, 09 Dec 2024 12:58:47 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e39f6a42f31sm2556098276.4.2024.12.09.12.58.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 12:58:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/3] main.conf: Add GATT.ExportClaimedServices
Date: Mon,  9 Dec 2024 15:58:42 -0500
Message-ID: <20241209205843.1394081-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241209205843.1394081-1-luiz.dentz@gmail.com>
References: <20241209205843.1394081-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds GATT.ExportClaimedService which can be used to allow access to
service under control of bluetoothd(1) since often times it should be
safe to allow read-only access as it shouldn't interfere with each
other, but this one step further and allow the systems to be configured
with read-write as well just in case some sort of workaround is needed,
or for debugging purposes.

Since this is now a proper system policy this removes the expections from
battery and deviceinfo introduced by 713f6f09f017
("profile: Add exception to battery profile for external access") and
0cef5a7996db ("deviceinfo: Enable external flag").
---
 profiles/battery/battery.c       |  1 -
 profiles/deviceinfo/deviceinfo.c |  1 -
 src/btd.h                        |  7 ++++++
 src/gatt-client.c                | 37 ++++++++++++++++++++++++++++++--
 src/main.c                       | 30 ++++++++++++++++++++++++++
 src/main.conf                    |  5 +++++
 6 files changed, 77 insertions(+), 4 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 02d024d927ec..5318d40d12b4 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -327,7 +327,6 @@ static struct btd_profile batt_profile = {
 	.device_remove	= batt_remove,
 	.accept		= batt_accept,
 	.disconnect	= batt_disconnect,
-	.external	= true,
 };
 
 static int batt_init(void)
diff --git a/profiles/deviceinfo/deviceinfo.c b/profiles/deviceinfo/deviceinfo.c
index b6dc0ab2e207..0cdf2947e0a3 100644
--- a/profiles/deviceinfo/deviceinfo.c
+++ b/profiles/deviceinfo/deviceinfo.c
@@ -138,7 +138,6 @@ static int deviceinfo_disconnect(struct btd_service *service)
 static struct btd_profile deviceinfo_profile = {
 	.name		= "deviceinfo",
 	.remote_uuid	= DEVICE_INFORMATION_UUID,
-	.external	= true,
 	.device_probe	= deviceinfo_probe,
 	.device_remove	= deviceinfo_remove,
 	.accept		= deviceinfo_accept,
diff --git a/src/btd.h b/src/btd.h
index 07205aa69486..a443f66f6cd8 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -42,6 +42,12 @@ enum sc_mode_t {
 	SC_ONLY,
 };
 
+enum bt_gatt_export_t {
+	BT_GATT_EXPORT_OFF,
+	BT_GATT_EXPORT_READ_ONLY,
+	BT_GATT_EXPORT_READ_WRITE,
+};
+
 struct btd_br_defaults {
 	uint16_t	page_scan_type;
 	uint16_t	page_scan_interval;
@@ -147,6 +153,7 @@ struct btd_opts {
 	uint16_t	gatt_mtu;
 	uint8_t		gatt_channels;
 	bool		gatt_client;
+	enum bt_gatt_export_t gatt_export;
 	enum mps_mode_t	mps;
 
 	struct btd_avdtp_opts avdtp;
diff --git a/src/gatt-client.c b/src/gatt-client.c
index a67e04eee81e..6f22bbb490a7 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -66,6 +66,7 @@ struct btd_gatt_client {
 struct service {
 	struct btd_gatt_client *client;
 	bool primary;
+	bool claimed;
 	uint16_t start_handle;
 	uint16_t end_handle;
 	bt_uuid_t uuid;
@@ -616,6 +617,14 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 	if (parse_options(&iter, &offset, NULL))
 		return btd_error_invalid_args(msg);
 
+	/*
+	 * Check if service was previously claimed by a plugin and if we shall
+	 * consider it read-only, in that case return not authorized.
+	 */
+	if (desc->chrc->service->claimed &&
+			btd_opts.gatt_export == BT_GATT_EXPORT_READ_ONLY)
+		return btd_error_not_authorized(msg);
+
 	/*
 	 * Don't allow writing to Client Characteristic Configuration
 	 * descriptors. We achieve this through the StartNotify and StopNotify
@@ -1046,6 +1055,14 @@ static DBusMessage *characteristic_write_value(DBusConnection *conn,
 	if (parse_options(&iter, &offset, &type))
 		return btd_error_invalid_args(msg);
 
+	/*
+	 * Check if service was previously claimed by a plugin and if we shall
+	 * consider it read-only, in that case return not authorized.
+	 */
+	if (chrc->service->claimed &&
+			btd_opts.gatt_export == BT_GATT_EXPORT_READ_ONLY)
+		return btd_error_not_authorized(msg);
+
 	/*
 	 * Decide which write to use based on characteristic properties. For now
 	 * we don't perform signed writes since gatt-client doesn't support them
@@ -1295,6 +1312,14 @@ static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
 	if (!gatt)
 		return btd_error_failed(msg, "Not connected");
 
+	/*
+	 * Check if service was previously claimed by a plugin and if we shall
+	 * consider it read-only, in that case return not authorized.
+	 */
+	if (chrc->service->claimed &&
+			btd_opts.gatt_export == BT_GATT_EXPORT_READ_ONLY)
+		return btd_error_not_authorized(msg);
+
 	if (chrc->write_io)
 		return btd_error_not_permitted(msg, "Write acquired");
 
@@ -1954,6 +1979,7 @@ static struct service *service_create(struct gatt_db_attribute *attr,
 	service->chrcs = queue_new();
 	service->incl_services = queue_new();
 	service->client = client;
+	service->claimed = gatt_db_service_get_claimed(attr);
 
 	gatt_db_attribute_get_service_data(attr, &service->start_handle,
 							&service->end_handle,
@@ -2097,8 +2123,15 @@ static void export_service(struct gatt_db_attribute *attr, void *user_data)
 	struct btd_gatt_client *client = user_data;
 	struct service *service;
 
-	if (gatt_db_service_get_claimed(attr))
-		return;
+	if (gatt_db_service_get_claimed(attr)) {
+		switch (btd_opts.gatt_export) {
+		case BT_GATT_EXPORT_OFF:
+			return;
+		case BT_GATT_EXPORT_READ_ONLY:
+		case BT_GATT_EXPORT_READ_WRITE:
+			break;
+		}
+	}
 
 	service = service_create(attr, client);
 	if (!service)
diff --git a/src/main.c b/src/main.c
index 41c3271a7457..b92b22e41d4c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -148,6 +148,7 @@ static const char *gatt_options[] = {
 	"ExchangeMTU",
 	"Channels",
 	"Client",
+	"ExportClaimedServices",
 	NULL
 };
 
@@ -1066,6 +1067,33 @@ static void parse_gatt_cache(GKeyFile *config)
 	g_free(str);
 }
 
+static enum bt_gatt_export_t parse_gatt_export_str(const char *str)
+{
+	if (!strcmp(str, "no") || !strcmp(str, "false") ||
+				!strcmp(str, "off")) {
+		return BT_GATT_EXPORT_OFF;
+	} else if (!strcmp(str, "read-only")) {
+		return BT_GATT_EXPORT_READ_ONLY;
+	} else if (!strcmp(str, "read-write")) {
+		return BT_GATT_EXPORT_READ_WRITE;
+	}
+
+	DBG("Invalid value for ExportClaimedServices=%s", str);
+	return BT_GATT_EXPORT_READ_ONLY;
+}
+
+static void parse_gatt_export(GKeyFile *config)
+{
+	char *str = NULL;
+
+	parse_config_string(config, "GATT", "ExportClaimedServices", &str);
+	if (!str)
+		return;
+
+	btd_opts.gatt_export = parse_gatt_export_str(str);
+	g_free(str);
+}
+
 static void parse_gatt(GKeyFile *config)
 {
 	parse_gatt_cache(config);
@@ -1075,6 +1103,7 @@ static void parse_gatt(GKeyFile *config)
 	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
 				1, 5);
 	parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client);
+	parse_gatt_export(config);
 }
 
 static void parse_csis_sirk(GKeyFile *config)
@@ -1219,6 +1248,7 @@ static void init_defaults(void)
 	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
 	btd_opts.gatt_channels = 1;
 	btd_opts.gatt_client = true;
+	btd_opts.gatt_export = BT_GATT_EXPORT_READ_ONLY;
 
 	btd_opts.avdtp.session_mode = BT_IO_MODE_BASIC;
 	btd_opts.avdtp.stream_mode = BT_IO_MODE_BASIC;
diff --git a/src/main.conf b/src/main.conf
index fff13ed2ff31..80e72e18f749 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -262,6 +262,11 @@
 # Default to 1
 #Channels = 1
 
+# Export claimed services by plugins
+# Possible values: no, read-only, read-write
+# Default: read-only
+#ExportClaimedServices = read-only
+
 [CSIS]
 # SIRK - Set Identification Resolution Key which is common for all the
 # sets. They SIRK key is used to identify its sets. This can be any
-- 
2.47.1

