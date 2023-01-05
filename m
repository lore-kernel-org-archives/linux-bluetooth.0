Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADA4C54EBC
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Jan 2023 22:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjAEWKJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Jan 2023 17:10:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjAEWJt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Jan 2023 17:09:49 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37C167BEA
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Jan 2023 14:09:47 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d3so40764809plr.10
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Jan 2023 14:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLx/zURPiGT0IcVnLTUycL4Bg0QmQuAYlvG/tHxlN70=;
        b=PW8wjLZmTcfPe9sjHOqaoPZJYFTtlILPY/B3AOeu/dqQKeGMrMdTDbVdGmcROyUNVB
         6Mi6C3eb5BQlzi/sSMtZ+CavvTcr1qOtyYTG4acympyqvhpeVDZecLmuK3HHe2BBcj0V
         /fkK1NwWkpCbTnqQpYTUH3zFlVzO/v89x6RPZNialEwkqLeRBFHitPaZ5/qQ8FOMvAnh
         3Yl9myBu2wVTvoHP0wyWF95vaU9sGe8x7Sq5eJlJazvdWAfxH5IGMvNB7s2afFrbm9+Z
         4BofFE0v8Ex6Ge9BsLNh7YTRudRUtVrG6oh6BtxoP8K61puQc6aNN+ZmxHCYsb4QhpAh
         ArVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nLx/zURPiGT0IcVnLTUycL4Bg0QmQuAYlvG/tHxlN70=;
        b=WpSuXFtQrVSu6YkptW3mFG4BQxfQMOkPQhLot5htZoCOfE/oVGBn9ydz/VffC7ATpT
         23lLZpY31ch16hqQle1KSIxiqLkWk2MoYSjJoVoGLllfYnkTrp7AVax4+oVyDmvG9956
         WAuwUkWG18VQTKxaGTQp6b+PZ7Q9lSQSNTYG63y6CkYhR8y1Rc1IvU1MCLWr2nwgb+MO
         CnwjE8Wcq0xblk/rg+uhKBgZxd5lwtaSuUALG3tY9y2vJ/BO4h9nFXVWX8ifCgUcFyjm
         /cZUP36yWpeva8s4UVWM3vr/IbvOLH5quWANAzrLmXYMY5Nl4DTXKw4j/yoe/TvKsEMb
         RBlQ==
X-Gm-Message-State: AFqh2koRhxCUyM5wyvr7pigArXRMEd6tnU3qYTWJbPTzxUglQQEejext
        XbAVzXJMFsSyR1YmID2NDTyv8hMJtvA=
X-Google-Smtp-Source: AMrXdXuRs/vB5vvxevfw5/gHrqACbw/dmWl1t/+sd/0dwtuX2cTS+wqq7aaanxfe7EIbKYjnV1DuJQ==
X-Received: by 2002:a17:902:f201:b0:189:377c:9ab with SMTP id m1-20020a170902f20100b00189377c09abmr48996978plc.51.1672956586631;
        Thu, 05 Jan 2023 14:09:46 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id jg21-20020a17090326d500b001929827731esm16744861plb.201.2023.01.05.14.09.45
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 14:09:46 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] shared/gatt-client: Use parent debug_callback if not set on clone
Date:   Thu,  5 Jan 2023 14:09:41 -0800
Message-Id: <20230105220944.2373424-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If clone don't have a dedicated callback set use its parent so users of
bt_gatt_client_clone don't have to keep setting the same callback for
all clone instances.
---
 src/shared/gatt-client.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cb2e64b6cc6b..4aa5d7d92957 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -38,7 +38,8 @@
 #define GATT_SVC_UUID	0x1801
 #define SVC_CHNGD_UUID	0x2a05
 #define DBG(_client, _format, arg...) \
-	gatt_log(_client, "%s:%s() " _format, __FILE__, __func__, ## arg)
+	gatt_log(_client, "[%p] %s:%s() " _format, _client, __FILE__, \
+		__func__, ## arg)
 
 struct ready_cb {
 	bt_gatt_client_callback_t callback;
@@ -357,15 +358,28 @@ static void discovery_op_free(struct discovery_op *op)
 
 static bool read_db_hash(struct discovery_op *op);
 
+static void gatt_log_va(struct bt_gatt_client *client, const char *format,
+						va_list va)
+{
+	if (!client || !format)
+		return;
+
+	if (client->debug_callback)
+		util_debug_va(client->debug_callback, client->debug_data,
+							format, va);
+	else
+		gatt_log_va(client->parent, format, va);
+}
+
 static void gatt_log(struct bt_gatt_client *client, const char *format, ...)
 {
 	va_list ap;
 
-	if (!client || !format || !client->debug_callback)
+	if (!client || !format)
 		return;
 
 	va_start(ap, format);
-	util_debug_va(client->debug_callback, client->debug_data, format, ap);
+	gatt_log_va(client, format, ap);
 	va_end(ap);
 }
 
-- 
2.37.3

