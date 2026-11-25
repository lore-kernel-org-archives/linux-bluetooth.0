Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795626138;
	b=BTI3w8nezufZHYxA4iauGtxHr5N+Z7FrNxRBbtQJt27pN1LddJ2YOPV+x75lZTV7HJrV
	 qxqGnTBypvL4lmvGujB15HVLTvzCpTm7jI4kfw7r635El6TLV8/esNbOzFw9jVhKWUy13
	 6fjU/kf6tUCzQ1m/KGAjMGMU0xL4kVzb10T/E8mZTCOz+KfJuNhBUo30cUxxpbFvmX4Za
	 kHqa7sBUPp48wWgnwaSyliwFhACRu6ih+CQIWAfofONmB41aTroy945bbMKuMUpx8lE1o
	 KDQ9Yk5oq21/LIXazb473POl3gYXR7KVIIX8YNXWdImfrany1ycOPldP5HCc0+BhaNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626138;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LIPwpq9Q370zg5un4vbkRXdrLLbKwJMPk3zWxjPoXIk=;
	b=kVju/+EYBuXjlEj3SidxOYRgPlK8TxorazUFwtxKzTH6qpA2hxeKN1tPDMs9qzCPR3+E
	 KifudQl6JJSMpce0A8Hzv7cozEurLXGE1rLHSLMBkf3CtibPCoOYf1Y3zemilDl6NdKno
	 yGi1Sw7yZ3sOoOv0HoRLphOjLu1OOc1nqhYxCvzRbKgxaxFUtpYJaNGmYzegYPE+SkhjQ
	 dzfiSJx8HNfTFNtQDwpsdPLj/5U2/16b6UTYDNpC1/H+6gTbveb4cepIDWDAP5h21ekrX
	 M1SQTjdMndnrmwxoEN/k4kzUDq1Ex6QDbRzr54PzF2vUc6RrDkRAOfE0d0lAXrukhzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=streamunlimited.com;
	spf=pass smtp.mailfrom=streamunlimited.com;
	dkim=pass header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Tj0UYJ41;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CD7606A337
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 17:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3CD7606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.a=rsa-sha256 header.s=google header.b=Tj0UYJ41
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a00so48573805e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Nov 2026 09:02:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1795626136; x=1796230936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LIPwpq9Q370zg5un4vbkRXdrLLbKwJMPk3zWxjPoXIk=;
        b=Tj0UYJ41J5rtqDD6nlQj6s+O47zYN1e/jv1A96yXMythrr//C/b7/laT1PgBwuwYrh
         LciHFYB6QTeZB1h1xgGgPd9Yw/C4MYDSBHvniAC0brsC1/5DxabuOnTxeC4uS1gSy2R9
         eUv6kspXzhgLKDEvZASSP+a5tjR1PY1d4Iam8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795626136; x=1796230936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LIPwpq9Q370zg5un4vbkRXdrLLbKwJMPk3zWxjPoXIk=;
        b=KgmCoAPGYbVS30eS3WgJCfthkfG/BkzT2yeWBvd7u2qC6o7pGUOp7VaclJGDAXtDEl
         fEAHP2sRrlex9uD7416oGKerKvVrAKafhAAd8LmTZuBvtgNbZfksN6uWHxvjn9Lnn5+K
         7hF05+MnKCMIrDMQh6YsESHV1i7AapmoTlmKN8/2KlO/Wib7gg6U7qNin+zp7b2TiL2g
         6xNAt15T/KnlBm5YfPSHzn4KHA0AduqXWB38dfTlOwzdM1tJ8HG8Iwb5tTC/d22NpmIy
         rERjhJCVw/qkKi+fHKZ3OaxdYc48eRlwGRpdbGOoxFE02mBTF4SzJRsRKWSfO7cFWoyr
         B9zQ==
X-Gm-Message-State: APuU4Z+OvMHO77E7w32QzdGtQRQRY6iUeHDkOS8/XtfHSi4uIaYQXmLr
	N2PzLtlFYkea3Er9ROTiNnBaJJCKtNBLAc9ep79Eo9U76/AdymIrbIaFiTTOTrJO/d6UrLH+B2t
	0h+eo
