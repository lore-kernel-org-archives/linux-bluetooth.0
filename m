Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B56EB64D9
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Jun 2023 20:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjFSUal (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Jun 2023 16:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjFSUak (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Jun 2023 16:30:40 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696EDD2
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-54fb1bbc3f2so3032365a12.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Jun 2023 13:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687206638; x=1689798638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W6eZOkmzK1/ccqKHeeqR3SphX0WmkzDV7Brj63U2hL8=;
        b=pUM6PkTOzqMWiCG1u6o8p0OnxDPBVbVDlBkb/JQD4uZlp5rjBoOb9VBEJkm2AmmfN9
         SrWc8Sq10XT5Plby46aYMByGp6HgyouvAGlakeKYa2kcUtS3PdoNFIT6S4weaBAgSkRR
         4kw6HBWDG1wmOSPdpRonCBXhW6xkK/j1OwmJVa+VN81TaKj0BkPn991FsuaEuRAjY3IE
         kRQF4omAUdbbY0vVi2AUvm4wn67hrTM2GoGEhaCZlSRIvJD1djHrGSUimkFF336gzge5
         KVlqHBc4wgvsZxp9BqFJFyAMLs2fkwKtpsP3irxxlMfwXByB9QNVjE4L/e0xt10Emtt1
         sltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687206638; x=1689798638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W6eZOkmzK1/ccqKHeeqR3SphX0WmkzDV7Brj63U2hL8=;
        b=iwM6VgpKYXGTgB0ArHuXKuQipYIazh+yEIOqEhtN2PhSDTVGYpACF7WcS9Tnj2imGy
         F6aENL6EXpOA7s4wEJX/hNABNEgHfstDJlH5Y7KgH0gDIbdfiYEJhRD2DFn/Yev1sSRZ
         w39JUSKEz2bcvnDfMcey+WD6Nz2zZZR3HaoaHHSoLaX8mWpmdJHkobGq0A7b4Gok8c7r
         nJ2WbPmPo0ZqXyD/WJrivctr8Rxh51adYbYu3Ftnn4NYLVMsyNK/zN607xSPby82uGpl
         Ys+bIVpjc5gFBX3HuixF7/H7uhhL0qWrAKHYKG1ZJl9d8jS7QOctnImABGgKJxHZhtd4
         YNpA==
X-Gm-Message-State: AC+VfDyyDFycTj2weojeTbDs6NeoFrMhCcVxhFava24ywU0lfDgmtCzU
        ab0XzU/B5TI70HJ448ApY5/DP4jtZA+LBg==
X-Google-Smtp-Source: ACHHUZ6qejHusaJSZ1dasJ3gfX2MIaGq/GkQdB0DkQnQNUUMgze3cd7vLvqCDCfonM+fvHFBK0csng==
X-Received: by 2002:a17:902:8646:b0:1b6:75b5:5fae with SMTP id y6-20020a170902864600b001b675b55faemr1468265plt.42.1687206637811;
        Mon, 19 Jun 2023 13:30:37 -0700 (PDT)
Received: from lvondent-mobl3.. (c-71-59-129-171.hsd1.or.comcast.net. [71.59.129.171])
        by smtp.gmail.com with ESMTPSA id ju18-20020a170903429200b001b045c9ababsm202714plb.264.2023.06.19.13.30.36
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jun 2023 13:30:36 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] client/player: Fix auto registration of broadcast endpoint
Date:   Mon, 19 Jun 2023 13:30:30 -0700
Message-Id: <20230619203032.6812-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230619203032.6812-1-luiz.dentz@gmail.com>
References: <20230619203032.6812-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

For broadcast endpoint broadcast must be set properly.
---
 client/player.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/client/player.c b/client/player.c
index 389fc1d07..a399d82ec 100644
--- a/client/player.c
+++ b/client/player.c
@@ -1740,22 +1740,22 @@ struct endpoint_config {
 				0xa2, 0x65, 0xbb, 0xaf, 0xc6, 0xea, 0x03, 0xb8}
 
 static struct bt_iso_qos bcast_qos = {
-		.bcast = {
-			.big = BT_ISO_QOS_BIG_UNSET,
-			.bis = BT_ISO_QOS_BIS_UNSET,
-			.sync_interval = 0x07,
-			.packing = 0x00,
-			.framing = 0x00,
-			.encryption = 0x00,
-			.bcode = BCODE,
-			.options = 0x00,
-			.skip = 0x0000,
-			.sync_timeout = 0x4000,
-			.sync_cte_type = 0x00,
-			.mse = 0x00,
-			.timeout = 0x4000,
-		}
-	};
+	.bcast = {
+		.big = BT_ISO_QOS_BIG_UNSET,
+		.bis = BT_ISO_QOS_BIS_UNSET,
+		.sync_interval = 24,
+		.packing = 0x00,
+		.framing = 0x00,
+		.encryption = 0x00,
+		.bcode = BCODE,
+		.options = 0x00,
+		.skip = 0x0000,
+		.sync_timeout = 0x4000,
+		.sync_cte_type = 0x00,
+		.mse = 0x00,
+		.timeout = 0x4000,
+	}
+};
 
 static void append_properties(DBusMessageIter *iter,
 						struct endpoint_config *cfg)
@@ -3175,6 +3175,7 @@ static struct endpoint *endpoint_new(const struct capabilities *cap)
 
 	ep = new0(struct endpoint, 1);
 	ep->uuid = g_strdup(cap->uuid);
+	ep->broadcast = strcmp(cap->uuid, BAA_SERVICE_UUID) ? false : true;
 	ep->codec = cap->codec_id;
 	ep->path = g_strdup_printf("%s/ep%u", BLUEZ_MEDIA_ENDPOINT_PATH,
 					g_list_length(local_endpoints));
-- 
2.40.1

