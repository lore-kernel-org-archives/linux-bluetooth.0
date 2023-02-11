Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83778C636CC
	for <linux-bluetooth@archiver.kernel.org>; Sat, 11 Feb 2023 10:57:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbjBKK5O (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 11 Feb 2023 05:57:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjBKK5K (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 11 Feb 2023 05:57:10 -0500
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE05126CDD
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 02:57:09 -0800 (PST)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 74D0D240769
        for <linux-bluetooth@vger.kernel.org>; Sat, 11 Feb 2023 11:57:08 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PDSGr0SM0z9rxK;
        Sat, 11 Feb 2023 11:57:08 +0100 (CET)
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ v2 6/9] adapter: add function for checking adapter features, add CIS features
Date:   Sat, 11 Feb 2023 10:53:50 +0000
Message-Id: <fec95d980e1d7c4588a227d24140a213d156470c.1676112710.git.pav@iki.fi>
In-Reply-To: <3df45c4a6737b249b519d4c6128e2eb783198abc.1676112710.git.pav@iki.fi>
References: <20230127205205.20235-1-pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add function for checking adapter features, similar to
btd_has_kernel_features. Currently supports the CIS feature bits.
---

Notes:
    v2: use feature flags, not separate functions

 src/adapter.c | 13 +++++++++++++
 src/adapter.h |  7 +++++++
 2 files changed, 20 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index aadad4016..4ccacdb8b 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -10712,6 +10712,19 @@ bool btd_le_connect_before_pairing(void)
 	return false;
 }
 
+bool btd_adapter_has_features(struct btd_adapter *adapter, uint32_t features)
+{
+	uint32_t flags = 0;
+
+	if (adapter->current_settings & MGMT_SETTING_CIS_CENTRAL)
+		flags |= ADAPTER_CIS_CENTRAL;
+
+	if (adapter->current_settings & MGMT_SETTING_CIS_PERIPHERAL)
+		flags |= ADAPTER_CIS_PERIPHERAL;
+
+	return (flags & features) ? true : false;
+}
+
 bool btd_has_kernel_features(uint32_t features)
 {
 	return (kernel_features & features) ? true : false;
diff --git a/src/adapter.h b/src/adapter.h
index 78eb069ae..96a8668d5 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -256,6 +256,13 @@ void btd_adapter_for_each_device(struct btd_adapter *adapter,
 
 bool btd_le_connect_before_pairing(void);
 
+enum adapter_features {
+	ADAPTER_CIS_CENTRAL		= 1 << 0,
+	ADAPTER_CIS_PERIPHERAL		= 1 << 1,
+};
+
+bool btd_adapter_has_features(struct btd_adapter *adapter, uint32_t features);
+
 enum experimental_features {
 	EXP_FEAT_DEBUG			= 1 << 0,
 	EXP_FEAT_LE_SIMULT_ROLES	= 1 << 1,
-- 
2.39.1

