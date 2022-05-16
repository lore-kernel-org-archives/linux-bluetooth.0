Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FEBC433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 May 2022 22:13:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346155AbiEPWNN (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 May 2022 18:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244688AbiEPWNM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 May 2022 18:13:12 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87672A729
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:10 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id z26so17509257iot.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 May 2022 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Upiq2tso0Z2Gk/Lu4n1kwNZl/OhAOySUn57PApKrmvY=;
        b=iNoQVvHqJmtqO1GvfFOeny3tLkoXpynCyLSR/Ccoa7X8wODBoo3vRMA1dyPvpNM8xv
         cvfj0nBQRNUNePTgsPQa2FgCy7pMfWVKim3wBx9KtjNS6Oa1iH6+hoDmDltnbW6ag/+q
         P25myhTOB4Kru+cYvszkmXSPDb2o27Ni2Td093D4Z49/QCzATPSoy6zS3qK5PZ3xNphb
         vD4SBBOOWOoAkFtFzFtjxgZ0GMtQwm+fXLJzGUVYFiVwUwxtdz4ccGcxCbsB/L61PJgl
         ktHMydM7bRhD7BaCOpsjkPagxBjj3LkDQU2yrgP9/EUm9eYuIk4vDdNrk3meyB2TwSHG
         nu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Upiq2tso0Z2Gk/Lu4n1kwNZl/OhAOySUn57PApKrmvY=;
        b=n9/mxWr2X7DdnjL+sBVfn6C0Dzwzi3stmkpeGaLxHcPu+iFua4z5jbIUkULaEjVYfR
         klXgV+bklapcImM8S8IP/0iqVR5ojJwO58wUitEwW82Pfde+CgTokQ1FBaomUp2bsBL1
         EwHdaIiisp38W0nbufP9D2IXAn0RCcDR72nYF39akhp5azqzwAcVXQVNA5v234vcSda/
         q5zYfCFRd2kXt91Jz2si7R+ZrUKZGFDXRlMfVBF6kaenOrmWix8iw9oBMEGbK2gXB7Y5
         eMqyz1ofmQJ+Gcxts4mdX7tBJazECIr9kZq0EvsPK+52S185bqfutgKRAZQqe6fm65sQ
         HYfQ==
X-Gm-Message-State: AOAM5319C7AAaVwcfOlB7Frys0/jDoZHDLAlccPpOjfjB3i3O2GnpX29
        5ShbyZLwyhQr067lO25gTcnEqRpRvCE=
X-Google-Smtp-Source: ABdhPJxpieE1occuAJR+NPGsoQqAB6cfcpiMWXxGovZZko270UtJxMwe8Trky4XKU31ZGVp30wfKEA==
X-Received: by 2002:a05:6638:2513:b0:32e:5298:8264 with SMTP id v19-20020a056638251300b0032e52988264mr607101jat.178.1652739189780;
        Mon, 16 May 2022 15:13:09 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id t9-20020a6b5f09000000b005e1729b55ccsm166426iob.1.2022.05.16.15.13.08
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 15:13:09 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v4 4/8] adapter: Add support for setting ISO Socket experimental feature
Date:   Mon, 16 May 2022 15:13:00 -0700
Message-Id: <20220516221304.1744026-4-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220516221304.1744026-1-luiz.dentz@gmail.com>
References: <20220516221304.1744026-1-luiz.dentz@gmail.com>
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

