Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5C427A126
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747419459; cv=none; b=WumJ8KmBWkCoan2a2JlNTa0tvXKl7l9UUGmwyykiaErN4ZkVoLQT1vJnEIKEwCJPm685909SN+JFGFYuk8TNTOyVsDd6pGOU0XrCXsw5Ynas+tYBxtuyNEluHyoXfM0laSp1WYg+fkz2E73LjCHgSBjeM2GgUUq4h40whXsSAHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747419459; c=relaxed/simple;
	bh=2H3bXk65a8IW7tp+UxxUPEfQkmZLv8pP8OC4qKXmwPQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RU4PvCV4uVSt7ahIalNYyGtcTPacP+cO1+MEC/i9+DznUQ6pg7Xc3bTjoe76KTgTjSJIh7ctXmt35fVfSP7vW8NoXEDgdV1IQHQMP47xdKRHF+apY935kwLU+VPVHQFV3ba3VlfnjHzgZGh4tjMav8u+7UBA+b6zjZa/dCQmcZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoT0SyI1; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoT0SyI1"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4c34dcdaf88so853731137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 May 2025 11:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747419456; x=1748024256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kDe/MwuqHoFqTxwwpwfdcYHXuXMusxGJl59iCdJxXA8=;
        b=DoT0SyI1G3cQjEd8lXUKQOh1TUDGd3E6YkdYJnvwfgArYZ3I/o7lTu5u+UqKJEKwEl
         EqTKrFgUFppE6dAd1JMxWkbWcso4DedaFG2izDou/gdVFjwP/7dtXE6hVU7oJXjHYxIl
         bT1rMtSqfQkWs22LwDi3i8cg0SM5CNPTNolkeW4WZhBrgxrOdTHARBQmAwR5pmJDnJET
         eJq40QA01nPUjOOguOYP67Hsu78Ks8AMv3ffunPXLNau94fIYW09zXpqOWgATnj8NDIt
         VIBUbW4IEY+GCsrjw93Djwe/zwbVU7qnm0ZA0dHgtPyG1j0V6qqr4xytI5iqs97z6ldg
         BEYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747419456; x=1748024256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kDe/MwuqHoFqTxwwpwfdcYHXuXMusxGJl59iCdJxXA8=;
        b=ZyrP13xUBnuKdIFzKmwxl96tl1ytwWwj/5JZgMvFI8lfP5bU1IJOPt0Ora5UnaMH5z
         xyz6ztoxZjluTc3bnHCxnhE2ZU+FjtnR2cPWLDjf7JRo+/NQ3ob5dLEMK+oeY2XVNJJ2
         p3/TO+Wd/aho2S4YNZ+JySj4d1HiMzG/Pvl1k5zg9OVNPpSEB4XVgsY3ehhzuv0S05GZ
         5AabuqTwGt86pkzhFOh0rKK6e2Wf1JdCmDKpD5JN11EGrksu8JKGz8n+nZyXVkRozD54
         Cx/rL1Zbt23HEfUpJYwtI5zxVDcGeUugAbQpWOgQZtmhWZxoluAHaAE1rly8OX5um7pv
         X9lQ==
X-Gm-Message-State: AOJu0YxYZT15JcMRLA5bZxw3JqMSF471cYP+JjY3v5Ti6L0zOASUjBEz
	gcnyY3Nx+jCXvw/gaxBfVb/PAqhQm78E/Ge53HGlMCT1nwaAolG1yATXKhNc49yE9Qg=
X-Gm-Gg: ASbGnct8O/SEYwuULgpscXjTQBxm06v6Rn4ZJcX4qfbqK3FBKC4HEFBQUgX4TDqiMEc
	rVY9ODg/2XUmllEHYluXwWRs6GKWjYnwVZGmbjsadG/SXoGuXRO2ECKbfOXnAiXz5I/PkMtec2y
	kyP1b8kjEtKZ2Uhd10f6Y3kRbmydLJil9MAdGMQyJ8liDC+vrr9ZxEdKT5zPKHjmA9LjTp2q+ho
	n04JueNU7bHoqfXkTx8AhTLbvhsfTsakJ5lo6l80CJK38IHM+HWD3DyByEp2zqPecsUrE2AGrHJ
	lJt0zRm/JBmCslvd8uq+LO9bEggwM4hdYzi3Qozo7S9/ByvmLbjjLTMu3u8Ejxy7r/pgN95d8EZ
	lHxqktU/RHiTA04VYc0CD
