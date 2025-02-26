Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B83221DAA
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 18:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593500; cv=none; b=P1eZ9HwP/JWZI6Hn4NhzpVbMbrKY5ZMV+VaNhs4uqyxXul/vuK0M0FIfHk4YYaD5FTU6pZ8widvM2WVb+5mNCYq4iI01z2V9H+0GphDq49e6Yr4szUxfjLaRXTi5PU3OKX8bkDfHHWss5mI0M0imM1Rq3AiWtzVRMpU9YYPOUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593500; c=relaxed/simple;
	bh=UM4LraNquXqIiw5KEQxKvAh1fdU10xFrkj3UAl3JWXY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YI8UZotO5CEOZJe4tKO84IQfzMVWd5syIezi4cYTPPBfUUlrjlt7efz4Wfh9HF6iqUT35PatMfr1bwEXO0lIj8IkX+9b/+2YFE3MycpA8JtnK9tIybQE0Ft3Jlakwk5b5YW4k1EY2447WfL4omHKtr5SO5Z08qf8ayWhrG+2dfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hl0xS9NY; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hl0xS9NY"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-521b3ebb0f3so22165e0c.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 10:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593497; x=1741198297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tU+iSDsWWRst0jbrXq0PzBAipjCohQXsQ98Za+pHcEY=;
        b=Hl0xS9NY5EQ0IMy1uldlTPQowQmdudUkgrW02sYGgwNxZ0vWhjzBYfvmB2HsaYyEZe
         fP/rkKOyPIgvz/FJHBUD8lSI6KqmhSe5U9EZoGJIBR+0l3Fe3B3O3bIzq54gQfnyP2hN
         zXzC2alwSQrSkwrEMpHRC0P7KmCbR8IPfI3ewDBRcaAyR8UnMnD/qN1AoQf/H6dT/M0V
         WtN3tvQ9fNBTsBVCL+zVYexP5/NpJ92ksY2R3BtB2mm8iuOhfekUD1L00ikz3vjydz5A
         fvrBKCxLMNEUazj4AXdrWxOr5NtA9IPyIhuVh3ZewHGe8qpsThsBnztLHPcWAhA/yiJn
         wDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593497; x=1741198297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tU+iSDsWWRst0jbrXq0PzBAipjCohQXsQ98Za+pHcEY=;
        b=NXBtjNoWrx2GahGKzJorFwa08M4985NJGj/NwALnxwz2ODIANzi/fghu46R+A2I7LQ
         tU0I7F36z5IuKBYDUK/NpupZYa640tqnFY/EnE/teYv84U9yv4QUHg1FOlU1xRb+lyZW
         Zmm5Dwj98BpbMv0IZzKqLBl7pKbPuKic86kGIgZeDs+BN43V456pxqS9CroBYSZdQUX2
         7ZNAHOzNnFEnnxOn5p0vKRfF3J15xX+uR/cQqwKWUbfDx6eBfjORPjanoInPT9YyN52D
         SGESePxsK1ZXTihwGjPRql2qNOLV0LKL38V5dEHrNsUyYeb5P5pVgyFOdqaD7eZ39sbF
         gJUg==
X-Gm-Message-State: AOJu0YwIR4Kn2dKfRTTMH1tA7PJTkKotZ26WttZfA3evQA6DHfgBRcGG
	xQSs0KJzTwExdk1eRsmk2MBuPWGmRdIrScxYDJGSUeID+e+gbO9hnJPJ00z3
X-Gm-Gg: ASbGncsNyS0DBS8Ar0NGQClcVynFembPSE7o+prY2i7IYPJUSpVPs6ZDgFlJGn/qsVe
	Jk2e+mMp3hOTSPnooih0C+aGuP06nAk118CnGp6wykulK2ppYNxAJs5intAkKVd9D5d7vW+LsPU
	2Mg2Tvc8hiSyWst3TtaXOvgkLGaDq6udSLj9Hs9pQFCcM5LshVo19851qjsPunSA4dcA2LiS8I8
	n2tilyhr4mpfHwX4fC4xE1H1JI99Pb4Tct2YAhoOX2hLiIvWHomJTx+Feuq7VWm7rjJHiVgmyCE
	ppUEIpNqG+szAW2IY0Tglu2TqJ9xmDTYpEss6ZBNOm7QewZ3EOk7Srw3v+sY6w0YcLCsPYE=
