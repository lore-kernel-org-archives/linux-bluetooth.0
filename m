Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE43312DDBF
	for <linux-bluetooth@vger.kernel.org>; Tue,  6 Feb 2024 11:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707218593; cv=none; b=VW1GaJNBArYkEkOFWQseamtrKibH9G43DF81Kfgj7feq7NFakZC+ei98ddRaNpmSJKs1N+01amdZbNcx0aKV8Xa9lzaAxACkwlR/qs13i27KVLLP7wlgA4lJ9nXVaGzV0qrQKIK7mYTYueGqgWetOmRSKQ5DSiMNFsx3QRLcWLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707218593; c=relaxed/simple;
	bh=6rFVdGR+WN09ktXqbKSf6W23yNl7aba+/4WTYm61AyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j0gLcqVVDlAu0Tyl/uVNUlUCBLTk9Qu6aYZUy0oWIITmP2hAvBPYhk7uu7ukxAnOfj+oBOspJp9ingHCXuu43Gt9wlmZMrm630gkGBto6Dk4bl219xW8ewPYfdkxCOvkraDfz8pmkUX96fvs/Gyjw4x4AfNwQg28HAs6X1QmjJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4TTgpg5sS8z9t4P;
	Tue,  6 Feb 2024 12:23:07 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ v2 1/4] mgmt-tester: Add a 0-entry to expect_hci_list lists
Date: Tue,  6 Feb 2024 12:22:50 +0100
Message-ID: <20240206112253.76446-2-verdre@v0yd.nl>
In-Reply-To: <20240206112253.76446-1-verdre@v0yd.nl>
References: <20240206112253.76446-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TTgpg5sS8z9t4P

In add_expect_hci_list() we iterate through the entries of the
expect_hci_list as long as there is an opcode, which means currently
this relies on overflowing the buffer to detect the end of the list.

This is not great and when running with address sanitizer, the
out-of-bounds read gets detected and mgmt-tester aborts. Fix it by
adding a trailing zero-entry to all those lists.
---
 tools/mgmt-tester.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7dfd1b0c7..7d884bbf6 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8798,6 +8798,7 @@ static const struct hci_cmd_data multi_ext_adv_add_second_hci_cmds[] = {
 		.len = sizeof(le_set_ext_adv_enable_inst_2),
 		.param = le_set_ext_adv_enable_inst_2,
 	},
+	{},
 };
 
 static const struct generic_data multi_ext_advertising_add_second_2 = {
@@ -8845,6 +8846,7 @@ static const struct hci_cmd_data multi_ext_adv_remove_adv_hci_cmds[] = {
 		.len = sizeof(advertising_instance1_param),
 		.param = advertising_instance1_param,
 	},
+	{},
 };
 
 static const struct generic_data multi_ext_advertising_remove = {
@@ -8877,6 +8879,7 @@ static const struct hci_cmd_data multi_ext_adv_remove_all_adv_hci_cmds[] = {
 	{
 		.opcode = BT_HCI_CMD_LE_CLEAR_ADV_SETS,
 	},
+	{},
 };
 
 static const struct generic_data multi_ext_advertising_remove_all = {
@@ -8913,6 +8916,7 @@ static const struct hci_cmd_data multi_ext_adv_add_2_advs_hci_cmds[] = {
 		.len = sizeof(set_ext_adv_data_test1),
 		.param = set_ext_adv_data_test1,
 	},
+	{},
 };
 
 static const struct generic_data multi_ext_advertising_add_no_power = {
@@ -10378,6 +10382,7 @@ static const struct hci_cmd_data ll_privacy_add_device_3_hci_list[] = {
 		.param = set_resolv_on_param,
 		.len = sizeof(set_resolv_on_param),
 	},
+	{},
 };
 
 static const struct generic_data ll_privacy_add_device_3 = {
@@ -10495,6 +10500,7 @@ static const struct hci_cmd_data ll_privacy_add_device_9_hci_list[] = {
 		.len = sizeof(le_add_to_resolv_list_param),
 		.param = le_add_to_resolv_list_param
 	},
+	{},
 };
 
 static const struct generic_data ll_privacy_add_device_9 = {
@@ -10823,6 +10829,7 @@ static const struct hci_cmd_data ll_privacy_set_device_flags_1_hci_list[] = {
 		.param = set_resolv_on_param,
 		.len = sizeof(set_resolv_on_param),
 	},
+	{},
 };
 
 static const uint8_t device_flags_changed_params_1[] = {
-- 
2.43.0

