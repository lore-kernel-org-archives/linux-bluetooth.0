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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154ACC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009386056C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346573AbhIGWbU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346660AbhIGWbU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 18:31:20 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCA2C061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 15:30:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 17so372517pgp.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 15:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=V9aKXTmWmkGWqZBXTW8WnMhZLSLPCzs303ngGj763SA=;
        b=VjITV71R8EJ9jajVjuxyhQ+eAYUPb8KAsGwSQb+SVu2bq1DJRUDsaZpd05tFE0Ae9h
         RnKo2Mz6H8IljXml3n8lkUqarqU6SFclbcOufi9PM/LHVHk2WRYWUSMu1hcuTH9lgMwv
         66JiwrTKP33WXUVPcIdW2GHJBFe8ANo2lMjkbzre9xXVWYZG1T2cDIlc0UDGedtD8MA/
         04eHLOWnVWBTsCbUpbCK+IlyU545fWiJeiBBqjJVWZwKFE0aVi+XhSUdJ+LJI13yqMfT
         dMVH/Jp8ej8wp2cvRW8ywX4Jo9bcfU9XLBixhNbpKWwYAdZyUseDWY8a03oHZREQGDlm
         y71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=V9aKXTmWmkGWqZBXTW8WnMhZLSLPCzs303ngGj763SA=;
        b=o6hZbnXaBXeSht12qbKBkhub/XX2YHQwRsmTtslv6vIwz2fxvgXPMaGJO7JuWdlEtH
         TpGS0Wmqda3q1Dbu2T6xBVt8RHuLjbWJAiX+uaPWOilYeh6CANzpYNEmPO1sqtJdAC/a
         xDtkXeOdKKwUv2p2z1XHxtNIrqWT7HVF4NG7srWqyUYj7CeJ14FS9KxUQU2H4mHV2iOw
         tPLi7XwtQsU6tUpK4wlrWcfPgqSOmSY/c1P/RkNNyrYPemGvCwUIqEdSjD6NrCiL8bIO
         fO6V56LXJ9Lyob3YsNokCqcqImer+5286MzbfU52Od+Gn5o1biPWvzsBTJsymlBt50hq
         azLA==
X-Gm-Message-State: AOAM530oebQ4BtUzshkcP9KUcVZmLtXH7VX/QZK0EGKK/9Oyi3YSIM3O
        zsYZvDVnp3u7G+O8bOEhfskFr3fQMJ4=
X-Google-Smtp-Source: ABdhPJxb/TqAtQNo7ooWiINH8YLbPkP+mhUQwJ23yeW+IhJ62IQWLafZnBJEebVwadY99NuRbnjuHA==
X-Received: by 2002:a63:7c58:: with SMTP id l24mr543619pgn.464.1631053812730;
        Tue, 07 Sep 2021 15:30:12 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x19sm153811pgk.37.2021.09.07.15.30.12
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 15:30:12 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] adapter: Enable codec offload when Experimental is set
Date:   Tue,  7 Sep 2021 15:30:08 -0700
Message-Id: <20210907223008.2322035-5-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210907223008.2322035-1-luiz.dentz@gmail.com>
References: <20210907223008.2322035-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables codec offload experimental feature if its UUIDs has been
enabled by main.conf:Experimental or -E has been passed in the command
line.
---
 src/adapter.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index bc6469e0a..ce715766c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -135,6 +135,13 @@ static const struct mgmt_exp_uuid rpa_resolution_uuid = {
 	.str = "15c0a148-c273-11ea-b3de-0242ac130004"
 };
 
+/* a6695ace-ee7f-4fb9-881a-5fac66c629af */
+static const struct mgmt_exp_uuid codec_offload_uuid = {
+	.val = { 0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f, 0x1a, 0x88,
+		0xb9, 0x4f, 0x7f, 0xee, 0xce, 0x5a, 0x69, 0xa6 },
+	.str = "a6695ace-ee7f-4fb9-881a-5fac66c629af"
+};
+
 static DBusConnection *dbus_conn = NULL;
 
 static uint32_t kernel_features = 0;
@@ -9555,6 +9562,40 @@ static void rpa_resolution_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set RPA Resolution");
 }
 
+static void codec_offload_complete(uint8_t status, uint16_t len,
+					const void *param, void *user_data)
+{
+	struct btd_adapter *adapter = user_data;
+	uint8_t action = btd_opts.experimental ? 0x01 : 0x00;
+
+	if (status != 0) {
+		error("Set Codec Offload failed with status 0x%02x (%s)",
+						status, mgmt_errstr(status));
+		return;
+	}
+
+	DBG("Codec Offload successfully set");
+
+	if (action)
+		queue_push_tail(adapter->exps, (void *)codec_offload_uuid.val);
+}
+
+static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
+{
+	struct mgmt_cp_set_exp_feature cp;
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(cp.uuid, codec_offload_uuid.val, 16);
+	cp.action = action;
+
+	if (mgmt_send(adapter->mgmt, MGMT_OP_SET_EXP_FEATURE,
+			adapter->dev_id, sizeof(cp), &cp,
+			codec_offload_complete, adapter, NULL) > 0)
+		return;
+
+	btd_error(adapter->dev_id, "Failed to set Codec Offload");
+}
+
 static const struct exp_feat {
 	const struct mgmt_exp_uuid *uuid;
 	void (*func)(struct btd_adapter *adapter, uint8_t action);
@@ -9564,6 +9605,7 @@ static const struct exp_feat {
 		 le_simult_central_peripheral_func),
 	EXP_FEAT(&quality_report_uuid, quality_report_func),
 	EXP_FEAT(&rpa_resolution_uuid, rpa_resolution_func),
+	EXP_FEAT(&codec_offload_uuid, codec_offload_func),
 };
 
 static void read_exp_features_complete(uint8_t status, uint16_t length,
-- 
2.31.1

