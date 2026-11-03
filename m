Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793737844;
	b=I7TZDj/zE5QAg+XVIbrKnWraiBuMzKtWOHZPdaCKlayrtcCOFd5z8/48jl2uxBOlr0jE
	 J0+lT2mYOkzsx9pExnfQlxmaHHhB4siUbTxFi9ptxykC74NnFiVrJbJA8My652Sqq9lpR
	 UoFDn73cjjwT35/qCBHlUZ3mKPHlcUJCOBlHWa7S29Zq95NrLmTRmJDvk8ALdnsLnkTB4
	 8joOhWKcjYpLfmDQYqTftLsCzEExueMoKpA+LEfdBe+nmv+2L0bUzZKgDy9TukxggCbMb
	 5dQBJf+7QjrBy/NvkJDBIFpLhudQNalo01hwI6aX0GDTt7qTuWXYdGttap2a0ZtBaQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793737844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Qh65e8JDZKas9KySMyRDgyNPSYBfocWoO0D8i26UmMA=;
	b=JTCfbCoBsLa0J6WrIMRg9TXvZvDliPKofqXbl6SSSiqfVy/cebOgEe0J03Z5UcvfAvNM
	 dUdv7Jjq29Qglc5o1uCApPTI0QNQee2ZIYzTnMs9envmvZX9wEkRXxMI44TjaTVHa2bgb
	 faT2C5Wmt8jtWB6TOUYchI70md0WJH7YDX3MYrnKmJD5ffQD4xc9ZIs3nOhv/SlS6g3HM
	 OltBNDzacUIIlyOS2ozCSMY6axN9jLGMyaYPNQtxaY2nQVTUba5tiMJ0+1MFT/AsC/4bN
	 bVSGEsichN7A8179kSy8EoONQWJs6HwQgehBJyC94OeOqXrfIsbzdu8jndiTu5gMYbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVpixYcA;
	arc=none smtp.remote-ip=209.85.222.45
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E155606A31B
	for <linux-bluetooth@vger.kernel.org>; Tue,  3 Nov 2026 20:30:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E155606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PVpixYcA
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-980c4258105so1750241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Nov 2026 12:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793737843; x=1794342643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Qh65e8JDZKas9KySMyRDgyNPSYBfocWoO0D8i26UmMA=;
        b=PVpixYcAuV0KGlvGevYsCHG9wmsdg3EAYskRII7lQ2rvtvsL4lAXGKOWM84oyFMdI4
         sWMzqc4EH9iCXPgHJa/sRE2X3/u1egNwsZsDT1K3qbh0mO/n1kUzo1c26wGvzuQQoSwN
         rrVIXD5NjmxIDX9Ie3kGSGuqA2YB1bHAC2fYvietV5EqG9cCxpFIWL7kwsFmCAxkj4pR
         VYkrNIJb+VHF/pbSWyLxV3gr/y6pvUuqGIOY6KmaIdsSOaCodIT652aRuMFvEe7KTa7C
         0v8XQALQ4t7UHPUXUG2d1PgpYBm9pnJlr4N6Sn4LIelKKTspWg3vfG5JkeudBxonFHqs
         z/mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793737843; x=1794342643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Qh65e8JDZKas9KySMyRDgyNPSYBfocWoO0D8i26UmMA=;
        b=K+fDfn4z6Mx5HmafDJDAm9WJjR6p6f3BddPZXtAONnyocm0IXVMdytXicF6N0oy7dI
         udPK28j6ZrYE9LdVBfP+nxQLFV7oE5d4KOxgP88qWprTahwskqmareq0fG+ltlAsUdqc
         8+lOyv1ywn62352fCptvNXmQHkk5TEFgpIP0ANXgC+iZBBzHWM//julM48/qFym/LC5L
         JO2slvpZnw6TGKgXuVKaO8JsT0q9IUn9SuKaKZdbCgFkwQSMsI+1+buTNDnfHiG9IAGa
         GO85FCjmBXQSEWnhG9Q11EX+AKyAk7ZykSkWEnwgsezQu5XeIVwQfhdLHrK5hFKgYuE1
         Nfpw==
