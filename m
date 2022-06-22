Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA6EFC43334
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Jun 2022 22:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358395AbiFVW2R (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Jun 2022 18:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358214AbiFVW2L (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Jun 2022 18:28:11 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B12CCC
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:08 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id g186so17384593pgc.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Jun 2022 15:28:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=whZTdz3OP8Yu5clRqSco0PrrQlonxEk5mOHyA5xX/sM=;
        b=TZLsBc8EjVzF9+tCCw3c8eBNumM60lPC1y5Y6Jv7iB+kWdNzsNjAR7dPmC5uADlQP6
         aq+sLC5ZNepYW0RWAD9lrWEbf3bmS1rCW4areScw4+MdpTNtC0PIxQOMlb4Rz0eJ4KGE
         EV8lUkwbAX0YIcB3fd+MvJgC2Kx3STjvDmg3mVC7lZ9HxQIQdoYBPWPAbO5ZroIEviyO
         wAe+a0/+pPYa9Uu3WsJ0rO8zbzwvyDtZT3BWPiz4nKazPwrU9URSUJz9BBCw/ejZOgPe
         44BF4So7RCJHEY9WqkMkpGMNpci68C3DOT34VDk7RAH73HhSqeZw49jo5fxEv5QoAF4M
         ksdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=whZTdz3OP8Yu5clRqSco0PrrQlonxEk5mOHyA5xX/sM=;
        b=NDmRPCGSxeLuAH5rKhF//Gh/PVBo3uFMk5E+J8/gGKa6WEKj2eTNFiCebvRX/qxqfE
         f8lSGUnaSSRFNh24I1SgfLh/g+YxamC5mRjdRmeDItJI4Xj39ZF02DStRyPOoIlrWW3P
         dS1gv8plp3vlfBoQvj69cGv+9cdlfWfcXeHCmqBQEjml1ba09xguI5mgc5F+AoIN0wzi
         TKaZWzoWvTXAsA1dUOX3wHdU+Q4KRK8M8Z/yZehcYuuIk1LcmEjj46y1RQ1R44Zcv+8q
         MTX6iuZN49ew2+qQ+MMp9hsdIwpvyU9LXdbJ2Iegj2E8BlIYTtEo0mDM1w+oGfiXB5og
         7iXw==
X-Gm-Message-State: AJIora86HOsqTrqqofIUVKJibKHUGeAvemFS4u90vd1/ZuTBjfNjmuKI
        DdLHZImYGwFxEB+2jDRL+hXboEz+PjZThA==
X-Google-Smtp-Source: AGRyM1tGWtn9rdaCHKaElbj67Apd6k+/PoQ0JhYlBV3NOTjJQNfOhbN6eRNxTpmTOSbhpGixH5a63w==
X-Received: by 2002:a63:7257:0:b0:40c:ab23:31d9 with SMTP id c23-20020a637257000000b0040cab2331d9mr4722168pgn.210.1655936886827;
        Wed, 22 Jun 2022 15:28:06 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x10-20020a1709028eca00b0016368840c41sm11710482plo.14.2022.06.22.15.28.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 15:28:06 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v7 4/8] adapter: Add support for setting ISO Socket experimental feature
Date:   Wed, 22 Jun 2022 15:27:57 -0700
Message-Id: <20220622222801.2676431-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220622222801.2676431-1-luiz.dentz@gmail.com>
References: <20220622222801.2676431-1-luiz.dentz@gmail.com>
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
index 43884cf15..f876cb992 100644
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
@@ -9708,6 +9715,42 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
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
@@ -9721,6 +9764,7 @@ static const struct exp_feat {
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

