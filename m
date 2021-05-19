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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D57C433ED
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A7F560FE5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 19 May 2021 00:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhESAyg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 20:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbhESAye (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 20:54:34 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA2C061761
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 17:53:15 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id f22so7287556pgb.9
        for <linux-bluetooth@vger.kernel.org>; Tue, 18 May 2021 17:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+D7OqP4dwIQnUzDjlEDKWg26P099anF/7oRXAn963M=;
        b=vEPQcPsPnzHXsesBp9ap+EtNNn9Ex9dHzWeqH5gptrIjgS6uoGEoPftg4qrrXVkBXg
         POt/iP1rvoEjeATTvyKSLENH9D+RVdJxZwMLTGvM6AzG4eFjX/vYm11PrTj3QQDOnck6
         XfkIwpe0k3l4uFOzSt/eroJC8AK3lAJOnJWlfGrxc6Z9UkSMbuuyNzx5kQq05/mb/4xI
         rrcQ8muXMPy+yRtTN1hbgDMestUESwT/YY67iaidHpsdJWnLEZ2C6UjIyBNAcZEjUKRU
         NPlDlIxwyshUEwrB3OddnFEcKVQQxr0cYSaaZe0R4yNvG6farSkDsIw7+PCZ3ntrJ1M4
         d3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e+D7OqP4dwIQnUzDjlEDKWg26P099anF/7oRXAn963M=;
        b=PMqKalIphMG4eRKgDBTZ0Hfd64Io860ORJwbUoqAvJfx3G/NlvCWHyEjCHlG89tA+R
         L9vS/lx60hgmc25Uwfkgm7PxjSVI6I7DYkKJ64tyBT0aReBlwHkujOQ40CP4lxsCWzIi
         cyX8qrzqYiqMrQiWI0RUS8S+5s3huBKSJc2bYLtZ+0OCQFsXXFydiZjmEWhq++LX2Wk8
         pD/tBKan5TxJXAce0wK5FJPw5twNLwSoNnxBT05qInWB0XLhQ7Fx3+1FfJmCHUE5NJgX
         ym36DrDoNtasNlMWUOfE2qrPM8tsuiEEyXSdrezbm+yr3zfPMuyzB8v+HDevSxCSW0X2
         rZYw==
X-Gm-Message-State: AOAM533DoLxFEbbQzPHOXDTBlPZyDtS1xJ/VXgHkyd5smsuk3hKqmu5Z
        op/uX+qCadadvCBs3C1CXzZ9qpEOpLI=
X-Google-Smtp-Source: ABdhPJxcVFRP2+DlXVFm/jQxiCljRh0ZSNOeSUerp4jQAS0PFOMQ18uoONqZFkvM5ulPLcf6ObwXJg==
X-Received: by 2002:a05:6a00:cd3:b029:27f:c296:4a5d with SMTP id b19-20020a056a000cd3b029027fc2964a5dmr7867255pfv.38.1621385594842;
        Tue, 18 May 2021 17:53:14 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id n20sm14057962pjq.45.2021.05.18.17.53.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 17:53:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core: Enable experimental MGMT when experimental is set
Date:   Tue, 18 May 2021 17:53:13 -0700
Message-Id: <20210519005313.867382-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables experimental MGMT features when experimental has been set.
---
 src/adapter.c | 126 ++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 10 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2fa06b73c..30331a716 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9216,6 +9216,106 @@ static bool set_blocked_keys(struct btd_adapter *adapter)
 						adapter, NULL);
 }
 