X-Google-Smtp-Source: AGHT+IGMQFoNBOddF3dqYZS7UQ32QD+6tZq9P3fczmqIh9kt83INESazm9lPqUr1c5pe7G80HycT4Q==
X-Received: by 2002:a05:6122:828a:b0:520:6773:e5ca with SMTP id 71dfb90a1353d-5224ccd522bmr2569064e0c.6.1740593497164;
        Wed, 26 Feb 2025 10:11:37 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ef052a6sm857744241.27.2025.02.26.10.11.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:11:35 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 2/4] device: Add implementation of PreferredBearer
Date: Wed, 26 Feb 2025 13:11:27 -0500
Message-ID: <20250226181129.2958079-2-luiz.dentz@gmail.com>
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

This adds initial implementation of PreferredBearer.
---
 src/device.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 96 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index ec97fc889056..de92e68d2780 100644
--- a/src/device.c
+++ b/src/device.c
@@ -152,6 +152,7 @@ struct svc_callback {
 
 /* Per-bearer (LE or BR/EDR) device state */
 struct bearer_state {
+	bool prefer;
 	bool paired;
 	bool bonded;
 	bool connected;
@@ -2543,10 +2544,12 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	time_t bredr_last = NVAL_TIME, le_last = NVAL_TIME;
 	time_t current = time(NULL);
 
-	/* Prefer bonded bearer in case only one is bonded */
-	if (dev->bredr_state.bonded && !dev->le_state.bonded )
+	/* Use preferred bearer or bonded bearer in case only one is bonded */
+	if (dev->bredr_state.prefer ||
+			(dev->bredr_state.bonded && !dev->le_state.bonded))
 		return BDADDR_BREDR;
-	else if (!dev->bredr_state.bonded && dev->le_state.bonded)
+	else if (dev->le_state.prefer ||
+			(!dev->bredr_state.bonded && dev->le_state.bonded))
 		return dev->bdaddr_type;
 
 	/* If the address is random it can only be connected over LE */
@@ -3340,6 +3343,92 @@ static const GDBusMethodTable device_methods[] = {
 	{ }
 };
 
+static const char *device_prefer_bearer_str(struct btd_device *device)
+{
+	if (device->bredr_state.prefer)
+		return "bredr";
+	else if (device->le_state.prefer)
+		return "le";
+	else
+		return "last-seen";
+}
+
+static gboolean
+dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
+				DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *str = device_prefer_bearer_str(device);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &str);
+
+	return TRUE;
+}
+
+static void
+dev_property_set_prefer_bearer(const GDBusPropertyTable *property,
+					 DBusMessageIter *value,
+					 GDBusPendingPropertySet id, void *data)
+{
+	struct btd_device *device = data;
+	const char *str;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &str);
+
+	if (!strcasecmp(device_prefer_bearer_str(device), str))
+		goto done;
+
+	if (!strcasecmp(str, "last-seen")) {
+		device->bredr_state.prefer = false;
+		device->le_state.prefer = false;
+	} else if (!strcasecmp(str, "bredr")) {
+		device->bredr_state.prefer = true;
+		device->le_state.prefer = false;
+		/* Remove device from auto-connect list so the kernel does not
+		 * attempt to auto-connect to it in case it starts advertising.
+		 */
+		device_set_auto_connect(device, FALSE);
+	} else if (!strcasecmp(str, "le")) {
+		device->le_state.prefer = true;
+		device->bredr_state.prefer = false;
+		/* Add device to auto-connect list */
+		device_set_auto_connect(device, TRUE);
+	} else {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "PreferredBearer");
+
+done:
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean
+dev_property_prefer_bearer_exists(const GDBusPropertyTable *property,
+						void *data)
+{
+	struct btd_device *device = data;
+
+	/* Check if both BR/EDR and LE bearer are connected/bonded */
+	if ((device->bredr_state.connected || device->bredr_state.bonded) &&
+			(device->le_state.connected || device->le_state.bonded))
+		return TRUE;
+
+	/* Check if both BR/EDR and LE are connectable */
+	return device->bredr_state.connectable && device->le_state.connectable;
+}
+
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "AddressType", "s", property_get_address_type },
@@ -3378,6 +3467,10 @@ static const GDBusPropertyTable device_properties[] = {
 				dev_property_wake_allowed_exist },
 	{ "Sets", "a{oa{sv}}", dev_property_get_set, NULL,
 				dev_property_set_exists },
+	{ "PreferredBearer", "s", dev_property_get_prefer_bearer,
+				dev_property_set_prefer_bearer,
+				dev_property_prefer_bearer_exists,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ }
 };
 
-- 
2.48.1

