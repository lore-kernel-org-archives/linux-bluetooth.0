Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349169;
	b=P/pdLCgqNJtXJP38WI03m8q+OAeTWeU04F6IOZiM0Zf1LhBwnVVXJQcdys/EKQ1suBCy
	 lxFQmN3WPtJdGnKo6SSVrRisGj/aaJdqQpVhONR3T6u5aHRYvfeLq67tTI0RKSAt/fqHM
	 kRA4i57aNiQ/Gw+J3ENY/UdN5Dd7jQn2YN2NCtYAVXsnal4rfnPPtsGCwWMJWXjhdX78X
	 hwz5q7SDiBf2PgHO0QPqrFJM4OeYYx6MZjfxUM+b+GFaNdardvY0F9R7D9M7lNtWN6dma
	 Uxey2l9D8t2SbBXo+kQUpxOKKteA6PX1CMwLn1jV3auIp/wsXg5aCxYFh5329uxQDdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7ultLS7DJZO6amKRuS2B4SXquW/fd9Gcp+jm7yv8IoU=;
	b=z4SsfaBPCTNqUCxq/YkBCaTdoqopRJhpxRVJYvUUDp4uDKE4fyTNCKmZqf8ElIY2EDy7
	 rCHG8zQw55oNVfDOupgQn/87vcfxaV35uPltYZw9LxgxHLqO6WNhPr/Y4ZEJK3yBAYreY
	 Wr7eVGPtspYvngx+FImlO8meGdb67+DMhbmEZR0ZqPw0w0NujX7vgSlLR1KL5kxnjd7qR
	 kNjilvQQTkxabQBzNB/160HutsFQn2Ks712zpvTAZkW986iH+KTbTPMmNeOVVD7djtZxg
	 VUQnMSsxmrJgJJe/2+Oo8kD8TYJs25kko57Athhy7bUyVclLz36iiSJQVkJ531souvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyESWtGU;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8082A606A320
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 22:19:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8082A606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PyESWtGU
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5e9528732b4so1204051e0c.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 14:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794349168; x=1794953968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=7ultLS7DJZO6amKRuS2B4SXquW/fd9Gcp+jm7yv8IoU=;
        b=PyESWtGUBXVa1w0SHcdh27khGEKQEhMDbgryqFprWD8QhTcEX4SyHvy077fA/8Jk1N
         /hYOUX/at+glq8yS2ftSmOUFqGuk9N5jZURpscjIQz83k8UIP6/YM+FF+V5J2RwZZxAZ
         pgXe2rMJMzORHJdc+j0+cgK0UYd8TheyxADwEqUP4umi/uyX8saiaEpvL3+/Y0lScV4i
         N3Q7C2zTlX3wNL1FyjVAKCHYwdqVzjb/1tiIrgPfyVCvHUkf1fHl3N5iJ23SBxfHi3kj
         SjaoQmyFmlZcAoLg6O+JJQwn3ENL9osIiR/n3KaUxq/0U4Yr4G1bMBb9YfXA9sssEB/E
         zWdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794349168; x=1794953968;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=7ultLS7DJZO6amKRuS2B4SXquW/fd9Gcp+jm7yv8IoU=;
        b=AYcAOfbffw8uRikJ+HiODRMn7V0MTNHk3l7qlo3ECX3Ojmbnzgnco0SkDusXPsfVk2
         FQakKqoYi5zpH6X1aCZNuH09EiqZZaIVnSeI8bsuIzEJ+oOf4WvtgehSpSTLnldCB5Sq
         T2asx5j7GnDP/Z3iO6YdieuYVVrLXG0qlbVdOzhiIL1dUH+ZGDHMie9q/96tJT7HbSZ4
         fynHlbJe5AIOiVh1mnwYnA/ueuHwVj+bQBDyTkL8+MNAdWwZ+VaMmRJKyCzVFOKtM5EL
         xXSowr1UpeuHKukczB2S/TlPvu/9yo33fvBkNlFPKyoNRJsCPfA/dMBPfTdAF2KCNUVn
         +Ggg==
X-Gm-Message-State: APuU4Z/AAEuE5NDt33LLMzQ7sAPLYjfuiNVDKco4hiNKiAb6CwaQKjxf
	S2e8JUazmbIBf3Y+MIJCauCnd47ea6wzuMTdnjQ1s5L1zBa+4+D3nYIjea2OwQ==