+#define EXP_FEAT(_uuid, _func) \
+{ \
+	.uuid = _uuid, \
+	.func = _func, \
+}
+
+/* d4992530-b9ec-469f-ab01-6c481c47da1c */
+static const uint8_t debug_uuid[16] = {
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c, 0x01, 0xab,
+	0x9f, 0x46, 0xec, 0xb9, 0x30, 0x25, 0x99, 0xd4,
+};
+
+/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
+static const uint8_t le_simult_central_peripheral_uuid[16] = {
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
+	0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
+};
+
+/* 15c0a148-c273-11ea-b3de-0242ac130004 */
+static const uint8_t rpa_resolution_uuid[16] = {
+	0x04, 0x00, 0x13, 0xac, 0x42, 0x02, 0xde, 0xb3,
+	0xea, 0x11, 0x73, 0xc2, 0x48, 0xa1, 0xc0, 0x15,
+};
+
+static void set_exp_debug_complete(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	if (status != 0)
+		error("Set Experimental Debug failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		DBG("Experimental Debug successfully set");
+}
+
+static void exp_debug_func(struct btd_adapter *adapter, uint32_t flags)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	/* If already enabled don't attempt to set it again */
+	if (flags & BIT(0))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, debug_uuid, 16);
+	cp.action = 0x01;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+			adapter->dev_id, sizeof(cp), &cp,
+			set_exp_debug_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set exp debug");
+}
+
+static void le_simult_central_peripheral_func(struct btd_adapter *adapter,
+							uint32_t flags)
+{
+	adapter->le_simult_roles_supported = flags & 0x01;
+}
+
+static void set_rpa_resolution_complete(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	if (status != 0)
+		error("Set RPA Resolution failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+	else
+		DBG("RPA Resolution successfully set");
+}
+
+static void rpa_resolution_func(struct btd_adapter *adapter, uint32_t flags)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	/* If already enabled don't attempt to set it again */
+	if (flags & BIT(0))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, debug_uuid, 16);
+	cp.action = 0x01;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+			adapter->dev_id, sizeof(cp), &cp,
+			set_rpa_resolution_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set RPA Resolution");
+}
+
+static const struct exp_feat {
+	const uint8_t *uuid;
+	void (*func)(struct btd_adapter *adapter, uint32_t flags);
+} exp_table[] = {
+	EXP_FEAT(debug_uuid, exp_debug_func),
+	EXP_FEAT(le_simult_central_peripheral_uuid,
+		 le_simult_central_peripheral_func),
+	EXP_FEAT(rpa_resolution_uuid, rpa_resolution_func),
+};
+
 static void read_exp_features_complete(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -9239,19 +9339,24 @@ static void read_exp_features_complete(uint8_t status, uint16_t length,
 	}
 
 	feature_count = le16_to_cpu(rp->feature_count);
+
+	if (length < sizeof(*rp) + (sizeof(*rp->features) * feature_count)) {
+		btd_error(adapter->dev_id, "Response too small");
+		return;
+	}
+
 	for (i = 0; i < feature_count; ++i) {
+		size_t j;
 
-		/* 671b10b5-42c0-4696-9227-eb28d1b049d6 */
-		static const uint8_t le_simult_central_peripheral[16] = {
-			0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb, 0x27, 0x92,
-			0x96, 0x46, 0xc0, 0x42, 0xb5, 0x10, 0x1b, 0x67,
-		};
+		for (j = 0; j < ARRAY_SIZE(exp_table); j++) {
+			const struct exp_feat *feat = &exp_table[j];
 
-		if (memcmp(rp->features[i].uuid, le_simult_central_peripheral,
-				sizeof(le_simult_central_peripheral)) == 0) {
-			uint32_t flags = le32_to_cpu(rp->features[i].flags);
+			if (memcmp(rp->features[i].uuid, feat->uuid,
+					sizeof(rp->features[i].uuid)))
+				continue;
 
-			adapter->le_simult_roles_supported = flags & 0x01;
+			if (feat->func)
+				feat->func(adapter, rp->features[i].flags);
 		}
 	}
 }
@@ -9375,7 +9480,8 @@ static void read_info_complete(uint8_t status, uint16_t length,
 			(missing_settings & MGMT_SETTING_FAST_CONNECTABLE))
 		set_mode(adapter, MGMT_OP_SET_FAST_CONNECTABLE, 0x01);
 
-	if (btd_has_kernel_features(KERNEL_EXP_FEATURES))
+	if (btd_opts.experimental &&
+			btd_has_kernel_features(KERNEL_EXP_FEATURES))
 		read_exp_features(adapter);
 
 	err = adapter_register(adapter);
-- 
2.30.2

