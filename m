Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61422F163
	for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740593504; cv=none; b=IkBpILCskG8ypyhfYh5PQiidnrwkxLUamti6xebYwxEWDGaPdQDVnIcmqxV0EHPFaWFV7W6L8HRVeaVp5q7uVoYbXtiNJlqL/h5TDhTPhAxxq0ziGCRQy3GeczTlGLVCtPAbZYDPnKViJfpuWt7WbMVJSuid8+j/+70TvNI9qIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740593504; c=relaxed/simple;
	bh=E+J/gJDBllzgbPg2jXiGzP4lQt8++u2b00nKG6/ZWcw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pjBMBQr1DnYpJWKCsVizlO6scqIDfm4xDrPsW8gFJhcvjtjC7flMxsvIugo+uFr254rTxAyxqc+3R+4CSoYJJ1WppN2Nu4dRY82zpPb+dlyl5ZYtzG2HyeSC/2HudAYoCP7YAFnl4dgU5E76K6VlTTFkPKB1jgFQ+weFEhoSrLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PfwNpCpJ; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PfwNpCpJ"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-4be4d72bceaso34961137.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 26 Feb 2025 10:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740593501; x=1741198301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SvKrfYWbmyHXvv9pqahfsRLswqJ46HGYbtz5HENIf3U=;
        b=PfwNpCpJNeNM36i3DW1qlZXs/8JNpnL+guWBXTzsejUxf9Yzy17WjS4fNxOvtvJKre
         UERBV+OBU6KQO4nLYQVvzUacWJk5qAthnKtR5Vq9UzqiQzM6iijy3PPqDaHxYd+J+D2j
         Mm1bcBvcDEWuWMzwh4KxPnviAFLLdoM4Nn3vPjgjfFdNo1hL7cVaUOXncs6EcVBVlWyf
         SYxmF6FhN7xHGICyzABfqyV4EQTWkN8vOA1WcLpfD/7Th8ft4BrdxleybwiYYff0Wk0T
         bgueQb6VnIZ+JLuV2qc21tJ8v3KgMMyVVOkj/DGXt+nETEO+ujRm/v/TTwdIWDsDuvsG
         JWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740593501; x=1741198301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvKrfYWbmyHXvv9pqahfsRLswqJ46HGYbtz5HENIf3U=;
        b=FHPkZUgiGCO38Qa4wDDnxzebfW5xhyewg7pxPwvhOmA2DTuNz/9L74ktXQbjpFT90P
         qg3fz9L5Etih4XRKVGSTYF3CCsbYLHNZaNss/3inF4ZOkdFTzjlSzqfzVzNgA0h1Oxzm
         MCVtrQBHSfjLg+9fVr9FypjB5Xq2s/QR44HyVUcdBdtnirhWChkRhKuo+aMSIPQzxCs7
         k3IJR95V0iIBLdczi1RducBHCy4nrBybbnqYYraCKUIg4R9J7XzAOfcuXfFbWeoZPFgs
         gIIxCFZwXlQ+DMfpTlmxMDXuycDNH3DqTzZ7Eof2VxXGKZ5uBwTP/86EmZ8ny4x5tJOn
         7UGQ==
X-Gm-Message-State: AOJu0YyZTkksCq4N46NCNgDTUYUsDvLRJxLzDkcSLz5nQYa4Yy/motBM
	W3EJyRMKUSPrbGJN4PxdFgSkFa01DYb7NCC+hqON5qGgwH1TK4LH0AetL7xe
X-Gm-Gg: ASbGncst9TEKtACdfzEEXi0djb2ppYPxLkL8ssYV7CEVdYprQmw7yM7tuPPKJ2K1SEF
	gvvWepapIRYrtxvtQ0jeCXj2XDVUSgq4GKEsjIlTN7E5aGJM4kQjhHf4SsTTz8+pQvTuXj0b/fu
	z9oOhgvfG3O3F5bgd683VQZCqNtqea5PGNHXJHceGFPb5EaweMrmUS2iIIpO63Uk9IkRXkKBCqi
	wHI3aVkDeOocmWM700STnERS9jHJmdj3dfovEuq4V7jUxY89byVID/DisTqzcyergh6lmAwrK0t
	kdCAcqmyttxss2hZ7X2UiSaVEY0UYwiYHWjBwV6PLMb30o7FE312263/+Wiy79yea/6RDs4=
