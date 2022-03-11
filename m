Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02725C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Mar 2022 22:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiCKWus (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Mar 2022 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiCKWuj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Mar 2022 17:50:39 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822721B371A
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:32:32 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id j5so8060876qvs.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Mar 2022 14:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb/XHSd9cfBC2AgGpJK38o7mocvWWCcj1vl5eGJQ0A8=;
        b=XT6JnNpMAUDBR25tpVR4co96qMiwMq2KXN3Vtstze3rpNW88m/kD7RRDzdbwud5HNa
         eZ4UYG/ntDf2E229UdtQW3R1eIxkOgJ/tmcBP1fg9awzP72y2EVQwuOCDs+pSvPXVF12
         zsd2IIHPRyaulRFNTXzRnZvzyjajDEKNq6K99nuuueGBc1NKBMym3aqJjD+FAf5sExlt
         75gWAAiOsaRC7rmUL1yTXhxQ+q/UzX2Ek1NEG60HYN6mvbAXOSB/kqafPWF2iWtK1jzj
         ZRYGUHz+qXj2Y96sgdL8xM3QBN7NTeaEyp/wDAjxoSBQyn3qbPyJRSUfsHKZz1ZfGNGo
         eJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb/XHSd9cfBC2AgGpJK38o7mocvWWCcj1vl5eGJQ0A8=;
        b=cn0RL9+yj60Tu3BRnY0+vE3wWAlLzLai7p4OaLiE/nsjZ4Xnl4Vfe+kg0hAIo6TIyX
         kNsbZ/kbVA0Ih0CmEwvuHB+Rrs+DyyFsfUDrCYf+8ovTYa9w3qrRFfYsfC0fuWqT7RVq
         tXU1hxd7WLXJZdjbsZ1YuhLABQVOCHyLoYNpnYXRqCpkXq9+2mOuyJzEWfOZlIgF87iR
         hvPsk19ZUyyZllHTRuGF0v0xs4VbkDneu6hfQizHYdxjr59rycJPdGnFJ08Xg+HsS98Y
         joEf2tH3MQmgbvPK+eD6xqYNtQCJBsTMWRorhHA31G5gOrUjpVP9Ef/bipgaOR0ahC40
         ARYQ==
X-Gm-Message-State: AOAM530DK9nOPNiZ3rgNMR3VIvw5ogFDKb3c96P8RJwbhtNpkDnTkByZ
        KW1PxbY/KpGYe9flkONLLqCv2OvS0VY=
X-Google-Smtp-Source: ABdhPJy2ufc7e3mWOYUXQF16Y0C/lxC8wmTGcwotDrwNdotBJ60UKX/EGR30buaEufm8U9id0W9q6A==
X-Received: by 2002:a17:902:aa8d:b0:150:c60:29a4 with SMTP id d13-20020a170902aa8d00b001500c6029a4mr12028006plr.40.1647033451761;
        Fri, 11 Mar 2022 13:17:31 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x3-20020a17090ad68300b001b8bcd47c35sm13927508pju.6.2022.03.11.13.17.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 13:17:31 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] bthost: Fix not setting all parameters when using Create BIG cmd
Date:   Fri, 11 Mar 2022 13:17:29 -0800
Message-Id: <20220311211730.3285028-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Create BIG shall set proper values for interval, latency, rtn and phy.
---
 emulator/bthost.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/emulator/bthost.c b/emulator/bthost.c
index a7a0b8428..75fa625b1 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -3104,8 +3104,11 @@ void bthost_create_big(struct bthost *bthost, uint8_t num_bis)
 	cp.handle = 0x01;
 	cp.adv_handle = 0x01;
 	cp.num_bis = num_bis;
+	put_le24(10000, cp.bis.sdu_interval);
 	cp.bis.sdu = 40;
-	cp.bis.phy = 0x01;
+	cp.bis.latency = cpu_to_le16(10);
+	cp.bis.rtn = 0x02;
+	cp.bis.phy = 0x02;
 	send_command(bthost, BT_HCI_CMD_LE_CREATE_BIG, &cp, sizeof(cp));
 }
 
-- 
2.35.1

