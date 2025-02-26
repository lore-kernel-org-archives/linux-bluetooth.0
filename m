Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2559D22F163
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593507; cv=none; b=MJiEjMHVug5vt3spBQUbg/kT339HjxAHrvnx0yn8GIcYM1NrQe9N5XnYQNXVw2gXGp8BN8caCSoMD726Rq2ICCMAQ2aTFrP32H9VaLza/sq8XlSD4Ii+8QaX7R4xRyvlV+PflzpGNeeAe60FMUuvZZ9DIMNnU+WsNoEWVJjzpwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593507; c=relaxed/simple;
	bh=4DWOG/7vaA0lA92dINcbsX6inqNXR5xkFYj0PWRSVIQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zu8Sl3RHoNjHyoaScTmmLcdSwFVnciozEZ4+/VuQABfqJk4geGFfyaCrpr8p+HshHScby3jDumNpvJHdKdME7bvlen9EWX6qYDbw+1cH6yW5nfBoAkggNT+A+Ar8yp1b0zf6QQ4CMZDEcubFfH4U8DpdVGXiCg+JZKMSc+3Z0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dhwzab40; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dhwzab40"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-4bd3a8b88f3so71425137.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 10:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593504; x=1741198304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rMFkHd1q6uurURxgZwux7q4Uho1ru3VqXOk3BkRMwEM=;
        b=Dhwzab40h6gaf+UsA9L4w0AF2H8Vg+xGrXTzZL8dle8NguCYfb6F470dt+U2AzYmZb
         B1RjnxAz/yijsETtkPT7jIMh2CJ8kCkft7JBugu0P1Fzgugplg+nmIro6QwjlwllLOuE
         GMSFSdN1NVHcbqB6gdg05xVE7S3sOdh02u3fywMN+nTKuIQK8Z3bBUMXrzSdkaB+bEjz
         aLYMwK/rfH8DvVZv8UMqkQZ8QruQtQ2maFbIAPlvB2AQzrejN+d+0kOr66FHcK4rwYrv
         uZAwBqreWzumIoVJBtuuEOxHKCWRdBVmFiKGkqc8xfccAT6oeGXnLxSN5QK9HVCPvu/0
         IINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593504; x=1741198304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rMFkHd1q6uurURxgZwux7q4Uho1ru3VqXOk3BkRMwEM=;
        b=qYop2f+7vk4UfJdGFG7CZ7AP1o6/Gvyj0cmo0450wq7WpEfhGsexJJh4A6DkQUzxkA
         PFTYmEjC1TftI5jqdfmKizH1WMtf59NWHPPCA3FSJmu4tMBDuiSI41PnJsLXW0/PUxe8
         5HzvqbjArXmyOEWGzMgqxlezXVCMa1K+4YpsWxqc1n9Lfy2pKhWITE4iSoeGCLx55O0v
         mqF7RB4nEQKzFL8BpAEajsC3YhD4niaUswgxo1ObGNgY/qsBZmA5XMoR1cnbOxFtjGsM
         FsBf7pznAk/n9XtASu+HWcIDngea/t8iUVbxeiMNQlJ2gunMabjzxzYyfju+pQWSzvjJ
         zaRQ==
X-Gm-Message-State: AOJu0Yw9EWkJ0gDALFBxnz3QHRkf8AXD4Jc6IiGGKL1GayE4zIMTED3Q
	qpc7QW1MiDNLkzLawZ/I/BWz4hQRmWU9LaJtTGiY/vWw4dTReS5OKruhJUVx
X-Gm-Gg: ASbGncsCkQBc+CsNpHJMDVc7ttDCMeAScxnVP1FGFTEb5j7raeL4jp0JTF3cqiZI+z3
	7LS6m/u2FCIVbuQtnqGkRVhKEXbphxNNhmr9Wv9uwQw5+195qIz88J3sYfuG6ObOnMUAsAILYaD
	N/d2M3sywDaSvRuQd/YpLcbQZIJXm9oxCSm3UQE6dHTZMXYQKqfG5gz3ICJ7G1C5/5nkt7017FI
	Nr+yjCIegM4MuP0Wb6gaAWaKZ8AUH4H1NqA/IDKbG7py0uxQgEdunDOYzJowd2gY6WpYdjhayI8
	gmgpe8yZN5eWCAQzPuSi54VH3mQkToyp0j9I2LopeG0HTxdDVnB+clE9qCBxnfv2mphQvPM=
X-Google-Smtp-Source: AGHT+IEZWTm5IJlggfSM24nLJ/c4n/eWB3uVtMelPlurgYxKqEQ5S8m5X/WDtZpHUGFrcYZHmLHrfA==
X-Received: by 2002:a05:6102:32d2:b0:4bb:d64d:8331 with SMTP id ada2fe7eead31-4c01e1ef3cemr3310172137.11.1740593504278;
        Wed, 26 Feb 2025 10:11:44 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ef052a6sm857744241.27.2025.02.26.10.11.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:11:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/4] storage: Add support for storing PreferredBearer
