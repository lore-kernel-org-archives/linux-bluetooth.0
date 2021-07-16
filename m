Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7273FC636CA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 19:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54E4A610D1
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Jul 2021 19:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbhGPTmg (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Jul 2021 15:42:36 -0400
Received: from mga05.intel.com ([192.55.52.43]:58159 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233089AbhGPTmd (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Jul 2021 15:42:33 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10047"; a="296425607"
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="296425607"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 12:39:37 -0700
X-IronPort-AV: E=Sophos;i="5.84,245,1620716400"; 
   d="scan'208";a="431316671"
Received: from landruma-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.217.108])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jul 2021 12:39:37 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org, hj.tedd.an@gmail.com,
        brian.gix@intel.com
Subject: [PATCH BlueZ v2 2/3] tool/mgmt-tester: Add test cases for Read Clock Information API
Date:   Fri, 16 Jul 2021 12:39:31 -0700
Message-Id: <20210716193932.2939264-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210716193932.2939264-1-brian.gix@intel.com>
References: <20210716193932.2939264-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch adds test cases for Read Clock Information management API.
---
 tools/mgmt-tester.c | 71 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d2ded574e..bd581874e 100644
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
 
+	test_bredrle("Get Clock Info - Success",
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
2.31.1

