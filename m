Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E637C43381
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E8E64EE8
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Mar 2021 13:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358930AbhCCNSg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Mar 2021 08:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236237AbhCCAa3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 2 Mar 2021 19:30:29 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E142C061756
        for <linux-bluetooth@vger.kernel.org>; Tue,  2 Mar 2021 16:29:46 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id l7so10778088pfd.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 02 Mar 2021 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88H6v8qxsrC+P6Kl9gTr2i1+YKmnbVeTsHgCQx6QMM4=;
        b=uOX0QV2DUB2/ttxkFKDadOWAjOMVv4nJyXFUW0UO5vk22QbbU0AZpF/ix9ajScxSg+
         cYgi2ZuPR3yyZg9djLHFox10wHVlDqrgddOijUaayReEAfHdCpd/7yX5r9drcmdFloYK
         t4KanHZzdRM8Gm/gyV/fkjSmKE7AO61Fp7+fTuyczwjUz7hg0XD9v71Oz9YSdHN0r5tn
         G5p8tg0aXBqG+iJGMnSVaqazNXx7qSCfkMVsFXL5osSIJdSm4KTiQHAoODHPsSlGS51v
         Hjycwb5JDNY/Yik4+e5z+32Gcl8ncBjNFewWGlH+CidXH1RxelX7cODAKSc51qfFVAvc
         t8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=88H6v8qxsrC+P6Kl9gTr2i1+YKmnbVeTsHgCQx6QMM4=;
        b=UOSxIB0rlZ17mt5NHRZrbDMjmr5ydgzPlAkyaWJwxmM40cDRBxYo1dEEnHozDDq6S5
         fPY0z4er8EZNJEiYkEw4tSMHiLm44MDwXoNLM0u2Y3d5M12Dz+tA6cVs5PrzATtxJwEb
         k+Xto4O10SV0Xhyh7acO5eV7tYssJbV17RbuHT6gvjoYU02SlUiALJP1zK2f12o8+Yiz
         CV9nG82lsdy6UurXpDFfdo1ova8x8yX2vfPcG0toIs7V/U5v7S/gtb2kUnPz1D4Kmtpu
         R2IBqgM21Y1GRyJKEIYghPOMLcq041NpRUfyl81P0n7Bl1b9/zMoNDpX8e49J0g+e8Yy
         TF6Q==
X-Gm-Message-State: AOAM530fD4SwMXXv1w15Qy5TvhrelRyixYC6gxsD3vLpDzSOLzrbn6qw
        cuAuVO+s78fQ0pf+U6jNfYeyj1s/pZN66w==
X-Google-Smtp-Source: ABdhPJz8SBxdAWj6Me50zkJ+P1YrcFMmtLGTDeOOMuL+YtlvwPVzT/GLTqZR/juMBMCf5vndTjOBJA==
X-Received: by 2002:a63:4662:: with SMTP id v34mr20931018pgk.197.1614731385445;
        Tue, 02 Mar 2021 16:29:45 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id y14sm19715518pfq.218.2021.03.02.16.29.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 16:29:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-server: Fix not properly checking for secure flags
Date:   Tue,  2 Mar 2021 16:29:44 -0800
Message-Id: <20210303002944.3444644-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

When passing the mask to check_permissions all valid permissions for
the operation must be set including BT_ATT_PERM_SECURE flags.
---
 src/shared/att-types.h   |  8 ++++++++
 src/shared/gatt-server.c | 25 +++++++------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 7108b4e94..3adc05d9e 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -129,6 +129,14 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_PERM_WRITE_SECURE	0x0200
 #define BT_ATT_PERM_SECURE		(BT_ATT_PERM_READ_SECURE | \
 					BT_ATT_PERM_WRITE_SECURE)
+#define BT_ATT_PERM_READ_MASK		(BT_ATT_PERM_READ | \
+					BT_ATT_PERM_READ_AUTHEN | \
+					BT_ATT_PERM_READ_ENCRYPT | \
+					BT_ATT_PERM_READ_SECURE)
+#define BT_ATT_PERM_WRITE_MASK		(BT_ATT_PERM_WRITE | \
+					BT_ATT_PERM_WRITE_AUTHEN | \
+					BT_ATT_PERM_WRITE_ENCRYPT | \
+					BT_ATT_PERM_WRITE_SECURE)
 
 /* GATT Characteristic Properties Bitfield values */
 #define BT_GATT_CHRC_PROP_BROADCAST			0x01
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index b5f7de7dc..970c35f94 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -444,9 +444,7 @@ static void process_read_by_type(struct async_read_op *op)
 		return;
 	}
 
-	ecode = check_permissions(server, attr, BT_ATT_PERM_READ |
-						BT_ATT_PERM_READ_AUTHEN |
-						BT_ATT_PERM_READ_ENCRYPT);
+	ecode = check_permissions(server, attr, BT_ATT_PERM_READ_MASK);
 	if (ecode)
 		goto error;
 
@@ -811,9 +809,7 @@ static void write_cb(struct bt_att_chan *chan, uint8_t opcode, const void *pdu,
 				(opcode == BT_ATT_OP_WRITE_REQ) ? "Req" : "Cmd",
 				handle);
 
-	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE |
-						BT_ATT_PERM_WRITE_AUTHEN |
-						BT_ATT_PERM_WRITE_ENCRYPT);
+	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE_MASK);
 	if (ecode)
 		goto error;
 
@@ -913,9 +909,7 @@ static void handle_read_req(struct bt_att_chan *chan,
 			opcode == BT_ATT_OP_READ_BLOB_REQ ? "Blob " : "",
 			handle);
 
-	ecode = check_permissions(server, attr, BT_ATT_PERM_READ |
-						BT_ATT_PERM_READ_AUTHEN |
-						BT_ATT_PERM_READ_ENCRYPT);
+	ecode = check_permissions(server, attr, BT_ATT_PERM_READ_MASK);
 	if (ecode)
 		goto error;
 
@@ -1051,9 +1045,8 @@ static void read_multiple_complete_cb(struct gatt_db_attribute *attr, int err,
 		goto error;
 	}
 
-	ecode = check_permissions(data->server, next_attr, BT_ATT_PERM_READ |
-						BT_ATT_PERM_READ_AUTHEN |
-						BT_ATT_PERM_READ_ENCRYPT);
+	ecode = check_permissions(data->server, next_attr,
+						BT_ATT_PERM_READ_MASK);
 	if (ecode)
 		goto error;
 
@@ -1129,9 +1122,7 @@ static void read_multiple_cb(struct bt_att_chan *chan, uint8_t opcode,
 		goto error;
 	}
 
-	ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ |
-						BT_ATT_PERM_READ_AUTHEN |
-						BT_ATT_PERM_READ_ENCRYPT);
+	ecode = check_permissions(data->server, attr, BT_ATT_PERM_READ_MASK);
 	if (ecode)
 		goto error;
 
@@ -1308,9 +1299,7 @@ static void prep_write_cb(struct bt_att_chan *chan, uint8_t opcode,
 	util_debug(server->debug_callback, server->debug_data,
 				"Prep Write Req - handle: 0x%04x", handle);
 
-	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE |
-						BT_ATT_PERM_WRITE_AUTHEN |
-						BT_ATT_PERM_WRITE_ENCRYPT);
+	ecode = check_permissions(server, attr, BT_ATT_PERM_WRITE_MASK);
 	if (ecode)
 		goto error;
 
-- 
2.29.2

