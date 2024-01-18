Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E7D3172E
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705613600; cv=none; b=dBxw6baL3xBdC5HPjCSzC/v3APD9lSnuCUGiBWHiTeH69vAP5eOjekvl8COMFHRSZZ63So/ZJakjRF3S06NIdZeXmJjy/WQXIfZeNTVakjzlNQxhIgNrlN2KNBN2NLm7isx95IwoTv2R/doPCQSqc0+b59zKbY225avSNIc6W5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705613600; c=relaxed/simple;
	bh=4+P2Wle40NQ97lEZJP2Co9YeWuaLlYdwrsdVRP3tMgE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=CwWGGsfdBlxp3ZPqwzQzKdtzzFCiTDOUAaCdqru5aLpZul3oSENz9+Q+9tCoj9dPjBlx6qv2133LeOMFaEgzHtbO7rv98rFCoEE0M2E6qgi09TelGuWzRhcSI7tSwsQPiyFigyNkNzKfvgDwrCek4dsszlwE0NrTs740vMUuPLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kW/xEopP; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kW/xEopP"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-598cf18b259so68769eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Jan 2024 13:33:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705613597; x=1706218397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=whPRIrmxj3IUu42msiK9GPrFaC7pd7/RcvdGJ6mVBjg=;
        b=kW/xEopPI3sEKfnICWLZ52ow7L0sympGx1+J3gTCD2Yppj0axaxX9wMf+dj0hh/cTb
         ZoiGsSk6oDTn2+Ru1TwDTj4FJ64KEmqDczZo1QS/UGhWgP+e8IRo/R2vVmoIe1NKzkgO
         Qx/i9wQBaBKgMaBf9t8XI3YXEurBoR0B6j3Vs5NBqku7pjWizSGzgm0iRGN/jp9wen0w
         qeoSrC3iDNVTrdoVXjhURH9Rsf2sgwlclvrqlpobIAgIpIZL/dzxaH3x/+hM6XRhSxr0
         ymS85fQVFDObRfPOnQ3jyz8UN/+V6vMjh9Kzzk0HhCegDtHj6/qNUxmNAPKUNrSN9tCS
         V8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705613597; x=1706218397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=whPRIrmxj3IUu42msiK9GPrFaC7pd7/RcvdGJ6mVBjg=;
        b=EAiMrqWfy+IdU7P3CIcpBTse9nsLxE9SYf4gz4H83VwCTBsXFHa6ePjriuLXXDfXTj
         m9HoKmKHrTDcB/NHvVAOxgk0Fe6uxbFBXkkJP80S5HdPADES0eqLuufWW2JGRcB7+FRI
         E3/mkaDJxL8Oxy7bKBxcWslLi9bNPrwiHkoXcMukBkS79boGEWR7V+B1cBW/gUVx6seN
         jFoH0UzH2CvO70MjwthuB4xwpI/uY47Y0vdXZBWikXp+XbAzag9yuTdnie3YXN/CR8mQ
         qWsC0jo8rHECdBuWUKQdsOTDcczlR4VuPbGET3KxfsHK9bp5v8kF1QM1dw685Gjv35/q
         UOKQ==
X-Gm-Message-State: AOJu0YzlOiFU5Zyu56zXjXl+eRj3kvMetfNtrRJ75Thx1MrAAjKoMMQ7
	xfRRJ+HjrLDiClxdS13K2ZpJhnKa0CdBSMb8bz//eQ5tQucXNJ+Vi5XqhK0s
X-Google-Smtp-Source: AGHT+IEudlwLzS55Z3zE5Rgs9+cTIo66jtcIRoynNpjLDoj+FqXx8mvV7oIKFSliEA9giKxXJwo7CA==
X-Received: by 2002:a05:6359:6395:b0:175:a4ad:40fa with SMTP id sg21-20020a056359639500b00175a4ad40famr1048426rwb.48.1705613596921;
        Thu, 18 Jan 2024 13:33:16 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id d7-20020a254f07000000b00dbd9a0ec1d5sm6301383ybb.47.2024.01.18.13.33.15
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:33:15 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] player: Fix endpoint.config for broadcast
Date: Thu, 18 Jan 2024 16:33:13 -0500
Message-ID: <20240118213314.2066415-1-luiz.dentz@gmail.com>
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
index 39d1be665c8f..1bc64af3c2ae 100644
--- a/client/player.c
+++ b/client/player.c
@@ -3642,10 +3642,6 @@ static void cmd_config_endpoint(int argc, char *argv[])
 {
 	struct endpoint_config *cfg;
 	const struct codec_preset *preset;
-	const struct capabilities *cap;
-	char *uuid;
-	uint8_t codec_id;
-	bool broadcast = false;
 
 	cfg = new0(struct endpoint_config, 1);
 
@@ -3660,33 +3656,14 @@ static void cmd_config_endpoint(int argc, char *argv[])
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
 
@@ -4105,8 +4082,7 @@ static const struct bt_shell_menu endpoint_menu = {
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

