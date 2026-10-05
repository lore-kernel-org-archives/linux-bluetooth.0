Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC3A4C224C
	for <linux-bluetooth@vger.kernel.org>; Mon,  5 Oct 2026 15:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213685; cv=none; b=IhVSDWlOFeCIwCDnwXXM67wGqF82/T/L2K+x8Q44rz1FzftMpwXvGAjHZgCoIQ34WU9N7p/9Orqp4FMK6/IUKno3l52KmKw+rmoA0boL8uHnT3D6lW4LWMmRQa0NfS9XJTC/aEvrflKBbsuqnpiin6srKcbKJYnWxgGHEdGtQf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213685; c=relaxed/simple;
	bh=0VMMZRRT00IBMye8zluzXhcrpspOuFUlIt05aFCR8PU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SITS5gWh8pc7FVwvRm6qmJDoHhEyFFPQkjSmhXr2p75+S5uPQgh+8B6cY0NMKS8Y3zgLRKhgCVY8fFQl3TyuEQtuAMHEigOfBroiXnSz3WKndmIj10yb/XJt4+iyl9IA4nETDEcCQn3ZLRHUDsaLgyHD4qkXguH69W0/dikft3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d18KkPXg; arc=none smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d18KkPXg"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-988ce00f22dso374408241.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Oct 2026 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791213683; x=1791818483; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=orLrw4lY8RE62lw2sstaSiR/11rn4SPCdtRxj6KHyOU=;
        b=d18KkPXgfSSrA/c6WEVh54l3KU3HQclLyGRwuVeMJ8/sWh1TfBg1y1JQtP9n5v2iwq
         bBPPETeambPPvT6EXUX4bE10qHmVMDDzeiQJ9f14r21+bPJ8UTR5Lg7cL2ieqOvkjeQQ
         rP7gEOIgZnmqCLAEODSWlOPdqYSVRVDwEpi9LBqSM0aq/WoMmgUcI2SvVwaLJRXNrtaN
         a5SAYs/xLYz3Uz7Sv87FspAsAlJDTPKTpdzzowObWbP9YgP8hc4DI24Foq+DgbiQCep7
         0dNasdZkFZ86DZQiEwBzlZtjdGkkM4sBeA52XIIYYfaQBjCjTZ3gAX3CYSPC6D8TwGnI
         iAPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791213683; x=1791818483;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=orLrw4lY8RE62lw2sstaSiR/11rn4SPCdtRxj6KHyOU=;
        b=u21F7Kmy/W66hRzLF4k/G1hylC7mipgL/uBW0oIdNf71nIRqC4UioIjgimiS0nadRF
         bFPex1qDng0w5DFyCoiTrSgQPNlvnxr4HlZD66zt4cg9FeAUraYfjrD+F79co59B3AH6
         N3kmDeJoffPql6tObg7l5b3tE4dMAp8pf9Vg5RP/gjP0XwY2HJNoWElyaLmqy8HGqppA
         JvVCub3A8M9DRRs7yPYCJAWSpQjgE7qm9Uz2OifduzIJksrNtbcDSMOr9ST92ft0SiHI
         eJn4JWy0wPTskdWBR3UNHe1HuqIkMMzBl5vk6xNbJNfO42YyX6Kftrl1YO0GBxiB33WE
         OJkg==
X-Gm-Message-State: AFq9FYIGYR0vbVoDUfoi9B2xWm2q232GOrYwSgveivF6faSY2SLjHnPE
	v8/MurvTQ5OFawQ/NE/oNZyhfHJ0EtXPTg5wpT+54xgXaySUmptQHvWGpO8BGgbv
X-Gm-Gg: AYBFou11bHzLqJ+psNPx8YO0TeJgFAJYtbXmwaBwQx30GCJB/H4muycuTM3aBjkaky3
	XdBfHp8CN3FDWx9LqsUtb0TXo3ypJ8+cPo3zSvykk/dSqcg0JGPjL96tm8qNvZ3aHtuvBzjQo2l
	qlXq1iFmqPNalquRVsxO9fp65kZiDqRk5v29B9qGzjq9LhwHUvfXG3T3sb0gwXonrhcynHmhsXs
	WMk7WMt2ko2WBeSVUpPMmZFcRj1ABaw4KVPLsA/axLw9QVzyClXgL912KZ4+qexG74OGXhqEOQU
	Ydr9mlvLmfBFzkSZEGyHEmUznUQHPvaZxL7YRoC2WU60i13LrQ39WcboWdaI1Qt34Lf5WeUZb6+
	iWhCUQy44erGIgdwyf7K4IiFCOOgIH3fu9qwUDLShl7Y2747Ln3IKolaMT1dDkzOhnkw/qVArHc
	j8eAe0DYUqLSdD8qKnTshNx8Tzc6ySjaoI8wTKS5mcHk/Z3QBdf3qpj8pEA/j2xJsHeEywJdSpV
	EC/p7GjlrKYmhQeW73LGCzhaQzNXHlLn/ZXW9BmjOY60AvRR5K23z0Sl2IB3ty+IQQ/FQ/aoO0=
X-Received: by 2002:a05:6123:2ea:b0:5c9:c60a:e9b2 with SMTP id 71dfb90a1353d-5dab2f853d0mr3107557e0c.18.1791213682720;
        Mon, 05 Oct 2026 08:21:22 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5da62d10534sm14429707e0c.13.2026.10.05.08.21.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2026 08:21:22 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 2/2] mgmt-tester: Add Global Advertising tests for extended advertising
Date: Mon,  5 Oct 2026 11:21:11 -0400
Message-ID: <20261005152111.3419786-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005152111.3419786-1-luiz.dentz@gmail.com>
References: <20261005152111.3419786-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With extended advertising, instances are advertised concurrently with
Global Advertising, so update "Set Adv off override" to expect only
the set of instance 0 to be disabled, and add tests checking that
adding an instance enables it and that removing the last instance does
not disable Global Advertising.

