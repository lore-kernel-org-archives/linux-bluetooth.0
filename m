Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795861259;
	b=duCV9ma2fNIdr57KCTnJbjnbSwMYBwz6344mSQBpLcjGcbf1Xl/QbxYoRJlpTW7Hjpj1
	 QGSmJ5CqXGGJUFYJfXC2JubMH3GksfEkQoJiA4SbH+iF3c8+PBZMEhFepcbWCEKMtDAwI
	 kQWhaj+1VXDHAa/430TvD0tJuheF5mnDn9Qm+lCo2MJ8yopf9R4WvJjqaUshyw6sC+XDM
	 LhAoJyQBthG8JGHJAOGImDg1AApEx9/AXS9En4Y3E5pINuBGTvKXYW7GzyGTRssSrO+gB
	 BIzTlj5d/d1bQdcWQr5Fe1Dz8ZnrGAiu9wBOQJklvwXQ1HXpaEJt3dlLXOhqSinB/xA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795861259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=b1IAvdWedxCm6ZaZC2tqPxDZvT71aM3dYskFQqdOsDc=;
	b=xZrEaewUqfHXtxiZOWT6AdQ4u14RYKV0ClPmJhQdpIGufW48+t1FG6sIKP5g9ptLysiu
	 PZ8T0WRXLJRlowYltlaMeGWXMApSR+mQLQW2qV2FUcYEODEcaCZcISHTwPyQPxipRm3uK
	 Fx26qLUVPxVwv7stTQUuUMhjC2B9R+UOkz52zsi8Kt7wqie7EOKeath/vzbuDDnvCkQ/1
	 kNTuX0grtxThpDhLiTsXY0SMLUp0iH0ap8N/t8ljuHbgG/IttdU5+4k3zp0dOLfgLEy1K
	 Zr+cigR4nRBBhdbe5ZhAOUcyz1aDQbUFdP9f9dKhcdjdMVAFxRT30YFAp/NqdEBR+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zb22uof1;
	arc=none smtp.remote-ip=209.85.218.49
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A7A606A31C
	for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2026 10:20:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 53A7A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zb22uof1
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c5126505cb3so1164622766b.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 28 Nov 2026 02:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795861257; x=1796466057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b1IAvdWedxCm6ZaZC2tqPxDZvT71aM3dYskFQqdOsDc=;
        b=zb22uof1SFPM03MAJPUNXIWVp0sxqIdPv0yFRzUSfVN9bkDWqg3sP5TDhUwVDEbDpf
         VXNpBmMELXl5gKm7h3iHLxNgBE2sWOJWaLi1S7LGNrf72djba2Z3dMa1fsgKf4bmZw0A
         pe5S0raqdEtuLAvk5WMt613Hb1ysU81urtM9EBlAcq71thupf8m05zSOSwkJ6d1yu0dt
         GVTIebUJpyuFJVMGGulSCrc2LzTU0DWd6o343JcM4M6prfa2Y7kMbBOt51t8pW+gNf3H
         vnLNvX19wkG9sJW98FyhXzyZz0i6+RneyIZ7ZFvPknoj0LlfAFHwFCgeLb1GSvxwnAJc
         JnRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795861257; x=1796466057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=b1IAvdWedxCm6ZaZC2tqPxDZvT71aM3dYskFQqdOsDc=;
        b=1JowLsEXWObNEw6EMWbwdfag5XOtsn9c7ngumTnipVISL8P+pkMtkDImJkw/GRHBVe
         dctawhMc/Zfp58xGphcYcYhyK4dCXgLlCSdCOAFZrvNgx6F9avH/JaH0DD8R1r8NYRz/
         LVkEhzb9KSQympyvDHKgM1qistEaeHMV6JF5V9WoX51OPYPchUTQTwd4hNSdIAnKw9zR
         Bsm4wZAOyf/zZlv62oZuqEaopZSSDtryamddOvoWWxF01rbckJaQSosUvMDkUDFKsbLm
         f9dtZUQQJLqpTEVfdaTMpop/BXUEAx799oH6/oU3EAQGSxlzSE2R94TB1Yk6WBsf76/a
         gsEA==
X-Gm-Message-State: APuU4Z/mD6bQp4FGqwK582/bIAjbqi0h0XpmQQhbCXELjaRwCGRydX47
	x3yiejqD0Ip28xNXqBFlpxxC2Ckai/yRNQ3AkV+I4bqPu9Xs34Gw9p+8nSt0HbM=
X-Gm-Gg: AZFdTZdg+2GSjPGnjRqcygKCJESFShbU3X3XrEvHujtrZeRZd0+iGR/PqS8R/FXxAbr
	pMJ9mgZm6cNPd2CVWuW7M2Kwd0DKRvhhaIo7FjwuWrNRTyhaMC03TIWbOyRon7B9+SKbaryS6A9
	HEjdqdr2pWffUud9GSXeZndbhfHmPKQ9KJ9pxMIGpYneh99tujRiacXVdKcC5AJMVM0YyRJxVdA
	VHXuJa0N10+BKPg9MB+v1cKD/dL8/vK5g2fB161dcMOFYYgncbSuIjrs125bntVoxjZFPUfBAGN
	sGKCZOEUu3Azqnao38BsjBo8TwFuo7SWMxIcP4E/WgDxY6jNaoeGpZk2DF1c5yXyUXmDdxKgAgO
	WsGdP7e6RZEe5KBOUchJcMO3SO7nlJSJUr09UN+rZBLDJlhdI4mYNxUBPdLQ1syWQsr1bZeVt1h
	kZ0zWRy6QJ3KNmq2JFxaHMeMdIZhT7dBAT1FP0sDp5wNIrj9XwupxMAWGvdoBvF6P7wW4VT62+K
	vSGAyVzJIvB4ssfKn7g7lQqK3pAz9gk2HcqqWXZsklzwAdFWyyyXMg4FrRcP8bDeEVgaOAlBK7P
	uur+pesL2uy5s6SK6Kkkk+PUItUU68LNxG0PXrPun4UTDkoAc1iivg==
X-Received: by 2002:a17:907:3dab:b0:c4d:212a:192a with SMTP id a640c23a62f3a-c51a2a75817mr1062725766b.48.1795861256419;
        Sat, 28 Nov 2026 02:20:56 -0800 (PST)
