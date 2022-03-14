Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Mar 2022 02:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235799AbiCNCFT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 13 Mar 2022 22:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbiCNCFR (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 13 Mar 2022 22:05:17 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A45396A9
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Mar 2022 19:04:07 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id r22so19832710ljd.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 13 Mar 2022 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpIo2jEJB6xQmpOqYBQB3G8GZ5SPoqNqZqtveiD2Mfc=;
        b=Uty8+3OoQlm5gbhs2Srzent89H/K8yyrkmslnUvNLP//5MVkBubvOMMbecRAkhhcrz
         139TZzr2XTrg5rVTRsBFDTUK5kLuDUvaAJnBJeUdw2BEcdM3r9dPAq99QH88uETTxTL3
         9IwvYmsPFr7lnQPelzQQMTOJh8aw6niGUJ6pzf3Tt3hvDlsvk7bLInAXotthUVhZnWSG
         uvm9O10b31XOJGzOWSDGoIaGiQnX7ANOj2wqmZlEcdC3HS0a1ahNXrmKw1qE1XS0Kwda
         fA3HtdVppkChwhyLi2Y6dDsbLmd1s56rr1gapcseIh6meiF8HWdX/p5EewC9OvcsYYeC
         PAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mpIo2jEJB6xQmpOqYBQB3G8GZ5SPoqNqZqtveiD2Mfc=;
        b=3P3oYR/i84QWMtBQcqzZLibLqCclacPm53IJ9L6cGQDKo8a77nvrnJHJ94Oxs6b8V5
         xQVKe000aXxpXR47uC+NShUvqtMJRZxo9s4hwjX8PoWkIC4uFjtzTMcUy/x+mBfFsH8I
         bHbSXo6RtlTG8y3QeQDXQsx1BnlQ/AWzWcRzVAZlsJ3BmaO+EXnHIkR8lykcm/v/xvOB
         szPIkP9GKBFI/vIEc+7mY1wXsdQThTrMnKJunjPbq04XQzYb1dsro8YLvKB9/IoNN+Kt
         XPjSZlN8lPX/Td093Pc7r/CMTDFJWZq8ZXv/myK9VLHwrzD4qlQe3W4xdOusE2tMqxsx
         r9bw==
X-Gm-Message-State: AOAM531OGrqGub3JsZS8+joe8TREvfUOIXlYQii+N2C9JiyY2pTH/fyM
        llrjwjkTIU1UAnZHb7ZG0Ll2xzCq4FoJ4w==
X-Google-Smtp-Source: ABdhPJy9rlzrvHs9T0rlQbJ+skEoQF9j1sPAx34vvVyKvuvwMvHcKzbilKKuyiVlIBHFO20uaLNALw==
X-Received: by 2002:a05:651c:1603:b0:248:e00:aeba with SMTP id f3-20020a05651c160300b002480e00aebamr12801933ljq.456.1647223446168;
        Sun, 13 Mar 2022 19:04:06 -0700 (PDT)
Received: from nano.hatato.dy.fi (91-159-87-54.elisa-laajakaista.fi. [91.159.87.54])
        by smtp.gmail.com with ESMTPSA id j14-20020a056512108e00b004481ee0cee1sm3002906lfg.67.2022.03.13.19.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 19:04:05 -0700 (PDT)
From:   Jesse Pullinen <jesse12p@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jesse Pullinen <jesse12p@gmail.com>
Subject: [PATCH BlueZ] sixaxis: Fix Sony Navigation Controller pairing
Date:   Mon, 14 Mar 2022 04:02:45 +0200
Message-Id: <20220314020245.135251-1-jesse12p@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Fixed the device name.

Commit 61745d2bb8b5f534278db49faf8e2cdb7e894529
("sixaxis: Fix Bluetooth PS3 clone joypad being named like the original")
made the matching use the name, which broke the pairing.
---
 profiles/input/sixaxis.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/input/sixaxis.h b/profiles/input/sixaxis.h
index ab8831995..cbd27cd06 100644
--- a/profiles/input/sixaxis.h
+++ b/profiles/input/sixaxis.h
@@ -49,7 +49,7 @@ get_pairing(uint16_t vid, uint16_t pid, const char *name)
 			.type = CABLE_PAIRING_SIXAXIS,
 		},
 		{
-			.name = "Navigation Controller",
+			.name = "Sony Navigation Controller",
 			.source = 0x0002,
 			.vid = 0x054c,
 			.pid = 0x042f,

base-commit: 42e99371584cc26c637fcc332de437d2c646f324
-- 
2.35.1

