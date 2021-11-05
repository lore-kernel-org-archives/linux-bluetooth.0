Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5B8BC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 16:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0CCD610D0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 16:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233740AbhKERAt (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbhKERAt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 13:00:49 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7460EC061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 09:58:09 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id g18so4620725pfk.5
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 09:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFFls0QXklC6N2oJJPdeNf3RykoHVkdfuCLNKLfFnE8=;
        b=VVGMyDxt9/Bg6NGQCHj1Bl2BuiOFmhHI+zdrU6fLkhwTgExRHN6P/pivTGvU/eRKsm
         w78fDbgQja0mLghSJkozMxdKAcT6xwZyNOa+x7R9WoV8dhYtcqTDBgQKT48w79uY9gy1
         RUG+dl1ml7IDwPCKRVs44rHwNnDCqEpPESIv/3DI0WgEQyGfb+o2OuhAt7y7bw2C1jaC
         /OJzgKAqbgLhENOFbR21OtGMJtZp+dH64gDZqzWyJFQ/6MI1KXo9/yudQuxwoIu1dLLc
         XnUqpgqpxHm5HIYIkSSbW7DHIJ+Xjk0Ias9N7q/lu1uNdEMHXBmSE+4iChK/1qgfeTFr
         l/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFFls0QXklC6N2oJJPdeNf3RykoHVkdfuCLNKLfFnE8=;
        b=ZkA5urgw+cGqJOShd0Hk50WsYAIENWYcFknF2E3aCcE31193gpXPb7zwpuqNYolk1N
         iH7Y9s9BnvCiPcJS5JNVbiyeW0YFsiPopll6T1CnAP1YU0/Y57vNgmLXqVLuy0MlUoIX
         fI7bvIphwH0Zjn1MRUh0BTk0m4iCZyXAiKF/YXa72GCFa3CPcPExLbqwC8WGrK4dNtgS
         9plu/o370HpuOgPCQ5H4asBdbcScso6p6H0SbLzTTyRyZizgTY1nlTDDlYxv5fCgtG69
         KKVYg0fa1uStSaLhF/YVlvzzKejTamN1vPLUvfwR52DNp5WTL2iGy2tn8UCOfQJr6T9+
         YLVg==
X-Gm-Message-State: AOAM532EQpZc7o59WNBANKGV6rLrWTOEdNROV8I6To7Nt3unEDscU2rZ
        eKmZ2Z16rhJ/tXDqLTIW+Vn9p9nAOTiutQ==
X-Google-Smtp-Source: ABdhPJyLx3AzqB0Nl8DSjTWVzKHHMCjAI+H7J0zydEruyUeJva7dgDbtOVfhxZeXnAz8WcGRn2vs5w==
X-Received: by 2002:a62:3306:0:b0:480:f89c:c251 with SMTP id z6-20020a623306000000b00480f89cc251mr43564934pfz.74.1636131484247;
        Fri, 05 Nov 2021 09:58:04 -0700 (PDT)
Received: from localhost.localdomain ([69.196.88.170])
        by smtp.gmail.com with ESMTPSA id k73sm6361486pgc.63.2021.11.05.09.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:58:04 -0700 (PDT)
From:   Jefferson Zhai <goodgame13241324@gmail.com>
X-Google-Original-From: Jefferson Zhai <GoodGame13241324@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jefferson Zhai <jefferson@zhai.ca>
Subject: [PATCH BlueZ 1/1] FIX: Fixed oversight of not supporting vendor model in Meshctl tool's sub-add command
Date:   Fri,  5 Nov 2021 09:57:35 -0700
Message-Id: <20211105165735.13606-2-GoodGame13241324@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211105165735.13606-1-GoodGame13241324@gmail.com>
References: <20211105165735.13606-1-GoodGame13241324@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jefferson Zhai <jefferson@zhai.ca>

---
 tools/mesh-gatt/config-client.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/tools/mesh-gatt/config-client.c b/tools/mesh-gatt/config-client.c
index 3ec42d94a..7bdd028d2 100644
--- a/tools/mesh-gatt/config-client.c
+++ b/tools/mesh-gatt/config-client.c
@@ -972,7 +972,7 @@ static void cmd_sub_add(int argc, char *argv[])
 	n = mesh_opcode_set(OP_CONFIG_MODEL_SUB_ADD, msg);
 
 	parm_cnt = read_input_parameters(argc, argv);
-	if (parm_cnt != 3) {
+	if (parm_cnt != 3 && parm_cnt != 4) {
 		bt_shell_printf("Bad arguments: %s\n", argv[1]);
 		return bt_shell_noninteractive_quit(EXIT_FAILURE);
 	}
@@ -984,9 +984,15 @@ static void cmd_sub_add(int argc, char *argv[])
 	/* Subscription Address */
 	put_le16(parms[1], msg + n);
 	n += 2;
-	/* SIG Model ID */
-	put_le16(parms[2], msg + n);
-	n += 2;
+	/* Model ID */
+	if (parm_cnt == 4) {
+		put_le16(parms[3], msg + n);
+		put_le16(parms[2], msg + n + 2);
+		n += 4;
+	} else {
+		put_le16(parms[2], msg + n);
+		n += 2;
+	}
 
 	if (!config_send(msg, n)) {
 		bt_shell_printf("Failed to send \"ADD SUBSCRIPTION\"\n");
@@ -1222,7 +1228,7 @@ static const struct bt_shell_menu cfg_menu = {
 				cmd_hb_sub_set,     "Set heartbeat subscribe"},
 	{"hb-sub-get",           NULL,                   cmd_hb_sub_get,
 						"Get heartbeat subscribe"},
-	{"sub-add", "<ele_addr> <sub_addr> <model id>",
+	{"sub-add", "<ele_addr> <sub_addr> <mod id> [cid]",
 				cmd_sub_add,    "Add subscription"},
 	{"sub-get", "<ele_addr> <model id>",
 				cmd_sub_get,    "Get subscription"},
-- 
2.25.1