X-Google-Smtp-Source: AGHT+IGvsi6TqM7CkAAPLq34FmdVHNt7VwhIbNnSDpEgpo8sArK352TrOql+bVtXXuJ9qezixzs/ug==
X-Received: by 2002:a05:6102:334d:b0:4c5:1bff:4589 with SMTP id ada2fe7eead31-4e053c65c64mr4307376137.22.1747419456169;
        Fri, 16 May 2025 11:17:36 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87bec1efc05sm2116134241.22.2025.05.16.11.17.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 11:17:34 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] device: Implement PreferredBearer=last-used
Date: Fri, 16 May 2025 14:17:31 -0400
Message-ID: <20250516181731.1967217-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250516181731.1967217-1-luiz.dentz@gmail.com>
References: <20250516181731.1967217-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implementas PreferredBearer=last-use which enables Device.Connect
to use last used bearer first.

Fixes: https://github.com/bluez/bluez/issues/986
---
 src/device.c | 166 +++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 134 insertions(+), 32 deletions(-)

diff --git a/src/device.c b/src/device.c
index d230af0a8aaa..56583f71a78b 100644
--- a/src/device.c
+++ b/src/device.c
@@ -160,6 +160,7 @@ struct bearer_state {
 	bool initiator;
 	bool connectable;
 	time_t last_seen;
+	time_t last_used;
 };
 
 struct ltk_info {
@@ -188,6 +189,13 @@ enum {
 	WAKE_FLAG_DISABLED,
 };
 
+enum {
+	PREFER_LAST_USED = 0,
+	PREFER_LE,
+	PREFER_BREDR,
+	PREFER_LAST_SEEN,
+};
+
 struct btd_device {
 	int ref_count;
 
@@ -269,6 +277,7 @@ struct btd_device {
 
 	struct btd_gatt_client *client_dbus;
 
+	uint8_t prefer_bearer;
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
 
@@ -378,12 +387,61 @@ static const char *device_prefer_bearer_str(struct btd_device *device)
 	if (!device->bredr || !device->le)
 		return NULL;
 
-	if (device->bredr_state.prefer)
-		return "bredr";
-	else if (device->le_state.prefer)
+	switch (device->prefer_bearer) {
+	case PREFER_LAST_USED:
+		return "last-used";
+	case PREFER_LE:
 		return "le";
-	else
+	case PREFER_BREDR:
+		return "bredr";
+	case PREFER_LAST_SEEN:
 		return "last-seen";
+	}
+
+	return NULL;
+}
+
+static bool device_set_prefer_bearer(struct btd_device *device, uint8_t bearer)
+{
+	switch (bearer) {
+	case PREFER_LAST_USED:
+		device->prefer_bearer = PREFER_LAST_USED;
+		return true;
+	case PREFER_LE:
+		device->prefer_bearer = PREFER_LE;
+		device->le_state.prefer = true;
+		device->bredr_state.prefer = false;
+		return true;
+	case PREFER_BREDR:
+		device->prefer_bearer = PREFER_BREDR;
+		device->bredr_state.prefer = true;
+		device->le_state.prefer = false;
+		return true;
+	case PREFER_LAST_SEEN:
+		device->prefer_bearer = PREFER_LAST_SEEN;
+		device->bredr_state.prefer = false;
+		device->le_state.prefer = false;
+		return true;
+	default:
+		error("Unknown preferred bearer: %d", bearer);
+		return false;
+	}
+}
+
+static bool device_set_prefer_bearer_str(struct btd_device *device,
+						const char *str)
+{
+	if (!strcmp(str, "last-used"))
+		return device_set_prefer_bearer(device, PREFER_LAST_USED);
+	else if (!strcmp(str, "le"))
+		return device_set_prefer_bearer(device, PREFER_LE);
+	else if (!strcmp(str, "bredr"))
+		return device_set_prefer_bearer(device, PREFER_BREDR);
+	else if (!strcmp(str, "last-seen"))
+		return device_set_prefer_bearer(device, PREFER_LAST_SEEN);
+
+	error("Unknown preferred bearer: %s", str);
+	return false;
 }
 
 static void update_technologies(GKeyFile *file, struct btd_device *dev)
@@ -413,9 +471,15 @@ static void update_technologies(GKeyFile *file, struct btd_device *dev)
 
 	/* Store the PreferredBearer in case of dual-mode devices */
 	bearer = device_prefer_bearer_str(dev);
-	if (bearer)
+	if (bearer) {
 		g_key_file_set_string(file, "General", "PreferredBearer",
 							bearer);
+		if (dev->prefer_bearer == PREFER_LAST_USED) {
+			g_key_file_set_string(file, "General", "LastUsedBearer",
+						dev->le_state.prefer ?
+						"le" : "bredr");
+		}
+	}
 }
 
 static void store_csrk(struct csrk_info *csrk, GKeyFile *key_file,
@@ -3450,28 +3514,27 @@ dev_property_set_prefer_bearer(const GDBusPropertyTable *property,
 	if (!strcasecmp(device_prefer_bearer_str(device), str))
 		goto done;
 
-	if (!strcasecmp(str, "last-seen")) {
-		device->bredr_state.prefer = false;
-		device->le_state.prefer = false;
-	} else if (!strcasecmp(str, "bredr")) {
-		device->bredr_state.prefer = true;
-		device->le_state.prefer = false;
-		/* Remove device from auto-connect list so the kernel does not
-		 * attempt to auto-connect to it in case it starts advertising.
-		 */
-		device_set_auto_connect(device, FALSE);
-	} else if (!strcasecmp(str, "le")) {
-		device->le_state.prefer = true;
-		device->bredr_state.prefer = false;
-		/* Add device to auto-connect list */
-		device_set_auto_connect(device, TRUE);
-	} else {
+	if (!device_set_prefer_bearer_str(device, str)) {
 		g_dbus_pending_property_error(id,
 					ERROR_INTERFACE ".InvalidArguments",
 					"Invalid arguments in method call");
 		return;
 	}
 
+	switch (device->prefer_bearer) {
+	case PREFER_BREDR:
+		/* Remove device from auto-connect list so the kernel does not
+		 * attempt to auto-connect to it in case it starts advertising.
+		 */
+		device_set_auto_connect(device, FALSE);
+		break;
+
+	case PREFER_LE:
+		/* Add device to auto-connect list */
+		device_set_auto_connect(device, TRUE);
+		break;
+	}
+
 	store_device_info(device);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
@@ -3563,12 +3626,44 @@ static void clear_temporary_timer(struct btd_device *dev)
 	}
 }
 
+static void device_update_last_used(struct btd_device *device,
+					uint8_t bdaddr_type)
+{
+	struct bearer_state *state;
+
+	state = get_state(device, bdaddr_type);
+	state->last_used = time(NULL);
+
+	if (device->prefer_bearer != PREFER_LAST_USED)
+		return;
+
+	/* If current policy is to prefer last used bearer update the state. */
+	state->prefer = true;
+	if (bdaddr_type == BDADDR_BREDR) {
+		if (device->le_state.prefer) {
+			device->le_state.prefer = false;
+			/* Remove device from auto-connect list so the kernel
+			 * does not attempt to auto-connect to it in case it
+			 * starts advertising.
+			 */
+			device_set_auto_connect(device, FALSE);
+		}
+	} else if (device->bredr_state.prefer) {
+		device->bredr_state.prefer = false;
+		/* Add device to auto-connect list */
+		device_set_auto_connect(device, TRUE);
+	}
+
+	store_device_info(device);
+}
+
 void device_add_connection(struct btd_device *dev, uint8_t bdaddr_type,
 							uint32_t flags)
 {
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 
 	device_update_last_seen(dev, bdaddr_type, true);
+	device_update_last_used(dev, bdaddr_type);
 
 	if (state->connected) {
 		char addr[18];
@@ -4062,18 +4157,16 @@ static void load_info(struct btd_device *device, const char *local,
 	str = g_key_file_get_string(key_file, "General", "PreferredBearer",
 								NULL);
 	if (str) {
-		if (!strcasecmp(str, "last-seen")) {
-			device->bredr_state.prefer = false;
-			device->le_state.prefer = false;
-		} else if (!strcasecmp(str, "bredr")) {
-			device->bredr_state.prefer = true;
-			device->le_state.prefer = false;
-		} else if (!strcasecmp(str, "le")) {
-			device->le_state.prefer = true;
-			device->bredr_state.prefer = false;
-		}
-
+		device_set_prefer_bearer_str(device, str);
 		g_free(str);
+
+		/* Load last used bearer */
+		str = g_key_file_get_string(key_file, "General",
+						"LastUsedBearer", NULL);
+		if (str)
+			device_update_last_used(device, !strcmp(str, "le") ?
+						device->bdaddr_type :
+						BDADDR_BREDR);
 	}
 
 next:
@@ -4854,6 +4947,11 @@ void device_set_bredr_support(struct btd_device *device)
 		return;
 
 	device->bredr = true;
+
+	if (device->le)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "PreferredBearer");
+
 	store_device_info(device);
 }
 
@@ -4868,6 +4966,10 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 					DEVICE_INTERFACE, "AddressType");
 
+	if (device->bredr)
+		g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "PreferredBearer");
+
 	store_device_info(device);
 }
 
-- 
2.49.0