Received: from cachyos-x8664 ([37.31.32.22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c513acfeda1sm1007868066b.6.2026.11.28.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2026 02:20:55 -0800 (PST)
From: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Pawe=C5=82=20Owoc?= <frut3k7@gmail.com>
Subject: [PATCH 1/1] device: Add per-device bearer restrictions
Date: Sat, 28 Nov 2026 11:20:19 +0100
Message-ID: <20261128102019.183334-2-frut3k7@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261128102019.183334-1-frut3k7@gmail.com>
References: <20261128102019.183334-1-frut3k7@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the experimental AllowedBearers property to restrict a
dual-mode device to BR/EDR, LE, or both bearers.

Persist the policy, enforce it alongside controller mode and device
capabilities, and expose it through bluetoothctl. Add functional tests
and documentation.

Assisted-by: GitHub-Copilot:gpt-6-luna
---
 client/main.c                  |  33 +++
 doc/bluetoothctl.rst           |  21 ++
 doc/functional-bearer.rst      |  48 +++
 doc/org.bluez.Device.rst       |  23 ++
 doc/settings-storage.txt       |   1 +
 src/adapter.c                  |  13 +-
 src/bearer.c                   |   9 +
 src/device.c                   | 520 +++++++++++++++++++++++++++++----
 src/device.h                   |   1 +
 test/functional/test_bearer.py | 336 +++++++++++++++++++++
 10 files changed, 941 insertions(+), 64 deletions(-)

diff --git a/client/main.c b/client/main.c
index 1131c2ae3..57740e22c 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2059,6 +2059,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 	print_property(proxy, "Sets");
+	print_property(proxy, "AllowedBearers");
 	print_property(proxy, "PreferredBearer");
 
 	battery_proxy = find_proxies_by_path(battery_proxies,
@@ -2644,6 +2645,36 @@ static void cmd_bearer(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void cmd_allowed_bearers(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char *str;
+
+	proxy = find_device(argc, argv);
+	if (!proxy)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc <= 2) {
+		print_property(proxy, "AllowedBearers");
+		return;
+	}
+
+	if (strcmp(argv[2], "dual") && strcmp(argv[2], "bredr") &&
+				strcmp(argv[2], "le")) {
+		bt_shell_printf("Invalid allowed bearers mode: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	str = strdup(argv[2]);
+
+	if (g_dbus_proxy_set_property_basic(proxy, "AllowedBearers",
+					DBUS_TYPE_STRING, &str,
+					generic_callback, str, free))
+		return;
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void cmd_list_attributes(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -4161,6 +4192,8 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
 				"Get/Set preferred bearer", dev_generator },
+	{ "allowed-bearers", "<dev> [dual/bredr/le]", cmd_allowed_bearers,
+				"Get/Set allowed bearers", dev_generator },
 	{ } },
 };
 
diff --git a/doc/bluetoothctl.rst b/doc/bluetoothctl.rst
index 23f92a512..d9e9a5f04 100644
--- a/doc/bluetoothctl.rst
+++ b/doc/bluetoothctl.rst
@@ -524,6 +524,27 @@ Get/Set preferred bearer.
 	| [CHG] Device <addr> PreferredBearer: bredr
 	| Changing bredr succeeded
 
+allowed-bearers
+---------------
+
+Get/Set the bearers allowed for a dual-mode device.
+
+:Usage: **> allowed-bearers <dev> [dual/bredr/le]**
+:Uses: **org.bluez.Device(5)** property **AllowedBearers**
+:<dev>: Device MAC address (XX:XX:XX:XX:XX:XX) or object path (required)
+:[dual/bredr/le]: "dual" allows BR/EDR and LE, "bredr" allows BR/EDR only, and "le" allows LE only (optional)
+:Example get allowed bearers:
+	| > allowed-bearers <addr>
+	|    AllowedBearers: dual
+:Example allow only LE:
+	| > allowed-bearers <addr> le
+	| [CHG] Device <addr> AllowedBearers: le
+	| Changing le succeeded
+:Example allow only BR/EDR:
+	| > allowed-bearers <addr> bredr
+	| [CHG] Device <addr> AllowedBearers: bredr
+	| Changing bredr succeeded
+
 Advertise Submenu
 =================
 
diff --git a/doc/functional-bearer.rst b/doc/functional-bearer.rst
index 8331a2a6d..706ac6bbf 100644
--- a/doc/functional-bearer.rst
+++ b/doc/functional-bearer.rst
@@ -181,3 +181,51 @@ test_bearer_bredr_pair
 :Notes: The ACL link is terminated a short time after the profiles are
 	disconnected, so the ``Disconnected`` signal follows the reply to
 	``Disconnect``.
+
+test_bearer_allowed_bearers
+----------------------------
+
+:Setup: As for test_bearer_bredr_pair, with
+	``Experimental = true`` enabled on both hosts.
+
+:Steps:
+	1. Host0 pairs with host1 over BR/EDR.
+	2. Host0 reads ``AllowedBearers`` and sets it to ``le``, ``bredr``,
+	   and ``dual`` in turn.
+	3. Host0 attempts to set ``AllowedBearers`` to ``invalid``.
+
+:Expected:
+	1. ``Pair`` replies and both hosts have dual-mode bearer objects.
+	2. ``AllowedBearers`` reports each successfully selected mode. Selecting
+	   ``le`` removes the BR/EDR bearer interface and selecting ``bredr``
+	   removes the LE bearer interface.
+	3. The invalid value is rejected with
+	   ``org.bluez.Error.InvalidArguments`` and the previous valid mode is
+	   unchanged.
+
+test_bearer_allowed_bearers_persistence
+---------------------------------------
+
+:Setup: As above, with host0 using a restartable **bluetoothd(8)** and
+	``Experimental = true`` enabled.
+
+:Steps:
+	1. Host0 pairs with host1 over BR/EDR and sets ``AllowedBearers`` to
+	   ``le``.
+	2. Host0 restarts **bluetoothd(8)** using the same state directory.
+	3. Host0 removes the stored ``AllowedBearers`` value and restarts
+	   **bluetoothd(8)** again.
+
+:Expected:
+	1. After the first restart, ``AllowedBearers`` remains ``le``, the
+	   BR/EDR bearer interface is unavailable, and a BR/EDR connection
+	   attempt fails.
+	2. When no value is stored, ``AllowedBearers`` defaults to ``dual``,
+	   the BR/EDR bearer interface is available, and a BR/EDR connection
+	   succeeds.
+
+The same single-device policy is also tested with global LE-only and
+BR/EDR-only controller modes. A bearer is available only if it is enabled by
+both the controller mode and the device's supported bearers; this can leave
+both bearers available when the controller supports them and the device supports
+a dual-mode configuration.
diff --git a/doc/org.bluez.Device.rst b/doc/org.bluez.Device.rst
index f3e4bfa4a..c22e2a9cf 100644
--- a/doc/org.bluez.Device.rst
+++ b/doc/org.bluez.Device.rst
@@ -457,6 +457,29 @@ which can contain the following:
 
 	Rank of the device in the Set.
 
+string AllowedBearers [readwrite, optional, experimental]
+``````````````````````````````````````````````````
+
+Restricts the bearers that can be used for this dual-mode device. Possible
+values are ``dual``, ``bredr``, and ``le``:
+
+:"dual": Allow both BR/EDR and LE.
+
+:"bredr": Allow BR/EDR only and block LE.
+
+:"le": Allow LE only and block BR/EDR.
+
+The setter rejects unsupported values, bearers disabled by the global
+``ControllerMode``, and unknown values with
+``org.bluez.Error.InvalidArguments``. Setting this property prevents the other
+bearer from being connected, including incoming connections and automatic
+connections. Changing the property disconnects bearer links that are no longer
+allowed; it does not disconnect links on an allowed bearer.
+
+The property is persisted and is only available for dual-mode devices. Invalid
+persisted values are reset to the effective mode for the supported bearers.
+Legacy persisted arrays are converted to these string values.
+
 string PreferredBearer [readwrite, optional, experimental]
 ``````````````````````````````````````````````````````````
 
diff --git a/doc/settings-storage.txt b/doc/settings-storage.txt
index 8bd677e24..f7b5f8d01 100644
--- a/doc/settings-storage.txt
+++ b/doc/settings-storage.txt
@@ -293,6 +293,7 @@ Long term key) related to a remote device.
 			strings		remote in 128-bits UUID format,
 					separated by ";"
 
+  AllowedBearers	String		Allowed bearer mode for remote dual-mode device
   PreferredBearer	String		Preferred bearer for remote device
   LastUsedBearer	String		Last used bearer for remote device
 
diff --git a/src/adapter.c b/src/adapter.c
index 112312651..bddfe0fd4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4949,9 +4949,9 @@ static uint8_t get_addr_type(GKeyFile *keyfile)
 	uint8_t addr_type;
 	char *type;
 
-	/* The AddressType is written to file only When dev->le is
-	 * set to true, as referenced in the update_technologies().
-	 * Therefore, When type is NULL, it default to BDADDR_BREDR.
+	/* AddressType is stored when LE support is known, as referenced in
+	 * update_technologies(). Therefore, when type is NULL, it defaults to
+	 * BDADDR_BREDR.
 	 */
 	type = g_key_file_get_string(keyfile, "General", "AddressType", NULL);
 	if (!type)
@@ -5681,6 +5681,13 @@ static void adapter_add_connection(struct btd_adapter *adapter,
 						uint8_t bdaddr_type,
 						uint32_t flags)
 {
+	if (!btd_device_bearer_allowed(device, bdaddr_type)) {
+		btd_adapter_disconnect_device(adapter,
+							device_get_address(device),
+							bdaddr_type);
+		return;
+	}
+
 	device_add_connection(device, bdaddr_type, flags);
 
 	if (g_slist_find(adapter->connections, device)) {
diff --git a/src/bearer.c b/src/bearer.c
index 154e132ae..c2f3fd77c 100644
--- a/src/bearer.c
+++ b/src/bearer.c
@@ -139,6 +139,12 @@ static DBusMessage *bearer_connect(DBusConnection *conn, DBusMessage *msg,
 	DBusMessage *reply;
 	int err;
 
+	if (!btd_device_bearer_allowed(device, bearer->type)) {
+		if (msg)
+			return btd_error_failed(msg, "Bearer not allowed");
+		return NULL;
+	}
+
 	if (btd_device_bdaddr_type_connected(device, bearer->type)) {
 		if (msg)
 			return btd_error_already_connected(msg);
@@ -532,6 +538,9 @@ struct btd_bearer *btd_bearer_new(struct btd_device *device, uint8_t type)
 {
 	struct btd_bearer *bearer;
 
+	if (!btd_device_bearer_allowed(device, type))
+		return NULL;
+
 	switch (btd_opts.mode) {
 	case BT_MODE_LE:
 		if (type == BDADDR_BREDR)
diff --git a/src/device.c b/src/device.c
index 36a980d1e..67bb01041 100644
--- a/src/device.c
+++ b/src/device.c
@@ -274,6 +274,12 @@ struct btd_device {
 	struct btd_gatt_client *client_dbus;
 
 	uint8_t prefer_bearer;
+	bool allowed_bredr;
+	bool allowed_le;
+	bool allowed_bearers_set;
+	bool bredr_supported;
+	bool le_supported;
+	uint8_t le_address_type;
 	struct bearer_state bredr_state;
 	struct bearer_state le_state;
 
@@ -332,7 +338,7 @@ static struct bearer_state *get_state(struct btd_device *dev,
 
 static bool device_connectable_known(struct btd_device *dev)
 {
-	if (dev->bredr)
+	if (dev->bredr_supported)
 		return true;
 
 	return get_state(dev, dev->bdaddr_type)->last_seen != 0;
@@ -397,7 +403,7 @@ static GSList *find_service_with_uuid(GSList *list, char *uuid)
 static const char *device_prefer_bearer_str(struct btd_device *device)
 {
 	/* Check if both BR/EDR and LE bearer are supported */
-	if (!device->bredr || !device->le)
+	if (!device->bredr_supported || !device->le_supported)
 		return NULL;
 
 	switch (device->prefer_bearer) {
@@ -414,6 +420,99 @@ static const char *device_prefer_bearer_str(struct btd_device *device)
 	return NULL;
 }
 
+bool btd_device_bearer_allowed(struct btd_device *device, uint8_t bdaddr_type)
+{
+	if (bdaddr_type == BDADDR_BREDR)
+		return device->bredr_supported && device->allowed_bredr &&
+				btd_opts.mode != BT_MODE_LE;
+
+	return device->le_supported && device->allowed_le &&
+				btd_opts.mode != BT_MODE_BREDR;
+}
+
+static void device_normalize_allowed_bearers(struct btd_device *device)
+{
+	device->allowed_bredr = device->bredr_supported &&
+				btd_opts.mode != BT_MODE_LE;
+	device->allowed_le = device->le_supported &&
+				btd_opts.mode != BT_MODE_BREDR;
+}
+
+static bool device_parse_allowed_bearers(struct btd_device *device,
+							const char *mode,
+							bool check_adapter_mode,
+							bool *bredr, bool *le)
+{
+	if (!bredr || !le)
+		return false;
+
+	if (!strcmp(mode, "dual")) {
+		if (!device->bredr_supported || !device->le_supported)
+			return false;
+
+		if (check_adapter_mode &&
+				(btd_opts.mode == BT_MODE_LE ||
+				btd_opts.mode == BT_MODE_BREDR))
+			return false;
+
+		*bredr = true;
+		*le = true;
+		return true;
+	}
+
+	if (!strcmp(mode, "bredr") && device->bredr_supported) {
+		if (check_adapter_mode && btd_opts.mode == BT_MODE_LE)
+			return false;
+
+		*bredr = true;
+		*le = false;
+		return true;
+	}
+
+	if (!strcmp(mode, "le") && device->le_supported) {
+		if (check_adapter_mode && btd_opts.mode == BT_MODE_BREDR)
+			return false;
+
+		*bredr = false;
+		*le = true;
+		return true;
+	}
+
+	return false;
+}
+
+static const char *device_allowed_bearers_str(struct btd_device *device)
+{
+	if (device->allowed_bredr && device->allowed_le)
+		return "dual";
+
+	if (device->allowed_bredr)
+		return "bredr";
+
+	if (device->allowed_le)
+		return "le";
+
+	return NULL;
+}
+
+static const char *device_effective_allowed_bearers_str(
+						struct btd_device *device)
+{
+	bool bredr = btd_device_bearer_allowed(device, BDADDR_BREDR);
+	bool le = btd_device_bearer_allowed(device, BDADDR_LE_PUBLIC);
+
+	if (bredr && le)
+		return "dual";
+
+	if (bredr)
+		return "bredr";
+
+	if (le)
+		return "le";
+
+	return NULL;
+}
+
 static bool device_set_prefer_bearer(struct btd_device *device, uint8_t bearer)
 {
 	switch (bearer) {
@@ -463,10 +562,10 @@ static void update_technologies(GKeyFile *file, struct btd_device *dev)
 	size_t len = 0;
 	const char *bearer;
 
-	if (dev->bredr)
+	if (dev->bredr_supported)
 		list[len++] = "BR/EDR";
 
-	if (dev->le) {
+	if (dev->le_supported) {
 		const char *type;
 
 		if (dev->bdaddr_type == BDADDR_LE_PUBLIC)
@@ -482,6 +581,14 @@ static void update_technologies(GKeyFile *file, struct btd_device *dev)
 	g_key_file_set_string_list(file, "General", "SupportedTechnologies",
 								list, len);
 
+	if (dev->bredr_supported && dev->le_supported) {
+		const char *mode = device_allowed_bearers_str(dev);
+
+		if (mode)
+			g_key_file_set_string(file, "General", "AllowedBearers",
+							mode);
+	}
+
 	/* Store the PreferredBearer in case of dual-mode devices */
 	bearer = device_prefer_bearer_str(dev);
 	if (bearer) {
@@ -1010,7 +1117,8 @@ static gboolean property_get_address_type(const GDBusPropertyTable *property,
 	struct btd_device *device = user_data;
 	const char *str;
 
-	if (device->le && device->bdaddr_type == BDADDR_LE_RANDOM)
+	if (device->le_supported &&
+			device->le_address_type == BDADDR_LE_RANDOM)
 		str = "random";
 	else
 		str = "public";
@@ -1967,11 +2075,11 @@ int device_block(struct btd_device *device, gboolean update_only)
 	}
 
 	if (!update_only) {
-		if (device->le)
+		if (device->le_supported)
 			err = btd_adapter_block_address(device->adapter,
 							&device->bdaddr,
 							device->bdaddr_type);
-		if (!err && device->bredr)
+		if (!err && device->bredr_supported)
 			err = btd_adapter_block_address(device->adapter,
 							&device->bdaddr,
 							BDADDR_BREDR);
@@ -2001,11 +2109,11 @@ int device_unblock(struct btd_device *device, gboolean silent,
 		return 0;
 
 	if (!update_only) {
-		if (device->le)
+		if (device->le_supported)
 			err = btd_adapter_unblock_address(device->adapter,
 							&device->bdaddr,
 							device->bdaddr_type);
-		if (!err && device->bredr)
+		if (!err && device->bredr_supported)
 			err = btd_adapter_unblock_address(device->adapter,
 							&device->bdaddr,
 							BDADDR_BREDR);
@@ -2331,9 +2439,13 @@ static void device_set_auto_connect(struct btd_device *device, gboolean enable)
 	char addr[18];
 	const char *bearer;
 
-	if (!device || !device->le)
+	if (!device || !device->le_supported)
 		return;
 
+	if (enable && !btd_device_bearer_allowed(device,
+							device->le_address_type))
+		enable = FALSE;
+
 	ba2str(&device->bdaddr, addr);
 
 	DBG("%s auto connect: %d", addr, enable);
@@ -2489,7 +2601,9 @@ done:
 
 	if (err) {
 		/* Fallback to LE bearer if supported */
-		if (err == -EHOSTDOWN && dev->le && !dev->le_state.connected) {
+		if (err == -EHOSTDOWN &&
+				btd_device_bearer_allowed(dev, BDADDR_LE_PUBLIC) &&
+				!dev->le_state.connected) {
 			err = device_connect_le(dev);
 			if (err == 0)
 				return;
@@ -2499,7 +2613,8 @@ done:
 				btd_error_bredr_errno(dev->connect, err));
 	} else {
 		/* Start passive SDP discovery to update known services */
-		if (dev->bredr && !dev->svc_refreshed && dev->refresh_discovery)
+		if (btd_device_bearer_allowed(dev, BDADDR_BREDR) &&
+				!dev->svc_refreshed && dev->refresh_discovery)
 			device_browse_sdp(dev, NULL);
 		g_dbus_send_reply(dbus_conn, dev->connect, DBUS_TYPE_INVALID);
 	}
@@ -2742,6 +2857,12 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	time_t bredr_last = NVAL_TIME, le_last = NVAL_TIME;
 	time_t current = time(NULL);
 
+	if (!dev->allowed_bredr)
+		return dev->le_address_type;
+
+	if (!dev->allowed_le)
+		return BDADDR_BREDR;
+
 	/* Use preferred bearer or bonded bearer in case only one is bonded */
 	if (dev->bredr_state.prefer ||
 			(dev->bredr_state.bonded && !dev->le_state.bonded))
@@ -2769,10 +2890,10 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 	if (le_last == NVAL_TIME && bredr_last == NVAL_TIME)
 		return dev->bdaddr_type;
 
-	if (dev->bredr && (!dev->le || le_last == NVAL_TIME))
+	if (dev->bredr_supported && (!dev->le_supported || le_last == NVAL_TIME))
 		return BDADDR_BREDR;
 
-	if (dev->le && (!dev->bredr || bredr_last == NVAL_TIME))
+	if (dev->le_supported && (!dev->bredr_supported || bredr_last == NVAL_TIME))
 		return dev->bdaddr_type;
 
 	/*
@@ -2808,6 +2929,9 @@ int btd_device_connect_services(struct btd_device *dev, GSList *services)
 		return -ENETDOWN;
 
 	bdaddr_type = select_conn_bearer(dev);
+	if (!btd_device_bearer_allowed(dev, bdaddr_type))
+		return -ENOTSUP;
+
 	if (bdaddr_type != BDADDR_BREDR) {
 		if (dev->le_state.connected)
 			return -EALREADY;
@@ -2849,6 +2973,9 @@ DBusMessage *device_connect_profiles(struct btd_device *dev,
 	struct bearer_state *state = get_state(dev, bdaddr_type);
 	int err;
 
+	if (!btd_device_bearer_allowed(dev, bdaddr_type))
+		return btd_error_failed(msg, "Bearer not allowed");
+
 	DBG("%s %s, client %s", dev->path, uuid ? uuid : "(all)",
 						dbus_message_get_sender(msg));
 
@@ -2924,10 +3051,17 @@ static DBusMessage *dev_connect(DBusConnection *conn, DBusMessage *msg,
 			bdaddr_type = dev->bdaddr_type;
 		else
 			bdaddr_type = BDADDR_BREDR;
-	} else if (dev->le_state.connected && dev->bredr)
-		bdaddr_type = BDADDR_BREDR;
-	else
+	} else if (dev->le_state.connected) {
+		if (btd_device_bearer_allowed(dev, BDADDR_BREDR))
+			bdaddr_type = BDADDR_BREDR;
+		else
+			bdaddr_type = dev->le_address_type;
+	} else {
 		bdaddr_type = select_conn_bearer(dev);
+	}
+
+	if (!btd_device_bearer_allowed(dev, bdaddr_type))
+		return btd_error_failed(msg, "Bearer not allowed");
 
 	dev->auth_failures = 0;
 
@@ -3190,7 +3324,8 @@ static void browse_request_complete(struct browse_req *req, uint8_t type,
 	if (err) {
 		/* Fallback to LE bearer if supported */
 		if (err == -EHOSTDOWN && bdaddr_type == BDADDR_BREDR &&
-				dev->le && !dev->le_state.connected) {
+				btd_device_bearer_allowed(dev, BDADDR_LE_PUBLIC) &&
+				!dev->le_state.connected) {
 			err = device_connect_le(dev);
 			if (err == 0)
 				goto done;
@@ -3432,24 +3567,21 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 	enum mgmt_io_capability io_cap;
 	int err;
 
-	btd_device_set_temporary(device, false);
-
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_INVALID))
 		return btd_error_invalid_args(msg);
 
 	if (device->bonding || device->connect)
 		return btd_error_in_progress(msg);
 
-	/* Only use this selection algorithms when device is combo
-	 * chip. Otherwise, it will use the wrong bearer to establish
-	 * a connection if the device is already paired, which will
-	 * stall the pairing procedure. For example, for a BLE only
-	 * device, if the device is already paired, and upper layer
-	 * issue the pair device again, it will set bdaddr_type to
-	 * BDADDR_BREDR since LE is bonded, then it goes with BR/EDR
-	 * bearer.
-	 */
-	if (device->bredr && device->le) {
+	if (!device->allowed_bredr) {
+		bdaddr_type = device->le_address_type;
+	} else if (!device->allowed_le) {
+		bdaddr_type = BDADDR_BREDR;
+	} else if (device->bredr_supported && device->le_supported) {
+		/* Use the existing selection algorithm only for a combo device.
+		 * Otherwise pairing could select the wrong bearer for a
+		 * BLE-only or BR/EDR-only device.
+		 */
 		if (device->bredr_state.bonded)
 			bdaddr_type = device->bdaddr_type;
 		else if (device->le_state.bonded)
@@ -3460,11 +3592,16 @@ static DBusMessage *pair_device(DBusConnection *conn, DBusMessage *msg,
 		bdaddr_type = device->bdaddr_type;
 	}
 
+	if (!btd_device_bearer_allowed(device, bdaddr_type))
+		return btd_error_failed(msg, "Bearer not allowed");
+
 	state = get_state(device, bdaddr_type);
 
 	if (state->bonded)
 		return btd_error_already_exists(msg);
 
+	btd_device_set_temporary(device, false);
+
 	sender = dbus_message_get_sender(msg);
 
 	agent = agent_get(sender);
@@ -3693,6 +3830,118 @@ static const GDBusSignalTable device_signals[] = {
 	{ }
 };
 
+static void device_sync_bearers(struct btd_device *device);
+
+static void device_apply_allowed_bearers(struct btd_device *device,
+					bool bredr, bool le)
+{
+	device->allowed_bredr = bredr;
+	device->allowed_le = le;
+	device->allowed_bearers_set = true;
+
+	if (!bredr) {
+		device_cancel_browse(device, BDADDR_BREDR);
+		device_remove_pending_services(device, BDADDR_BREDR);
+
+		if (device->bonding &&
+				device->bonding->bdaddr_type == BDADDR_BREDR)
+			device_cancel_bonding(device, MGMT_STATUS_CANCELLED);
+
+	}
+
+	if (!le) {
+		device_cancel_browse(device, device->bdaddr_type);
+		device_remove_pending_services(device, device->bdaddr_type);
+
+		if (device->bonding &&
+				device->bonding->bdaddr_type != BDADDR_BREDR)
+			device_cancel_bonding(device, MGMT_STATUS_CANCELLED);
+	}
+
+	if (!bredr) {
+		if (device->bredr_state.connected)
+			btd_adapter_disconnect_device(device->adapter,
+						&device->bdaddr, BDADDR_BREDR);
+
+		if (le)
+			device_set_prefer_bearer(device, PREFER_LE);
+	} else if (!le) {
+		if (device->le_state.connected)
+			btd_adapter_disconnect_device(device->adapter,
+					&device->bdaddr,
+					device->le_address_type);
+
+		device_set_prefer_bearer(device, PREFER_BREDR);
+	}
+
+	device_sync_bearers(device);
+
+	if (!bredr)
+		device_set_auto_connect(device, TRUE);
+	else
+		device_set_auto_connect(device, le);
+
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "PreferredBearer");
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "AllowedBearers");
+	store_device_info(device);
+}
+
+static gboolean
+dev_property_get_allowed_bearers(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_device *device = data;
+	const char *bearer = device_effective_allowed_bearers_str(device);
+
+	if (!bearer)
+		return FALSE;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &bearer);
+
+	return TRUE;
+}
+
+static void dev_property_set_allowed_bearers(const GDBusPropertyTable *property,
+					DBusMessageIter *value,
+					GDBusPendingPropertySet id, void *data)
+{
+	struct btd_device *device = data;
+	const char *bearer;
+	bool bredr;
+	bool le;
+
+	if (dbus_message_iter_get_arg_type(value) != DBUS_TYPE_STRING) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	dbus_message_iter_get_basic(value, &bearer);
+
+	if (!device_parse_allowed_bearers(device, bearer, true, &bredr, &le)) {
+		g_dbus_pending_property_error(id,
+					ERROR_INTERFACE ".InvalidArguments",
+					"Invalid arguments in method call");
+		return;
+	}
+
+	device_apply_allowed_bearers(device, bredr, le);
+	g_dbus_pending_property_success(id);
+}
+
+static gboolean
+dev_property_allowed_bearers_exists(const GDBusPropertyTable *property,
+					void *data)
+{
+	struct btd_device *device = data;
+
+	return device->bredr_supported && device->le_supported &&
+		device_effective_allowed_bearers_str(device) != NULL;
+}
+
 static gboolean
 dev_property_get_prefer_bearer(const GDBusPropertyTable *property,
 				DBusMessageIter *iter, void *data)
@@ -3826,6 +4075,10 @@ static const GDBusPropertyTable device_properties[] = {
 				dev_property_wake_allowed_exist },
 	{ "Sets", "a{oa{sv}}", dev_property_get_set, NULL,
 				dev_property_set_exists },
+	{ "AllowedBearers", "s", dev_property_get_allowed_bearers,
+				dev_property_set_allowed_bearers,
+				dev_property_allowed_bearers_exists,
+				G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "PreferredBearer", "s", dev_property_get_prefer_bearer,
 				dev_property_set_prefer_bearer,
 				dev_property_prefer_bearer_exists,
@@ -4167,6 +4420,7 @@ void device_remove_connection(struct btd_device *device, uint8_t bdaddr_type,
 	}
 
 	device_disconnected(device, reason);
+	device_sync_bearers(device);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 						DEVICE_INTERFACE, "Connected");
@@ -4488,28 +4742,117 @@ static void load_info(struct btd_device *device, const char *local,
 
 	for (t = techno; *t; t++) {
 		if (g_str_equal(*t, "BR/EDR"))
-			device->bredr = btd_bearer_new(device, BDADDR_BREDR);
+			device->bredr_supported = true;
 		else if (g_str_equal(*t, "LE"))
-			device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
+			device->le_supported = true;
 		else
 			error("Unknown device technology");
 	}
 
-	if (!device->le) {
-		device->bdaddr_type = BDADDR_BREDR;
-	} else {
+	if (device->le_supported) {
+		device->bdaddr_type = BDADDR_LE_PUBLIC;
+		device->le_address_type = BDADDR_LE_PUBLIC;
+
 		str = g_key_file_get_string(key_file, "General",
-						"AddressType", NULL);
+							"AddressType", NULL);
 
-		if (str && g_str_equal(str, "public"))
+		if (str && g_str_equal(str, "public")) {
 			device->bdaddr_type = BDADDR_LE_PUBLIC;
-		else if (str && g_str_equal(str, "static"))
+			device->le_address_type = BDADDR_LE_PUBLIC;
+		} else if (str && g_str_equal(str, "static")) {
 			device->bdaddr_type = BDADDR_LE_RANDOM;
-		else
+			device->le_address_type = BDADDR_LE_RANDOM;
+		} else if (str) {
 			error("Unknown LE device technology");
+		}
 
 		g_free(str);
+	} else {
+		device->bdaddr_type = BDADDR_BREDR;
+		device->le_address_type = BDADDR_LE_PUBLIC;
+	}
+
+	{
+		char *allowed = NULL;
+		char **legacy;
+
+		legacy = g_key_file_get_string_list(key_file, "General",
+								"AllowedBearers", NULL,
+								NULL);
+		if (legacy) {
+			bool bredr = false;
+			bool le = false;
+			bool dual = false;
+			bool invalid = false;
+
+			for (char **p = legacy; *p; p++) {
+				if (g_str_equal(*p, "dual") && !dual && !bredr && !le)
+					dual = true;
+				else if (g_str_equal(*p, "bredr") && !dual && !bredr)
+					bredr = true;
+				else if (g_str_equal(*p, "le") && !dual && !le)
+					le = true;
+				else
+					invalid = true;
+			}
+
+			if (!invalid) {
+				if (dual || (bredr && le))
+					allowed = g_strdup("dual");
+				else if (bredr)
+					allowed = g_strdup("bredr");
+				else if (le)
+					allowed = g_strdup("le");
+			}
 
+			g_strfreev(legacy);
+		} else {
+			allowed = g_key_file_get_string(key_file, "General",
+								"AllowedBearers",
+								NULL);
+		}
+
+		if (allowed) {
+			bool bredr;
+			bool le;
+
+			if (device_parse_allowed_bearers(device, allowed, true,
+									&bredr,
+									&le)) {
+				device->allowed_bredr = bredr;
+				device->allowed_le = le;
+				device->allowed_bearers_set = true;
+				g_key_file_set_string(key_file, "General",
+								"AllowedBearers", allowed);
+			} else {
+				device->allowed_bearers_set = false;
+				device_normalize_allowed_bearers(device);
+				if (device_effective_allowed_bearers_str(device))
+					g_key_file_set_string(key_file, "General",
+							"AllowedBearers",
+							device_effective_allowed_bearers_str(device));
+			}
+
+			g_free(allowed);
+		} else {
+			device->allowed_bearers_set = false;
+			device_normalize_allowed_bearers(device);
+			if (device_effective_allowed_bearers_str(device))
+				g_key_file_set_string(key_file, "General",
+								"AllowedBearers",
+								device_effective_allowed_bearers_str(device));
+		}
+	}
+
+	if (device->bredr_supported && device->allowed_bredr)
+		device->bredr = btd_bearer_new(device, BDADDR_BREDR);
+
+	if (device->le_supported && device->allowed_le)
+		device->le = btd_bearer_new(device, device->le_address_type);
+
+	if (!device->le_supported) {
+		device->bdaddr_type = BDADDR_BREDR;
+	} else {
 		device->local_csrk = load_csrk(key_file, "LocalSignatureKey");
 		device->remote_csrk = load_csrk(key_file, "RemoteSignatureKey");
 
@@ -5087,6 +5430,10 @@ static struct btd_device *device_new(struct btd_adapter *adapter,
 	device->tx_power = 127;
 	device->volume = -1;
 	device->wake_id = -1U;
+	device->le_address_type = BDADDR_LE_PUBLIC;
+	device->allowed_bredr = true;
+	device->allowed_le = true;
+	device->allowed_bearers_set = false;
 
 	device->db = gatt_db_new();
 	if (!device->db) {
@@ -5179,10 +5526,18 @@ struct btd_device *device_create(struct btd_adapter *adapter,
 
 	device->bdaddr_type = bdaddr_type;
 
-	if (bdaddr_type == BDADDR_BREDR)
-		device->bredr = btd_bearer_new(device, BDADDR_BREDR);
-	else
-		device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
+	if (bdaddr_type == BDADDR_BREDR) {
+		if (!device->allowed_bearers_set)
+			device->allowed_bredr = true;
+		device->bredr_supported = true;
+	} else {
+		if (!device->allowed_bearers_set)
+			device->allowed_le = true;
+		device->le_supported = true;
+		device->le_address_type = bdaddr_type;
+	}
+
+	device_sync_bearers(device);
 
 	storage_dir = btd_adapter_get_storage_dir(adapter);
 	str = load_cached_name(device, storage_dir, dst);
@@ -5358,8 +5713,10 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 	/* Since this function is only used for LE SMP Identity
 	 * Resolving purposes we can now assume LE is supported.
 	 */
-	if (!device->le)
-		device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
+	if (!device->allowed_bearers_set)
+		device->allowed_le = true;
+
+	device->le_supported = true;
 
 	/* Remove old address from accept/auto-connect list since its address
 	 * will be changed.
@@ -5369,6 +5726,9 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 
 	bacpy(&device->bdaddr, bdaddr);
 	device->bdaddr_type = bdaddr_type;
+	device->le_address_type = bdaddr_type;
+
+	device_sync_bearers(device);
 
 	if (device->temporary)
 		btd_device_set_temporary(device, false);
@@ -5384,30 +5744,57 @@ void device_update_addr(struct btd_device *device, const bdaddr_t *bdaddr,
 		device_set_auto_connect(device, TRUE);
 }
 
+static void device_sync_bearers(struct btd_device *device)
+{
+	if (!btd_device_bearer_allowed(device, BDADDR_BREDR) &&
+				device->bredr &&
+				!device->bredr_state.connected) {
+		btd_bearer_destroy(device->bredr);
+		device->bredr = NULL;
+	} else if (btd_device_bearer_allowed(device, BDADDR_BREDR) &&
+				!device->bredr) {
+		device->bredr = btd_bearer_new(device, BDADDR_BREDR);
+	}
+
+	if (!btd_device_bearer_allowed(device, BDADDR_LE_PUBLIC) &&
+				device->le && !device->le_state.connected) {
+		btd_bearer_destroy(device->le);
+		device->le = NULL;
+	} else if (btd_device_bearer_allowed(device, BDADDR_LE_PUBLIC) &&
+				!device->le) {
+		device->le = btd_bearer_new(device, device->le_address_type);
+	}
+}
+
 void device_set_bredr_support(struct btd_device *device)
 {
-	if (btd_opts.mode == BT_MODE_LE || device->bredr)
-		return;
+	if (!device->allowed_bearers_set)
+		device->allowed_bredr = true;
 
-	if (!device->bredr)
-		device->bredr = btd_bearer_new(device, BDADDR_BREDR);
+	device->bredr_supported = true;
+
+	device_sync_bearers(device);
 
 	if (device->le)
 		g_dbus_emit_property_changed(dbus_conn, device->path,
 					DEVICE_INTERFACE, "PreferredBearer");
 
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "AllowedBearers");
+
 	store_device_info(device);
 }
 
 void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 {
-	if (btd_opts.mode == BT_MODE_BREDR || device->le)
-		return;
-
-	if (!device->le)
-		device->le = btd_bearer_new(device, BDADDR_LE_PUBLIC);
+	if (!device->allowed_bearers_set)
+		device->allowed_le = true;
 
+	device->le_supported = true;
 	device->bdaddr_type = bdaddr_type;
+	device->le_address_type = bdaddr_type;
+
+	device_sync_bearers(device);
 
 	g_dbus_emit_property_changed(dbus_conn, device->path,
 					DEVICE_INTERFACE, "AddressType");
@@ -5416,6 +5803,9 @@ void device_set_le_support(struct btd_device *device, uint8_t bdaddr_type)
 		g_dbus_emit_property_changed(dbus_conn, device->path,
 					DEVICE_INTERFACE, "PreferredBearer");
 
+	g_dbus_emit_property_changed(dbus_conn, device->path,
+					DEVICE_INTERFACE, "AllowedBearers");
+
 	store_device_info(device);
 }
 
@@ -5469,8 +5859,10 @@ void device_merge_duplicate(struct btd_device *dev, struct btd_device *dup)
 	/* dup keeps its own bearer, which is destroyed along with it, so
 	 * dev needs a bearer of its own unless it already has one.
 	 */
-	if (!dev->bredr)
-		dev->bredr = btd_bearer_new(dev, BDADDR_BREDR);
+	if (!dev->allowed_bearers_set)
+		dev->allowed_bredr = true;
+	dev->bredr_supported = true;
+	device_sync_bearers(dev);
 
 	/* Connection state stays with dup, which owns the link and gets
 	 * its disconnection, so only the pairing state is inherited.
@@ -5770,13 +6162,13 @@ int device_addr_type_cmp(gconstpointer a, gconstpointer b)
 		return 0;
 
 	if (addr->bdaddr_type == BDADDR_BREDR) {
-		if (!dev->bredr)
+		if (!dev->bredr_supported)
 			return -1;
 
 		return cmp;
 	}
 
-	if (!dev->le)
+	if (!dev->le_supported)
 		return -1;
 
 	if (addr->bdaddr_type != dev->bdaddr_type) {
@@ -6856,6 +7248,9 @@ done:
 int device_connect_le(struct btd_device *dev)
 {
 	struct btd_adapter *adapter = dev->adapter;
+
+	if (!btd_device_bearer_allowed(dev, dev->le_address_type))
+		return -ENOTSUP;
 	BtIOSecLevel sec_level;
 	GIOChannel *io;
 	GError *gerr = NULL;
@@ -7086,6 +7481,9 @@ int device_discover_services(struct btd_device *device,
 {
 	int err;
 
+	if (!btd_device_bearer_allowed(device, bdaddr_type))
+		return -ENOTSUP;
+
 	if (bdaddr_type == BDADDR_BREDR)
 		err = device_browse_sdp(device, msg);
 	else
@@ -7113,7 +7511,7 @@ const bdaddr_t *device_get_address(struct btd_device *device)
 }
 uint8_t device_get_le_address_type(struct btd_device *device)
 {
-	return device->bdaddr_type;
+	return device->le_address_type;
 }
 
 const char *device_get_path(const struct btd_device *device)
@@ -7427,7 +7825,7 @@ bool device_is_connectable(struct btd_device *device)
 	if (!device)
 		return false;
 
-	if (device->bredr)
+	if (device->bredr_supported)
 		return true;
 
 	state = get_state(device, device->bdaddr_type);
@@ -7439,7 +7837,7 @@ static bool start_discovery_cb(gpointer user_data)
 {
 	struct btd_device *device = user_data;
 
-	if (device->bredr)
+	if (btd_device_bearer_allowed(device, BDADDR_BREDR))
 		device_browse_sdp(device, NULL);
 	else
 		device_browse_gatt(device, NULL);
diff --git a/src/device.h b/src/device.h
index 047a894c3..4d61b2a41 100644
--- a/src/device.h
+++ b/src/device.h
@@ -125,6 +125,7 @@ void device_set_rssi(struct btd_device *device, int8_t rssi);
 void device_set_tx_power(struct btd_device *device, int8_t tx_power);
 void device_set_flags(struct btd_device *device, uint8_t flags);
 bool btd_device_is_connected(struct btd_device *dev);
+bool btd_device_bearer_allowed(struct btd_device *dev, uint8_t bdaddr_type);
 bool btd_device_bearer_is_connected(struct btd_device *dev);
 bool btd_device_bdaddr_type_connected(struct btd_device *dev, uint8_t type);
 bool btd_device_bdaddr_type_connectable(struct btd_device *dev, uint8_t type);
diff --git a/test/functional/test_bearer.py b/test/functional/test_bearer.py
index 3f1033b35..ca34fa4c4 100644
--- a/test/functional/test_bearer.py
+++ b/test/functional/test_bearer.py
@@ -8,6 +8,10 @@ interfaces of the device object it has for the other.
 """
 
 import logging
+import os
+import re
+import subprocess
+from pathlib import Path
 
 import dbus
 import pytest
@@ -57,6 +61,10 @@ CONN_PARAMS = ("Interval", "Latency", "SupervisionTimeout", "Subrate")
 # ReadRSSI is a testing method
 TESTING_CONF = LE_CONF + "Testing = true\n"
 
+ALLOWED_CONF = "[General]\nExperimental = true\n"
+LE_ALLOWED_CONF = "[General]\nControllerMode = le\nExperimental = true\n"
+BREDR_ALLOWED_CONF = "[General]\nControllerMode = bredr\nExperimental = true\n"
+
 
 class Bearers(HostPlugin, EventPluginMixin):
     """
@@ -119,6 +127,51 @@ class Bearers(HostPlugin, EventPluginMixin):
 
         return None
 
+    @mainloop_wrap
+    def get_device_property(self, address, name):
+        """Return a property of the remote Device1 interface."""
+        path = self._device_path(address)
+        if path is None:
+            return None
+
+        props = dbus.Interface(self.bus.get_object(BUS_NAME, path), PROPS_INTERFACE)
+        try:
+            value = props.Get(DEVICE_INTERFACE, name)
+        except dbus.exceptions.DBusException:
+            return None
+
+        return str(value)
+
+    @mainloop_wrap
+    def set_device_property(self, address, name, value):
+        """Set a Device1 property and return its D-Bus error, if any."""
+        path = self._device_path(address)
+        if path is None:
+            return "org.bluez.Error.Failed"
+
+        props = dbus.Interface(self.bus.get_object(BUS_NAME, path), PROPS_INTERFACE)
+        try:
+            props.Set(DEVICE_INTERFACE, name, dbus.String(value))
+        except dbus.exceptions.DBusException as exc:
+            return exc.get_dbus_name()
+
+        return None
+
+    @mainloop_wrap
+    def set_device_property_raw(self, address, name, value):
+        """Set a raw Device1 property and return its D-Bus error."""
+        path = self._device_path(address)
+        if path is None:
+            return "org.bluez.Error.Failed"
+
+        props = dbus.Interface(self.bus.get_object(BUS_NAME, path), PROPS_INTERFACE)
+        try:
+            props.Set(DEVICE_INTERFACE, name, value)
+        except dbus.exceptions.DBusException as exc:
+            return exc.get_dbus_name()
+
+        return None
+
     @mainloop_wrap
     def get(self, address, interface, name):
         """
@@ -140,6 +193,16 @@ class Bearers(HostPlugin, EventPluginMixin):
 
         return str(value)
 
+    @mainloop_wrap
+    def call_device(self, address, method):
+        """Call a method on the remote Device1 interface."""
+        path = self._device_path(address)
+        if path is None:
+            return
+
+        device = dbus.Interface(self.bus.get_object(BUS_NAME, path), DEVICE_INTERFACE)
+        self._object_method(device, method)
+
     @mainloop_wrap
     def call(self, address, interface, method):
         """
@@ -181,6 +244,90 @@ bredr_config = host_config(
     [Bluetoothd(args=ARGS), Agent(), Bearers()],
 )
 
+allowed_config = host_config(
+    [Bluetoothd(conf=ALLOWED_CONF, args=ARGS), Agent(), Bearers()],
+    [Bluetoothd(conf=ALLOWED_CONF, args=ARGS), Agent(), Bearers()],
+)
+
+
+class RestartableBluetoothd(Bluetoothd):
+    """Bluetoothd plugin that can restart while keeping its state directory."""
+
+    def restart(self):
+        command = self.job.args
+        self.job.terminate()
+        self.job.wait()
+
+        env = os.environ.copy()
+        env["STATE_DIRECTORY"] = str(Path(self.tmpdir.name) / "state")
+        self.job = subprocess.Popen(
+            command,
+            env=env,
+            stdin=subprocess.DEVNULL,
+            stdout=self.log_stream.stream,
+            stderr=subprocess.STDOUT,
+        )
+
+    def clear_allowed_bearers(self, address):
+        info_file = self._device_info_file(address)
+        contents = info_file.read_text(encoding="utf-8")
+        contents, count = re.subn(
+            r"^AllowedBearers=.*(?:\r?\n|$)",
+            "",
+            contents,
+            flags=re.MULTILINE,
+        )
+        if count != 1:
+            raise ValueError(f"AllowedBearers not found for {address}")
+
+        info_file.write_text(contents, encoding="utf-8")
+
+    def stored_allowed_bearers(self, address):
+        contents = self._device_info_file(address).read_text(encoding="utf-8")
+        match = re.search(
+            r"^AllowedBearers=(.*?)\r?$",
+            contents,
+            flags=re.MULTILINE,
+        )
+        return match.group(1) if match else None
+
+    def _device_info_file(self, address):
+        storage = Path(self.tmpdir.name) / "state" / "bluetooth"
+        info_files = list(storage.glob(f"*/{address.upper()}/info"))
+        if len(info_files) != 1:
+            raise FileNotFoundError(f"Device info not found for {address}")
+
+        return info_files[0]
+
+
+restartable_allowed_config = host_config(
+    [
+        RestartableBluetoothd(conf=ALLOWED_CONF, args=ARGS),
+        Agent(),
+        Bearers(),
+    ],
+    [
+        Bluetoothd(conf=ALLOWED_CONF, args=ARGS),
+        Agent(),
+        Bearers(),
+    ],
+)
+
+le_allowed_config = host_config(
+    [Bluetoothd(conf=LE_ALLOWED_CONF, args=ARGS), Agent(), Bearers()],
+    [
+        Bluetoothd(conf=LE_ALLOWED_CONF, args=ARGS),
+        LeAdvertiser(),
+        Agent(capability="NoInputNoOutput"),
+        Bearers(),
+    ],
+)
+
+bredr_allowed_config = host_config(
+    [Bluetoothd(conf=BREDR_ALLOWED_CONF, args=ARGS), Agent(), Bearers()],
+    [Bluetoothd(conf=BREDR_ALLOWED_CONF, args=ARGS), Agent(), Bearers()],
+)
+
 
 def start_discovery(host):
     host.agent.adapter_method("StartDiscovery")
@@ -418,6 +565,195 @@ def test_bearer_le_pair(hosts):
         assert host.bearers.get(remote.bdaddr, BREDR_INTERFACE, "Paired") is None
 
 
+@le_allowed_config
+def test_bearer_allowed_bearers_le_mode(hosts):
+    host0, host1 = hosts
+
+    pair_le(host0, host1)
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "le")
+        is None
+    )
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "bredr")
+        == "org.bluez.Error.InvalidArguments"
+    )
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "dual")
+        == "org.bluez.Error.InvalidArguments"
+    )
+
+
+@bredr_allowed_config
+def test_bearer_allowed_bearers_bredr_mode(hosts):
+    host0, host1 = hosts
+
+    pair_bredr(hosts, True)
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "bredr")
+        is None
+    )
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "le")
+        == "org.bluez.Error.InvalidArguments"
+    )
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "dual")
+        == "org.bluez.Error.InvalidArguments"
+    )
+
+
+@allowed_config
+def test_bearer_allowed_bearers(hosts):
+    host0, host1 = hosts
+
+    pair_bredr(hosts, True)
+
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "dual"
+    )
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "le")
+        is None
+    )
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "le"
+    )
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, LE_INTERFACE, "Connected") is False
+    )
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, BREDR_INTERFACE, "Connected") is None
+    )
+
+    host0.bearers.call(host1.bdaddr, BREDR_INTERFACE, "Connect")
+    event = host0.bearers.expect(f"{BREDR_INTERFACE}.Connect:error")
+    assert event.error.get_dbus_name() == "org.bluez.Error.Failed"
+
+    host0.bearers.call_device(host1.bdaddr, "Connect")
+    event = host0.bearers.expect("org.bluez.Device1.Connect:error")
+    assert event.error.get_dbus_name() == "org.bluez.Error.Failed"
+
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "Connect")
+    host0.bearers.expect(f"{LE_INTERFACE}.Connect:reply")
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, LE_INTERFACE, "Connected") is True
+    )
+
+    host0.bearers.call_device(host1.bdaddr, "Connect")
+    host0.bearers.expect("org.bluez.Device1.Connect:reply")
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "bredr")
+        is None
+    )
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "bredr"
+    )
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, BREDR_INTERFACE, "Connected") is False
+    )
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, LE_INTERFACE, "Connected") is None
+    )
+
+    host0.bearers.call(host1.bdaddr, LE_INTERFACE, "Connect")
+    event = host0.bearers.expect(f"{LE_INTERFACE}.Connect:error")
+    assert event.error.get_dbus_name() == "org.bluez.Error.Failed"
+
+    host0.bearers.call_device(host1.bdaddr, "Connect")
+    event = host0.bearers.expect("org.bluez.Device1.Connect:error")
+    assert event.error.get_dbus_name() == "org.bluez.Error.Failed"
+
+    host0.bearers.call(host1.bdaddr, BREDR_INTERFACE, "Connect")
+    host0.bearers.expect(f"{BREDR_INTERFACE}.Connect:reply")
+
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, BREDR_INTERFACE, "Connected") is True
+    )
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "dual")
+        is None
+    )
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "dual"
+    )
+
+    assert (
+        host0.bearers.set_device_property_raw(
+            host1.bdaddr, "AllowedBearers", dbus.Boolean(False)
+        )
+        == "org.bluez.Error.InvalidArguments"
+    )
+
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "invalid")
+        == "org.bluez.Error.InvalidArguments"
+    )
+    assert (
+        host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "dual"
+    )
+
+
+@restartable_allowed_config
+def test_bearer_allowed_bearers_persistence(hosts):
+    host0, host1 = hosts
+
+    pair_bredr(hosts, True)
+
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "dual"
+    )
+    assert (
+        host0.bearers.set_device_property(host1.bdaddr, "AllowedBearers", "le")
+        is None
+    )
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "le"
+    )
+    wait_until(
+        lambda: host0.bluetoothd.stored_allowed_bearers(host1.bdaddr) == "le"
+    )
+
+    host0.bluetoothd.restart()
+
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "le"
+    )
+    assert host0.bearers.get(host1.bdaddr, BREDR_INTERFACE, "Connected") is None
+    host0.bearers.call(host1.bdaddr, BREDR_INTERFACE, "Connect")
+    event = host0.bearers.expect(f"{BREDR_INTERFACE}.Connect:error")
+    assert event.error.get_dbus_name() == "org.bluez.Error.Failed"
+
+    host0.bluetoothd.clear_allowed_bearers(host1.bdaddr)
+    host0.bluetoothd.restart()
+
+    wait_until(
+        lambda: host0.bearers.get_device_property(host1.bdaddr, "AllowedBearers")
+        == "dual"
+    )
+    assert host0.bearers.get(host1.bdaddr, BREDR_INTERFACE, "Connected") is False
+    host0.bearers.call(host1.bdaddr, BREDR_INTERFACE, "Connect")
+    host0.bearers.expect(f"{BREDR_INTERFACE}.Connect:reply")
+    wait_until(
+        lambda: host0.bearers.get(host1.bdaddr, BREDR_INTERFACE, "Connected") is True
+    )
+
+
 @bredr_config
 def test_bearer_bredr_pair(hosts):
     host0, host1 = hosts
-- 
2.56.1

