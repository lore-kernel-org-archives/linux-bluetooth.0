Return-Path: <SRS0=G1v0=QF=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10128C282C7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D69D1214DA
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Jan 2019 13:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE3a1Jeo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfA2N0p (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:26:45 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:37441 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfA2N0p (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Jan 2019 08:26:45 -0500
Received: by mail-ed1-f42.google.com with SMTP id h15so15954581edb.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Jan 2019 05:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=ece6LNwJ41w0ovKEZ7at1zRF9o+tpCzc7gewBjfj304=;
        b=DE3a1Jeo5zKWM6X1iMrQZHA8cCeJs33fQIFaCeBPWqZTG3DO81fJxfnPOQtaIY6AHR
         4AMfstHZS92M5emyngAA8ML4VFi3r9/FHJlyGTXwz0E/VjpVXsZMFL1tPQd4xl9l6zwB
         Wdpdou+iN2xkRx2WQVoaoS5UrzAsE4yON1X58w93N/DKeCl+UY5Zn5TFUDrlv5jyjEhH
         nRxDAs1nAyt7tZXgUC8xQENB8Mdh22DDzgBVIuBDeCTy48CA/5Sc/Y8qEVagm60WuEA6
         ZrS+WnzENQ7eTSAYrwVtLzuD1ZfCLenIjzPYq+5D/ThnD1OyzHjSloNb7LSn50mipawT
         VnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=ece6LNwJ41w0ovKEZ7at1zRF9o+tpCzc7gewBjfj304=;
        b=eBBBQ7QnvPg5VSTjABHvJqgIfzy78NtqPcFfKYgi3v3fC08YDBkssxTczlKfSjHrZD
         MDNTw8ytuggBWJ4lVUD1lSUmR0EhD4YEF7mVd09YTy8PDi8Ezn6zA5rP6CPiqHpvMsWk
         qjl+qSpwLlF8t5xIyNU9u5/u6s5TagrIXYR7nKoI3okk8PoXANTwCjWcicvSUUIfGSaH
         bkscX3VPVrP0QoI+NDE7vrheYLiexPLLxuFJ/hg4SmAAY/2uFnz6RSA0xuJEB9iMUYTq
         Mc/eE2mG7irZZpacq6lkS8jaC17v8YOFCgAL9/KzI+fMQBiHBzSQ0jBUOocErc5CLkGm
         pwWw==
X-Gm-Message-State: AJcUukdSMREfoWhjXwTwSQQqIgcUXr5MMJgAaIiKDDHbIQIpO4lzMqV4
        KAwoaPpJQyGDA2A06LaKXrWHxA4g
X-Google-Smtp-Source: ALg8bN6BI6SY+3eH2riUYZ9xbfb1RMWR4q+pxIKdFX7AjOdVWxpQi2BW03TjTQleCNVRGA0uP20qvA==
X-Received: by 2002:a17:906:452:: with SMTP id e18mr11922727eja.142.1548768403091;
        Tue, 29 Jan 2019 05:26:43 -0800 (PST)
Received: from localhost.localdomain ([192.198.151.62])
        by smtp.gmail.com with ESMTPSA id i14-v6sm8179964ejy.40.2019.01.29.05.26.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 05:26:42 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/15] shared/att-types: Add errors introduced by GATT caching
Date:   Tue, 29 Jan 2019 15:26:24 +0200
Message-Id: <20190129132634.28786-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20190129132634.28786-1-luiz.dentz@gmail.com>
References: <20190129132634.28786-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds Database Out of Sync and Value Not Allowed errors.
---
 src/shared/att-types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/shared/att-types.h b/src/shared/att-types.h
index 51922d174..8a2658de3 100644
--- a/src/shared/att-types.h
+++ b/src/shared/att-types.h
@@ -100,6 +100,8 @@ struct bt_att_pdu_error_rsp {
 #define BT_ATT_ERROR_INSUFFICIENT_ENCRYPTION		0x0F
 #define BT_ATT_ERROR_UNSUPPORTED_GROUP_TYPE		0x10
 #define BT_ATT_ERROR_INSUFFICIENT_RESOURCES		0x11
+#define BT_ATT_ERROR_DB_OUT_OF_SYNC			0x12
+#define BT_ATT_ERROR_VALUE_NOT_ALLOWED			0x13
 
 /*
  * Common Profile and Service Error Code descriptions (see Supplement to the
@@ -154,3 +156,6 @@ struct bt_att_pdu_error_rsp {
 #define BT_GATT_CHRC_EXT_PROP_AUTH_WRITE		0x20
 #define BT_GATT_CHRC_EXT_PROP_AUTH	(BT_GATT_CHRC_EXT_PROP_AUTH_READ | \
 					BT_GATT_CHRC_EXT_PROP_AUTH_WRITE)
+
+/* GATT Characteristic Client Features Bitfield values */
+#define BT_GATT_CHRC_CLI_FEAT_ROBUST_CACHING		0x01
-- 
2.17.2

