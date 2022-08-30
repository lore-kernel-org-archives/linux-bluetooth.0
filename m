Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B542BC0502C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 14:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229985AbiH3OsB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 10:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiH3Or7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 10:47:59 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76735BFC53
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 07:47:56 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1B5D36601F01
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 15:47:55 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661870875;
        bh=6QLviVyQq0ni+/AJifpiFagFZmFAziOKtE9yGu4Jbzc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=jDWhkY5vDLQ9eTrSHoUev6easnT5qFtiNmwhf1fWqdJQoOxBF7s+gv5dZiqzXdQfQ
         UcJGNtCazvtTu6XwSWHH6LAAEKF3NUkVIB0M1HFqBx98UoKdq087dOzueEXIYMM6+D
         Tn+RoakpvH7uQ7R/9fCGW0c2xU4uDKVyhJkrAXA72VObVfAaZb7ps48arOPVoUWqww
         ZD5jbDq5FJs63T7VLl36M/LM/lsnu6sqdVxB+/y1Q44zY/zucEJ8ALBzNGaZeXXGon
         /gs1898A2W04uy+M5OeDv5YEUTSZ8Ujp+e3WmG+C56KYEV/EH+FdCFJJiDQZzs9DlU
         6sbfRKKfyipPA==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] profiles: Fix function definition style
Date:   Tue, 30 Aug 2022 16:47:34 +0200
Message-Id: <20220830144734.55263-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830144734.55263-1-frederic.danis@collabora.com>
References: <20220830144734.55263-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This was found by checkpatch in previous commit:
WARNING:SPACING: Unnecessary space before function pointer arguments
124: FILE: src/shared/bap.h:123:
+	int (*select) (struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,

Do the same for (*config) and (*clear) for consistence.
---
 src/shared/bap.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/shared/bap.h b/src/shared/bap.h
index 93b00d771..b63b4b024 100644
--- a/src/shared/bap.h
+++ b/src/shared/bap.h
@@ -123,10 +123,10 @@ struct bt_bap_pac_ops {
 	int (*select)(struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,
 			struct bt_bap_pac_qos *qos,
 			bt_bap_pac_select_t cb, void *cb_data, void *user_data);
-	int (*config) (struct bt_bap_stream *stream, struct iovec *cfg,
+	int (*config)(struct bt_bap_stream *stream, struct iovec *cfg,
 			struct bt_bap_qos *qos, bt_bap_pac_config_t cb,
 			void *user_data);
-	void (*clear) (struct bt_bap_stream *stream, void *user_data);
+	void (*clear)(struct bt_bap_stream *stream, void *user_data);
 };
 
 bool bt_bap_pac_set_ops(struct bt_bap_pac *pac, struct bt_bap_pac_ops *ops,
-- 
2.25.1

