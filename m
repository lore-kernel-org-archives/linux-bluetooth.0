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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B5DC4743C
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3310161350
	for <linux-bluetooth@archiver.kernel.org>; Tue, 22 Jun 2021 01:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFVBDv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 21 Jun 2021 21:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhFVBDu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 21 Jun 2021 21:03:50 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA405C061574
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:35 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id e22so9518574pgv.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Jun 2021 18:01:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uds3L49so16zNtVQwJGRT7zPx25Ama56a91u3XmbS1Y=;
        b=tzlslYtW+KyeSc+v0r5kC4SXyz0Z5UNVE4yzov2tWs09wK6u5t1btePWhi2j+01AzY
         tCNMkcjrr15phA8uZmsFypvAzYsNc5ETFPB1ivZg4Q/MVYdZZzTNGDXull3+CvOEveTk
         eYpAMeK7NK6IH9zrTm0O4dpn5Mperr8MKb9xswxt2tJpnRUPpZe//i0N/yRAoUH602mm
         jTrLo3zhjqpKldcQRQxfVfOfsSsfrjOweZpfIXWGNGfvJowojUiVKAS9D7KenRfnHjcW
         U2IZKDW4fyKKB84t4ZQUwOHXcahy1WIBgBf/IPsRTz0mTBVo58wuk/k7JMEKCez9XhLj
         JHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uds3L49so16zNtVQwJGRT7zPx25Ama56a91u3XmbS1Y=;
        b=hi97uGHGKzIaoN3KNPQuwarMkDPIbHrJHJGxCh3+uBy6r6G77U3vTVyCvmqgtsGd/H
         wgXT9cvfKlvZaXRiDCefDP/WJHVbj4Y8qiI4hvH33kh26hMZOfCV2QB3752N7o85oKyA
         Kty6E8PgHrtnWrmadYSY8o5zboeLR+P+wzgaoXQu7vEvWSGLOUhILqe5gIT9AYnGlLlV
         VBXQl6dtSv3TOsl/tLndU0xYhii5Mb1gU1Qr/qLjRCdtxiE2XVGJRm0E39onzbwcCUkZ
         Lr+JylaVREPZDiA3e3WlFJHXmdeHC3w6f3gsalFnJReQD75vf+MOm8/64us25eB6Gk87
         Y6Rg==
X-Gm-Message-State: AOAM532TWrBH6afVqmdcVY3SXPFqqP/CdTAPeTJm1xyWEH3KQIiWsKHR
        CTQRx+Egp0d95TNmxlBXQiiHzEF0dDc=
X-Google-Smtp-Source: ABdhPJz55Yol1PMkeNhPh4rt3v5mwuTAAvENUTe6cjyV1Ar5DkwLTK6GHei3DsR4p66guor7+80rlg==
X-Received: by 2002:a05:6a00:1629:b029:2ef:f4de:244f with SMTP id e9-20020a056a001629b02902eff4de244fmr980804pfc.6.1624323695316;
        Mon, 21 Jun 2021 18:01:35 -0700 (PDT)
Received: from han1-mobl3.hsd1.or.comcast.net ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id f28sm17970120pgb.12.2021.06.21.18.01.34
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 18:01:34 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH 5/5] tools/mgmt-tester: Update to support multiple extended adv instances
Date:   Mon, 21 Jun 2021 18:01:31 -0700
Message-Id: <20210622010131.427059-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210622010131.427059-1-hj.tedd.an@gmail.com>
References: <20210622010131.427059-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates to align with the multiple extended advertising
support.
---
 tools/mgmt-tester.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8cae376f4..aacabcbd3 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5871,9 +5871,10 @@ static void setup_bthost(void)
 
 	if (data->hciemu_type == HCIEMU_TYPE_LE ||
 		test->client_enable_adv) {
-		if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
+		if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
+			bthost_set_ext_adv_params(bthost);
 			bthost_set_ext_adv_enable(bthost, 0x01);
-		else
+		} else
 			bthost_set_adv_enable(bthost, 0x01);
 	} else
 		bthost_write_scan_enable(bthost, 0x03);
@@ -7554,7 +7555,7 @@ static const uint8_t read_adv_features_rsp_3[] =  {
 	0xff, 0xff, 0x01, 0x00,	/* supported flags */
 	0x1f,			/* max_adv_data_len */
 	0x1f,			/* max_scan_rsp_len */
-	0x01,			/* max_instances */
+	0x03,			/* max_instances */
 	0x00,			/* num_instances */
 };
 
@@ -8120,7 +8121,7 @@ static const struct generic_data remove_ext_advertising_success_2 = {
 };
 
 static const uint8_t set_ext_adv_data_test2[] = {
-	0x01,				/* handle */
+	0x02,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x07,				/* adv data len */
@@ -9654,6 +9655,7 @@ static void trigger_device_found(void *user_data)
 
 		bthost_set_adv_enable(bthost, 0x01);
 	} else if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
+		bthost_set_ext_adv_params(bthost);
 		if (test->set_adv)
 			bthost_set_ext_adv_data(bthost, test->adv_data,
 							test->adv_data_len);
@@ -11067,7 +11069,6 @@ int main(int argc, char *argv[])
 					 &add_advertising_name_data_appear,
 					 setup_command_generic,
 					 test_command_generic);
-
 	test_le_full("Adv. connectable & connected (slave) - Success",
 					&conn_slave_adv_conneactable_test,
 					setup_advertise_while_connected,
-- 
2.26.3

