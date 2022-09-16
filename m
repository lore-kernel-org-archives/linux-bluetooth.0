Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74015ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 21:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiIPVmk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiIPVmj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 17:42:39 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B4627165
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 14:42:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id s18so16663496plr.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Sep 2022 14:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=pzRPd7v6adCRJz2Sw6r7zO8j2JR6XUW5M7gFX2FiL8I=;
        b=MxldTnPe0WavDSK2LbkpxPVW62FX/EHJennZfmPqPwkRqbvMmnsefWffJAM+7xerMJ
         Mn5ZKch3wABon9IeJmBnJInNjjBtq2vUsnidFkRCkLFYXkdWP00TrZagfl0tFssvT6y3
         O5ZfPRPMgjtVDnPGlnbYfPJYw4fsXbIXrM1DoOpqScOMWiyiDvgLiiZmKf2LYnv3wMbX
         NkXDrn94iDMa9lLk1T1ZjBrlZTeHe9flqUQnvw5K2n0jjbSeP8DXCtUEdNyTh/OagCOb
         7cZ0rnepBpN2W6AXvkgPoEhAxJqEYBHEo/9vqw8uNnHgoIRYRg1RVC1Nspv981mdYDmM
         RNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=pzRPd7v6adCRJz2Sw6r7zO8j2JR6XUW5M7gFX2FiL8I=;
        b=l+yGBTyHhE7mKsUfzzwgvb0Bu/zDlILXjAro6VA8u6C37ojpDsPiVsUhc1J2HXR+4w
         Zs5K40/c2CuaOzrbS5Ku6ecz5o6BjN/EkNns6ZMGFuizWtdr0UnKRCDoW8yyBY3EMdMo
         YhH/xJh6kkHjbfCD1Jh7FLSlcNoxYicpXKxk9qpi9DQJ84w9Pqua5VqYgg3ATI3uZCEQ
         l78xB7iPY3i+U3V+anOH474pH7yX9M977j8OJOlZHQdwdxFPRoBEyOGg2zOXu3TX/TS9
         a543Y9VqNOgaFwltpcneGZYdcVLT4Xc4PMCOyl30ow8/nMaWgW2jlQBlbbVEno/Nwlo4
         Koiw==
X-Gm-Message-State: ACrzQf1jw95FSxNPRq05Mi+HpT3TsZnt77xPnkFTZwEiT40sxm8fGeI4
        UYzzrHAMa9QhjUPbtl9O5R0j/aOpkEo=
X-Google-Smtp-Source: AMsMyM6AWI4zyu4SGsboVPIoXvvtU8Syyz+IEj/rBJdLFIUa9fx/vlX1zZJQd8TyhJw5Br7Yti5Tug==
X-Received: by 2002:a17:902:e886:b0:178:28d1:4a17 with SMTP id w6-20020a170902e88600b0017828d14a17mr1827700plg.63.1663364557248;
        Fri, 16 Sep 2022 14:42:37 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p4-20020aa79e84000000b0053ea0e55574sm14885880pfq.187.2022.09.16.14.42.35
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 14:42:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] a2dp: Fix not detecting transport connection collision
Date:   Fri, 16 Sep 2022 14:42:35 -0700
Message-Id: <20220916214235.1120979-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Some headsets appears to attempt to connect back after receiving
AVDTP_Open which would cause unexpected transitions since setup->io
and stream->io would not be in sync:

> ACL Data RX: Handle 70 flags 0x02 dlen 6
      Channel: 64 len 2 [PSM 25 mode Basic (0x00)] {chan 0}
      AVDTP: Open (0x06) Response Accept (0x02) type 0x00 label 2 nosp 0
< ACL Data TX: Handle 70 flags 0x00 dlen 12
      L2CAP: Connection Request (0x02) ident 6 len 4
        PSM: 25 (0x0019)
        Source CID: 67
> ACL Data RX: Handle 70 flags 0x02 dlen 12
      L2CAP: Connection Request (0x02) ident 10 len 4
        PSM: 25 (0x0019)
        Source CID: 68
< ACL Data TX: Handle 70 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 10 len 8
        Destination CID: 68
        Source CID: 68
        Result: Connection pending (0x0001)
        Status: Authorization pending (0x0002)
< ACL Data TX: Handle 70 flags 0x00 dlen 16
      L2CAP: Connection Response (0x03) ident 10 len 8
        Destination CID: 68
        Source CID: 68
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)
> ACL Data RX: Handle 70 flags 0x02 dlen 16
      L2CAP: Connection Response (0x03) ident 6 len 8
        Destination CID: 69
        Source CID: 67
        Result: Connection successful (0x0000)
        Status: No further information available (0x0000)

Fixes: https://github.com/bluez/bluez/issues/327
---
 profiles/audio/a2dp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 276512208e13..47b5dd7c3d25 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -2522,7 +2522,8 @@ static void confirm_cb(GIOChannel *io, gpointer data)
 		if (!setup || !setup->stream)
 			goto drop;
 
-		if (setup->io) {
+		if (setup->io || avdtp_stream_get_transport(setup->stream,
+						NULL, NULL, NULL, NULL)) {
 			error("transport channel already exists");
 			goto drop;
 		}
-- 
2.37.3