X-Gm-Message-State: APuU4Z9wzB3bz6vROQAPLVYiuHJc1iiN/+kAVov8NV4jAml2Fe1EJ8Sd
	6YzVMG7uCNli/XiWnIlWxO5EOynXW/thEtMfp2tAZLXACAmsin8dQ9bW/MxfaQ==
X-Gm-Gg: AYBFou3Qrxkma5Ttt4RO+A729AYFQJM0F6e03jJROhYFf2trWLqTqZY/Uw3DTWIqGg+
	odIdbFLmuBIIRIISud4eiuVA0ovrXdD+BBctF/0maay2IEk4PoMxXip8sCzENAVQVONdxqMhr/I
	MOoskIGOv73BxVk65PxW9xn+E+oeN7RhCgK9gHCOq8TSBErJMy+XYqI2R2g0zdh2PxlT+TiiwlZ
	2ogKD7g2gAU8/qSfeCvZ2jo+irOIc7KrbtbR2X/pwz+Y96z+T60+IEQJrnLxKIv4gJ8obiYtjBH
	r9sNsm7kOj2x5VL9mutdlTksQBrUA4aSS+HYopw3sH7QZK29qshh+nsO9Rcd5xXFDDRWc3nG/ag
	1wbBo5GDVXPRZKh7maDy+F3VSmhjripBMJJSxvyUVG5NIjazsBqHLNXQx9rxaDHGTxkbtA6so5Q
	6EVCjrN8aGskbVOFDe9lfg5PuASDfM8oiQP82A7D6AtjkIV+vcemmm8Y+Fxc4sGXxlAY6bIlo1O
	T0IAuMTall/jmnkjTSlEWMe7yU/AXU3XtscloI2E8v/mqxu96jNSI4XWlNkqvNtxjyjvsl72Q3r
	UdiB1emIKyBio7CZocmrC5RGxDHR0FiEt0tcyHau0Ua74cqOqhJuoNhGTzzxhoK8OcEiaR45Pha
	7fe6pF3jnAJnWKzfoHzXyNeeCzoUbgKHfGEq4GDeZ1f8CeEgSLYp67gPZjZFTPwFxxAz/6AqpAN
	nYLGZs
X-Received: by 2002:a05:6102:54a2:b0:7c0:4d52:8cc9 with SMTP id ada2fe7eead31-7d072c4161fmr6334342137.14.1793737843037;
        Tue, 03 Nov 2026 12:30:43 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-998d69af021sm167865241.1.2026.11.03.12.30.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 12:30:42 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 5/5] main.conf: Add NotifyMultiple option to GATT section
Date: Tue,  3 Nov 2026 15:30:34 -0500
Message-ID: <20261103203034.3904499-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103203034.3904499-1-luiz.dentz@gmail.com>
References: <20261103203034.3904499-1-luiz.dentz@gmail.com>
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

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds NotifyMultiple option which can be used to control the use
of GATT Notify Multiple:

 false: Disable Notify Multiple, always send regular notifications.
 true: Enable Notify Multiple with 0 ms timeout (default).
 <ms>: Enable Notify Multiple with the given timeout in milliseconds.
---
 src/btd.h     |  1 +
 src/device.c  |  2 ++
 src/main.c    | 32 ++++++++++++++++++++++++++++++++
 src/main.conf | 12 ++++++++++++
 4 files changed, 47 insertions(+)