X-Gm-Gg: AZFdTZev0QkmFvmvl8SNqV3hRwELDBr4cS7dr1rRxBXq+JHVULqp9Lil5WdXMkgFv4O
	RUXcutAlsYz3h9fr3y1DwuD0QS2/evFF8LH756ABelvQfRGuUhPDhK5OtyqUfF/llMU4r4y1Yhz
	wKeJwppN6ma24Ismz2A18fF7GHwJh0GPhM1wamcN9/IdS1A432mptUBVw9f8Zqi0fXvnhgidOyk
	FoWSdebPx9IGoU9fCxQ7JYhaPvedP4RHD1ps3ApSj39mF5TuEyM6m3BY3r2ZQne65Zv39+tAGkS
	1Cl1HoVug2EJ1aX1b+FlW9b/90ebi7nIddr8n/251WYkDIpc0pQBGrUUc9iQb2V26/ySY2VWjtf
	YXZvdPy7gOrGxuovuAz50lguebQtxrdo1M8NAnkjBjkFCzT0cPGqsosqd1nY7eUqLdFzMM+Ny1m
	wh0/jWJcfl8mk2WM/QuDmw0nUHUAtYGTFmiIKsl0mxKmrT4HG5DhvUUdgSTNHNV8hAjec1xXMyb
	tjKXmrQwmk9SHmZPa7lGYELwGsSyFcI5yYE2E53welxwEbmvWudOVNAUCYn/zCBOMdNVrn9hNq3
	tGMCx27NmSZ4YOQUv1gZ2HMTGajCAzvdmIbRlxYkz171hQzgIH4NRzu9OjOfbMwq3uW2Bi0=
X-Received: by 2002:a05:600c:1389:b0:4bb:7347:d5c0 with SMTP id 5b1f17b1804b1-4bb88826937mr341955165e9.9.1795626136406;
        Wed, 25 Nov 2026 09:02:16 -0800 (PST)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:641b:80e1:c5fc:b7eb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bba3d3679bsm40475725e9.2.2026.11.25.09.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 09:02:16 -0800 (PST)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ v2 4/4] client/player: Add transport.mute command
Date: Wed, 25 Nov 2026 18:02:07 +0100
Message-ID: <20261125170207.1648671-4-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
References: <20261125170207.1648671-1-simon.mikuda@streamunlimited.com>
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

Get or set the Mute property of a transport, like transport.volume.

Assisted-by: Claude:claude-opus-5-5
---
 client/player.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/client/player.c b/client/player.c
index 932338ef5..71d2ee20b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -6160,6 +6160,54 @@ static void cmd_volume_transport(int argc, char *argv[])
 	}
 }
 
+static void mute_callback(const DBusError *error, void *user_data)
+{
+	if (dbus_error_is_set(error)) {
+		bt_shell_printf("Failed to set Mute: %s\n", error->name);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Changing Mute succeeded\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_mute_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	dbus_bool_t mute;
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (argc == 2) {
+		print_property(proxy, "Mute");
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	if (!strcasecmp(argv[2], "on") || !strcasecmp(argv[2], "yes") ||
+				!strcmp(argv[2], "1"))
+		mute = TRUE;
+	else if (!strcasecmp(argv[2], "off") || !strcasecmp(argv[2], "no") ||
+				!strcmp(argv[2], "0"))
+		mute = FALSE;
+	else {
+		bt_shell_printf("Invalid argument: %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	if (!g_dbus_proxy_set_property_basic(proxy, "Mute", DBUS_TYPE_BOOLEAN,
+						&mute, mute_callback,
+						NULL, NULL)) {
+		bt_shell_printf("Failed to set mute\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void set_metadata_cb(const DBusError *error, void *user_data)
 {
 	if (dbus_error_is_set(error)) {
@@ -6278,6 +6326,9 @@ static const struct bt_shell_menu transport_menu = {
 	{ "volume",      "<transport> [value]",	cmd_volume_transport,
 						"Get/Set transport volume",
 						transport_generator },
+	{ "mute",        "<transport> [on/off]", cmd_mute_transport,
+						"Get/Set transport mute",
+						transport_generator },
 	{ "select",      "<transport> [transport1...]", cmd_select_transport,
 						"Select Transport",
 						transport_generator },
-- 
2.43.0

