Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5729FC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 30 Jun 2022 22:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiF3WPA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 30 Jun 2022 18:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiF3WO7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 30 Jun 2022 18:14:59 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA857206
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:59 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 128so672801pfv.12
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jun 2022 15:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=oT6v5I5blA+7elXvToO8XtI3jd09cfgnBgXkXVeuE7w=;
        b=BsRi4XHe7g/ONp2+ZD4jjQ5Zu4x+Yn0nWzjD+6KqIewcCnrnIC+S3zFWEO/Bwei6B+
         aJHSX3B1Crm/QUWdCSVjpOhe5YUvulISC8tosB5A36Y27eHmbO1Am6OqhPbPGgnnkDMO
         CQ7c3BaZWhznnZcNgaHMHpWRTJMaqFoMo7NFWus5y9kaPjh+lRY9aIZHvCwYBSvVY1D1
         xG4af7HWRmHyvcnt5LtDtx2Sir2SFdAHLAxY1+vFzS825ML5pFg6M8Y41VD5++igd+O8
         OC6Fpjlvn3RbV83AgK4IlFg/R26wXvvSlGnhkJVkCVFdlB0X9tKk/amhwx82oCS87aIU
         ws3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oT6v5I5blA+7elXvToO8XtI3jd09cfgnBgXkXVeuE7w=;
        b=zG0Tz09AQGbJMX/C6vC8lknP6KC9UlToVfTZbqYhTWFQLkHnKnh2XHYV0XSClnYY8q
         na1P1HVwFLhpOteVFFJ1dyhIoc+B+kvYFwHeQ8G5ELPj7UjGz5Dba0JD6FFZGzxkYxYu
         pkChUZM3NIph3M6NyCtQxKihC/sXU9UAdC24RBCYtNKadDixR5+FvUjygzojhwT/hajm
         c5Q17diXR0/dhSNQ5j+Q9468bx9cVxHgMkcuPKZOjg/j3ngYIg7u62tiFdsZ+XlErlI7
         4zYtSV+y9ePd107yVjmkW2k06nJbDmEOAuCqa3oyPji5VSEhAq+lhUW4OelddnKlw0jv
         uttg==
X-Gm-Message-State: AJIora+gLZ1EUaB9HcS36AMNU+wpxKKRzXGONZbFK6tJ+0+A/xeTsynh
        dX2r8vtLMZgjk8LB3zNMsPZpBDiYlu6XNw==
X-Google-Smtp-Source: AGRyM1v78m8lcICfktuPL8Hs9TdhwiJQgZo2sdfswgXYqbvHEoqMTZ/3jlYxHG1ofKD3albygAMlyg==
X-Received: by 2002:a63:ec03:0:b0:40d:e79d:e22e with SMTP id j3-20020a63ec03000000b0040de79de22emr9800052pgh.53.1656627297969;
        Thu, 30 Jun 2022 15:14:57 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id me3-20020a17090b17c300b001ec84b0f199sm3460333pjb.1.2022.06.30.15.14.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:14:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v8 4/8] adapter: Add support for setting ISO Socket experimental feature
Date:   Thu, 30 Jun 2022 15:14:48 -0700
Message-Id: <20220630221452.638591-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220630221452.638591-1-luiz.dentz@gmail.com>
References: <20220630221452.638591-1-luiz.dentz@gmail.com>
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
index c4d5ad2e2..2d6e30dab 100644
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