X-Gm-Gg: AYBFou1Jh2bM+EHymew9iGyBk7SYJtNswLwFoOOy2a82Zk/mTZH4AgII5+ee7CGf+FD
	+ERHeZXr4YQB7e8gu2/FYHItHEvUAnefuS+7z2VkSMkxBYuUUUJHx3PgTUcvq38omU43i4Fp682
	DOc+6Utv8vCWaRSM+ShU76QBnmcf7ekxbW44RS7HPczYYtNPBW5ywo6ni7s1OXZSCq4viL2usAE
	9ajGn4TqsLfqC3yjDomikLMGKMl4EtGMvXi7i3dzfpOLVnDREC319Xwclsg2y7UPUabysyGCI1D
	Urm/53oCr1g5uzImDZgJtc6MwYoGhOiCQxrcqmlxzfPhm0i8c1WrsSFMJHCuQL5cgdMQ7ukAHPO
	QpiZRBeGPOvDYq37dEg3UYH2zmELGVDP6fKrTinAO/b3oAzd5CkQo+LU+cfS/+xfn9/KLMxQzRB
	YqY4Nq2c7CEUC0AZGIEBsVYkzUeKMxDmKsbPL0qdpplWOxZmhtESfedhSOe9jBtuM4feyB5+/p4
	lB828/+HBNHOfdfeQD3GZvh68L11E7u9B7D+RYnuoAoFNUxKmYBHMFEol05v3gMY5ZlIGqIVh4W
	70fxhWSJBk9bOah+Aq1RhHsx9ZZwCqnpQL3/Hr7dhLzkCwGt6KwvRXpy7Bj+uZH/nEmmW04ms5h
	9vLczDpJJ8Trk/9z3RD8OaXlxzywucfigOxfjYDmLqfvJ8mFWRsT86D3f/U8K0/r1m9fdFtZqMw
	8e5Rb+pzxDDEwNS+0e4n6uFj/Y
X-Received: by 2002:a05:6122:3d15:b0:5ee:a81:e77 with SMTP id 71dfb90a1353d-5ee1c3e5552mr115089e0c.6.1794349168446;
        Tue, 10 Nov 2026 14:19:28 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee0c58ed55sm2605244e0c.5.2026.11.10.14.19.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 14:19:27 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/5] client/player: Add endpoint.clear command
Date: Tue, 10 Nov 2026 17:19:06 -0500
Message-ID: <d9b7ff8ce5812813970f4c38462797753fb5a0c9.1794348982.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794348982.git.luiz.von.dentz@intel.com>
References: <cover.1794348982.git.luiz.von.dentz@intel.com>
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

Add a command calling ClearConfiguration on a remote endpoint, to close
the stream of a given transport or all the streams of the endpoint.

Assisted-by: Claude:claude-opus-5-5
---
 client/player.c               | 52 +++++++++++++++++++++++++++++++++++
 doc/bluetoothctl-endpoint.rst | 20 ++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/client/player.c b/client/player.c
index 88221076c1e0..74b09b930a1b 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4030,6 +4030,55 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
 		config_endpoint_iso_group, cfg);
 }
 
+static void clear_endpoint_setup(DBusMessageIter *iter, void *user_data)
+{
+	const char *path = user_data;
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
+}
+
+static void clear_endpoint_reply(DBusMessage *message, void *user_data)
+{
+	DBusError error;
+
+	dbus_error_init(&error);
+
+	if (dbus_set_error_from_message(&error, message)) {
+		bt_shell_printf("Failed to clear configuration: %s\n",
+								error.name);
+		dbus_error_free(&error);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	bt_shell_printf("Configuration cleared\n");
+
+	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+}
+
+static void cmd_clear_endpoint(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	const char *path;
+
+	proxy = g_dbus_proxy_lookup(endpoints, NULL, argv[1],
+						BLUEZ_MEDIA_ENDPOINT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Endpoint %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	/* The path of the endpoint itself clears all its transports */
+	path = argc > 2 ? argv[2] : g_dbus_proxy_get_path(proxy);
+
+	if (!g_dbus_proxy_method_call(proxy, "ClearConfiguration",
+					clear_endpoint_setup,
+					clear_endpoint_reply,
+					(void *) path, NULL)) {
+		bt_shell_printf("Failed to clear configuration\n");
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+}
+
 static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
@@ -4625,6 +4674,9 @@ static const struct bt_shell_menu endpoint_menu = {
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
+	{ "clear",        "<endpoint> [transport]", cmd_clear_endpoint,
+						"Clear Endpoint Configuration",
+						endpoint_generator },
 	{ "presets",      "<endpoint>/<UUID> [codec[:company]] [preset] "
 						"[codec config] [metadata]",
 						cmd_presets_endpoint,
diff --git a/doc/bluetoothctl-endpoint.rst b/doc/bluetoothctl-endpoint.rst
index 019e64e38452..ba30ef769ec4 100644
--- a/doc/bluetoothctl-endpoint.rst
+++ b/doc/bluetoothctl-endpoint.rst
@@ -154,6 +154,26 @@ Note:
 If the endpoint was registered by an audio server, it can't be configured from bluetoothctl.
 This must be done by the audio server as well.
 
+clear
+-----
+
+Clear Endpoint Configuration.
+
+:Usage: **> clear <endpoint> [transport]**
+:Uses: **org.bluez.MediaEndpoint(5)** method **ClearConfiguration**
+:<endpoint>: Path to the remote endpoint to clear
+:[transport]: Path to the transport whose stream to close (optional, all the
+	streams of the endpoint are closed if omitted)
+:Example Release all the streams of a remote endpoint:
+	| **> clear /org/bluez/hci0/dev_00_11_22_33_44_55/pac_sink0**
+:Example Release the stream of a single transport:
+	| **> clear /org/bluez/hci0/dev_00_11_22_33_44_55/pac_sink0 /org/bluez/hci0/dev_00_11_22_33_44_55/pac_sink0/fd0**
+
+Note:
+
+Clearing an endpoint whose codec configuration was cached by the remote, after
+its streams were released, releases them again.
+
 presets
 -------
 
-- 
2.56.0

