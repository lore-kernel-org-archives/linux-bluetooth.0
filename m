Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A144D60871
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jan 2024 11:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706528959; cv=none; b=SLsfbm//sOmn7yFqcj16KcJkS6ULxQhfipJXjn6RHwuX9VDa4olyWmYNEw861cw+p5jyAIFxQfUDw2LGrio/qPfp7PcosMWtXJjUhHKCWCXYZiKZgOWCJt0vFK1fTe7EqeEohcC12XKWo2rC18RpbYR9AAdi6Yz52TIWoNRKyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706528959; c=relaxed/simple;
	bh=oP7hkoD4y9SFvkJUps5sHkG78trHf0ZIoGP9okY2syI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnaZ5ErEJ1plP8kdlFPgYqBj9pIcjJGdMy5O7y5biVEN6XbhBTceFXgDtNrdzXhveiSOe1vqpn0925y+hvbBbWm/zJRry2JKFaH+GnooAor6jt271WPMms6c9I3FBOsED3IOun/PgOjQKmPn+frCcoxFPYSB4V7nloRtC+Vk2hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl; spf=pass smtp.mailfrom=v0yd.nl; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=v0yd.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=v0yd.nl
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4TNmmM2LYFz9sqj;
	Mon, 29 Jan 2024 12:49:07 +0100 (CET)
From: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
To: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: =?UTF-8?q?Jonas=20Dre=C3=9Fler?= <verdre@v0yd.nl>
Subject: [PATCH BlueZ 1/4] mgmt-tester: Add a 0-opcode to expect_hci_list lists
Date: Mon, 29 Jan 2024 12:48:57 +0100
Message-ID: <20240129114900.92919-2-verdre@v0yd.nl>
In-Reply-To: <20240129114900.92919-1-verdre@v0yd.nl>
References: <20240129114900.92919-1-verdre@v0yd.nl>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4TNmmM2LYFz9sqj

In add_expect_hci_list() we iterate through the entries of the
expect_hci_list as long as there is an opcode, which means currently
this relies on overflowing the buffer to detect the end of the list.

This is not great and when running with address sanitizer, the
out-of-bounds read gets detected and mgmt-tester aborts. Fix it by
adding a trailing 0-opcode to all those lists.
---
 tools/mgmt-tester.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7dfd1b0c7..ee12ed7d5 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -8798,6 +8798,9 @@ static const struct hci_cmd_data multi_ext_adv_add_second_hci_cmds[] = {
 		.len = sizeof(le_set_ext_adv_enable_inst_2),
 		.param = le_set_ext_adv_enable_inst_2,
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const struct generic_data multi_ext_advertising_add_second_2 = {
@@ -8845,6 +8848,9 @@ static const struct hci_cmd_data multi_ext_adv_remove_adv_hci_cmds[] = {
 		.len = sizeof(advertising_instance1_param),
 		.param = advertising_instance1_param,
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const struct generic_data multi_ext_advertising_remove = {
@@ -8877,6 +8883,9 @@ static const struct hci_cmd_data multi_ext_adv_remove_all_adv_hci_cmds[] = {
 	{
 		.opcode = BT_HCI_CMD_LE_CLEAR_ADV_SETS,
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const struct generic_data multi_ext_advertising_remove_all = {
@@ -8913,6 +8922,9 @@ static const struct hci_cmd_data multi_ext_adv_add_2_advs_hci_cmds[] = {
 		.len = sizeof(set_ext_adv_data_test1),
 		.param = set_ext_adv_data_test1,
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const struct generic_data multi_ext_advertising_add_no_power = {
@@ -10378,6 +10390,9 @@ static const struct hci_cmd_data ll_privacy_add_device_3_hci_list[] = {
 		.param = set_resolv_on_param,
 		.len = sizeof(set_resolv_on_param),
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const struct generic_data ll_privacy_add_device_3 = {
@@ -10495,6 +10510,9 @@ static const struct hci_cmd_data ll_privacy_add_device_9_hci_list[] = {
 		.len = sizeof(le_add_to_resolv_list_param),
 		.param = le_add_to_resolv_list_param
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const struct generic_data ll_privacy_add_device_9 = {
@@ -10823,6 +10841,9 @@ static const struct hci_cmd_data ll_privacy_set_device_flags_1_hci_list[] = {
 		.param = set_resolv_on_param,
 		.len = sizeof(set_resolv_on_param),
 	},
+	{
+		.opcode = 0,
+	},
 };
 
 static const uint8_t device_flags_changed_params_1[] = {
-- 
2.43.0

