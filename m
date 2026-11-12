Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515619;
	b=G2+eoIthdFDOCRl1aiFt4mlZWgsflrePx7cQ49TNNQ3yyuR1B9C9/km0457cXMlSC7vy
	 3DNfIPGFHiv87E0BCoaKOQu8dPX73tPRjWzUcR7AcBPjieWBnu3T7fDzZZ8uArcYrsZCR
	 gmM93WWFOw19PeIwCYxnwsJ0E3l841+EB1yEp96k9lljBNPcJn2KRrx3DN4ItYK2UYKHC
	 lZK/hXMIkK8D91NHgSj2fJAOgqzHkikw4PFr+8x+c5k6kvJWYzmvIl7yn0Zl5pVhg0/Wv
	 YEt36Uvctennxbt8sv3tAzzuV6dy4LduZIfots2JiOmMKcN+PRZKS5yKfAZb/GIBZSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
	b=FM0QxbQBKq8upWOC/yFO5DJv+8+UFktfwlcqhxC/jqoRAc95WAHrSbnbTU/WHWCGQjs6
	 DJjD4qBLoWhuxR8PeW3rjMmsxQHhg323wN5YxO44syn1XVbDuG06JamIPg754VBFDqRLx
	 0kw0vcy+ilncQi/SJe3382iMdE5AtucZs4O19tpeUvtJDP6hWAbZ0MGPYencoDFjLcsd1
	 +1bqjzLnwsuv+BIwTMuen6QRzFVIqX/oTh+mZEMwL+opyfXEd7kdHIhjpEzIzEEH5njNZ
	 I7qxsCDWkMDJGiASYAVU+5HMmpJ8G1vC8O5KMii9JjzGaNoGBiZXlPmfOhFHiU7Q1UQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqreX57u;
	arc=none smtp.remote-ip=209.85.217.47
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E55CB606A33D
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 20:33:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E55CB606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rqreX57u
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-78fb1fb9508so1131909137.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 12:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794515618; x=1795120418; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=rqreX57uxM++w+1ty9B72d6izVKP7xOzwhAuWYPAT+iUbQlV5XJliy1nYqOkJe9Rj2
         08+eaMxMPkoPLXDLYYBuIAVgIj6kH+SQkLhzVWxMM1gs1hWdiqBiXUNE0nBpkvAVgg4r
         Djmt4VEOKjBZ8xxEeRUOpO77jwVHqMKx3+8DsKdyQ5GHxcaB2l2ECai/WcCUai7UE8pe
         0PP98yjB3jxNjQqwVFPBbRZFloDOI8tYwQ8UPLHsCfWoL1VHEb7a1odi2b8XFiOS7AkG
         AxGila6NIXFdKOT/5F2ho45IclzbU5klrq9GgoSmE4r68A4XsZSWFVsFUCpiwddx6w3d
         D86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794515618; x=1795120418;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=QWmaqThQMA2PUd58X+y++HaYkXGRDCgW6kWyrlnGlYFbJCom7WyY9IHOSLAEipqAgM
         fk4Fo+hOiCqGUmJl2w8TLMzy/501jP8o6kLno5YZHV0PRxVbgiS7CH1A+VRT78HA0m4v
         jFq2xY9yqE+KUpwMlCK6pi7qKPd5mCI60K3jMk/WdzJkocBM96dxxf9BWEM0Ai46yh1C
         Wnz9AMps3dmFNO9yHF37JbQ+FJU7XLrZhQo6yqUjHn4UKxdheK/C+FGTkt1LWCNYNQi1
         Id8v0NNRvjyxnz3K9qyX7gQ9Q0tG79yjeihXvoNQt4Xs+HibQpDQfMsJ3wug2KoHYWDk
         KrfQ==
X-Gm-Message-State: APuU4Z8VZGAWOrGl4qhRWW/pfM2cdtsoTca8SKjgcYPBo4jhtDc9w+oP
	HwxLmltl2MVqxKgTsrdQYpYs/5tsMlP6Cg9n4v5evuOiAlxxI7rUnRg59EGuqg==
X-Gm-Gg: AYBFou3r9fVsORLNwudqfeVPyfytEXKhFvbeBPOBBYSVZrrUKzB77iBUZqYolYDPBPS
	huvA/utYZjX1OL47WsMDY6kV+lTa/Av6HEdgG9MRLku8Zaf1q06V6LiWJ6VkGAwddqVM5jLo3/9
	NVm/riutIcsum7R8xQr5NUYgVDVUlB1fnB+hsiw8AlIdSi33DT6vERtpxXH68PUdH+GSFr1XFjU
	OQrN4yay566tg/bfJ4fR0K2aDvfH2hAERDpt2RZXpE99gGJH7RE8dd9N6BKbAf+n8u7BcWS8Vkx
	2/5dpGSTEosPAUWhZApHW+oXTIc3Pa5rgbgo2EbWvjQTE7FQGSji1lBSMuMo7v/TKettP9hj9Bh
	Rzb/PykHcQkpZvmR+zfLkvKNN8fUbrtP1dm0kJ/ZV14B3He0pGJXVHxMWGL42WxbX/f95VMxsN1
	zN4tGjtAkhC7iUIBDV7+i2K+z+3iHLwMmi8VQuPv6P+/l5z7txBUGGtOmjcDxmNuH3uaP4ubPwC
	FUmy8ounRIZtD9+XVYZ7xQB7uRBoZdLmH/wGOGgn0KQAd3vAw5VkNr94cwisUhIJCzv4Up885/Z
	CF3UutjP25PufPZ6RtIyIduhAHyTQm/jwaqu6hD6xBGblDDEgkEmEvEAsO1Uj5xxmL2iwxkxg/r
	qlLt0ElVJTk1uyhY0/zr+KljpyJrPizpG9o5f9DwDcbl0O0jW9IMtjHrF7by2Of9kBla5BLoVD6
	PQNag=
X-Received: by 2002:a05:6102:6882:b0:7ce:78f9:ae13 with SMTP id ada2fe7eead31-7d6317565f5mr1276458137.10.1794515617892;
        Thu, 12 Nov 2026 12:33:37 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c842ac652sm346627241.10.2026.11.12.12.33.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 12:33:37 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/6] client/player: Add endpoint.clear command
Date: Thu, 12 Nov 2026 15:33:30 -0500
Message-ID: <b80bd69e15055425c70643766603b4f232c4fd03.1794515475.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794515475.git.luiz.von.dentz@intel.com>
References: <cover.1794515475.git.luiz.von.dentz@intel.com>
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
 client/player.c               | 57 +++++++++++++++++++++++++++++++++++
 doc/bluetoothctl-endpoint.rst | 20 ++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/client/player.c b/client/player.c
index 88221076c1e0..932338ef53a2 100644
--- a/client/player.c
+++ b/client/player.c
@@ -4030,6 +4030,60 @@ static void endpoint_set_config_bcast(struct endpoint_config *cfg)
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
+	if (!dbus_validate_path(path, NULL)) {
+		bt_shell_printf("Invalid transport path %s\n", path);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
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
@@ -4625,6 +4679,9 @@ static const struct bt_shell_menu endpoint_menu = {
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

