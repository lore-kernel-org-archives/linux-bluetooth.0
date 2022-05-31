Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E4E4C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 20:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347871AbiEaUze (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 16:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345922AbiEaUzS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 16:55:18 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CB49D075
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:15 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id s1so6011743ilj.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 31 May 2022 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Upiq2tso0Z2Gk/Lu4n1kwNZl/OhAOySUn57PApKrmvY=;
        b=RTkPRT631B5A+dImLMPT7WFSA1F9p7SYqdbh1Kx8caPPMTVEUUa6lk3W3PPE/7R2Nw
         9e/VfL52AQsNep7FJGKu5+2Wo5+5tMhw9Bjc9d9N745ANr/k2ztbELlAw3LwQMnvisGN
         qzqLqLzVTzo6CngACP+j145iXNDOCmjjoNXn/fhC37K/2jETApbXtnBIeedyeE08MSSF
         qLWsMoohzHqdFBb62eCgRoueqWqC0TAb5O2TgYo96rLFc7HqO0O6y6WhhVTmsbEHfA5q
         M5susUHBXrj6dgYwPDHm1RvE3LH5llBfb0MgIABe2jhUb6B8RYf2CLrprC7s8owYmI1j
         y2Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Upiq2tso0Z2Gk/Lu4n1kwNZl/OhAOySUn57PApKrmvY=;
        b=uFXPEKQKVSgGNeY6IN0kW8axi14YtXW/wyuhXMQiG3XD+cv47kdgH/vDHMvXi1iQZy
         lWCYckt86xkphhHi7zBJKzq+dcvvPFU3P1NMmWbkgxs8uKVQRfM/abAhU6lpuTybk27x
         t4tjv1L9NFAOKupUa4P9cQ6+BO1xcSrCwc4AksK0rN7M4ySYuTGVfjZ6yWcnmmeYMmNe
         rvBhNmKe3A34Yj8+4JzId0hT28cATdTTRV+dBHGwuv3U2tLZcwucT82yRPgCiAcp/qAy
         Xi43X6DA/1LOZqhlT740MflSqP2EiTLCZmMPwlBuN5F+DpGM8GEZZe2ybd7U4ZKCqPqm
         8BOw==
X-Gm-Message-State: AOAM531e2FjF8V2ts5tuEmwoO6JmAjvhmYNlZugX1IO/1fuUEfxgt10D
        L3aDhpX2KRUI5xgiA4mPYxRzX/HS32s=
X-Google-Smtp-Source: ABdhPJzVTlffYVbeeRVEJd5yWvczptmtNvYo0vVKLyRSVn2Pg+9FdIQhesxJ7eZqCH68dccM42SUHQ==
X-Received: by 2002:a05:6e02:1ca3:b0:2d1:aad8:9043 with SMTP id x3-20020a056e021ca300b002d1aad89043mr23059960ill.200.1654030514992;
        Tue, 31 May 2022 13:55:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id v1-20020a922e01000000b002d10dc367a1sm4808460ile.49.2022.05.31.13.55.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 13:55:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 4/8] adapter: Add support for setting ISO Socket experimental feature
Date:   Tue, 31 May 2022 13:55:05 -0700
Message-Id: <20220531205509.1062466-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531205509.1062466-1-luiz.dentz@gmail.com>
References: <20220531205509.1062466-1-luiz.dentz@gmail.com>
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
 src/adapter.h |  1 +
 src/main.c    |  1 +
 src/main.conf |  1 +
 4 files changed, 45 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index f7faaa263..6cfc7facc 100644
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
@@ -9695,6 +9702,40 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
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
 	uint32_t flag;
 	const struct mgmt_exp_uuid *uuid;
@@ -9708,6 +9749,7 @@ static const struct exp_feat {
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

