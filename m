Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1349EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 May 2022 22:47:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386460AbiEEWvO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 May 2022 18:51:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbiEEWvN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 May 2022 18:51:13 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8945BD2B
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 May 2022 15:47:32 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n18so5722604plg.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 May 2022 15:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=vvRnIZ14qQwpmNqfTRjQS+GOr22GgxtCuDvEgGckJUE=;
        b=Eql9Yjnx0JsS31u6l8nju2+EIx2Eujv4y7aUZt5YO0uULisYU5aPoAXA08nSmI4d5T
         XDHCPeDGT3m/v/t1cUKnqay01ihBIuhwuYgMTAyN2yi+htCcqG1Anpzt4FhTXroDn52N
         b9vtpiu9u/geABGXeokAeDVijB334p1hN1K18jbzT3UD9vDCxnOVaY3MI59nNCufkkkQ
         Ols78QbJiUEtSwXUCwhzul31yDSPDZYDl7xoZfkdCEvUb1dhAHUkmRjFXIqQoXZhL0hi
         s1yhpkHjtSbrGie3FWuj8aQ39lnNDbzEktGsqrLIostVqrHeBazE6GGWRnKQQDjrTQfp
         +rEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvRnIZ14qQwpmNqfTRjQS+GOr22GgxtCuDvEgGckJUE=;
        b=idI9OCdHj0Mv3R73Kdoge3Zv/g4RZoUg98iGVCVBF641NtcB8rbKKwVdM0llrOgCfU
         MhjKXAff49aIsMf0pQ3M5ZEp8YYhKT9Lbuby5QWwxSjdPlV5s3jz3Mx0OYOryStS4pJk
         F8AgSRoVyiISG0vXBdVbH/CaTcJvGt7IqlsNj749RcOKqMOTO+EppUrQZEj4grTudoDT
         JEq8LTglo+kdRNhcgdHIrA0mGuKXagpOI/PqB0758Vmwj0MwGF8IgSivWkBRdPioQiKx
         7A1v55LtLzv0cn2Mq++kPT2KbEEQjLY6wTTxyF5goR8E05Xj74nT4zchluRQ+n21462E
         IvQg==
X-Gm-Message-State: AOAM533p9jkXB3NenTItqTV+KCfR5mEQ+Q1xzWR50GECSLcajWUnkVtK
        QSLbwzIdGSgOMipD1uWdOG7QEzf7MYU=
X-Google-Smtp-Source: ABdhPJxLDJ8GEAUWMi6soidm9V8Zfi+fCMzJs+TE2Ky6ClI+1N6sWLdFHCHCAAF0v3Gjp20AlgjyFg==
X-Received: by 2002:a17:90a:a58c:b0:1c9:bc35:6ed9 with SMTP id b12-20020a17090aa58c00b001c9bc356ed9mr620562pjq.146.1651790851473;
        Thu, 05 May 2022 15:47:31 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e21-20020a170902d39500b0015e8d4eb2aesm129651pld.248.2022.05.05.15.47.30
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 15:47:30 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/7] adapter: Add support for setting ISO Socket experimental feature
Date:   Thu,  5 May 2022 15:47:23 -0700
Message-Id: <20220505224727.3369989-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220505224727.3369989-1-luiz.dentz@gmail.com>
References: <20220505224727.3369989-1-luiz.dentz@gmail.com>
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