Assisted-by: OpenCode:claude-opus-5.5
---
 tools/mgmt-tester.c | 110 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 3 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d8e3c413f8c9..75a1431fdf19 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8656,6 +8656,18 @@ static const struct generic_data add_ext_advertising_success_4 = {
 	.expect_hci_len = sizeof(set_ext_adv_data_txpwr),
 };
 
+static const char set_ext_adv_disable_param_0[] = {
+	0x00,		/* Disable */
+	0x01,		/* No of sets */
+	0x00,		/* Handle */
+	0x00, 0x00,	/* Duration */
+	0x00,		/* Max events */
+};
+
+/* With extended advertising instance 1 is already advertising alongside
+ * Global Advertising (instance 0), so disabling it shall only disable the
+ * advertising set used by instance 0.
+ */
 static const struct generic_data add_ext_advertising_success_5 = {
 	.send_opcode = MGMT_OP_SET_ADVERTISING,
 	.send_param = set_adv_off_param,
@@ -8663,9 +8675,61 @@ static const struct generic_data add_ext_advertising_success_5 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = set_powered_ext_adv_instance_settings_param,
 	.expect_len = sizeof(set_powered_ext_adv_instance_settings_param),
-	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_DATA,
-	.expect_hci_param = set_ext_adv_data_test1,
-	.expect_hci_len = sizeof(set_ext_adv_data_test1),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_disable_param_0,
+	.expect_hci_len = sizeof(set_ext_adv_disable_param_0),
+};
+
+static uint16_t settings_powered_le_advertising[] = { MGMT_OP_SET_LE,
+					MGMT_OP_SET_ADVERTISING,
+					MGMT_OP_SET_POWERED, 0 };
+
+/* Instances not sharing the advertising set of Global Advertising
+ * (instance 0) shall be advertised right away.
+ */
+static const struct generic_data add_ext_advertising_global_adv = {
+	.setup_settings = settings_powered_le_advertising,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_on_set_adv_enable_param,
+	.expect_hci_len = sizeof(set_ext_adv_on_set_adv_enable_param),
+};
+
+static const struct generic_data adv_data_global_adv = {
+	.setup_settings = settings_powered_le_advertising,
+	.send_opcode = MGMT_OP_ADD_EXT_ADV_DATA,
+	.send_param = ext_adv_data_valid,
+	.send_len = sizeof(ext_adv_data_valid),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = ext_adv_data_mgmt_rsp_valid,
+	.expect_len = sizeof(ext_adv_data_mgmt_rsp_valid),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+	.expect_hci_param = set_ext_adv_on_set_adv_enable_param,
+	.expect_hci_len = sizeof(set_ext_adv_on_set_adv_enable_param),
+};
+
+/* Removing the last instance shall not disable Global Advertising */
+static const struct generic_data remove_ext_advertising_global_adv = {
+	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
+	.send_param = remove_advertising_param_1,
+	.send_len = sizeof(remove_advertising_param_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = remove_advertising_param_1,
+	.expect_len = sizeof(remove_advertising_param_1),
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_REMOVE_ADV_SET,
+	.expect_hci_param = advertising_instance1_param,
+	.expect_hci_len = sizeof(advertising_instance1_param),
 };
 
 static const struct generic_data add_ext_advertising_success_6 = {
@@ -12071,6 +12135,32 @@ static void test_command_generic(const void *test_data)
 	test_add_condition(data);
 }
 
+static void global_adv_disable_hci_callback(uint16_t opcode,
+					const void *param, uint8_t length,
+					void *user_data)
+{
+	const uint8_t *cp = param;
+
+	if (opcode != BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE || length < 2)
+		return;
+
+	/* Fail if all sets, including Global Advertising, are disabled */
+	if (!cp[0] && !cp[1]) {
+		tester_warn("Global Advertising disabled");
+		tester_test_failed();
+	}
+}
+
+static void test_command_global_adv(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+
+	hciemu_add_central_post_command_hook(data->hciemu,
+					global_adv_disable_hci_callback, data);
+
+	test_command_generic(test_data);
+}
+
 static void setup_set_static_addr_success_2(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -14627,6 +14717,10 @@ int main(int argc, char *argv[])
 					setup_set_and_add_advertising,
 					test_command_generic);
 
+	test_bredrle50("Add Ext Advertising - Success (Global Adv)",
+					&add_ext_advertising_global_adv,
+					NULL, test_command_generic);
+
 	test_bredrle50("Add Ext Advertising - Success 6 (Scan Rsp Dta, Adv ok)",
 					&add_ext_advertising_success_6,
 					NULL, test_command_generic);
@@ -14807,6 +14901,11 @@ int main(int argc, char *argv[])
 						setup_add_advertising,
 						test_command_generic);
 
+	test_bredrle50("Remove Ext Advertising - Success (Global Adv)",
+					&remove_ext_advertising_global_adv,
+					setup_set_and_add_advertising,
+					test_command_global_adv);
+
 	/* When advertising two instances, the instances should be
 	 * advertised in a round-robin fashion.
 	 */
@@ -14989,6 +15088,11 @@ int main(int argc, char *argv[])
 				setup_ext_adv_params,
 				test_command_generic);
 
+	test_bredrle50("Ext Adv MGMT - AD Data (5.0) Success (Global Adv)",
+				&adv_data_global_adv,
+				setup_ext_adv_params,
+				test_command_generic);
+
 	test_bredrle50("Ext Adv MGMT - AD Scan Response (5.0) Success",
 				&adv_scan_rsp_success,
 				setup_ext_adv_params,
-- 
2.55.0

