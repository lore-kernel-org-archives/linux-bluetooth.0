Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1278A47B437
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028693; cv=none; b=KbDoNbG8VtbWsU3ON7jkLrnaNXqQuJ1GFjIAkAdX3uBl/Iz3RpSsw4X0YgfMyb4uiFExoO5ESS+CQ8w/PhAZGiQEg6saM6C2a4Vg57FPTriK6Lewjh5SzyALnVV/5u0hr3ZpxqimEI6/RTwKktj1CTu+ZAyhnLXinvuumyX/CVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028693; c=relaxed/simple;
	bh=t2BczT6WToY9XeR2qLD7JbbvH5s6SfwBqHHAA6VDZco=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qtvFaxAqc6ES+pOevFSDGWm1DkpbE3xdJURb7hPQCyeZYJpDbDJ6HHxTNpuBAAdXXIkRBvPGm5+zuWU3IHCgZ51ktPUolMlPilkYXz2WgHCAO4tSODwtKkPsPLMD168d7YQflMMKIjV8xP4eypVGo2Tlqj+siFrEqPG8vNGIeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=skUBFWb0; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="skUBFWb0"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c1915793so40065955e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781028689; x=1781633489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBWbQhHJp5FFqv0sAuMTmkq4+hbMK305KdayTAQVXBA=;
        b=skUBFWb0fHld/ZKZNpcr0+wKzQMI5wuGp09nScjdg5sFbHt2fQ9Q9MtlGaHPLYtcwv
         DwF1xzQDgsYqWYIaGQXUuUt5yKJlt3deWvtDXGGu9UgDOFURShX5JosKmR3ruO00bW2d
         ulvnMpuUl2QRCPViyVOHzhQYOlbbKT0aeYexo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781028689; x=1781633489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fBWbQhHJp5FFqv0sAuMTmkq4+hbMK305KdayTAQVXBA=;
        b=Pfdh2Km+pUyhrcS/mFb84/WFuM6llGxtz8UhHJ/PjXxfXH64lWwXVO2tz8dKajO0m1
         2e54KdV+UOH16YFWfyzseKxxG2x6do0Rn4D8g0pXrvl2KURw5mHjLs54aDEARFZPJdiq
         FYayqI6WdmR96yRzPMqAfRyoct9KX0440umLsVDOqdReVJH5EEpAF3efA2VN9lp6kUcS
         XbkOFIsQwAUiYS+yjrYr1kVdlGEkjEMozdStDeLpx8DzYtYZcTb/gUAblUJSPMn2Y3Ke
         f96XF5PXLu2StTCyW6Dr2PoOQuNk/aYhjj+oS5xXBbk9vcaLUTBnnfwq86Bh/Gh6XKcg
         RBLw==
X-Gm-Message-State: AOJu0Yx9C4wvq9vA2yGCT9G0ASwXsvpWqDX9O6AOcbrrhsL9DcNX6S7q
	7NnhvdJD6kPRf6GMFuUV9z4jlIqyJtfCu7SKki+jd5Cdcy29HJmWWjqPPV9vxNzXWVyoYIAZdk+
	qWsu5
X-Gm-Gg: Acq92OGP3G6QBkEzavXgbiRPm3Aul8QB5kBn6NmT7c8pQwQ95g7BpWVxQHHgBHDfirD
	92+mtpzRnqc3+BeuuxNunIrW7rkI5B/IfzkpidFsVOq2D0/NRsbhUnssjQFul9vR3EdCg5IZ9E1
	iV/sbDudTlmKpRIALGy16/OfhR6fIOF9YDiQPZ+tlshSfkCEgJwjSfgS+R/KAEVZJWq6jk//iW9
	evE/IYDL/glrKUkB0HGK3n41C2O2CdcaVxxbbwNBKARbYewFiOrim8zIJh4QFdFxUC9RuZ/oDgq
	9DHnxQ3BknSbLrKnE/eW/G2CPfjCFNISxwAchkyDrap6nV5q383QP5Vdg7jcIVm1gFAZ4x1wQIA
	U3PCaw07T5FEvg20V0/LELZkXD2WWVAXfQu7px8W4ZC3o5RARyOHLODPkJLBMypY3Q7QWF1fUPV
	z36vnDpB+lVVYm2gRyxE34Hg7WN8dqusCJRSuNep3Dau9FHH4rx2nmKzg=
X-Received: by 2002:a05:600c:45c6:b0:490:b9fe:e64d with SMTP id 5b1f17b1804b1-490c2612b7fmr359215245e9.23.1781028689474;
        Tue, 09 Jun 2026 11:11:29 -0700 (PDT)
Received: from SMI-ubuntu.sueba ([2a01:390:0:101:824f:5c20:dbd5:c2c2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc40716bsm532750505e9.12.2026.06.09.11.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 11:11:29 -0700 (PDT)
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
To: linux-bluetooth@vger.kernel.org
Cc: Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 2/2] client/player: Add transport.mute command
Date: Tue,  9 Jun 2026 20:11:08 +0200
Message-ID: <20260609181108.3787224-2-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260609181108.3787224-1-simon.mikuda@streamunlimited.com>
References: <20260609181108.3787224-1-simon.mikuda@streamunlimited.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mirrors transport.volume. Accepts on/off, yes/no, 1/0.
---
 client/player.c | 51 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/client/player.c b/client/player.c
index c5e4beef0..2c3008221 100644
--- a/client/player.c
+++ b/client/player.c
@@ -6070,6 +6070,54 @@ static void cmd_volume_transport(int argc, char *argv[])
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
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
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
@@ -6188,6 +6236,9 @@ static const struct bt_shell_menu transport_menu = {
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

