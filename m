Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE0AC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 032A661159
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 21:12:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbhKEVPd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 17:15:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbhKEVPc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 17:15:32 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E1F9C061570
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 14:12:52 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s5so9981167pfg.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 14:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=YOw6foaMeZxG38K+pATPyi0RjjRyGzjcJJWw5ABs3ks=;
        b=BjFWwcU9HYVvpQRh1iYV/XL+/F54AmSD8DGjBPB+t/U8G9DH+tLIDqERgDFOhG4Qft
         IMN3h7CSPatcp2unw3slk9ReUeA8zf25uSdPDMSxDPmY9ymb4B5Apy/ZdBu7fz3f+Sta
         gI1dmAAwpa5XJVm2O5CNKnMUyNPaET1rJaCeC8fDnAzorMb/LcC3FRaN/+9LTaZc4YiN
         fhG8BFO2Pe7uY38BlNl9Yg4r+k4e8D05MdThjvh4tAu41CrjlMSW+eQZbOb1GzWJrhzY
         ovoSvg7d2CzxNuhpO4AyD/pA65kdY9P9x1bCKubLVungEFcKr7zWLQuvop1VLtCxyUhP
         rqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YOw6foaMeZxG38K+pATPyi0RjjRyGzjcJJWw5ABs3ks=;
        b=PxUlEdUp++ap7VxbB3PWJ9EseI0cgxfQNdZZ675pqKLFcKgiCaNkB9ytwOOu2NAoFP
         la88SYAOuju46m2NnXxhkY1K2y8P7qCwafMzU8KsX9BNw1GulkZ6homTwPpnSDbPNdN3
         3gYf5KqfDFVoBV7uTLPgdKnpdNvBTQCfDlk9N2jncLV0BtKGxtr2PBKxboMcQfFdy4eD
         f3tKSASCkbh15w4vy5RlnpRk5pLv5N2xTSSFZd8bbJ628+l1hbG8Y4ZXFFs4xSygA43c
         IK/63Df1ZjzCk9I1/g3RzeVs5AthePiMJ74//ByWbRm0NhftXLJiLExFHHgxZZv16f5C
         YpjQ==
X-Gm-Message-State: AOAM532ut1yfzW8BUdSrOfIpD3GW/Gnof9AzDKBoYna1D3r9F9Tb37vo
        liSHgpNJRMuQWxpK35xylZExqtiNuvo=
X-Google-Smtp-Source: ABdhPJz9jUe5CM3kcj3MqiOsqbIIijxm69YbhHX+LNXJ0V7hIO7BL+rROA0xdV4zd6neCEXevP3YYg==
X-Received: by 2002:a05:6a00:1311:b0:455:c1f8:4637 with SMTP id j17-20020a056a00131100b00455c1f84637mr61241694pfu.83.1636146771272;
        Fri, 05 Nov 2021 14:12:51 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id om8sm2250553pjb.12.2021.11.05.14.12.50
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 14:12:50 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] mgmt-tester: Add test for Device Privacy Mode flag
Date:   Fri,  5 Nov 2021 14:12:45 -0700
Message-Id: <20211105211245.424024-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211105211245.424024-1-luiz.dentz@gmail.com>
References: <20211105211245.424024-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This tests the use of Set Device Flags to set Device Privacy Mode which
results in the following sequence:

@ MGMT Event: Command Compl.. (0x0001) plen 10  {0x0001}
      Set Device Flags (0x0050) plen 7
        Status: Success (0x00)
        LE Address: BC:9A:78:56:34:12 (OUI BC-9A-78)
< HCI Command: LE Set Exten.. (0x08|0x0042) plen 6
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
= mgmt-tester: Set Device Flags (0x0050): Success (0x00)
= mgmt-tester: Test condition complete, 4 left
= mgmt-tester: New Device Flags Changed event received
= mgmt-tester: Test condition complete, 3 left
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Addre.. (0x08|0x002d) plen 1
        Address resolution: Disabled (0x00)
= mgmt-tester: HCI Command 0x2042 length 6
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Priva.. (0x08|0x004e) plen 8
        Peer Identity address type: Public (0x00)
        Peer Identity address: BC:9A:78:56:34:12 (OUI BC-9A-78)
        Privacy Mode: Use Device Privacy (0x01)
= mgmt-tester: HCI Command 0x202d length 1
= mgmt-tester: Test condition complete, 2 left
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Privacy Mode (0x08|0x004e) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Addre.. (0x08|0x002d) plen 1
        Address resolution: Enabled (0x01)
