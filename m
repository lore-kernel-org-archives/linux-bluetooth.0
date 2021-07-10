Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00CBC07E99
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 00:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0D85611ED
	for <linux-bluetooth@archiver.kernel.org>; Sat, 10 Jul 2021 00:38:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhGJAku (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 9 Jul 2021 20:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhGJAkt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 9 Jul 2021 20:40:49 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69C4C0613E5
        for <linux-bluetooth@vger.kernel.org>; Fri,  9 Jul 2021 17:38:05 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id p36so545489pfw.11
        for <linux-bluetooth@vger.kernel.org>; Fri, 09 Jul 2021 17:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Zxz84MZik6tQH6NSkK9edzfoiXIstAHSh7FRcIqU+Dg=;
        b=C9lRDLfW8kVjyVwNPWUnKfQTzN9h1T6x3K4WkfZ4t4W6+CZlzeHPCmcSuqgoGgpLlD
         DpbqYuEz/2EU1zIzqOaXsptpr73d3P5y8X8B2woEqQDhWz5/vbwPcObxNf4o047jLrN3
         +0gov/+vaIaa26EGMLTqSiPoKJ+ujs5XP4vRJadljYjz3qnqBLjZGHIG/QJ1xyMPD0ff
         bkSvhczvY9d8aEnr4rTlmoBwKGLKsz4u5+exIE20kyoy/BO/wImOSSsGNOgRff3oZBxW
         Vn9AW9tHaRPigZQFrmTIm/43kWyikZOwoka4n5ahPY2mXyDEv4L6c49/sXrjG18785HC
         /rZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zxz84MZik6tQH6NSkK9edzfoiXIstAHSh7FRcIqU+Dg=;
        b=M+ivnxpM6gjj03PkKSCjp1udAnuWAseqr0dDaHc0yDIBaJTyJdHow941zJem5CkiD2
         Yeh9lTf+Jt2nbr5MGjaYST5DZkOj9Wv7RLpowkwjv6FbnanRWRAY6YJA6uk41Tq4eM1E
         SYNDm+g4NKYFrfguVa6EoqSEi6Kauw3oa0noYq98t33LdkLermM/PC01lXRVwEKI+j7A
         6tj3SRYn9h9yHOYWkHy6ptdGGmgENvq9KSRQMPy1jjKVkTb5GtPqx3w9+aJOh3HYyaYQ
         snrddcERzysHOPYT3qVp+6L4vMsFJWqxdTwKaC+hbpjUYG8CKvNzycH4J2elnCeQ/Opt
         W1xQ==
X-Gm-Message-State: AOAM531dEOUD8mf4ClQLWvW7GU3oAqnNlfl0E7injH2JE+EBoHc3jhdt
        KgCBBKXoZ6tFlhsGflUJYyKBR+PXjl8=
X-Google-Smtp-Source: ABdhPJxD6g655z+ZLvLNUC+JIhKTcFfEe7XA8fSugErbMQg69uOTzT9O73+JZpan95wAEhFx9nl04g==
X-Received: by 2002:a62:1782:0:b029:2f7:dcbe:c292 with SMTP id 124-20020a6217820000b02902f7dcbec292mr40796949pfx.63.1625877485174;
        Fri, 09 Jul 2021 17:38:05 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id u13sm7278219pfi.54.2021.07.09.17.38.04
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jul 2021 17:38:04 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 2/2] tool/mgmt-tester: Add test cases for Read Clock Information API
Date:   Fri,  9 Jul 2021 17:38:01 -0700
Message-Id: <20210710003801.941787-2-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210710003801.941787-1-hj.tedd.an@gmail.com>
References: <20210710003801.941787-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Brian Gix <brian.gix@intel.com>

This patch adds test cases for Read Clock Information management API.
---
 tools/mgmt-tester.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d2ded574e..5def0d83c 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -3917,6 +3917,53 @@ static const struct generic_data set_privacy_nval_param_test = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const void *get_clock_info_send_param_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static uint8_t param[7];
+
+	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
+	param[6] = 0x00; /* Address type */
+
+	*len = sizeof(param);
+
+	return param;
+}
+
+static const void *get_clock_info_expect_param_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static uint8_t param[17];
+	struct mgmt_rp_get_clock_info *rp;
+
+	rp = (struct mgmt_rp_get_clock_info *)param;
+	memset(param, 0, sizeof(param));
+	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
+	param[6] = 0x00; /* Address type */
+
+	rp->local_clock = 0x11223344;
+	rp->piconet_clock = 0x11223344;
+	rp->accuracy = 0x5566;
+
+	*len = sizeof(param);
+
+	return param;
+}
+
+static const void *get_clock_info_expect_param_not_powered_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static uint8_t param[17];
+
+	memset(param, 0, sizeof(param));
+	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
+	param[6] = 0x00; /* Address type */
+
+	*len = sizeof(param);
+
+	return param;
+}
+
 static const void *get_conn_info_send_param_func(uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
@@ -3962,6 +4009,21 @@ static const void *get_conn_info_error_expect_param_func(uint16_t *len)
 	return param;
 }
 
+static const struct generic_data get_clock_info_succes1_test = {
+	.setup_settings = settings_powered_connectable_bondable_ssp,
+	.send_opcode = MGMT_OP_GET_CLOCK_INFO,
+	.send_func = get_clock_info_send_param_func,
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_func = get_clock_info_expect_param_func,
+};
+
+static const struct generic_data get_clock_info_fail1_test = {
+	.send_opcode = MGMT_OP_GET_CLOCK_INFO,
+	.send_func = get_clock_info_send_param_func,
+	.expect_status = MGMT_STATUS_NOT_POWERED,
+	.expect_func = get_clock_info_expect_param_not_powered_func,
+};
+
 static const struct generic_data get_conn_info_succes1_test = {
 	.setup_settings = settings_powered_connectable_bondable_ssp,
 	.send_opcode = MGMT_OP_GET_CONN_INFO,
@@ -9780,7 +9842,7 @@ static void test_command_generic_connect(const void *test_data)
 
 	addr_type = data->hciemu_type == HCIEMU_TYPE_BREDRLE ? BDADDR_BREDR :
 							BDADDR_LE_PUBLIC;
-
+	tester_print("ADDR TYPE: %d", addr_type);
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_hci_connect(bthost, master_bdaddr, addr_type);
 }
@@ -10755,6 +10817,13 @@ int main(int argc, char *argv[])
 				&set_privacy_nval_param_test,
 				NULL, test_command_generic);
 
+	test_bredr("Get Clock Info - Success",
+				&get_clock_info_succes1_test, NULL,
+				test_command_generic_connect);
+	test_bredrle("Get Clock Info - Fail (Power Off)",
+				&get_clock_info_fail1_test, NULL,
+				test_command_generic);
+
 	test_bredrle("Get Conn Info - Success",
 				&get_conn_info_succes1_test, NULL,
 				test_command_generic_connect);
-- 
2.26.3

