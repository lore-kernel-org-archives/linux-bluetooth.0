Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699751C1726
	for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 19:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466866; cv=none; b=bsMU0j9JWP/N37sh76NzuDYuHJzcFBExy08FU7tCjRDIRPLQh3BYMF+87/fx3ag3/piK3V0a7ItQw2D3bF6FyxXlnYc5f4G7rULqUlqsl7nC5sQiyTNPEBmdX8d50dKzZGetKi9lvt3rRKaiTGBOLfmTWxlMtoXgCXOxWQCnIxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466866; c=relaxed/simple;
	bh=ZPygmGOhQBTdXHcod5fOCbQ9GRBrNIlalUZ1UkMG8zE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJ8vqCky+o9aqG8uIJVrsbNA/LsLWxvs541RjKnWs0YVeimHnPkUtQqZTjaGZ+o5vF1Tfb+zmY1M5hNqgkwhYsC8LyAErU4kf6GAtniVBSpVUPtU8FDg8piw6cavHjDDY0rGvhMm5LAeHF8cAT5m0r9Gdmbe33/4RramOj3Le60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1xu4+1D; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1xu4+1D"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-49bcaee2754so788732137.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 27 Sep 2024 12:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727466862; x=1728071662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u2AS3VNxu9KsxuC0U6PJpX88Zf7++V80OUmpMs9dxOw=;
        b=i1xu4+1DgESxDWJn179gR7lxX5oSNWIr2adjnr02kMWD5nSeoHKlonOD6rCwTDX09k
         ePCmGCaPa8A+oETM4ojfkPDYCC8DBM3s1hue9TNzGbjSHK8ii7tRBPxldnjcau80g7/Z
         SKKCBIpLZkmYU14UYcAoe7l+N1x26YvBSLkE2NPem0Vd/aEmQCOhwK+1H7vKU8Uhltw6
         Y6qxQbCyEHGOSHPYFrTxjCWXYBpXPAj9dgQAE0LBHjc546kX93Un3RLCi7wcdaZ9oNQo
         YQE++dNnVFq/+wpmI2fnpRmQKImb7dg7Yoy/8vFyRt+Pr0y66KAPhjSukOJig8byTjAk
         KuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727466862; x=1728071662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u2AS3VNxu9KsxuC0U6PJpX88Zf7++V80OUmpMs9dxOw=;
        b=BTJR7KhNGluYXo9nVR1Zo9AuEZqi5FC2Xuv8+tVMYguazagH7ZM16uzcw0QvoxG+fd
         iR4S7llRktudq7YU+CnbsYFv6PKZftVdMQ6NZXljQEm5WDbP5ztheXPSBurfHHWt7hTu
         6Ho0zLhwNAe4o7HR76Kn7VgqkYQ1awRBZWSf1HurpNb2lM5VDjwgQtwLyFUQxz50/8qS
         YgWK7wVL7Xg4RSjJa0toDvTfgZwc19Jf8dgcjV/Xrv2oYnsB6I8KZtJ3nfHCdfAEXweh
         EpyN31piUZiXan+oa6i/VRqIw1v8+RFnoKyruO5VH8VSxws871f8S/99sVisUiWFiI2O
         dxtw==
X-Gm-Message-State: AOJu0Yzc88h66M9D15jNkdMKv7W4d0akM9gyt9LKbeJVzbwLeCWvk+J3
	ih9OIMW4aJoKOVUCQJWq3azNrlwPHk779QA/qOmNfvjtfygvsjg0yvmqTQ==
X-Google-Smtp-Source: AGHT+IFLNJpez8vae+c/3fOxqx+ytH9YVd4RdPjgZHFQ9f/zIc+1FhoHocLZaayMF1FxzJ8i347g2Q==
X-Received: by 2002:a05:6102:26d6:b0:498:d51a:989 with SMTP id ada2fe7eead31-4a2d7f2d562mr3981679137.9.1727466862402;
        Fri, 27 Sep 2024 12:54:22 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4a2bba3b41esm450476137.22.2024.09.27.12.54.19
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Sep 2024 12:54:20 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] client/player: Make transport.show print all transports with no argument
Date: Fri, 27 Sep 2024 15:54:16 -0400
Message-ID: <20240927195416.2527923-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240927195416.2527923-1-luiz.dentz@gmail.com>
References: <20240927195416.2527923-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes transport.show arguments optional and in case none is given
print all configured transports:

[bluetooth]# transport.show
Transport /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX/sep4/fd0
	UUID: Audio Source              (0000110a-0000-1000-8000-00805f9b34fb)
	Codec: 0x02 (2)
	Media Codec: MPEG24
	Object Types: MPEG-2 AAC LC
	Frequencies: 48kHz
	Channels: 2
	Bitrate: 320000
	VBR: Yes
	Device: /org/bluez/hci0/dev_XX_XX_XX_XX_XX_XX
	State: active
	Delay: 0x06a4 (1700)
	Volume: 0x0059 (89)
	Endpoint: /org/bluez/hci0/dev_94_XX_XX_XX_XX_XX/sep4
---
 client/player.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

diff --git a/client/player.c b/client/player.c
index 39c14a9434cb..df22465169d5 100644
--- a/client/player.c
+++ b/client/player.c
@@ -5048,17 +5048,8 @@ static void print_configuration(GDBusProxy *proxy)
 	print_lc3_meta(data, len);
 }
 
-static void cmd_show_transport(int argc, char *argv[])
+static void print_transport_properties(GDBusProxy *proxy)
 {
-	GDBusProxy *proxy;
-
-	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
-					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
-	if (!proxy) {
-		bt_shell_printf("Transport %s not found\n", argv[1]);
-		return bt_shell_noninteractive_quit(EXIT_FAILURE);
-	}
-
 	bt_shell_printf("Transport %s\n", g_dbus_proxy_get_path(proxy));
 
 	print_property(proxy, "UUID");
@@ -5072,6 +5063,31 @@ static void cmd_show_transport(int argc, char *argv[])
 	print_property(proxy, "QoS");
 	print_property(proxy, "Location");
 	print_property(proxy, "Links");
+}
+
+static void print_transports(void *data, void *user_data)
+{
+	print_transport_properties(data);
+}
+
+static void cmd_show_transport(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+
+	/* Show all transports if no argument is given */
+	if (argc != 2) {
+		g_list_foreach(transports, print_transports, NULL);
+		return bt_shell_noninteractive_quit(EXIT_SUCCESS);
+	}
+
+	proxy = g_dbus_proxy_lookup(transports, NULL, argv[1],
+					BLUEZ_MEDIA_TRANSPORT_INTERFACE);
+	if (!proxy) {
+		bt_shell_printf("Transport %s not found\n", argv[1]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	print_transport_properties(proxy);
 
 	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
 }
@@ -5641,7 +5657,7 @@ static const struct bt_shell_menu transport_menu = {
 	.entries = {
 	{ "list",         NULL,    cmd_list_transport,
 						"List available transports" },
-	{ "show",        "<transport>", cmd_show_transport,
+	{ "show",        "[transport]", cmd_show_transport,
 						"Transport information",
 						transport_generator },
 	{ "acquire",     "<transport> [transport1...]", cmd_acquire_transport,
-- 
2.46.1

