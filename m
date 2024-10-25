Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0FA1865FC
	for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 19:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729884622; cv=none; b=KvNw4ddTaK30yNofwVVV6xEhiydpjhdEgS8p6715oc0ElAadz7OXZue4VZ1/W14r4L6Ov+S4FbqA36unATLV1hSDsjzM+UEe8o/N9ji1i7V4TAQrzOHmIFlk324V+2ZZHNRRQ/bHv8w0uU0pa+JvfjY/AMv+QTvJcMn7ftwNjNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729884622; c=relaxed/simple;
	bh=5u/T0uPbxr7ZcoBViKcz8hL+K37eu48UfYe3S02QteE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ixe0bQoH2jkAHZrjs1zAcWoHa2fTm0sySp/eETwFxizzRnf2quvaiMEHmMEmrfOd+LAmgvPaosBIiyqRcTbxd9iGis6OCMTl3WZC+fkFX1H+lIHpR+dZbcmyjbDhpub8X74IqpogzfON2C1h5xbYOA6uSAFZvBwxwMXhx0LWUq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IhHBr9ac; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IhHBr9ac"
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-851d2a36e6dso1728913241.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Oct 2024 12:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729884616; x=1730489416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=v1dciNIzS0A4XHx5HEcxV1E05R48YXALnpiVpHqE90s=;
        b=IhHBr9ackmNu7ZiMZNlsNdCKZOxZZC8W2kmNQB3bbW2z5EXkhMmYlbyKpXQdHiG03+
         AyzhKqBeTA9bWOLGXHC1UKkrcIMdJ3XmkTVvRFo38cg9RJwPlepKRMuur/NXeBTflrDJ
         C+YgP6AEsQPLCdEg2u7EsUujJez+i8GbSg/7bwmV/X2YrFFi6EvfIoxfmVG6usDwmcJn
         dMIfGmKTwRUENh/vCvPI989sjCpqvV1w+Ki/6v3nLkcMTTpforPIky6DTvib2251vzst
         Vb1jto0zxTO3OuazNHCUbna3lD5AVaXGGKGCZK7AMEEmRMkErMDuPKEV2UekCc7IStf9
         UNJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729884616; x=1730489416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1dciNIzS0A4XHx5HEcxV1E05R48YXALnpiVpHqE90s=;
        b=QHeJc8zpXx5nLN+MS3Wvllgn2AKToFvX91/JMxvr1WAUUBoi9wWJ9PiIVnhJ+aGUpq
         8INA99eXPfXT/v0rc9bbNIHdDaOzrHKFqdCwKHKQzgK8pKtCQc/NPhklsl3+JsJjZqch
         CSWm1V2Z4/C9xAk1Yz6fEmvopTozrvggXBQZsLy7+ngTm1pGCc8NDEEFE7wF6YrRYRtP
         Bm/LGCYUCg9wWk6QC3EMsTODjpn7HkMIOW5S2qGjJa/MFxc37Cel5/kVmH4y/BSs7glO
         1YnCVX9poyI32VxaRaNzE7uRcEzmbcsU/v3VDymBv9nLBi2upYh6mW9PasGNjcVZoVZ2
         NAfQ==
X-Gm-Message-State: AOJu0YxhoLj/hybjQ4Qw0CN5Gp2jR/ayhH1/9cvJivpNAtRr5qpOqSlq
	FWQB1uQ40gTtVKnZixW5oxpJF/Kxnfl59TimrBSz9paXlMDNFXCLe7CzHw==
X-Google-Smtp-Source: AGHT+IEZS8mw3DLX+uc4nJQGicWGBeM3bFep5aU9T9FyGAzWKIZOlecA2bEO5PaWsySlU0RjF4SZcA==
X-Received: by 2002:a05:6122:4881:b0:50d:4925:555d with SMTP id 71dfb90a1353d-50feb48417cmr7288138e0c.5.1729884615904;
        Fri, 25 Oct 2024 12:30:15 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-51004361d42sm234860e0c.8.2024.10.25.12.30.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 12:30:13 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] input: Add support for UserspaceHID=persist
Date: Fri, 25 Oct 2024 15:30:11 -0400
Message-ID: <20241025193011.3035565-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support supportfor persist mode via input.conf:UserspaceHID
but don't default to it since this appears to create more problems than
it solves.

Fixes: https://github.com/bluez/bluez/issues/983
Fixes: https://github.com/bluez/bluez/issues/977
Fixes: https://github.com/bluez/bluez/issues/949
---
 profiles/input/device.c   | 27 ++++++++++++++++++++++-----
 profiles/input/device.h   |  9 ++++++++-
 profiles/input/hog.c      |  5 ++++-
 profiles/input/input.conf |  6 +++++-
 profiles/input/manager.c  | 11 ++++++-----
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/profiles/input/device.c b/profiles/input/device.c
index b162c0bc7572..8cf8e5ea78e1 100644
--- a/profiles/input/device.c
+++ b/profiles/input/device.c
@@ -89,7 +89,7 @@ struct input_device {
 };
 
 static int idle_timeout = 0;
-static bool uhid_enabled = true;
+static uhid_state_t uhid_state = UHID_ENABLED;
 static bool classic_bonded_only = true;
 
 void input_set_idle_timeout(int timeout)
@@ -97,9 +97,23 @@ void input_set_idle_timeout(int timeout)
 	idle_timeout = timeout;
 }
 
