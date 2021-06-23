Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C24E3C49EA5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA8A161289
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Jun 2021 04:49:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhFWEwK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Jun 2021 00:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbhFWEwI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Jun 2021 00:52:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C68C061574
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id c15so497800pls.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Jun 2021 21:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=jU/8LF/OreKqHBJT3ncRfFZ9nHj+jlfRqb827tR0OnU=;
        b=oZL1yQxkMZdseQyBr1Leb8/Ut44cc+DldWhj7HlSgG69oimSzZP3LMvZD6QgagSHTI
         dpKHGl3CLC5O+HAcmXTcnGHpyqPZ+TElLuHgxj1m/HKc+nMsvL6bDQS4GLHqiEKKkaW4
         srrQeuaUo4IKqxB9rxMUa12ARP3DowafkGouYk30k7995FYIVQUGvLrrWMb0B7G2UI0V
         k+lgQP9jw42T2fq6hHA6yQGhL7aFuJ9eNjSUWBTNrzDdP1K9buvCR7H4kLNeeNj42H6B
         KvxIphn6i5738o5mkeDniNkHfNtMIsW6B8KT6hJfq+yA9aBhHAb2l4pJqLTHjoIrxBtF
         SW1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jU/8LF/OreKqHBJT3ncRfFZ9nHj+jlfRqb827tR0OnU=;
        b=MHB61rBKXsjsSngXDjZb38oM8IhoOJYOzA2ChRp232+Y6Vs9mMEJ8c3BJ7jmGd8T5t
         4MlCOiFy4clpucH9C/AInxHyfa4yorFcSxVbt8Sln6DzXamffk5o0OTP4tGHQZSVcA/s
         NJ9PYZne5UzvuI/DCxpVnVqQZt/kzKcAl9cTq/mFjMAUUA73Al1iIFOfPAy6nAsDnA4N
         a2q+1o6iYLU5Te9MKkKdPM5h5nvsyeYQLKALUZk29V7aRAjm0KQFP/kt2nm8JsFQU6ff
         ViGDd4Bp7RoCI9W8h+9b/gBSQueH5VpEhq6I+IYCdhqC1VEc0P/6OqZ2XG+Bfv0gp3QW
         XlZA==
X-Gm-Message-State: AOAM531SX7MMxMTfX7+OsAr+oa0NDIqcD0Ud5hT0XF3xc+4hMNEb0e3Y
        L0eu6/0GJgPOnCcWVaS5xhJl+R8Zojk=
X-Google-Smtp-Source: ABdhPJzEvBukn+bFFFISE0Jb5opOSQqawby0qHYalbsVNMHCRQYHBYK+ULl1GbSZewFmeO//WTWXjQ==
X-Received: by 2002:a17:90a:4d48:: with SMTP id l8mr6571387pjh.120.1624423790195;
        Tue, 22 Jun 2021 21:49:50 -0700 (PDT)
Received: from han1-mobl3.intel.com ([2601:1c0:6a01:d830::512a])
        by smtp.gmail.com with ESMTPSA id c184sm900129pfa.38.2021.06.22.21.49.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 21:49:49 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 5/5] tools/mgmt-tester: Update to support multiple extended adv instances
Date:   Tue, 22 Jun 2021 21:49:44 -0700
Message-Id: <20210623044944.602205-5-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <20210623044944.602205-1-hj.tedd.an@gmail.com>
References: <20210623044944.602205-1-hj.tedd.an@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch updates to align with the multiple extended advertising
support.
---
 tools/mgmt-tester.c | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 8cae376f4..d2ded574e 100644
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
 
@@ -8077,9 +8078,6 @@ static const struct generic_data add_ext_advertising_timeout_expired = {
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
 	.expect_alt_ev_param = advertising_instance1_param,
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
-	.expect_hci_param = set_ext_adv_disable_param,
-	.expect_hci_len = sizeof(set_ext_adv_disable_param),
 };
 
 static const struct generic_data remove_ext_advertising_fail_1 = {
@@ -8120,7 +8118,7 @@ static const struct generic_data remove_ext_advertising_success_2 = {
 };
 
 static const uint8_t set_ext_adv_data_test2[] = {
-	0x01,				/* handle */
+	0x02,				/* handle */
 	0x03,				/* complete data */
 	0x01,				/* controller should not fragment */
 	0x07,				/* adv data len */
@@ -8129,13 +8127,10 @@ static const uint8_t set_ext_adv_data_test2[] = {
 	0x74, 0x65, 0x73, 0x74, 0x32,	/* "test2" */
 };
 
-static const struct generic_data multi_ext_advertising_switch = {
+static const struct generic_data multi_ext_advertising = {
 	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
 	.expect_alt_ev_param = advertising_instance1_param,
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
-	.expect_hci_param = set_ext_adv_data_test2,
-	.expect_hci_len = sizeof(set_ext_adv_data_test2),
 };
 
 static const struct generic_data multi_ext_advertising_add_second = {
@@ -9654,6 +9649,7 @@ static void trigger_device_found(void *user_data)
 
 		bthost_set_adv_enable(bthost, 0x01);
 	} else if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50) {
+		bthost_set_ext_adv_params(bthost);
 		if (test->set_adv)
 			bthost_set_ext_adv_data(bthost, test->adv_data,
 							test->adv_data_len);
@@ -9818,21 +9814,16 @@ static void le_connected_event(uint16_t index, uint16_t length,
 
 	tester_print("Device connected");
 
-	test_add_condition(data);
-
-	if (data->hciemu_type >= HCIEMU_TYPE_BREDRLE50)
-		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
-					BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
-					test_adv_enable_hook, data);
-	else
+	if (data->hciemu_type < HCIEMU_TYPE_BREDRLE50) {
+		test_add_condition(data);
 		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
 					BT_HCI_CMD_LE_SET_ADV_ENABLE,
 					test_adv_enable_hook, data);
+	}
 
 	/* Make sure we get not disconnected during the testaces */
 	mgmt_register(data->mgmt_alt, MGMT_EV_DEVICE_DISCONNECTED,
 				data->mgmt_index, disconnected_event,
-
 				NULL, NULL);
 
 	test_condition_complete(data);
@@ -11067,7 +11058,6 @@ int main(int argc, char *argv[])
 					 &add_advertising_name_data_appear,
 					 setup_command_generic,
 					 test_command_generic);
-
 	test_le_full("Adv. connectable & connected (slave) - Success",
 					&conn_slave_adv_conneactable_test,
 					setup_advertise_while_connected,
@@ -11406,8 +11396,8 @@ int main(int argc, char *argv[])
 	/* When advertising two instances, the instances should be
 	 * advertised in a round-robin fashion.
 	 */
-	test_bredrle50("Multi Ext Advertising - Success 1 (Instance Switch)",
-					&multi_ext_advertising_switch,
+	test_bredrle50("Multi Ext Advertising - Success 1",
+					&multi_ext_advertising,
 					setup_multi_adv,
 					test_command_generic);
 
@@ -11430,7 +11420,7 @@ int main(int argc, char *argv[])
 					NULL, test_command_generic);
 
 	test_bredrle50("Set PHY 1m 2m coded Succcess", &set_phy_all_success,
-                                        NULL, test_command_generic);
+					NULL, test_command_generic);
 
 	test_bredrle50("Set PHY 2m tx success", &set_phy_2m_tx_success,
 					NULL, test_command_generic);
-- 
2.26.3

