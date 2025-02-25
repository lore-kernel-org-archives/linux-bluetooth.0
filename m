Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38620E31E
	for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 22:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740520872; cv=none; b=S/x1N1VcSs68jHk9A99N3exL5zOXU0wirLgGFYz91Zbepo8TzSSIH8VwNjOJaCaoVwVGeaOqITKESEavZPDNxJw+FGeeqJMOl361vAki1Hu0IArDopIe+k76FPNnHBKlnmpkiAJy0I17i4MOBuIXp/xkUA3ho9ypO4fFUG931gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740520872; c=relaxed/simple;
	bh=2qx9GwFfGm/Atsf8mteW/2Zs6/W8gajiBHjSum0S5kI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHeLdXt6YBzjE3aABbTQLcBBur+0HXkG6CnjET1/Kq7wQs6ImjuUyDjoW5iXNWwHbnpOJgXqfrtu9i3Hk5Mj5+XeDZeW4Bvesq76RkdaQPvpP9vUklaIXARzYoF7w60F8/l0n69vH+Wzjseg4WaVpK425uFpIXg6NTwcUTeyuYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DEytnB6Z; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DEytnB6Z"
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-4be75b2bbceso2103559137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Feb 2025 14:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740520870; x=1741125670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dAGe+QBkDTuxpOYnGPVHdAhCibFrbVZNPHp1Uilvl9M=;
        b=DEytnB6Z5jISYn1Vl+Dw6DN9QqNkpwXfkHPHNT2N5YRZi/RroNXXU9L7QmLBMHcrHC
         44XhLZgX0QzBZYetIKNZeWPxNIpSrnAW49FDxItcboX/wpuiokd1MwZuQD6tf5BI+v9X
         gDQC5espR87E496P2Yw8YtYIv2U3yU81AOD4QbpATv7bQQ3ypMJF1ZwqI6rKnuQn6A79
         qn2m0wagwyTF2Zpm/MQObEVkIZnD9Ne+QfEvFtTX12skrIm9vvXw8TpsRjBABQsTtRYO
         qTz7WEgjhG/UrJdbGEUuR5yd2cxxJ0sxN0ybDdZdzaEP2RqJ1eAssWbb13vBqTLFLiPc
         /l3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740520870; x=1741125670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAGe+QBkDTuxpOYnGPVHdAhCibFrbVZNPHp1Uilvl9M=;
        b=Ku519qKcJHYKD1OGl+Nb7bXm+KKdV8Kz1Yf4KfZjYd2LGAi3NfXRxQ8VgWQAZ04/0n
         CIPhJ7tWEmMze7HL5G7K5HzYFTdyb0LcHqJ17pDQ2kCn+MI/ONwWuOXZQbcCP0QxTtsd
         GYZyxPuSJ13HoxV5XvJGChJ24Oe9+zGc5qZKsV4iPC6tz+bt4JX+V7wihIsHGYJUL70C
         5TWdi5maN7UFKqZjFZKx2m3h+SyrAzEQxx4L9hkg1dXosP7NZYU9NQw7mXtf10KBXjjL
         afKZc4ZzhNWGPHWj18m/cetQnMVFmDnGZz90cFaPfe6YTduf80eWXQJ49cvQZiVkTGE9
         xQZg==
X-Gm-Message-State: AOJu0YyRFBMZVWUjImS11jJ56WJ1gCFuuSw8c6gRw1345JXRQaATqRMt
	A5FqS6dTCmshP1I6M1WOCDbgMmv11N9yTV2pwCQ8gOQ/OISTOwxKEYo4pNgF
X-Gm-Gg: ASbGncuvohjDTN1WMzNmZ9+RkuoInyFYOITu9EWKY839CmqheK1h3lAfjKY5mwfEz55
	wbEryarcumT3KGbYWcxdxtOy0jYy2Z3p+TWEEWuanU3j/v4YrgU7hja//jJod3H0LoxGWrFjpze
	qGg7JVil4I+xgU4qHTu8mML9aAVROOzW/Jtw7GGeQxTKLthLkGPnPUDjCTPJVKe/BjeYxuaOnEz
	lNi4AsOL8580EpOgqciw4jXbLqLcsavB//Gdqy0atNlC/qBgDfpuu2HDNoRdY8k3jCMqDyZ/uFO
	RlDCE4XmfYufvGkV6vaT2xlDZeWXGBpAKy4r9Bm7DmNkOdIGbFEkZygvFxWz7VLtCCCAmBg=
X-Google-Smtp-Source: AGHT+IEPpu6UOmlqyIri8VERvmMrlkunXH3J/oJcfwP5Tnnm8lBp+wrd6vb9AKcPoKxVQiDXoUJMcQ==
X-Received: by 2002:a05:6102:32cc:b0:4bb:d688:9bf8 with SMTP id ada2fe7eead31-4bfc27ed54fmr10110003137.13.1740520869685;
        Tue, 25 Feb 2025 14:01:09 -0800 (PST)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-86b1ed4e428sm494863241.13.2025.02.25.14.01.07
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 14:01:08 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] client: Add support get/set PreferredBearer
Date: Tue, 25 Feb 2025 17:00:59 -0500
Message-ID: <20250225220059.2821394-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225220059.2821394-1-luiz.dentz@gmail.com>
References: <20250225220059.2821394-1-luiz.dentz@gmail.com>
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
 client/main.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

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

