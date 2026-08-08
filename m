Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21042E401
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 20:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786219691; cv=none; b=tlDDnRYF5i3zMWilvC2Ea0Dzu4NGV/LwWihm2mES3zMCMIcdHWweoq6pE1tkk6HMOCILeS1f1De0ZJmdl7x6oAvGvo6xRifrTB0Ov1OVicvArO/SaIR1Hyt5FNzOxMiAsJKwjPSqS3qkpW4iHH6veuB2qAVjsCPBdd5aPx1PHLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786219691; c=relaxed/simple;
	bh=x5MxKcfOu/qYpSo9NHaIZRXj4xb7zYL05HtIe9LSQ5U=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=JAFzm6wDL9DYigTvuExHvXantLvxyhmLZLodtj/nYug4ihy7ABhICEU+pbe2v4ZalNkmdpWb3LkOGDN3UqWJ4XwW50usF7YC9wKxTDlSug4bPpWx0+vLKN4zphyS608MFwlBCH0eWoO5YtYm8y+kWqk1tm8B8Oprt5ELWOy3sK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKZnO4jG; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKZnO4jG"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so1809555e9.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786219688; x=1786824488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4+PTWIdlmooTL3LG4i1MPAxy2LP75W9IxWV8cdVB5u8=;
        b=lKZnO4jGBpWuyICkd0PAGu9vVOk76KtbRSpbKxHrkw/P/NIMxytvysQcz3VRq9xc/o
         ScH06y+ir1V7jCxSBGQyeboKqapVglYezZKpTde/ux3AZVlhCEVPVOWdmZHyreL7L9PP
         dH/9cq1CkCtDtBh0yFcMCgU9cBaOP0RSLrCIkH2/4gx7HMO5RLxwCRowl96XxrENeokN
         joIDINWkw0yWPpfD6T5FkxTsU09gDDCs/ftt9CshFkoZ58mUyzYiRXxZtDF1CcJypQd/
         YloWOBjmXrZx6lWRosUoUVUK5Jm0uBN8r0r/npvItO3P0MWqskCje4R9OjF1nB1C2S58
         Q6JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786219688; x=1786824488;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4+PTWIdlmooTL3LG4i1MPAxy2LP75W9IxWV8cdVB5u8=;
        b=pBcInudun4hH5dsrpf3zWiZ3TB9UPweK8lyfKQX8C4Y8UGWtWNrIPlRS7Gschs1Fg8
         Td36iNVnbK5DDfqunfZfyUu2bzbIAKF1+gYfty/dZyZsbFwpcT58q/o1YSOZT7oH9WQN
         5K1HCAZ4mnQrh0XovRyXkyk4dndmR8reE9WzSmz60pbwD4s6jWYirpeg2lXN4t3x8kTb
         qZGGn+Rm2Mt1Qud3iFjVNtWocPKK5hiFRT4hNEKVJjphhPDHCsUFEhoVyl2cE81LOCYK
         ELDDHenyD+HABWroNq/WGr3r+RrqOujxmyngti8CRDiCLqR6o3wp4Hz55YUxugsfFbUw
         P2Ag==
X-Gm-Message-State: AOJu0Ywv34EHz2CSbtwZv9uE6X0xG3i56F3Dq7x/lWrjVQbn6kVFarSu
	VjTzqi7sH6eeyGvPR9nswJTTtxFC3SrDhs1obSHONnu4vnpmDSU9+yzsOpoLuzl9QSY=
X-Gm-Gg: AR+sD11Uy5VcdYWewXgDDmvx2kBRdBmkPjJcBsie9pgoOg+Vo/QmLF+gsaTZJbKm87l
	rjTZkm8YI2z7HZR+s01h/qVuQDfATmykzl+2zKvKxAS5h6bRaiZrObei19OIJ4bPiGRKOOD2jBZ
	g02Lyzt6msLgfPwVAgQdqSjuJyjD7uBmJqMAKicpgWG8u2Hgi0sp3FyaVLgYkmgfd6c0GCXgBKg
	995R14/BJXssJh1LitDaTO6+3ZlT9gfEKPGEze51myBXfmhRHjbe8RM6FayDr+tJMwDIoWMqepE
	VLtgfnm3TDMMEsPyXPSyhIdAdyY/Vg9hzFddi5EXho3List6pPWR5rD5YeAqUH9Vpfechgq06tA
	SXiZ7vzzLyovYSoOON4t5tTPvx25LBW5DgzOBU1hHVyA5g2MuoXAD3Xd/kDmRcqkTur60zTDAHv
	uqZxORc1UQbfd5gw1BQ9GdC7xiQXoxDMZqq2R4Yr/srOhR+LDSbgX3Qo89ws+RO6/My0+3RxXOs
	qqldNxWK/t+
X-Received: by 2002:a05:600c:6298:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-499619839d6mr86652915e9.9.1786219687781;
        Sat, 08 Aug 2026 13:08:07 -0700 (PDT)
Received: from arch (user-109-243-3-173.play-internet.pl. [109.243.3.173])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995ea3361esm145250395e9.15.2026.08.08.13.08.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 13:08:06 -0700 (PDT)
From: z4pdyy@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] client: Avoid scan prompt when discovery is already active
Date: Sat,  8 Aug 2026 22:05:17 +0200
Message-ID: <20260808200806.134373-1-z4pdyy@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: z4pdy <305461556+z4pdy@users.noreply.github.com>

Check the adapter's Discovering property before prompting the user
to start scanning. This avoids prompting to scan when discovery is
already in progress, which previously resulted
in an org.bluez.Error.InProgress error.

Changes in v2:
- Move variable declarations to the beginning of cmd_connect()
to fix the ISO C90 build failure.
---
 client/main.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/client/main.c b/client/main.c
index b5cad8afc..069e20485 100644
--- a/client/main.c
+++ b/client/main.c
@@ -2290,6 +2290,8 @@ static void cmd_connect(int argc, char *argv[])
 	const char *method = "Connect";
 	char profile[128] = "";
 	GDBusProxy *proxy;
+	dbus_bool_t discovering;
+	DBusMessageIter iter;
 
 	if (check_default_ctrl() == FALSE)
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
@@ -2297,8 +2299,18 @@ static void cmd_connect(int argc, char *argv[])
 	proxy = find_proxy_by_address(default_ctrl->devices, argv[1]);
 	if (!proxy) {
 		bt_shell_printf("Device %s not available\n", argv[1]);
-		bt_shell_prompt_input(argv[1], "Scan and connect (yes,no):",
-				      prompt_scan_connect, strdup(argv[1]));
+
+		if (g_dbus_proxy_get_property(default_ctrl->proxy,
+					"Discovering", &iter)) {
+			dbus_message_iter_get_basic(&iter, &discovering);
+
+			if (!discovering)
+				bt_shell_prompt_input(argv[1],
+					"Scan and connect (yes,no):",
+					prompt_scan_connect,
+					strdup(argv[1]));
+
+		}
 		return;
 	}
 
-- 
2.55.0

