Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBAB1DE3D7
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734459220; cv=none; b=A8ETbu2MI8OAk2th4YqBV3S2PJF2NDzHIHPPeMDqHeZzHsXQ9wuXK10gH8oll15UeB5TK3V4xBVJmB0wtoHuZmDDUWSLr7WMd24RR7g2QB2G1OcGRxF2B55NImNVZaX5zH6dWjoGK23TiY94FOtJPNVwNTGjEZ9Qm4acqWmDvB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734459220; c=relaxed/simple;
	bh=oizjkpllPsDOEBU/614EOV/Q6NQquysWJqKJKEA9dc4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=A2vlKFEAiODWI/yO+cj+puGaOXwwVQN5JDPG49rdZsA7tLATUJSzvheIHF3atNxqIkX8bpUJXZuYsZ5yXnluRjsZfOfEG/WXxP0J1aeaphB/pL6lRjex03Ifc9+5RWanvDscPjaBDx2ZuAWIAOU47etKecohxe5ERPEjiPD193w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NLUp7kcK; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLUp7kcK"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-4afe6a8d2e1so2815761137.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Dec 2024 10:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734459217; x=1735064017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ1MoB6UPTuEXkAyk2o/J6km3ElthbdHEvUpYhi5bCU=;
        b=NLUp7kcKWm274MirYyWtHzIpMoqFWIPVG1j2SjB6x7OQL0gbNXzGgJZ8itEj28FP0n
         hsScuwTGvY2AsLGBEtNQ6Qe4uQ2hi4cU+AWMO8J/23Q2rBRBaUM8Ur1ADopf2pR/YOyS
         BsR6hj1391SSJ8FsS43Uiewtgsyl3aUSlq1AQP2A28lUgPnB6zeJzipM1k9haaljILUn
         4iltX2jFAucmEeYGemOYxhldUPJ/Dbslhr3ysd9s/3HONdwoAGnjdnpp9jAgHo9l8yeJ
         BnwFo+hYEmxrO9T3ma5nGL6trGzUtG9p3SyQzZdv6Y6r0kpYXwB03iH9WowdGL/t3ieZ
         nDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734459217; x=1735064017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ1MoB6UPTuEXkAyk2o/J6km3ElthbdHEvUpYhi5bCU=;
        b=PyYNEKWKhXflx5+qn/I9RQc4bH8KKVeH/kCSLNBdVmMw7ApzJl2de7ENOg0ashPN1b
         I3cSlXjCXXbYQ1nohLL3K8nFtO9FciVgBNeg/EOgKjYHiLGGlbO58FQvB0jZC1lJVam6
         IxmiDEHgN7tTAagd0EMQjCmN1YXmG1/LsmnR5id9MAd1X59cJo5isk1VhCj0lQtaFWMp
         cAdmUb48AGx4mZphSkhcZksTvc/wQUjOcGZEsOzKvOqLlGWJlsTa3/Pz8uTHyKA7P+6+
         EH5EHzNblPlvty7GBTHAW4YwcUQ4gOkNtmHyymzCDjRqveUn/tUaD4ZMkzJ829KqSd6d
         AiMg==
X-Gm-Message-State: AOJu0YyLkNmTu3NsS8a504XVoKzh6l54YW2BInJQ/qKQSssCj8qAoyf1
	koJMFg/rp7dATo11wSDhUTl9+pZoiRtknHKHmR9S4yI42YhCkJmSQqmyRA==
X-Gm-Gg: ASbGncvbdVD9jkmWgoAwzZKwhmllE2BFHZl7ysomIG6nvK69gQbdFMgwxLP/Z9DaTa6
	MqbbWrXMD35f0Fy3mIe7scf//dGgocXI38wg3J0jt3DsOaYMGD9+ZIio6wS3SekiZ6DSWMs5R8s
	RjenqS2f4Rxz4v+UE2WaIXt8823FBxNFBIFFRvZ9erK83JIO7GdBTP0MPETe/nt8X7BXMP0wO4b
	brnlhz0yhUSMGKOnpCkbuiMs525r054LyGuJCb7OiLERKH8/Sofz3qiT/DJPb/b1WVPNtFytw89
	CSq/7dZdgJHL978+M1xqjmEqlV4S
X-Google-Smtp-Source: AGHT+IFKHEb/N9FXXcXokmXyHxIIAzvhFmfxFTQh0i5Ke0uDlg3GV9Xze9qdOj0PXdp99L0xoubhVA==
X-Received: by 2002:a05:6102:50aa:b0:4af:ed5a:b68d with SMTP id ada2fe7eead31-4b29dc38822mr4070446137.6.1734459216940;
        Tue, 17 Dec 2024 10:13:36 -0800 (PST)
Received: from lvondent-mobl5.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4b270238f25sm1214721137.12.2024.12.17.10.13.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 10:13:36 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 1/2] client: Add command wake
Date: Tue, 17 Dec 2024 13:13:33 -0500
Message-ID: <20241217181334.3243011-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds command wake which can be used to set WakeAllowed property:

[bluetoothctl]> wake XX:XX:XX:XX:XX:XX off
[bluetoothctl]> Changing wake off succeeded
[bluetoothctl]> [CHG] Device XX:XX:XX:XX:XX:XX WakeAllowed: no
[bluetoothctl]> wake XX:XX:XX:XX:XX:XX on
[bluetoothctl]> Changing wake on succeeded
[bluetoothctl]> [CHG] Device XX:XX:XX:XX:XX:XX WakeAllowed: yes
[bluetoothctl]> wake XX:XX:XX:XX:XX:XX
---
 client/main.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/client/main.c b/client/main.c
index c4fc49427021..322326ab9b80 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2050,6 +2050,42 @@ static void cmd_disconn(int argc, char *argv[])
 						proxy_address(proxy));
 }
 
+static void cmd_wake(int argc, char *argv[])
+{
+	GDBusProxy *proxy;
+	dbus_bool_t value;
+	char *str;
+
+	proxy = find_device(argc, argv);
+	if (!proxy)
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+
+	if (argc <= 2) {
+		print_property(proxy, "WakeAllowed");
+		return;
+	}
+
+	if (!strcasecmp(argv[2], "on")) {
+		value = TRUE;
+	} else if (!strcasecmp(argv[2], "off")) {
+		value = FALSE;
+	} else {
+		bt_shell_printf("Invalid value %s\n", argv[2]);
+		return bt_shell_noninteractive_quit(EXIT_FAILURE);
+	}
+
+	str = g_strdup_printf("wake %s", value == TRUE ? "on" : "off");
+
+	if (g_dbus_proxy_set_property_basic(proxy, "WakeAllowed",
+					DBUS_TYPE_BOOLEAN, &value,
+					generic_callback, str, g_free))
+		return;
+
+	g_free(str);
+
+	return bt_shell_noninteractive_quit(EXIT_FAILURE);
+}
+
 static void cmd_list_attributes(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
@@ -3130,6 +3166,8 @@ static const struct bt_shell_menu main_menu = {
 							dev_generator },
 	{ "disconnect",   "[dev]",    cmd_disconn, "Disconnect device",
 							dev_generator },
+	{ "wake",         "[dev] [on/off]",    cmd_wake, "Get/Set wake support",
+							dev_generator },
 	{ } },
 };
 
-- 
2.47.1