diff --git a/src/btd.h b/src/btd.h
index d70276b1dca0..b059ab872764 100644
--- a/src/btd.h
+++ b/src/btd.h
@@ -165,6 +165,7 @@ struct btd_opts {
 	uint16_t	gatt_mtu;
 	uint8_t		gatt_channels;
 	bool		gatt_client;
+	int		gatt_mnotify;
 	enum bt_gatt_export_t gatt_export;
 	bool		gatt_seclevel;
 	enum mps_mode_t	mps;
diff --git a/src/device.c b/src/device.c
index 137970637777..6d1e78b0ead2 100644
--- a/src/device.c
+++ b/src/device.c
@@ -6547,6 +6547,8 @@ static void gatt_server_init(struct btd_device *device,
 		bt_gatt_server_set_permissions(device->server, false);
 
 	bt_gatt_server_set_debug(device->server, gatt_debug, NULL, NULL);
+	bt_gatt_server_set_mnotify_timeout(device->server,
+						btd_opts.gatt_mnotify);
 
 	btd_gatt_database_server_connected(database, device->server);
 }
diff --git a/src/main.c b/src/main.c
index c7a55d30f61b..8e58b6b58ae2 100644
--- a/src/main.c
+++ b/src/main.c
@@ -151,6 +151,7 @@ static const char *gatt_options[] = {
 	"ExchangeMTU",
 	"Channels",
 	"Client",
+	"NotifyMultiple",
 	"ExportClaimedServices",
 	"Security",
 	NULL
@@ -1190,6 +1191,35 @@ static void parse_gatt_seclevel(GKeyFile *config)
 	g_free(str);
 }
 
+static void parse_gatt_mnotify(GKeyFile *config)
+{
+	char *str = NULL;
+	char *endptr = NULL;
+	long val;
+
+	parse_config_string(config, "GATT", "NotifyMultiple", &str);
+	if (!str)
+		return;
+
+	if (!strcmp(str, "false") || !strcmp(str, "no") ||
+				!strcmp(str, "off")) {
+		btd_opts.gatt_mnotify = -1;
+	} else if (!strcmp(str, "true") || !strcmp(str, "yes") ||
+				!strcmp(str, "on")) {
+		btd_opts.gatt_mnotify = 0;
+	} else {
+		val = strtol(str, &endptr, 0);
+		if (!endptr || *endptr != '\0' || val < 0 || val > INT_MAX)
+			error("Invalid value for NotifyMultiple=%s", str);
+		else
+			btd_opts.gatt_mnotify = val;
+	}
+
+	DBG("NotifyMultiple=%d", btd_opts.gatt_mnotify);
+
+	g_free(str);
+}
+
 static void parse_gatt(GKeyFile *config)
 {
 	parse_gatt_cache(config);
@@ -1199,6 +1229,7 @@ static void parse_gatt(GKeyFile *config)
 	parse_config_u8(config, "GATT", "Channels", &btd_opts.gatt_channels,
 				1, 6);
 	parse_config_bool(config, "GATT", "Client", &btd_opts.gatt_client);
+	parse_gatt_mnotify(config);
 	parse_gatt_export(config);
 	parse_gatt_seclevel(config);
 }
@@ -1425,6 +1456,7 @@ static void init_defaults(void)
 	btd_opts.gatt_mtu = BT_ATT_MAX_LE_MTU;
 	btd_opts.gatt_channels = 1;
 	btd_opts.gatt_client = true;
+	btd_opts.gatt_mnotify = 0;
 	btd_opts.gatt_export = BT_GATT_EXPORT_READ_ONLY;
 	btd_opts.gatt_seclevel = BT_ATT_SECURITY_AUTO;
 
diff --git a/src/main.conf b/src/main.conf
index 1d8e97dc6f1a..12028e162c1d 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -270,6 +270,18 @@
 # Defaults to 'true'.
 #Client = true
 
+# Controls the use of GATT Notify Multiple when acting as a server and the
+# remote client supports it. Multiple notifications are buffered for up to
+# the given timeout so they can be sent in a single PDU, this improves
+# throughput but adds latency which may be undesirable for e.g. HID.
+# Possible values:
+# false: Disable Notify Multiple, always send regular notifications.
+# true: Enable Notify Multiple with 0 ms timeout (only notifications queued
+#       in the same mainloop iteration are aggregated).
+# <ms>: Enable Notify Multiple with the given timeout in milliseconds.
+# Defaults to true
+#NotifyMultiple = true
+
 # Minimum required Encryption Key Size for accessing secured characteristics.
 # Possible values: 0 and 7-16. 0 means don't care.
 # Defaults to 0
-- 
2.56.0

