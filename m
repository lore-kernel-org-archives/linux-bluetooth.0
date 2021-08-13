Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.2 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F859C4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3885C610A4
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 Aug 2021 12:21:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240446AbhHMMVs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 Aug 2021 08:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240449AbhHMMVq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 Aug 2021 08:21:46 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC25C0617AE
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:19 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id w13-20020a17090a8a0d00b00179486bdfe9so702469pjn.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Aug 2021 05:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x2iqq46sI5isY1ui4xMROkakG4OluQ0GLwjzevnswfo=;
        b=hY46A3Eb/z2StqtEamiPRhsMrnaLmd0Rh8Amgp+LlXoaj/UBds3oWAzbC4PTqCZ10e
         b1mtvgpr8t80Me1BIyItfvkyQO5J18BeKCDzEqsu47lY5wQPRpkDGm8ap+x2IIKH9jaE
         u09Tc/agnyJDt8QsB3xrMd/XYh2GhaBZkhOGVfOsltgltPVZNBR7Hrue2xy5PuPgArSr
         R4SJjzV7VxOIguCWaOT+Tal3omXVtoZrd0yLaDByF71SxEn9/CrzG/Z+VakmX3xZc+DB
         UXEtMPuYvSPH0Gr5ahpR76925JS3de5UuwZrgSAM6CYcbi3P0R7/iWMy0d+fl13v1eiB
         al8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x2iqq46sI5isY1ui4xMROkakG4OluQ0GLwjzevnswfo=;
        b=de8zh4GnR/drBMf0FArddDq64I6bcca42sYk2clk3unIX1YqhCya0PIxyym0tW2NgA
         xCyRHCjX7wHZbZ98m6OqTh2julV0ZmIabnL+dZoyEX8OLFU5pNBQnsSs9DUFM48JWE6p
         WaXWNQhjJI9rvRwiNm4k6wfhCTXvnGUH/eRftnbXH2Et0GOLjuaV2ie/8Wl9sdE3lLFr
         EJN43EHtuvP2IH9o9AJzELYVvMoPuyxrW0C0HsL6Sgn29s5AyuOfQZjDsmG2gSjLh9JC
         mvp43e5ctCIO4Ttsc5kZXXQ3spevI/C96w1ftkylH6Je2+jX8nAAyuUue4V1ycaTxKcP
         7XTQ==
X-Gm-Message-State: AOAM5317KIiCOHKs8SeZGOU5m001R4BiA39LiXBMK6OPtV1RWqPsKHYp
        OS1BysGV3itAqGfPh4GniXIuLbOO0WXlUjEY8+2y+LzUsMDN5s6dSDnXOqazTPLYJ8IB7KuRVne
        I7gmgtsbkVeoYAuBlpWTyAj6IIMAFqb00jSnaC2xnQoNn6Aqv3W7oHYIOW9RlKSFxW7l836cZeG
        K+
X-Google-Smtp-Source: ABdhPJxo5OFPSslaAazQ6uFSE+7CjV74XOXXijzeo2he7QaVu5NNxEBZ52txdtdodkHPpbN68Dj+sSTb2zhJ
X-Received: from apusaka-p920.tpe.corp.google.com ([2401:fa00:1:10:b68c:ff41:db76:21e9])
 (user=apusaka job=sendgmr) by 2002:a17:903:2301:b029:12c:b19a:9d40 with SMTP
 id d1-20020a1709032301b029012cb19a9d40mr1952868plh.33.1628857278815; Fri, 13
 Aug 2021 05:21:18 -0700 (PDT)
Date:   Fri, 13 Aug 2021 20:18:13 +0800
In-Reply-To: <20210813121848.3686029-1-apusaka@google.com>
Message-Id: <20210813201256.Bluez.28.I188456b533753f56c46362ab5268053090cb26f0@changeid>
Mime-Version: 1.0
References: <20210813121848.3686029-1-apusaka@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [Bluez PATCH 28/62] tools/mgmt-tester: Inclusive language changes
From:   Archie Pusaka <apusaka@google.com>
To:     linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     CrosBT Upstreaming <chromeos-bluetooth-upstreaming@chromium.org>,
        Archie Pusaka <apusaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Archie Pusaka <apusaka@chromium.org>

