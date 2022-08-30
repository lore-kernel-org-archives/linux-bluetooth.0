Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A2CC0502A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 30 Aug 2022 20:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231277AbiH3Uy1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 30 Aug 2022 16:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiH3UyX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 30 Aug 2022 16:54:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF9F86731
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 13:54:22 -0700 (PDT)
Received: from localhost.localdomain (67.227.121.78.rev.sfr.net [78.121.227.67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: fdanis)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 11CE96601DDD
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Aug 2022 21:54:21 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661892861;
        bh=pNHwki0Xdbw+94ZZqN1z8E/ybCNnfvHFlO0jSAeX3NI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=YAwyFUHSGsyo9HcXRSbUtzNfX9QoLIuK60OFWP7HBuAWBhWUXBleWkgEqrUn9SY/I
         xIVMmJmU7YGKPnqUMQWzNKUM4465biemTShF6dMpHlZkZAVOmBSx+lwr+IKa79g1rk
         yUDqDwHQDy2qBAmDK7BdvU+Lv6RYpFmptRwt5el2QYWii7ec5uSvH/V5ff1yllwZca
         o3+lYB7qsMPjvyDx8dFCgxugEkfVFVfdzPIbEJ8YTvoavjwWA6Y6L2e8//RyjBTSek
         /Rn4N/weXT4KTggyhx7T1y+vi5EultyIwA+c76dl3rFJsQ3dxv7iT8ZLkW7F8MbEZ6
         car25Dt58j2FA==
From:   =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= 
        <frederic.danis@collabora.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 3/3] profiles: Fix function definition style
Date:   Tue, 30 Aug 2022 22:54:11 +0200
Message-Id: <20220830205411.68299-4-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830205411.68299-1-frederic.danis@collabora.com>
References: <20220830205411.68299-1-frederic.danis@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This was found by checkpatch in previous commit:
WARNING:SPACING: Unnecessary space before function pointer arguments
124: FILE: src/shared/bap.h:123:
+    int (*select) (struct bt_bap_pac *lpac, struct bt_bap_pac *rpac,

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

