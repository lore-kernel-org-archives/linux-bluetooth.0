Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CCEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Jun 2022 22:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347556AbiFQWV1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Jun 2022 18:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347292AbiFQWV0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Jun 2022 18:21:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0ECE60DB7
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:25 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d5so4947634plo.12
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jun 2022 15:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=VcnH9Xy2XaXX0MlPd/gOyIbtcnrLxA3uzU5JJHrbFlc=;
        b=UY5N9FLeY2T3rimQnRTML5xfq2zTWB2oJVKS9iYlq3hXcaQ6Yk5YzwwgWpSPJa3WdU
         rs1UNsACrnyICGiiYIqMWMaQJ09Ij06fraU8gUuYmlXjB5PSkQ18VDUfVUEzLhZlPI8u
         Xd1rUHf2QSzZ/NptsuerqR17G6kKasnlWp+DCguziNlK/+QfExJY8+bmJ1L1QspoghHJ
         mi8laX8m2XRrsUDCPQ2U7bM6l/4Lt/70ya3Ec3uvdD3YY0LwE2tzxSntq/+ZRXAdxjcI
         3cdzo4m1Rk+vkKuWOq5nEpYcjAg7mKrtybe9OMLOxAHRST/8kJip3tCmMeLIU9EagSGW
         7WCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VcnH9Xy2XaXX0MlPd/gOyIbtcnrLxA3uzU5JJHrbFlc=;
        b=7aAiBmqFfn/4ya86E6+ESKUquasTC38EkDCQotfPWQOF6MRFOcCgjD3z7zFp0jS2SB
         Gvek5zoa9KPI22/uEhzIPGXzjKJAH5EvrBzOylwqiOULBOnzrLkAzcJCCvca8aQJPwo6
         WGyXgUBGxfpR4hd8kPj9xR8/DWI4EkpgsQtEdwZvUenzYDBwOBYAsJz9e6sq+TPFYgo6
         8juKHCxODOxCGqZnZPi4CbNMCy7MEbzepy8v4/jG3SRlzCEK/eqQyFmRl9veM5M2d1ZX
         qIr3IZrgOAGoWQflVLp6MMVck8+ZjAA5lNP1TQ3Cal+HosB1MGoj9mvMqQoW5PvjjU0x
         MA3Q==
X-Gm-Message-State: AJIora9B3ftrvD2ITy4DzR1D4YUXHQWPK6i6dl24xVNxWNpLzAfwe5Ej
        IXxkVYsbjQ95myhegc7W716lqZKxl3Q=
X-Google-Smtp-Source: AGRyM1us0Ul9AzKsl41HPuwrLHJI0o2CyGnOLgYslFtuxa5GoiB45Xh4LbhV0osUdw/nuGaehylllA==
X-Received: by 2002:a17:90b:1650:b0:1e4:cff1:5a86 with SMTP id il16-20020a17090b165000b001e4cff15a86mr12998286pjb.30.1655504484714;
        Fri, 17 Jun 2022 15:21:24 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v9-20020a056a00148900b0051829b1595dsm4165392pfu.130.2022.06.17.15.21.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 15:21:24 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v6 4/8] adapter: Add support for setting ISO Socket experimental feature
Date:   Fri, 17 Jun 2022 15:21:15 -0700
Message-Id: <20220617222119.1413958-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220617222119.1413958-1-luiz.dentz@gmail.com>
References: <20220617222119.1413958-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting ISO Socket experimental UUID which
enables the use of BTPROTO_ISO on the system.
---
 src/adapter.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.h |  1 +
 src/main.c    |  1 +
 src/main.conf |  1 +
 4 files changed, 47 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index afefa1d5d..2f5a79d20 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -141,6 +141,13 @@ static const struct mgmt_exp_uuid codec_offload_uuid = {
 	.str = "a6695ace-ee7f-4fb9-881a-5fac66c629af"
 };
 
+/* 6fbaf188-05e0-496a-9885-d6ddfdb4e03e */
+static const struct mgmt_exp_uuid iso_socket_uuid = {
+	.val = { 0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6, 0x85, 0x98,
+		0x6a, 0x49, 0xe0, 0x05, 0x88, 0xf1, 0xba, 0x6f },
+	.str = "6fbaf188-05e0-496a-9885-d6ddfdb4e03e"
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static uint32_t kernel_features = 0;
@@ -9701,6 +9708,42 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
 }
 
+static void iso_socket_complete(uint8_t status, uint16_t len,
+				const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t action;
+
+	if (status != 0) {
+		error("Set ISO Socket failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return;
+	}
+
+	action = btd_kernel_experimental_enabled(iso_socket_uuid.str);
+
+	DBG("ISO Socket successfully %s", action ? "set" : "reset");
+
+	if (action)
+		queue_push_tail(adapter->exps, (void *)iso_socket_uuid.val);
+}
+
+static void iso_socket_func(struct btd_adapter *adapter, uint8_t action)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, iso_socket_uuid.val, 16);
+	cp.action = action;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+			MGMT_INDEX_NONE, sizeof(cp), &cp,
+			iso_socket_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set ISO Socket");
+}
+
 static const struct exp_feat {
 	uint32_t flag;
 	const struct mgmt_exp_uuid *uuid;
@@ -9714,6 +9757,7 @@ static const struct exp_feat {
 		rpa_resolution_func),
 	EXP_FEAT(EXP_FEAT_CODEC_OFFLOAD, &codec_offload_uuid,
 		codec_offload_func),
+	EXP_FEAT(EXP_FEAT_ISO_SOCKET, &iso_socket_uuid, iso_socket_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
diff --git a/src/adapter.h b/src/adapter.h
index 688ed51c6..b09044edd 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -260,6 +260,7 @@ enum experimental_features {
 	EXP_FEAT_BQR			= 1 << 2,
 	EXP_FEAT_RPA_RESOLUTION		= 1 << 3,
 	EXP_FEAT_CODEC_OFFLOAD		= 1 << 4,
+	EXP_FEAT_ISO_SOCKET		= 1 << 5,
 };
 
 bool btd_adapter_has_exp_feature(struct btd_adapter *adapter, uint32_t feature);
diff --git a/src/main.c b/src/main.c
index 34a54d43f..4dd24df1c 100644
--- a/src/main.c
+++ b/src/main.c
@@ -607,6 +607,7 @@ static const char *valid_uuids[] = {
 	"15c0a148-c273-11ea-b3de-0242ac130004",
 	"330859bc-7506-492d-9370-9a6f0614037f",
 	"a6695ace-ee7f-4fb9-881a-5fac66c629af",
+	"6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
 	"*"
 };
 
diff --git a/src/main.conf b/src/main.conf
index 3816cf362..2796f155e 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -124,6 +124,7 @@
 # 15c0a148-c273-11ea-b3de-0242ac130004 (BlueZ Experimental LL privacy)
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
+# 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
 # Defaults to false.
 #KernelExperimental = false
 
-- 
2.35.3