-void input_enable_userspace_hid(bool state)
+void input_set_userspace_hid(char *state)
 {
-	uhid_enabled = state;
+	if (!strcasecmp(state, "false") || !strcasecmp(state, "no") ||
+			!strcasecmp(state, "off"))
+		uhid_state = UHID_DISABLED;
+	else if (!strcasecmp(state, "true") || !strcasecmp(state, "yes") ||
+			!strcasecmp(state, "on"))
+		uhid_state = UHID_ENABLED;
+	else if (!strcasecmp(state, "persist"))
+		uhid_state = UHID_PERSIST;
+	else
+		error("Unknown value '%s'", state);
+}
+
+uint8_t input_get_userspace_hid(void)
+{
+	return uhid_state;
 }
 
 void input_set_classic_bonded_only(bool state)
@@ -179,6 +193,9 @@ static int uhid_disconnect(struct input_device *idev, bool force)
 	if (idev->virtual_cable_unplug && !force)
 		force = true;
 
+	if (!force && uhid_state != UHID_PERSIST)
+		force = true;
+
 	err = bt_uhid_destroy(idev->uhid, force);
 	if (err < 0) {
 		error("bt_uhid_destroy: %s", strerror(-err));
@@ -1507,7 +1524,7 @@ int input_device_register(struct btd_service *service)
 	if (!idev)
 		return -EINVAL;
 
-	if (uhid_enabled) {
+	if (uhid_state) {
 		idev->uhid = bt_uhid_new_default();
 		if (!idev->uhid) {
 			error("bt_uhid_new_default: failed");
@@ -1605,7 +1622,7 @@ int input_device_set_channel(const bdaddr_t *src, const bdaddr_t *dst, int psm,
 	if (!idev)
 		return -ENOENT;
 
-	if (uhid_enabled)
+	if (uhid_state)
 		cond |= G_IO_IN;
 
 	switch (psm) {
diff --git a/profiles/input/device.h b/profiles/input/device.h
index cf03894178f7..7b87ce590337 100644
--- a/profiles/input/device.h
+++ b/profiles/input/device.h
@@ -11,11 +11,18 @@
 #define L2CAP_PSM_HIDP_CTRL	0x11
 #define L2CAP_PSM_HIDP_INTR	0x13
 
+typedef enum {
+	UHID_DISABLED = 0,
+	UHID_ENABLED,
+	UHID_PERSIST
+} uhid_state_t;
+
 struct input_device;
 struct input_conn;
 
 void input_set_idle_timeout(int timeout);
-void input_enable_userspace_hid(bool state);
+void input_set_userspace_hid(char *state);
+uint8_t input_get_userspace_hid(void);
 void input_set_classic_bonded_only(bool state);
 bool input_get_classic_bonded_only(void);
 void input_set_auto_sec(bool state);
diff --git a/profiles/input/hog.c b/profiles/input/hog.c
index bc1b89e57fbd..017e320f0781 100644
--- a/profiles/input/hog.c
+++ b/profiles/input/hog.c
@@ -208,7 +208,10 @@ static int hog_disconnect(struct btd_service *service)
 {
 	struct hog_device *dev = btd_service_get_user_data(service);
 
-	bt_hog_detach(dev->hog, false);
+	if (input_get_userspace_hid() == UHID_PERSIST)
+		bt_hog_detach(dev->hog, false);
+	else
+		bt_hog_detach(dev->hog, true);
 
 	btd_service_disconnecting_complete(service, 0);
 
diff --git a/profiles/input/input.conf b/profiles/input/input.conf
index 273e15bc9c80..d555d423e43c 100644
--- a/profiles/input/input.conf
+++ b/profiles/input/input.conf
@@ -10,7 +10,11 @@
 #IdleTimeout=0
 
 # Enable HID protocol handling in userspace input profile
-# Defaults to true (Use UHID instead of kernel HIDP)
+# Possible values:
+#  - persist: Use UHID in persistent mode (keyboard only)
+#  - true: Use UHID instead
+#  - false: User kernel HIDP
+# Defaults to true
 #UserspaceHID=true
 
 # Limit HID connections to bonded devices
diff --git a/profiles/input/manager.c b/profiles/input/manager.c
index f4598bcd4e47..1c4442ef847f 100644
--- a/profiles/input/manager.c
+++ b/profiles/input/manager.c
@@ -83,7 +83,8 @@ static int input_init(void)
 	config = load_config_file(CONFIGDIR "/input.conf");
 	if (config) {
 		int idle_timeout;
-		gboolean uhid_enabled, classic_bonded_only, auto_sec;
+		gboolean classic_bonded_only, auto_sec;
+		char *uhid_enabled;
 
 		idle_timeout = g_key_file_get_integer(config, "General",
 							"IdleTimeout", &err);
@@ -93,12 +94,12 @@ static int input_init(void)
 		} else
 			g_clear_error(&err);
 
-		uhid_enabled = g_key_file_get_boolean(config, "General",
+		uhid_enabled = g_key_file_get_string(config, "General",
 							"UserspaceHID", &err);
 		if (!err) {
-			DBG("input.conf: UserspaceHID=%s", uhid_enabled ?
-							"true" : "false");
-			input_enable_userspace_hid(uhid_enabled);
+			DBG("input.conf: UserspaceHID=%s", uhid_enabled);
+			input_set_userspace_hid(uhid_enabled);
+			free(uhid_enabled);
 		} else
 			g_clear_error(&err);
 
-- 
2.47.0

