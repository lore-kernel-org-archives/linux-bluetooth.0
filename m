Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ADF8C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 May 2022 22:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442187AbiEFWWI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 May 2022 18:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391110AbiEFWWH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 May 2022 18:22:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FFBF0B
        for <linux-bluetooth@vger.kernel.org>; Fri,  6 May 2022 15:18:23 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id g21so9512104iom.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 06 May 2022 15:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vvRnIZ14qQwpmNqfTRjQS+GOr22GgxtCuDvEgGckJUE=;
        b=i0XYim208Ggzh28QKx36OBt2CBN1HHOePzS/V32SUwt+UprpZV7ZJ5AZ4Gw/BS1x2U
         DUfnITuj3op2l1MjSKvBZXMvycQj0NZSJ5Fs0lRtiYGWOvt0WLig1ivBC58Won19XzC1
         N60rFGkGnr++Tx3BlhUA3zh/P8q5No7IqPN9JGPskmi2HeAIme2guTPdUschWNHh2Zdm
         RuO3gWGrKrRgR1UBYfN/0sw6S1W9rimRSulH0wiNmqqSSYKPAbSiOf3yYxbe3QNNmu7J
         9WFhRaFrP/vnuQHFoT44eEU3UnfM3dO7sEMOSOMG9R5KiTYp0Id5OEf9rPl3v6AREBZ8
         BT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvRnIZ14qQwpmNqfTRjQS+GOr22GgxtCuDvEgGckJUE=;
        b=zDG/ZClxUcEbA76un+aGwRyWzjbc6JwytJIxH2zSnvTc2CA+WzsuU5vkc8qOOlIqS8
         By7btBuWdYUU1sXHuWSTqqekFYYZ/YJo7C/wdoHJTw2j57zYOxO+f39HopCofw+M4FKi
         xbxuFOkPERdQ78e5zzsH9FuUA0LM93Q6wjjjE5yYXPkpODm5gaoEdQJfkBsTMuJ7XLsg
         fVmKJD2Z6110qZrgl8IbUPxKENy9SZitXLmbRDhF7CZ59ZS+N8jff6+IFLv1cKMIHhJh
         P/8v7d70ziSzq2ej5dOb2gyBJ9QrU4YthYABNyHmKM8IPp52pSdy6PFvemfvBZHw7E/9
         3hsw==
X-Gm-Message-State: AOAM532BBA4hcz/QoymxVjAs1HSQsBzhiE88Y18PMW91eShZUvv7HPjb
        soBW60k9vPsgltPa99/rkR7VkhymM2E=
X-Google-Smtp-Source: ABdhPJynEfsmv6yP35h75st9uBgIqHEshiA1I1bl+Kiu330H32RjU3qJvADKQ8AXvAbdMK+z/xDDXA==
X-Received: by 2002:a6b:3fc2:0:b0:65a:4236:bb42 with SMTP id m185-20020a6b3fc2000000b0065a4236bb42mr2147573ioa.215.1651875502356;
        Fri, 06 May 2022 15:18:22 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id g4-20020a056e02130400b002cde6e352c8sm1480822ilr.18.2022.05.06.15.18.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 15:18:21 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 3/7] adapter: Add support for setting ISO Socket experimental feature
Date:   Fri,  6 May 2022 15:18:14 -0700
Message-Id: <20220506221818.3933843-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220506221818.3933843-1-luiz.dentz@gmail.com>
References: <20220506221818.3933843-1-luiz.dentz@gmail.com>
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