X-Google-Smtp-Source: AGHT+IEOrCIuk5J+2HpzoWNShtUKHGRFr5llb/KN0CAbXkNb2znW3qSWSMvHr5/exNyWa0VrPBlCIw==
X-Received: by 2002:a05:6102:2b85:b0:4bb:e6bc:e164 with SMTP id ada2fe7eead31-4c00ae76dd5mr5911891137.25.1740593500823;
        Wed, 26 Feb 2025 10:11:40 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ef052a6sm857744241.27.2025.02.26.10.11.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:11:39 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/4] client: Add support get/set PreferredBearer
Date: Wed, 26 Feb 2025 13:11:28 -0500
Message-ID: <20250226181129.2958079-3-luiz.dentz@gmail.com>
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

This adds support for PreferredBearer which is printed with the likes of
info command:

bluetoothctl> info <addr>
...
	PreferredBearer: last-seen

It also introduces a new command to get/set the PreferredBearer:

[bluetoothctl]> bearer --help
Get/Set preferred bearer
Usage:
	 bearer <dev> [last-seen/bredr/le]

[bluetoothctl]> bearer <addr>
	PreferredBearer: last-seen
[bluetoothctl]> bearer <addr> le
bluetoothd: @ MGMT Command: Add Device (0x0033) plen 8
        LE Address: <addr>
        Action: Auto-connect remote device (0x02)
[CHG] Device <addr> PreferredBearer: le
Changing le succeeded
[bluetoothctl]> bearer <addr>
	PreferredBearer: le
[bluetoothctl]> bearer <addr> bredr
bluetoothd: @ MGMT Command: Remove Device (0x0034) plen 7
        LE Address: <addr>
[CHG] Device <addr> PreferredBearer: bredr
Changing bredr succeeded
---
 client/bluetoothctl.rst | 17 +++++++++++++++++
 client/main.c           | 27 +++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/client/bluetoothctl.rst b/client/bluetoothctl.rst
index b6c2efa351d8..106ed971a59f 100644
--- a/client/bluetoothctl.rst
+++ b/client/bluetoothctl.rst
@@ -288,6 +288,23 @@ Device information.
 
 :Usage: **> info <dev>**
 
+bearer
+------
+
+Get/Set preferred bearer.
+
+:Usage: **> bearer <dev> [last-seen/bredr/le]**
+:Example get preferred bearer:
+	| > bearer <addr>
+        |    PreferredBearer: last-seen
+:Example set preferred bearer to LE:
+	| > bearer <addr> le
+	| [CHG] Device <addr> PreferredBearer: le
+	| Changing le succeeded
+:Example set preferred bearer to BREDR:
+	| > bearer <addr> bredr
+	| [CHG] Device <addr> PreferredBearer: bredr
+	| Changing bredr succeeded
 
 Advertise Submenu
 =================
diff --git a/client/main.c b/client/main.c
index feb21a1163d2..76c9bc329c96 100644
--- a/client/main.c
+++ b/client/main.c
@@ -1714,6 +1714,7 @@ static void cmd_info(int argc, char *argv[])
 	print_property(proxy, "AdvertisingFlags");
 	print_property(proxy, "AdvertisingData");
 	print_property(proxy, "Sets");
+	print_property(proxy, "PreferredBearer");
 
 	battery_proxy = find_proxies_by_path(battery_proxies,
 					g_dbus_proxy_get_path(proxy));
@@ -2086,6 +2087,30 @@ static void cmd_wake(int argc, char *argv[])
 	return bt_shell_noninteractive_quit(EXIT_FAILURE);
 }
 
+static void cmd_bearer(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	char *str;
+
+	proxy = find_device(argc, argv);
+	if (!proxy)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc <= 2) {
+		print_property(proxy, "PreferredBearer");
+		return;
+	}
+
+	str = strdup(argv[2]);
+
+	if (g_dbus_proxy_set_property_basic(proxy, "PreferredBearer",
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
@@ -3247,6 +3272,8 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake support",
 							dev_generator },
+	{ "bearer",       "<dev> [last-seen/bredr/le]", cmd_bearer,
+				"Get/Set preferred bearer", dev_generator },
 	{ } },
 };
 
-- 
2.48.1

