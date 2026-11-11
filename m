Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794414348;
	b=t4AH+A0i2tBL3xaWh1MMM7CX1qbRkn+bnqtxQkxGyuJsXRp2tHiWalDWBdwFDuDIJgQy
	 kmsNfga0oZdzj544AH7vDQwVkTmt6ZzsOE/EW5kdlMtNsm7z9G49NJSnvnFdQXmQJ/soX
	 XUSrN2iuUp44mZIX3Alv6bteGSckF2qpuXZTkMGkUEaohfeXXUqsoG9hTUlJy3gX9hTda
	 cSu8UO9zt1wslRAq41XavvZluoDubRTB9nfjuc+gbh6qWPVlxocuIGJGPMQDuMDUGU1HZ
	 JVZkOp+grPu+1jIeGTeYjmv2tv7KJdg/fE7bTlkoEyrmjOJsT6Xn9itZn/VyF8WueLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794414348;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
	b=dfK55vcKZIuAGd7O+3rPLTCWVeXEE69pj/N2Q1hmSeyma+XeqHKzC86B5try1Z7Y2F6i
	 xz60s3X32ubCLOpv7l3reLw3JGY2p68ZTrRXDG8d+dRsY/GlqSUwmOaWDKTatHWHuJqZY
	 EFDdr3LmegS/GGbC4KouHu/sEZe35YQ+epwkpLfuXZHJakElwIoWocsZO9Vj3m6fcos4q
	 IIuLW3R/pADYPelO4uO6BaqmnFoGzQF4exGVRuUyPN9+Ktvbv5T83pe4Bx3/7+0qFAVLo
	 Acs601WckoTu0J2NC+BVXVI88Axf+piUi7KCm1abktJbQ0t8OjM8AdKf7DKyfeOKEkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsSmGH0p;
	arc=none smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E7A606A33C
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 16:25:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 19E7A606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fsSmGH0p
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so2441831e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 08:25:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794414347; x=1795019147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=fsSmGH0pYo9BxYENoDZohHBE3bp/9mPDo2KfGPolY8jPNjODnotwVitw87f84KRvPY
         Q1UEkjpiyZZsS5UnI+QcXvFz4OkG7dHerxSClLSbuDQFJmUsipDwlmDCPIedCDamfT7d
         1uReE+xXObF65+3VuOZLUNlAxw0GKpCypfIrjlsku+YQ3V397SLLXx2McduiOxxi870u
         VtAoi3/VDdlsGMi+H/o3azxiTvdDCR9K5PuEMp2IZI9bhLog1lbawRN/bmkJFrIApYhx
         6ek4LxJQc5hutuSWo/lR8fQufRsOn5f3LNcumbSdoBZkpk/hbLYSoF/Jak+c6vwWghaF
         8Mog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794414347; x=1795019147;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=fj0blaNcL3+EhS0pkYgCwBVExRUFzZVwodDKVpx+MmJx611svXSdkcDuPr/syq5M2h
         LSvs9dZvMk5nQxhxR4R7sinZy/uwX5Tgj6WpY7M4YknOalaELT7Y6/E40U0zBumbeefB
         4dzi9vNMItNrYXP5HK1fNGv/SaKnU84NdtwNRb8ldAV+zWGq+iP2642qVj3YiqVohwgS
         Z05xWWQOBJGMSyAKraM1MT2ORzbN/ggobQVRgRa1CwZRU1cQMB/VhNjg97t+0WZvz/8K
         juKc9+oEuIMYIhIFP4xYq2bliw8DAEN5bVQDftDw/PjAvfJIwSfkYIBI8yJdU/7Ngx+R
         ilIQ==
X-Gm-Message-State: APuU4Z8+ELPGezbmHR1VRUpWpUeCRgA2ULi/lIHS2xxCFm5EkL1LEWdn
	F8HC2Gt8VSdu5tyFFJhZqN6OkUAF73CO5zBYu2neOZg7Zbmxk6GjFjO0jajTrg==
X-Gm-Gg: AYBFou3POlUExDxexidSJpaU45c6zv1OzhQ7Ekz8MOkdk4fICP8J02MKf5wosOaH1Jc
	yy+85GnFxgYGw43dlOmO5AnybOJ58QLeObWrvijAlecGaUxnf1RamWRhXFOGk9qJWdIUGPC9Vy6
	RrDbW6H2H2TEfojg2RwqB33xunMxyByphqeUXOEgrCx9OMEM/J49nfwJtU6QzQTCx39g+5B6ntE
	Qvry62AH1HeY0ZuVuuMLSbjLVmn+cn0oUYIzl+1oOGIDOUUCROcqaPB22BBGTjKkMzks+7WK2k6
	LYH0BNlEZjM8ml7poD10stSlm1TgSpXAwZcGWLQgaJF//or0O4vnoNMPGbChbTnUV3oGV9q7zYW
	kyKQ60URFMH//FIEk/bRmR/lnSn2hUxjU7p1Duhco2c1z14k8ihN7pmvtqOPsNAiJZgdJbkElro
	9fDFeourPN8BeMA8g78PTOuQybZY8wkBCI5Onq8BFDHnUP2PPS3XmOpiJBxKHwqmuiAguDrD7Pd
	uVJ854JiLhW38jlNpR+mQanJHx/Cr7KYCxPqdtk36+BtUhtApHYRAHEYQdedAm2FQqZitjlump1
	XoOBz/uT/44l4+pMLFCZRKa3IOLqZI/4nKhDoUqjy+86w+WuTZba5yPcFXCYwFTCGQ4XeTZWPPM
	J9GuCccC8jqbSI/IJnvzd7RtTJqBTD+P8xtjAGHwAbE2RpFC43uBq7LjnzM32+Xi2wJ4bzkMNHs
	l/Bwk=
X-Received: by 2002:a05:6122:e184:b0:5ea:f399:781d with SMTP id 71dfb90a1353d-5ee1c4a2151mr1253897e0c.23.1794414346874;
        Wed, 11 Nov 2026 08:25:46 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99c200004e7sm4269659241.3.2026.11.11.08.25.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:25:46 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 4/6] client/player: Add endpoint.clear command
Date: Wed, 11 Nov 2026 11:25:20 -0500
Message-ID: <aefde5fcfe665ed0574ce6d24029ac6021582298.1794413813.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794413813.git.luiz.von.dentz@intel.com>
References: <cover.1794413813.git.luiz.von.dentz@intel.com>
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

