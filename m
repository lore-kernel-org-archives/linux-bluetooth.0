Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71D4DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444770AbiEFWf3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444767AbiEFWf1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:35:27 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3312528F
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:31:43 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id b5so5672441ile.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vvRnIZ14qQwpmNqfTRjQS+GOr22GgxtCuDvEgGckJUE=;
        b=Hgd6Eb90xauw1yqKCSWQ6KVbNIJEDgyhEIVT9b5ZkTC3DWHK6LmcA8XQi6Pelpr3yq
         w2xiyJvdgScHzF6Ii6wuSwd3ZlAvrq2a9nJa41w2s9/+uAgJa3Efr/j63xGN+p41bOuV
         vzRSMva8/q/IcN79Xr4qOZxchdWbyc5x1gBKf3zoyC0wvvC+4STHT+LrItenLgjY+1rU
         Ymr0mG9wieWjcOFPS670zMFvW/UWTV2kMc16KZHHVFh/NCTHd+wq2VpS6VYQIlSjKJvx
         LZWjLMqcbscBAR6YWHF7j1mg/oXgnUm+t7VgvU1duK7LDUuoovHHA7aLWQhZOxkAEIhg
         sDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvRnIZ14qQwpmNqfTRjQS+GOr22GgxtCuDvEgGckJUE=;
        b=iSPz2ujAo8vbjCH/lEzstOspdcD01gc1o3QqyJVEi8x9272rjovRcMsyfdug+N9wzD
         Pz1haks1H7W950aqqd+zDxhAsFM0REh3neQIfKqHPy2WE3zXzxOGm791Zp6ucm3WPaPo
         7/WxdoLRI9R8erGJr6WJMmlCYpYIqnbs+J3Oh3KTRv99f7I/8Lrk8b/00ZNFCUuyVIpn
         ZuYAkyl0d+QQ+se0O/IZ2Zz0BLV9I1lh0SNjUoeDj/scwd6d4XZ+4UkLqswrWbIweyxz
         ekC4AQTPgGezfyfW7vxvYJqcb6iOaXdWOYMW3aZN3IaBGsrzEUvVmFwI6QglbemaO7Df
         We2A==
X-Gm-Message-State: AOAM531LmYGrW2MN8xfRbQCGcXeUKqOwcJbXkk3w+hNg8IVC7LrBeRHa
        ExRbOZFYKjMBYXGrvV/uUDRdCE/YmCw=
X-Google-Smtp-Source: ABdhPJz1WT8FUmbPrw/fnzoeP7I7vyDr0oL3qzvdrjBwOxHakQS6QI+PRmC2SyG96MfnCpId0Olrzw==
X-Received: by 2002:a92:ca0d:0:b0:2cf:3bb8:f1a5 with SMTP id j13-20020a92ca0d000000b002cf3bb8f1a5mr2181879ils.152.1651876302892;
        Fri, 06 May 2022 15:31:42 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p16-20020a92c110000000b002cbed258dcfsm1488375ile.0.2022.05.06.15.31.41
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:31:42 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 3/7] adapter: Add support for setting ISO Socket experimental feature
Date:   Fri,  6 May 2022 15:31:29 -0700
Message-Id: <20220506223139.3950573-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506223139.3950573-1-luiz.dentz@gmail.com>
References: <20220506223139.3950573-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support for setting ISO Socket experimental UUID which
enables the use of BTPROTO_ISO on the system.
---
 src/adapter.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 src/main.c    |  1 +
 src/main.conf |  1 +
 3 files changed, 44 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index db2624c60..1ede58494 100644
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
@@ -9691,6 +9698,40 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
 }
 
+static void iso_socket_complete(uint8_t status, uint16_t len,
+				const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+
+	if (status != 0) {
+		error("Set ISO Socket failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return;
+	}
+
+	DBG("ISO Socket successfully set");
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
 	const struct mgmt_exp_uuid *uuid;
 	void (*func)(struct btd_adapter *adapter, uint8_t action);
@@ -9701,6 +9742,7 @@ static const struct exp_feat {
 	EXP_FEAT(&quality_report_uuid, quality_report_func),
 	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
 	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
+	EXP_FEAT(&iso_socket_uuid, iso_socket_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
diff --git a/src/main.c b/src/main.c
index 12cc21372..011d66d5a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -606,6 +606,7 @@ static const char *valid_uuids[] = {
 	"15c0a148-c273-11ea-b3de-0242ac130004",
 	"330859bc-7506-492d-9370-9a6f0614037f",
 	"a6695ace-ee7f-4fb9-881a-5fac66c629af",
+	"6fbaf188-05e0-496a-9885-d6ddfdb4e03e",
 	"*"
 };
 
diff --git a/src/main.conf b/src/main.conf
index 91b98b8c4..9d0319318 100644
--- a/src/main.conf
+++ b/src/main.conf
@@ -120,6 +120,7 @@
 # 15c0a148-c273-11ea-b3de-0242ac130004 (BlueZ Experimental LL privacy)
 # 330859bc-7506-492d-9370-9a6f0614037f (BlueZ Experimental Bluetooth Quality Report)
 # a6695ace-ee7f-4fb9-881a-5fac66c629af (BlueZ Experimental Offload Codecs)
+# 6fbaf188-05e0-496a-9885-d6ddfdb4e03e (BlueZ Experimental ISO socket)
 # Defaults to false.
 #Experimental = false
 
-- 
2.35.1

