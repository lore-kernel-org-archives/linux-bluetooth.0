Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0DFC04A94
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Aug 2023 21:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjHIVOz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Aug 2023 17:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjHIU2E (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Aug 2023 16:28:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8071702
        for <linux-bluetooth@vger.kernel.org>; Wed,  9 Aug 2023 13:28:04 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c93638322so39782766b.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Aug 2023 13:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691612882; x=1692217682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Ahhm4AMxcMsMJuFStapwtJ59L6eCNdHZgH1HquwUfI=;
        b=EyVQjeaVioLRFAomOryJk3hp01fQEGOA8Wh/vYFxF45DqHmz3VHd96y3RgVRg1XJGO
         HCLLXV+mGoj3oPhD/rydekzFP6tqR1gGeinLr4EWtkZ5FuhRRhYDingfszdAjXa+ZMWY
         hd46pAUwtY3UcP4HhWj/984OUoTaJPkE2D/j5HmtQsAqcLSJ6X/Yp0UEJtGVIgblNgzv
         yCdDLNAGRu0C/EfiH08wfEwERKWj0cmy3ThHRkXi0IFZg+f21n5DL2qx+i/UvXRTN2jC
         d7gaGVPDYTb2Koer4sMJX/t/1AF2SCmEfXu9kPjQ/SHU1REPG0Rafxk2kkUfk1/CD4GE
         2YlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691612882; x=1692217682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Ahhm4AMxcMsMJuFStapwtJ59L6eCNdHZgH1HquwUfI=;
        b=SRs8vcXo1U+dH1LFssQF5LrPFJ+8PiCRsy4hRSpZ4yPSQ9o0U8KOUGo7Ga6ld0gGnk
         gIOqIl9QnqKrG2tm1VI+eVDiyhvoN9kvGpQIHVwu83BWCWrZgbcIc+nuq0Q0Z6VcXmYE
         1KrXA/+0Qv8h+J5EYP6hN2xDWBTNFF3mt3GyyZCn/JigFl4j7vXRrVOZSSiVdcDyoIis
         0Lget+xn5AmYydH7H8itZFV0AQ2YK0NCMeDqqv4N1q0nn8GHFDVG3TmCiJ1uHw81/8Ri
         6pG0alXT7ESlY+qpmydxt/oqkgO+pmexAhqDbyRO50JH++f9ZWHVrY3yVyV6oiTBQkR1
         pYpg==
X-Gm-Message-State: AOJu0YyfZZQX8glOxDQCrEk2KLwGczZB19GnVf+xPQcttreW/IxsO3v2
        uLx1aWZxQAJ57h36CUR6EjIn5DDpNcs=
X-Google-Smtp-Source: AGHT+IGngUbUYu+kuIVGnnnOXuRNH+SK/AmiY/HEzhfgboIc0hwoSRhOGGd6OM4PcuOlYPPz2TWZUg==
X-Received: by 2002:a17:906:315a:b0:99b:4bab:2841 with SMTP id e26-20020a170906315a00b0099b4bab2841mr671811eje.26.1691612881992;
        Wed, 09 Aug 2023 13:28:01 -0700 (PDT)
Received: from localhost.localdomain (77-169-139-185.fixed.kpn.net. [77.169.139.185])
        by smtp.gmail.com with ESMTPSA id h15-20020a1709066d8f00b00997e52cb30bsm8350819ejt.121.2023.08.09.13.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 13:28:01 -0700 (PDT)
From:   Bart Philips <bartphilips1@gmail.com>
X-Google-Original-From: Bart Philips <bart.philips@inspiro.nl>
To:     linux-bluetooth@vger.kernel.org
Cc:     Bart Philips <bart.philips@inspiro.nl>
Subject: [PATCH BlueZ 1/1] fix writing attributes of length 512
Date:   Wed,  9 Aug 2023 22:27:23 +0200
Message-Id: <20230809202724.15429-2-bart.philips@inspiro.nl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230809202724.15429-1-bart.philips@inspiro.nl>
References: <20230809202724.15429-1-bart.philips@inspiro.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 src/shared/gatt-server.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 0512d06f6..c7ce3ec1f 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -846,7 +846,7 @@ static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 	DBG(server, "Write %s - handle: 0x%04x",
 		(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd", handle);
 
-	ecode = check_length(length, 0);
+	ecode = check_length(length - 2, 0);
 	if (ecode)
 		goto error;
 
@@ -1333,7 +1333,7 @@ static void prep_write_cb(struct bt_att_chan *chan, uint8_t opcode,
 
 	DBG(server, "Prep Write Req - handle: 0x%04x", handle);
 
-	ecode = check_length(length, offset);
+	ecode = check_length(length - 4, offset);
 	if (ecode)
 		goto error;
 
-- 
2.34.1

