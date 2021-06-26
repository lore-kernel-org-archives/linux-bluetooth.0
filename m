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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22A8C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 06:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77D536193F
	for <linux-bluetooth@archiver.kernel.org>; Sat, 26 Jun 2021 06:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhFZGch (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 26 Jun 2021 02:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbhFZGcg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 26 Jun 2021 02:32:36 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756FDC061574
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 23:30:13 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id d12so10108171pgd.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Jun 2021 23:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toIwfYd1migbfBFthqNXleyyHdHwR8ESqVb1r7SHJHo=;
        b=aRP2w2VEIA+DkgkPhfn0WQz7Enh5JArQXNAEZml1MhHEp7/ZQZQlgTD3kglr101UAN
         Q12AiFMEWyTfzn+PQj6k5HZaz5l4sJiFQCGCeyZN41OfMt//R4MXKXpJ322+mK8AeBCw
         7kvdw6qSnAM1cze9GV3MIRXWWYdX2XrvH1aXmMetOkmg82gqTU+bwVGOfpDLQXIsLR42
         owOzTKAWAFcQNu4j9LBP64sEAnVR8lYrwCPq0pu/ukgiAVCaJVyyAu3SVvNNzuD3wApd
         qWDY7CRkNtd6CLpqkTgdqJBoI0D0pzth4XTpj+j05lBKvtF54oLBPUK2QE9zWjWc1zlq
         YMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=toIwfYd1migbfBFthqNXleyyHdHwR8ESqVb1r7SHJHo=;
        b=gcgG1xWJmoqmD29+2ppiCFtZghdSKgJZ1ro4riudEEkp/xGgl4ndsrSqLTkr+n6VUQ
         TNgtLd2iP7lORs7lx8bUMOIkZoh528BZxbfS/F3HeCcOiVg6GZJ3/8NWfPlefKXe08mB
         9dMWoBSdVDMUtz6E5qkELlWXaZfZuYnvtAl7S7iaG2Uj66QJOzzCRP36SEbOzXYz7pOB
         3bfRhitSmOftWw2NMzfLWS4ag/x99ZmzVQXJCOVjwoJN9KOiX1N/CzmVNEolehWMz6RB
         WKxyRiN+TblkyRHoY99oSa1v/ERIAgECvOUmzYbX7BjFEL57zxPOH8iU9iovuhQyU4kw
         J9AA==
X-Gm-Message-State: AOAM530IVJzY8N/Bev2DO3owTZBGWy6OnFyOIJLlS9P3SXjT0VZtasfq
        MBxrAnOrxfu9vF5MG5+woO4qyGe++gU=
X-Google-Smtp-Source: ABdhPJzEagM+L6/Wo4yri7KI6uZTAEZcSjDAg5g6p0pOTDu4Gct4/SgOEJswdDtvnp6QZnWxqmdpCw==
X-Received: by 2002:a63:27c2:: with SMTP id n185mr12990108pgn.178.1624689012549;
        Fri, 25 Jun 2021 23:30:12 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::5820])
        by smtp.gmail.com with ESMTPSA id y21sm7587880pgc.93.2021.06.25.23.30.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 23:30:11 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ PATCH v4 1/3] emulator/btdev: Update the white list and resolving list size
Date:   Fri, 25 Jun 2021 23:30:08 -0700
Message-Id: <20210626063010.152987-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates the white list and resolving list size to small
number.
Also, it update the size of white list and resolving list to 1 more than
actual size when it is read via HCI read size commands. This is used to
simulate the case when the list is out of space.

Note that the read list size may not represent the current actual list
size depends on the device vendor.
---
 emulator/btdev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 90457a5aa..202fc7996 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -33,8 +33,8 @@
 #include "monitor/bt.h"
 #include "btdev.h"
 
-#define WL_SIZE			16
-#define RL_SIZE			16
+#define WL_SIZE			3
+#define RL_SIZE			3
 #define CIS_SIZE		3
 
 #define has_bredr(btdev)	(!((btdev)->features[4] & 0x20))
@@ -3402,7 +3402,12 @@ static int cmd_read_wl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_white_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = WL_SIZE;
+	/* The size is not fixed and the actual list size can be different from
+	 * the returned size here.
+	 * In order to test such cases, return more than allocated size, and
+	 * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
+	 */
+	rsp.size = WL_SIZE + 1;
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_WHITE_LIST_SIZE, &rsp,
 						sizeof(rsp));
 
@@ -3687,7 +3692,12 @@ static int cmd_read_rl_size(struct btdev *dev, const void *data, uint8_t len)
 	struct bt_hci_rsp_le_read_resolv_list_size rsp;
 
 	rsp.status = BT_HCI_ERR_SUCCESS;
-	rsp.size = RL_SIZE;
+	/* The size is not fixed and the actual list size can be different from
+	 * the returned size here.
+	 * In order to test such cases, return more than allocated size, and
+	 * HCI Add device cmd will return the Memory Capacity Exceeded(0x07)
+	 */
+	rsp.size = RL_SIZE + 1;
 
 	cmd_complete(dev, BT_HCI_CMD_LE_READ_RESOLV_LIST_SIZE,
 							&rsp, sizeof(rsp));
-- 
2.26.3