Date: Wed, 26 Feb 2025 13:11:29 -0500
Message-ID: <20250226181129.2958079-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250226181129.2958079-1-luiz.dentz@gmail.com>
References: <20250226181129.2958079-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for storing PreferredBearer into device info file.
---
 doc/settings-storage.txt |  2 ++
 src/device.c             | 66 +++++++++++++++++++++++++++++-----------
 2 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 178e7d07bf11..4e9881eedf02 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -293,6 +293,8 @@ Long term key) related to a remote device.
 			strings		remote in 128-bits UUID format,
 					separated by ";"
 
+  PreferredBearer	String		Preferred bearer for remote device
+
 
 [DeviceID] group contains:
 
diff --git a/src/device.c b/src/device.c
index de92e68d2780..9219eb674f87 100644
--- a/src/device.c
+++ b/src/device.c
@@ -368,10 +368,25 @@ static GSList *find_service_with_uuid(GSList *list, char *uuid)
 	return NULL;
 }
 
+static const char *device_prefer_bearer_str(struct btd_device *device)
+{
+	/* Check if both BR/EDR and LE bearer are supported */
+	if (!device->bredr || !device->le)
+		return NULL;
+
+	if (device->bredr_state.prefer)
+		return "bredr";
+	else if (device->le_state.prefer)
+		return "le";
+	else
+		return "last-seen";
+}
+
 static void update_technologies(GKeyFile *file, struct btd_device *dev)
 {
 	const char *list[2];
 	size_t len = 0;
+	const char *bearer;
 
 	if (dev->bredr)
 		list[len++] = "BR/EDR";
@@ -391,6 +406,12 @@ static void update_technologies(GKeyFile *file, struct btd_device *dev)
 
 	g_key_file_set_string_list(file, "General", "SupportedTechnologies",
 								list, len);
+
+	/* Store the PreferredBearer in case of dual-mode devices */
+	bearer = device_prefer_bearer_str(dev);
+	if (bearer)
+		g_key_file_set_string(file, "General", "PreferredBearer",
+							bearer);
 }
 
 static void store_csrk(struct csrk_info *csrk, GKeyFile *key_file,
@@ -2080,6 +2101,7 @@ bool btd_device_add_set(struct btd_device *device, bool encrypted,
 static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 {
 	char addr[18];
+	const char *bearer;
 
 	if (!device || !device->le || device_address_is_private(device))
 		return;
@@ -2100,6 +2122,11 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 		return;
 	}
 
+	/* Inhibit auto connect if BR/EDR bearer is preferred */
+	bearer = device_prefer_bearer_str(device);
+	if (bearer && !strcasecmp(bearer, "bredr"))
+		return;
+
 	/* Enabling auto connect */
 	adapter_auto_connect_add(device->adapter, device);
 
@@ -3343,16 +3370,6 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
-static const char *device_prefer_bearer_str(struct btd_device *device)
-{
-	if (device->bredr_state.prefer)
-		return "bredr";
-	else if (device->le_state.prefer)
-		return "le";
-	else
-		return "last-seen";
-}
-
 static gboolean
 dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *data)
@@ -3382,6 +3399,7 @@ dev_property_set_prefer_bearer(const GDBusPropertyTable *property,
 
 	dbus_message_iter_get_basic(value, &str);
 
+	/* Check if current preferred bearer is the same */
 	if (!strcasecmp(device_prefer_bearer_str(device), str))
 		goto done;
 
@@ -3407,6 +3425,8 @@ dev_property_set_prefer_bearer(const GDBusPropertyTable *property,
 		return;
 	}
 
+	store_device_info(device);
+
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 					DEVICE_INTERFACE, "PreferredBearer");
 
@@ -3420,13 +3440,7 @@ dev_property_prefer_bearer_exists(const GDBusPropertyTable *property,
 {
 	struct btd_device *device = data;
 
-	/* Check if both BR/EDR and LE bearer are connected/bonded */
-	if ((device->bredr_state.connected || device->bredr_state.bonded) &&
-			(device->le_state.connected || device->le_state.bonded))
-		return TRUE;
-
-	/* Check if both BR/EDR and LE are connectable */
-	return device->bredr_state.connectable && device->le_state.connectable;
+	return device_prefer_bearer_str(device) != NULL;
 }
 
 static const GDBusPropertyTable device_properties[] = {
@@ -3996,6 +4010,24 @@ static void load_info(struct btd_device *device, const char *local,
 
 	g_strfreev(techno);
 
+	/* Load preferred bearer */
+	str = g_key_file_get_string(key_file, "General", "PreferredBearer",
+								NULL);
+	if (str) {
+		if (!strcasecmp(str, "last-seen")) {
+			device->bredr_state.prefer = false;
+			device->le_state.prefer = false;
+		} else if (!strcasecmp(str, "bredr")) {
+			device->bredr_state.prefer = true;
+			device->le_state.prefer = false;
+		} else if (!strcasecmp(str, "le")) {
+			device->le_state.prefer = true;
+			device->bredr_state.prefer = false;
+		}
+
+		g_free(str);
+	}
+
 next:
 	/* Load trust */
 	device->trusted = g_key_file_get_boolean(key_file, "General",
-- 
2.48.1