"central", "peripheral", and "accept list" are the preferred terms,
as reflected in the BT core spec 5.3.
---

 tools/mgmt-tester.c | 87 +++++++++++++++++++++++----------------------
 1 file changed, 44 insertions(+), 43 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 04c4393a09..7f067cfbc5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2698,20 +2698,20 @@ static const char load_ltks_invalid_param_2[] = {
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
 	0x00,						/* addr type */
 	0x00,						/* authenticated */
-	0x00,						/* master */
+	0x00,						/* central */
 	0x00,						/* encryption size */
 	0x00, 0x00,					/* diversifier */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (1/2) */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* value (2/2) */
 };
-/* Invalid master value */
+/* Invalid central value */
 static const char load_ltks_invalid_param_3[] = {
 	0x01, 0x00,					/* count */
 	0x00, 0x01, 0x02, 0x03, 0x04, 0x05,		/* bdaddr */
 	0x01,						/* addr type */
 	0x00,						/* authenticated */
-	0x02,						/* master */
+	0x02,						/* central */
 	0x00,						/* encryption size */
 	0x00, 0x00,					/* diversifier */
 	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* rand */
@@ -4233,7 +4233,7 @@ static const uint8_t add_device_success_param_6[] = {
 					0x02,
 };
 
-static const uint8_t le_add_to_white_list_param[] = {
+static const uint8_t le_add_to_accept_list_param[] = {
 	0x00,					/* Type */
 	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* Address */
 };
@@ -4249,8 +4249,8 @@ static const struct generic_data add_device_success_6 = {
 	.expect_alt_ev_param = add_device_success_param_6,
 	.expect_alt_ev_len = sizeof(add_device_success_param_6),
 	.expect_hci_command = BT_HCI_CMD_LE_ADD_TO_ACCEPT_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
 };
 
 static const uint8_t le_add_to_resolv_list_param[] = {
@@ -4419,8 +4419,8 @@ static const struct generic_data remove_device_success_7 = {
 	.expect_len = sizeof(remove_device_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_ACCEPT_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
 	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
 	.expect_alt_ev_param = remove_device_param_2,
 	.expect_alt_ev_len = sizeof(remove_device_param_2),
@@ -4434,8 +4434,8 @@ static const struct generic_data remove_device_success_8 = {
 	.expect_len = sizeof(remove_device_param_2),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_FROM_RESOLV_LIST,
-	.expect_hci_param = le_add_to_white_list_param,
-	.expect_hci_len = sizeof(le_add_to_white_list_param),
+	.expect_hci_param = le_add_to_accept_list_param,
+	.expect_hci_len = sizeof(le_add_to_accept_list_param),
 	.expect_alt_ev = MGMT_EV_DEVICE_REMOVED,
 	.expect_alt_ev_param = remove_device_param_2,
 	.expect_alt_ev_len = sizeof(remove_device_param_2),
@@ -5336,40 +5336,40 @@ static const struct generic_data read_local_oob_success_sc_test = {
 	.expect_hci_command = BT_HCI_CMD_READ_LOCAL_OOB_EXT_DATA,
 };
 
-static const uint8_t le_states_conn_slave_adv_connectable[] = {
+static const uint8_t le_states_conn_peripheral_adv_connectable[] = {
 			0x00, 0x00, 0x20, 0x00, 0x40, 0x00, 0x00, 0x00};
-static const uint8_t le_states_conn_slave_adv_non_connectable[] = {
+static const uint8_t le_states_conn_peripheral_adv_non_connectable[] = {
 			0x00, 0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00};
-static const uint8_t le_states_conn_master_adv_connectable[] = {
+static const uint8_t le_states_conn_central_adv_connectable[] = {
 			0x00, 0x00, 0x08, 0x00, 0x08, 0x00, 0x00, 0x00};
-static const uint8_t le_states_conn_master_adv_non_connectable[] = {
+static const uint8_t le_states_conn_central_adv_non_connectable[] = {
 			0x00, 0x00, 0x02, 0x00, 0x00, 0x00, 0x00, 0x00};
 
-static const struct generic_data conn_slave_adv_conneactable_test = {
+static const struct generic_data conn_peripheral_adv_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_slave_adv_connectable,
+	.le_states = le_states_conn_peripheral_adv_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true
 };
 
-static const struct generic_data conn_slave_adv_non_conneactable_test = {
+static const struct generic_data conn_peripheral_adv_non_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_slave_adv_non_connectable,
+	.le_states = le_states_conn_peripheral_adv_non_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true
 };
 
-static const struct generic_data conn_master_adv_conneactable_test = {
+static const struct generic_data conn_central_adv_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_master_adv_connectable,
+	.le_states = le_states_conn_central_adv_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true,
 	.client_enable_adv = 1
 };
 
-static const struct generic_data conn_master_adv_non_conneactable_test = {
+static const struct generic_data conn_central_adv_non_connectable_test = {
 	.setup_le_states = true,
-	.le_states = le_states_conn_master_adv_non_connectable,
+	.le_states = le_states_conn_central_adv_non_connectable,
 	.setup_settings = settings_powered_le,
 	.client_enable_le = true,
 	.client_enable_adv = 1
@@ -10874,9 +10874,9 @@ int main(int argc, char *argv[])
 				&add_device_success_5,
 				NULL, test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
-	 * Add device and check the device is added to the whitelist
+	 * Add device and check the device is added to the accept list
 	 */
-	test_bredrle50("Add Device - Success 6 - Add to whitelist",
+	test_bredrle50("Add Device - Success 6 - Add to accept list",
 				&add_device_success_6,
 				NULL, test_command_generic);
 	/* MGMT_OP_ADD_DEVICE
@@ -10928,7 +10928,7 @@ int main(int argc, char *argv[])
 	 * Remove the device and check the device is removed from the whilte
 	 * list as well.
 	 */
-	test_bredrle50("Remove Device - Success 7 - Remove from whitelist",
+	test_bredrle50("Remove Device - Success 7 - Remove from accept list",
 				&remove_device_success_7,
 				setup_ll_privacy_device2, test_command_generic);
 	/* MGMT_OP_REMOVE_DEVICE
@@ -11135,23 +11135,24 @@ int main(int argc, char *argv[])
 					 &add_advertising_name_data_appear,
 					 setup_command_generic,
 					 test_command_generic);
-	test_le_full("Adv. connectable & connected (slave) - Success",
-					&conn_slave_adv_conneactable_test,
-					setup_advertise_while_connected,
-					test_connected_and_advertising, 10);
 
-	test_le_full("Adv. non-connectable & connected (slave) - Success",
-					&conn_slave_adv_non_conneactable_test,
+	test_le_full("Adv. connectable & connected (peripheral) - Success",
+					&conn_peripheral_adv_connectable_test,
 					setup_advertise_while_connected,
 					test_connected_and_advertising, 10);
 
-	test_le_full("Adv. connectable & connected (master) - Success",
-					&conn_master_adv_conneactable_test,
+	test_le_full("Adv. non-connectable & connected (peripheral) - Success",
+				&conn_peripheral_adv_non_connectable_test,
+				setup_advertise_while_connected,
+				test_connected_and_advertising, 10);
+
+	test_le_full("Adv. connectable & connected (central) - Success",
+					&conn_central_adv_connectable_test,
 					setup_advertise_while_connected,
 					test_connected_and_advertising, 10);
 
-	test_le_full("Adv. non-connectable & connected (master) - Success",
-					&conn_master_adv_non_conneactable_test,
+	test_le_full("Adv. non-connectable & connected (central) - Success",
+					&conn_central_adv_non_connectable_test,
 					setup_advertise_while_connected,
 					test_connected_and_advertising, 10);
 
@@ -11547,23 +11548,23 @@ int main(int argc, char *argv[])
 				&device_found_invalid_field,
 				NULL, test_device_found);
 
-	test_bredrle50_full("Ext Adv. connectable & connected (slave) - Success",
-				&conn_slave_adv_conneactable_test,
+	test_bredrle50_full("Ext Adv. connectable & connected (peripheral) - Success",
+				&conn_peripheral_adv_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. non-connectable & connected (slave) - Success",
-				&conn_slave_adv_non_conneactable_test,
+	test_bredrle50_full("Ext Adv. non-connectable & connected (peripheral) - Success",
+				&conn_peripheral_adv_non_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. connectable & connected (master) - Success",
-				&conn_master_adv_conneactable_test,
+	test_bredrle50_full("Ext Adv. connectable & connected (central) - Success",
+				&conn_central_adv_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-	test_bredrle50_full("Ext Adv. non-connectable & connected (master) - Success",
-				&conn_master_adv_non_conneactable_test,
+	test_bredrle50_full("Ext Adv. non-connectable & connected (central) - Success",
+				&conn_central_adv_non_connectable_test,
 				setup_advertise_while_connected,
 				test_connected_and_advertising, 10);
 
-- 
2.33.0.rc1.237.g0d66db33f3-goog