= mgmt-tester: HCI Command 0x204e length 8
= mgmt-tester: Test condition complete, 1 left
> HCI Event: Command Complete (0x0e) plen 4
      LE Set Address Resolution Enable (0x08|0x002d) ncmd 1
        Status: Success (0x00)
< HCI Command: LE Set Exten.. (0x08|0x0041) plen 8
        Own address type: Random (0x03)
        Filter policy: Ignore not in accept list (0x01)
        PHYs: 0x01
        Entry 0: LE 1M
          Type: Passive (0x00)
          Interval: 60.000 msec (0x0060)
          Window: 30.000 msec (0x0030)
= mgmt-tester: HCI Command 0x202d length 1
= mgmt-tester: Test condition complete, 0 left
---
 tools/mgmt-tester.c | 88 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e9fcb2602..e5319d123 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -10578,6 +10578,63 @@ static const struct generic_data ll_privacy_unpair_2 = {
 	.expect_hci_len = sizeof(add_to_al_client),
 };
 
+static const uint8_t set_device_flags_param_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x02, 0x00, 0x00, 0x00			/* Flags - Device Privacy */
+};
+
+static const uint8_t set_device_flags_rsp[] =  {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01					/* Type - LE Public */
+};
+
+static const uint8_t le_set_priv_mode_param[] = {
+	0x00,					/* Type */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01					/* Privacy Mode */
+};
+
+static const struct hci_cmd_data ll_privacy_set_device_flags_1_hci_list[] = {
+	{
+		.opcode = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+		.param = set_resolv_off_param,
+		.len = sizeof(set_resolv_off_param),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_PRIV_MODE,
+		.param = le_set_priv_mode_param,
+		.len = sizeof(le_set_priv_mode_param),
+	},
+	{
+		.opcode = BT_HCI_CMD_LE_SET_RESOLV_ENABLE,
+		.param = set_resolv_on_param,
+		.len = sizeof(set_resolv_on_param),
+	},
+};
+
+static const uint8_t device_flags_changed_params_1[] = {
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* BDADDR */
+	0x01,					/* Type - LE Public */
+	0x03, 0x00, 0x00, 0x00,			/* Supported Flags */
+	0x02, 0x00, 0x00, 0x00			/* Current Flags */
+};
+
+static const struct generic_data ll_privacy_set_device_flag_1 = {
+	.setup_settings = settings_le_privacy_ll_privacy,
+	.setup_exp_feat_param = set_exp_feat_param_ll_privacy,
+	.send_opcode = MGMT_OP_SET_DEVICE_FLAGS,
+	.send_param = set_device_flags_param_1,
+	.send_len = sizeof(set_device_flags_param_1),
+	.expect_param = set_device_flags_rsp,
+	.expect_len = sizeof(set_device_flags_rsp),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_DEVICE_FLAGS_CHANGED,
+	.expect_alt_ev_param = device_flags_changed_params_1,
+	.expect_alt_ev_len = sizeof(device_flags_changed_params_1),
+	.expect_hci_list = ll_privacy_set_device_flags_1_hci_list,
+};
+
 static void setup_load_irks_callback(uint8_t status, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -11085,6 +11142,27 @@ static void setup_ll_privacy_add_adv(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_ll_privacy_add_device(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned char param[] = { 0x01 };
+
+	mgmt_send(data->mgmt, MGMT_OP_LOAD_IRKS, data->mgmt_index,
+					sizeof(load_irks_le_public_param_1),
+					load_irks_le_public_param_1,
+					setup_load_irks_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
+					sizeof(param), param,
+					setup_powered_callback, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_ADD_DEVICE, data->mgmt_index,
+					sizeof(add_device_le_public_param_1),
+					add_device_le_public_param_1,
+					setup_add_device_callback, NULL, NULL);
+
+}
+
 static bool power_off(uint16_t index)
 {
 	int sk, err;
@@ -14406,5 +14484,15 @@ int main(int argc, char *argv[])
 				NULL,
 				test_ll_privacy_unpair_2, 5);
 
+	/* LL Privacy
+	 * Setup: Enable LL Privacy, add IRK of new device, Add Device
+	 * Run: Set Device Flags
+	 * Expect: Device Privacy Mode is set.
+	 */
+	test_bredrle50("LL Privacy - Set Device Flag 1 (Device Privacy)",
+				&ll_privacy_set_device_flag_1,
+				setup_ll_privacy_add_device,
+				test_command_generic);
+
 	return tester_run();
 }
-- 
2.31.1

