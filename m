Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E821B2C6B2
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 17:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597222; cv=none; b=EW2z/7myGv19jCv3hfIWP6SZJCtQkkTqaFx3TceYdozVXLPpo7WaLOchBPaGI72hy9EkQN+ublmirHXYbfPwdkARvGKWjQ0TdZ5SWat0PWc3anRQVpYsZeVd/nwdAG0+14pB/KQ1EAiKL63P0lxejtzBBcvWTqnEVWUP/LQDlSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597222; c=relaxed/simple;
	bh=jJcGC7PYeYZymBre9WhvQFOrvBahXyYIzZb/v+QgWKg=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding; b=EpcS01QnmKkrtIjrb1Vudzta1Kr0rbU2WQ4bCW4AeQBvcLxCRzxs6aKO0p8VoxIeWjf9z1vLqncpde/IgNNxapSve8SJjGs4U/lf2UNW3ZV96FRt/tDQKAWB00dT/O8rRK6hjzyy6h6y6/RzQoArwfVI1gc809u4W8dlIAiqEgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esr2ID/J; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esr2ID/J"
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dddb927d02so6333512a34.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 09:00:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705597219; x=1706202019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=5ekUVIXIJBA9FebOAZiiq7ihTlpKtY2z7/oQDbELgHg=;
        b=Esr2ID/JKGTARe5YKfQPDyl2sEA2mIC6qxAf3DqvY0G1YgbqhgzxEVPsbS3hPcCFrC
         GOxw1KeifXLw6xsq4Yeww8q698jkZWFTSzDVvmK2XMUx3edP+7BDvU46AhNi3NVhUm3r
         bMTW/aSxKh5eNYgPQDUxjj+DjWVaZqQ7Nt9x8XrPVGt33mYyMJPpa9CtMvibI4rygIqr
         l9dOp7Jgff5jbzzbZAoEbR5S4/TYls2WoBTODbne5iPANIKQ3X9YES+k0Gs/aFS9IuRS
         J34/cKU3Xl0r57Nypno8ew3I/sifeHXQyvOg2PJVtiazN17g6kVtH6XrwOe6H+2mQBhE
         nZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597219; x=1706202019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ekUVIXIJBA9FebOAZiiq7ihTlpKtY2z7/oQDbELgHg=;
        b=MaHpHMtM4eCI0wFpPULGDDS75GknL+ui7LWk5qKMbL5TvFb9+8eBqh+SqspcV5Fb8t
         9IYWbBehOUNzdI2D96uoIphs8VRuFhtC3FdJ3QmGz28i9Gubs9Wz4VgE9kWyVNsgPo1v
         vRKlh2xWIKHxyLuWAQrRqXJ2LHvhz9+fQn46CyF+AjWc31LpFaIKq/2HfQ0YU6u/Ghqx
         87zhL+EGx09tAqhGr+CifbXi5wB/tSUkYKVuKjnVd5ocofyKauLuTGSqWdWPHWUGD1Dx
         JPM6hrk9LC1jfoCzl/Uz9FZ0HHfwlTO5gSfe7EOifbuU61UGXEhf0P+yFLoIerCzsozO
         RqiA==
X-Gm-Message-State: AOJu0YxDIC1QoxH5dxW8fi6stPpS3S5K3773kZY1XvocCL18n4g8G+vY
	5nCXDHgEygVK1to6BzrVpI0U+UyX7zUjRUMW63oA490px7a0NDkRv85RfkDM
X-Google-Smtp-Source: AGHT+IHh8gzY26igQKgkMF02B9OxvTk2oI2xt+D4wqhYUNEXs2M0JPUZTZke2QAxPtBrToleqTUSKg==
X-Received: by 2002:a9d:4f09:0:b0:6e0:d870:9fe9 with SMTP id d9-20020a9d4f09000000b006e0d8709fe9mr377772otl.43.1705597218990;
        Thu, 18 Jan 2024 09:00:18 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id bg12-20020a056830360c00b006ddc277db46sm281302otb.34.2024.01.18.09.00.17
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 09:00:18 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1] player: Fix endpoint.config for broadcast
Date: Thu, 18 Jan 2024 12:00:16 -0500
Message-ID: <20240118170016.2001865-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

endpoint.config where taking different arguments for broadcast which is
not recommended with shell as it doesn't support such a thing.

So instead of taking different arguments for broadcast both remote and
local endpoints shall be passed but in case of broadcast sync both the
remote and the local endpoint actually refer to the same endpoint
registered by bluetoothctl:

endpoint.config /org/bluez/hci0/pac_bcast0 /local/endpoint/ep2 16_2_1
---
 client/player.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/client/player.c b/client/player.c
index cd06ffd41c82..eff35ff87a00 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3972,10 +3972,6 @@ static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
 	const struct codec_preset *preset;
-	const struct capabilities *cap;
-	char *uuid;
-	uint8_t codec_id;
-	bool broadcast = false;
 
 	cfg = new0(struct endpoint_config, 1);
 
@@ -3990,33 +3986,14 @@ static void cmd_config_endpoint(int argc, char *argv[])
 	/* Search for the local endpoint */
 	cfg->ep = endpoint_find(argv[2]);
 	if (!cfg->ep) {
-
-		/* When the local endpoint was not found either we received
-		 * UUID, or the provided local endpoint is not available
-		 */
-		uuid = argv[2];
-		codec_id = strtol(argv[3], NULL, 0);
-		cap = find_capabilities(uuid, codec_id);
-		if (cap) {
-			broadcast = true;
-			cfg->ep = endpoint_new(cap);
-			cfg->ep->preset = find_presets_name(uuid, argv[3]);
-			if (!cfg->ep->preset)
-				bt_shell_printf("Preset not found\n");
-		} else {
-			bt_shell_printf("Local Endpoint %s,"
-				"or capabilities not found\n", uuid);
-			goto fail;
-		}
+		bt_shell_printf("Local Endpoint %s not found\n", argv[2]);
+		goto fail;
 	}
 
-	if (((broadcast == false) && (argc > 3)) ||
-		((broadcast == true) && (argc > 4))) {
-		char *preset_name = (broadcast == false)?argv[3]:argv[4];
-
-		preset = preset_find_name(cfg->ep->preset, preset_name);
+	if (argc > 3) {
+		preset = preset_find_name(cfg->ep->preset, argv[3]);
 		if (!preset) {
-			bt_shell_printf("Preset %s not found\n", preset_name);
+			bt_shell_printf("Preset %s not found\n", argv[3]);
 			goto fail;
 		}
 
@@ -4435,8 +4412,7 @@ static const struct bt_shell_menu endpoint_menu = {
 	{ "unregister",   "<UUID/object>", cmd_unregister_endpoint,
 						"Register Endpoint",
 						local_endpoint_generator },
-	{ "config",
-		"<endpoint> [local endpoint/UUID] [preset/codec id] [preset]",
+	{ "config",       "<endpoint> [local endpoint] [preset]",
 						cmd_config_endpoint,
 						"Configure Endpoint",
 						endpoint_generator },
-- 
2.43.0

