Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429476;
	b=gLGHWynKjyxNPSPZBPi2H/TJYkXsWGW0NeANgdoldbq/lyZThQjeLKyeOsZuMK9N1FRH
	 wV2DnJKzvMRHLXBL39M06zqKQaWNs5Uurq1Yd0qftqQ1Ul760Bm85wk/ExCCCvrSuEXP5
	 L1iX9iX9kZY+kf5lSgLm7sBK0FcCS2glw+Qootw+6MyrEujuMnOi7I8obvRVDuxmkcLYF
	 kpFGvQJIiAeSJoCb4udbiMfrwYr3LaGaXpvh45l7VgVmDarbxcAB/f160BKCLQiLMjpUS
	 OvFMrQhsnjJDcMhQPuQvCruP/eyAGb2gGEKoY5jZIlOH29ZM0AOt+GbC6MSI4EntRjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429476;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
	b=2I/ofSHsebEjM1IHwTYiJtbfqE2PjSYsvv5vCM+JCutGzWUBb4hSf9m3Xv8fS6QwH8t9
	 mzF7eVs/TsBKg37BsQXKPVb4DDysjHZoTwFV+8NUmho0RJAMXN6sgI4M3c8aMtCUbblV7
	 JHIx+v0x6xgiS12JAwtXfhrD3GFkFEvttMFTnAvCKMFewg9geGMtYxQ9/E0ILJ2X/TXSl
	 ImgvMdhm97BOKQjUbpaigsFHlVehum9t2MlWa633cYarBpgfclUqYxhEIURiQUjdWHykI
	 WyCxkEF4Erkwx8KuYy/VEERsurE1+SUeH0xQ6v1Kz7Rbe0fhLwxQ353leaJw8FUq8Gw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z0vNDbwO;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BB260A261A
	for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 20:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5BB260A261A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z0vNDbwO
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98301b325c4so874534241.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 12:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429474; x=1795034274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=Z0vNDbwOBxmdbJP5won3Gs8dBpPw2FmZk7aM7UIRjQdN2UN9IshP4wD5f6NDPfA0oq
         JkXsPtdShaKdtDqqgis4vULsjo3n1NicAWM2k37PI+46gIi5ODrB7DO2JP9jQH78NIqL
         A2J9Om2QFBjE71XG4gB8mSxx4awG4cHxX3hxV5wzheVJubKzg46WC7N9C9IKZecINBIR
         wHZudZQQJQGV8s5sNOnoJtUqcjHPEDtMSPTV3WAk0fO2wNpUaVq9Aio5LZFSETnt33t4
         Ya5dYKxe/F/LGOELdISls18bSX+Lk1rkfo5WguZeMBRgycyWA4ZOn9rhfgREVZnC/8jg
         8MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429474; x=1795034274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=MS4BVrAatFI2pIIKsYtpuHHigeSrBF3sT2Hx9JJi8UE=;
        b=Nj5pjcKH4n/DGsTo/JXUvHiULucDYyrzs1/5615U0iocltBVVtp5Bc75z+O60myOZe
         vdel6MlFuQwyMdvOnEbdz7Btz4RYhBoBbYENRTcBLIZ7ZBgUSgz3+iV0/zu4Etm51b9+
         5lLJ6UmL+v1Yx033QReA4T5uZEtQgbQVnbKuTlVlBov63DDdN6dby/AhCJAoRingmEo8
         jCj9HrvFNbzpDgN9cWq3l9QozAM19gZzs/FU8RHAYPdYGpYmCTIBNPncQFGvYIm1U6fq
         FhZt5XWY0qbsfWt2HCQftlVyD+esumm8TFB3eKWmWb/apx7c6vDnAeQFzoHwi0NYP90S
         1+zQ==
X-Gm-Message-State: APuU4Z9qx+6R+9XRBuA4pEOqeR7UO5mgA7EVSMBdgAEnHe2ubULZBdur
	qH5zq7EeM7HsVqUrEbS1YoZeCgd7QldvGi1Vn3A/FMgmwpYLu2Grp0nb3kPgOw==
X-Gm-Gg: AYBFou06usL3HE/LPjRTWpvHZtgB1NecFHnaSEefyj1t2YOrgM8Ckzi4ehITTxRxkdV
	samWOw/9wzBsByUJeVJ68iE0DKwcK+wlixB8ZusHgMIlZ34grkRMd9oDjsRJO+7zg+v4HamgSRy
	iklNjDlSJJopEEgI4PMqBepxyrO769Dsi99qYVyAvTVU4oC8eunKCEl1y23qYjWwCgGQvxl4ZCs
	Tz4CyzzXRWY/UuiMmaJAr63HwvBZ3bWIqXb1VXR57Jpvtr6azXyivsqsiXTG40zafT14FILqwrX
	44yf7sy98XWRi6z1ryqHA0V13/EWVDe6AecoA/4hZmWWP1wA+EqdBiSzG+VIyZaIgV2YC36gbAm
	ePou8EzlasjM/y3u0TEjwNqKKQ/Xsnh3lKk9v6Iy7WeZlOSwirX5K7iUvTZ2uzzhE7y1zXEolwy
	xx/IoqEcPRl+nNUhbkdQWL6opqvdZVEOLXlFSVo2L3madFNZPHjwcmREGXv89Cr6ZIct090Yykv
	vrLu95QVo/qHMBbrxaha9G/MzowqzKbV42Plu2WRlGdevJ1uax54XmxF9gLbhN0u0ooCAO1uT3u
	U/cS6UEv4jXh//q+Ibe3HLjYRdK0q1dB+/5qIi3O6nyhJfsN+R1Is6q/l/oVjE0Lqsh5srN0fxM
	SV82vxIN/0/dVjv+DV0pCm6dli2aQAjsxwOftAWa1w+AMpSGGMGxyLZeQoBhCiLWa52NKsJA3DD
	j2gkQ=
X-Received: by 2002:a05:6102:4bc4:b0:7cc:1045:610 with SMTP id ada2fe7eead31-7d5061a2492mr1362938137.27.1794429474428;
        Wed, 11 Nov 2026 12:37:54 -0800 (PST)
Received: from lvondent-mobl5.taila91cb8.ts.net ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d302359221sm4762571137.6.2026.11.11.12.37.53
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 12:37:54 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 4/6] client/player: Add endpoint.clear command
Date: Wed, 11 Nov 2026 15:37:31 -0500
Message-ID: <231c6e7909673a62925ebf13cef9d7e537ee9da6.1794428234.git.luiz.von.dentz@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1794428234.git.luiz.von.dentz@intel.com>
References: <cover.1794428234.git.luiz.von.dentz@intel.com>
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

