Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5B032147FA
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 22:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520870; cv=none; b=JupWuBZLnWxT8l2AhQ2nGPCBeXSQASqaaIsCych80AdIKaa9bzqVpyusT2PSWaOclL0VgkxRSI98Az5y3SWOlMCoIiW/I6QjTuyLUk7eObKcTMAhKC/w2oURpBRH4oGmtlxA06S4tewj18OMoVw36aZa57gyAHh2yc5FOXS8mOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520870; c=relaxed/simple;
	bh=hxl2QBjIYMEuHwFn89b/7PlrV51RyNaHCiIwfV6ue+A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u/YJCmGi6tkAZICEfm0586X9SZZw0hgQyYTob/JcHVjTK8z0zhDQLbkGZl6PzTILrI8W2dYWZvZsQFr1iqU62jQPCsutzzZbzeDMefYY0Qeeqxi9BdkMyFxaXzesSP6Gloo+GsTT+SPWE1u8HYFyslTHM72wm3Yk7MUqz9+AKhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ajo0pIOW; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ajo0pIOW"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-5209ea469e9so186502e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 14:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520867; x=1741125667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zkSP9ZgK4CLN4L76ja/nU7mk9o0BiM7eVmUu4dIaAnE=;
        b=ajo0pIOWoq+IY14ReOQmPw15UHtstoTk3i0aucbI7jmlDs5ypZkvBV1dyxMJhuZVds
         rFIaTp+TYN/h5LXcMzzQ4U63gVzttzCxAZVN5P2MYgcvV+QCDX9sL3zhbEszZJrrgJua
         CDOsj0gNB7aT3NLJxYoAK3lnTVo4NP8+CJOFSm3LXfIMJENfQgdD/64+Vmyvm2gbmuJv
         K2xebUGwUx7xgFGLQIsH05E0V4h1p+uLv2ZgTjtycEN8SF8+opBaU4VbK9KXi7mWLtbg
         xHvHwDkWuLURjCBmH4mZBlottTY2ORe6zoSCnMvsV4jn70BJ8ByibuBb8SPlbYEzL7ln
         8Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520867; x=1741125667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zkSP9ZgK4CLN4L76ja/nU7mk9o0BiM7eVmUu4dIaAnE=;
        b=Vxu/llSk90KDZs0tIl7tv2ZFz7lzsBleJGjvKURF0xdtzD9RdLWhH2Ad6blPN41JNh
         alFVymNoDx/7DpI/ckoGK/2HBFM+LXZ9xdwpQRUQsTjFvQqKNSO2hz/tp6i61vIzOYPI
         r6YidUJcZ3lpq5VbHVSJDGp8yStLvQQvYalK7jOe/gOJ0kQFF81l+FJwy6tzkGfbkXEt
         OdteKwfsYJ4uzF6ugORCjRMiIqY+7tyCBX6ZpH+4vOPdzFtGlMofuyGcDaykB3jwoCPW
         J+crOXLG7NGpAWvz3GoChr2QNV0ujyVG6IBBUFBBR9uKWESSzijjRSASatGN6ahP6fI4
         q9Yg==
X-Gm-Message-State: AOJu0YywjxEujUOtC+DuyX2kE/lsw0SitFYrRUGs4jLMekyeE/KYbAIp
	HpK+0tuJW7N3Vz1RrxWdUoPyILqo5hrS0uZsOlLW5aB1XWyMiQpYdKJiIwLu
X-Gm-Gg: ASbGncu3UBRU3RhxDlqT6gkT6VWyBudZ6RdAVhi0MfyfuYCLIW/ZTNPZz1ydsd0fNGV
	8Urex7DMMUHp+PxAXWBFQ3F770TSEv2DaVZSkrLw6fGMm+K75kRrdaA9mimxMIjVUIvdG2Bav7H
	8p24X27zJkiq8QB4hv2HKsOND4oP5Dr+vxrkTy0HU0JWqDdRuWFX6C05iZEofkyxF7v31mXPH1k
	6HCAs4Vp14JFgnf9zpoAZ/jL5E477/9o7NqcINJ2qrozYrBRACmKMR3fkav6U98CWQdAX7YMi+Q
	bzBUHH4DfvMpnlVfVn41yxC8DOiJLvb3NewOo7ZwD/qlSx8KmRVlIksiRhAub8P5F1Jswec=
X-Google-Smtp-Source: AGHT+IH+mwbONuaaqULBYbeAMxTFFlL/vIOIe6bJzb2XFOVyUtPDvs66KOUQp6/zNlKOgtkU8UX2Mw==
X-Received: by 2002:ac5:c92c:0:b0:520:9883:29c2 with SMTP id 71dfb90a1353d-521dcfc4539mr10227996e0c.6.1740520867012;
        Tue, 25 Feb 2025 14:01:07 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ed4e428sm494863241.13.2025.02.25.14.01.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:01:05 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/3] device: Add implementation of PreferredBearer
Date: Tue, 25 Feb 2025 17:00:58 -0500
Message-ID: <20250225220059.2821394-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225220059.2821394-1-luiz.dentz@gmail.com>
References: <20250225220059.2821394-1-luiz.dentz@gmail.com>
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
 src/device.c | 95 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 92 insertions(+), 3 deletions(-)

diff --git a/src/device.c b/src/device.c
index ec97fc889056..75ae1f0d027e 100644
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
@@ -3340,6 +3343,88 @@ static const GDBusMethodTable device_methods[] = {
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
+	if (strcasecmp(str, "last-seen") == 0) {
+		device->bredr_state.prefer = false;
+		device->le_state.prefer = false;
+	} else if (strcasecmp(str, "bredr") == 0) {
+		device->bredr_state.prefer = true;
+		device->le_state.prefer = false;
+		/* Remove device from auto-connect list so the kernel does not
+		 * attempt to auto-connect to it in case it starts advertising.
+		 */
+		device_set_auto_connect(device, FALSE);
+	} else if (strcasecmp(str, "le") == 0) {
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
+			device->le_state.connected || device->le_state.bonded)
+		return TRUE;
+
+	/* Check if both BR/EDR and LE are connectable */
+	return device->bredr_state.connectable && device->le_state.connectable;
+}
+
 static const GDBusPropertyTable device_properties[] = {
 	{ "Address", "s", dev_property_get_address },
 	{ "AddressType", "s", property_get_address_type },
@@ -3378,6 +3463,10 @@ static const GDBusPropertyTable device_properties[] = {
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

