Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40551CE79AA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Sep 2023 16:28:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjISQ21 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Sep 2023 12:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjISQ2Z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Sep 2023 12:28:25 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D2A8A1
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 09:28:19 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40472f9db24so59510385e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Sep 2023 09:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695140897; x=1695745697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HosHvoZ9OIzju4/9BMiJpIcBiD9vBKx4TMC5sa790xI=;
        b=fYvDfU6zvLcLNjNax3VuCONEv+rMf3FV2chB/O/xtKWKbIL8gqLaoHl3Jl/E5OWZ0x
         /aqpYR0wBzAuB/b/LpTI21pUFqgFss406UJh9J+5ZGL6OwKmfo/MlmT+mIecn72T4VTi
         4+fPx+Cv1NYaGzKcc05Kg0hCEX9pZwVsrcbwx2VwHZoQqP+Hq9p26jiIgWiUlY6GPj4w
         ImuWl5ktUDGMdo4U6mZ+tYvr8fuQW7TgVyhk9Bv/qK+BwlFWOh+cK6cp5g+/sblnnZBZ
         5l5MEiVDj2ewitgZW0o1L3bfi2unMoXDbz3iMa+SRI8wbzGKskekeJ0jvgqGBpj0dLLh
         3muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695140897; x=1695745697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HosHvoZ9OIzju4/9BMiJpIcBiD9vBKx4TMC5sa790xI=;
        b=ZN53TicxROH6mkQTnmE+qvwan7i0Z5/SplU36tG0mdjhmhi4tvZUNSBXAO8et2Q36V
         weYLjFMDvi+tJGkwlVUJI0YZqDxVjYu+Ogx215Dec3pigaR0B5LFRnoMbzvdIGBuOn43
         Kq0ZTj9KsUuCuDpx1jhWXQL+AhHBlNNlMKX34xhEFFjweSoX0SOxzIiqjJvUaoXDEKSw
         3sfy3UmAHej/Idg4t5ISm/LmnswHfmdWuFkPjRiYVJTE1j3o3r4IimZFJHB0xIlFF03W
         yNQm97AFXcHekoGIU6Pw9/xIngyCMlmGOmeT1C70wLwI5WwdFdBILhctQkQIKnra0Wcw
         V3xQ==
X-Gm-Message-State: AOJu0YzmIg9C0yO6luLcnLNecZxMuXFp66/+QxbDZjdlnt/zMRGOT5Bp
        2/XNpsSil04bW4TCW5uSoXSgovik0Zw=
X-Google-Smtp-Source: AGHT+IFlyJ9foc+DOwR5rbd2dYpAdo6UmShqcDY7M4i9/rywBfdpw8g0glg4obi17mbtAILirttxQg==
X-Received: by 2002:a05:600c:2245:b0:3fe:ba7:f200 with SMTP id a5-20020a05600c224500b003fe0ba7f200mr230686wmm.20.1695140897004;
        Tue, 19 Sep 2023 09:28:17 -0700 (PDT)
Received: from localhost.localdomain (46.205.192.105.nat.ftth.dynamic.t-mobile.pl. [46.205.192.105])
        by smtp.gmail.com with ESMTPSA id p18-20020a1c7412000000b00401d6c0505csm15599081wmc.47.2023.09.19.09.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 09:28:16 -0700 (PDT)
From:   Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
Subject: [PATCH BlueZ 1/2] emulator: Skip new line when using util_debug
Date:   Tue, 19 Sep 2023 18:27:44 +0200
Message-Id: <20230919162745.894828-1-arkadiusz.bokowy@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The debug callback vhci_debug() already prints new line after each debug
string. Explicit new line in the util_debug call causes double new line
in the output.
---
 emulator/btdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 58414bd74..65ad0a40c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -7298,16 +7298,17 @@ static const struct btdev_cmd *vnd_cmd(struct btdev *btdev, uint8_t op,
 					const struct btdev_cmd *cmd,
 					const void *data, uint8_t len)
 {
+	uint8_t opcode = ((const uint8_t *)data)[0];
+
 	for (; cmd && cmd->func; cmd++) {
-		if (cmd->opcode != ((uint8_t *)data)[0])
+		if (cmd->opcode != opcode)
 			continue;
 
 		return run_cmd(btdev, cmd, data, len);
 	}
 
 	util_debug(btdev->debug_callback, btdev->debug_data,
-			"Unsupported Vendor subcommand 0x%2.2x\n",
-			((uint8_t *)data)[0]);
+			"Unsupported Vendor subcommand 0x%2.2x", opcode);
 
 	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, op);
 
@@ -7333,7 +7334,7 @@ static const struct btdev_cmd *default_cmd(struct btdev *btdev, uint16_t opcode,
 	}
 
 	util_debug(btdev->debug_callback, btdev->debug_data,
-			"Unsupported command 0x%4.4x\n", opcode);
+			"Unsupported command 0x%4.4x", opcode);
 
 	cmd_status(btdev, BT_HCI_ERR_UNKNOWN_COMMAND, opcode);
 
@@ -7521,7 +7522,7 @@ void btdev_receive_h4(struct btdev *btdev, const void *data, uint16_t len)
 		break;
 	default:
 		util_debug(btdev->debug_callback, btdev->debug_data,
-				"Unsupported packet 0x%2.2x\n", pkt_type);
+				"Unsupported packet 0x%2.2x", pkt_type);
 		break;
 	}
 }
-- 
2.39.2

