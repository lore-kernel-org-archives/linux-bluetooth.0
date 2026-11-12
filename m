Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794451149;
	b=bh77UB8H67gZzOj/ltYSfsciUBAmR6GMAJ07Bpn5uyXCVPIJgXuEtIY9rQnlb8BkLLik
	 5RuMbn+H2cn/3VBHPmcJdV1b/2/peCqwJ5kvNTVYoXTMdj3K82I9DKhw1e66n/nTQPvDn
	 TCfZkToD4oVTwSK3PKH+TNqmRpGBK+OdlVMQDTHAafvuu2dyC0v/hV19/UKwrsgN+G2+r
	 hp5bYkXORN0nQi6WrSWx+7izT2DXPeB2+0pRWSWWN9kR5VRD5CYyxw1nRXyvd8Ex/li2Y
	 QNp0lVkEsfkMCT4RcFFFMOezkUas5MgiB5XAMAwKFMLaTXkTFxTEFOeDkjBGhg6fh7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794451149;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zl69Td4flcv2GN4L8NNcvmLss9Guto6iBr3SBufS+lk=;
	b=mEb51TmDPJghp6JjU5XGh/smHl7hvX551TJJCdPl7ozKGtaxCoYwfA440pRyqm0I/VK4
	 KLOwE/1eQaaA4kJsOK4KIc2jTqhblbaiJxBxemYXaN5uCth49pnRlPYwSCSZxLh6HoQUx
	 EwhlhxfttMbejQCTmAnZpF0xXCHemWaJzXpZkPPdH7Oyb6WwM179Bc5YEDA7Z8mxkGU8j
	 J2x7Hme20j8ZvhOxoBZcFoqp22bqeIX0xm9Wy1th+gTzAFL/bS2ghTvMsxKLbZRtsQXwR
	 I2KTxyaQyGYxw0zZh8E8SBCkVervn1efVmr2tensI2OHalpPHab+k+YTNYRWqX3qPUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVfEM4dw;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57EF4606A321
	for <linux-bluetooth@vger.kernel.org>; Thu, 12 Nov 2026 02:39:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57EF4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vVfEM4dw
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1b3acec6677so5678063c88.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Nov 2026 18:39:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794451148; x=1795055948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zl69Td4flcv2GN4L8NNcvmLss9Guto6iBr3SBufS+lk=;
        b=vVfEM4dwDz4XHUBTRlxV4TUDIvPbxCajzoVC9mb3R1/DmegmqxTO2m4QYZ63elRex8
         uSkSu0lq4jaHT9K2FPN5C4GyOBWwOUg7syfH69dKO2k6oehp2K0kmy75Dv19QI8amNTy
         pOSi/Lx/Wts346Xp9SSx0QCwxu0TtFvHJq+I6PCbJlpd2lkp70CszGPXjKn0d/Fs33HE
         3Mw5ak0eQGYw/th09Wflax9l2vCQlnlKcim+jYCaAR0170bCDzwjI6xBtKX8rA4rj+mp
         +jw4h88w1FqVXer7OU6w0DMthUX50hUJagYmBPJ3aR4DvaIjSZCom+PXDOoFD/3Tdv0V
         kdvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794451148; x=1795055948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zl69Td4flcv2GN4L8NNcvmLss9Guto6iBr3SBufS+lk=;
        b=SinOvVpdFmyMwFvW+Xy9xHrQyROLpmNZOAWZZCWi/LE+OwKRyYK9Ui+XDFbuxlPja7
         zLGCrLeRqu4EYw4LS9GRbwRxZaFivM1VHfSHclwWKElsZ3HpJ4ucZiVcS1t/MBXoJYVC
         ZbxG24FUf8kuRN5SnywXSdff1tjNrcPm9/eS3QhRaNo6H9HOvZ3gLvV+mUURhkUzA5bm
         ngdEpN8uLohB1AVyjx//M9YBjhnsIDcu/ZD1hnwZmbzvhNNPWRrNdOJEd/g+8Z/HmGaV
         b0gY9uG544s2Cq3bZWRE0fTJWOQg1fVVYQjJKSgj4E4oTon7sMTMjwgWGjXiG48FKZqk
         qNMw==
X-Gm-Message-State: APuU4Z/6hF9xgLV1yy328PaD362pOeH72Nae3fCKqEJtLDLgUHEUBkGd
	CqF9UWcKMHGvXnOXCbIs5yhfaw0hyzkjsB/Vm9V5YL0tnHcQUdm1v1F6DAFl1V1rjpY=
X-Gm-Gg: AYBFou2Z4bU9pjZYlSNlvD+Ybh61jxmsJQmPSxNvAe8o0f1wxOtZSF2zL7a923TJQR4
	qbohZoCkbuUFYqBeO6hNsdjsRtCVVROSkddLGOxOLsfLqxnhNXT1fLK6X4DIIfsoXr6re5AuFyd
	ucgJPtDJBQKeQtAzdj6jduzq4Q78SSP5c99yxN/vGXxoaX9jfMVzFHVafhGuYFbT665A8QjsCKL
	JDk2qI7rs6KUvY5eWsYbmPW+NWXizlhYZnaxTYmX5YB4I4c42cEFK8fEsLKcXKPQNQr5AP51yRg
	5w3fQCYEtUNA/hWMOYOG741afQUQksvBKk4h6lyp4Crn8cfnNY9KCHiheGPnAn2x2kYRMfkKuzq
	KzGRoY4p25Y59LZA4echhKuuf5E2im/LqU7xHj1yNBFsXhEJXorPeb75x/ytnNDUIhzqerAgLJG
	gAbpvl/d08zGDh/EuncQYQ64r0YG7t3g7uvyPHGwuOeE17A40jYJ5FKdEKpHm+s4KzexstWnxTU
	iXMz0bFO4pByQs9LYfuEudFRr3DfOrZq/EE51okAmXec2H7Jq9c2QOuwT4iAAV53ifutmHdaJqU
	ZiCfVc8LCpBxSORrii25oyvcjlR+o/frW7TjPnqvus9SUdFTnvP5/EhCkP8gJ5BmvjivSbvOJDQ
	=
X-Received: by 2002:a05:701b:20ce:20b0:1a4:3169:cb with SMTP id a92af1059eb24-1b3c0311b8dmr4062428c88.17.1794451148453;
        Wed, 11 Nov 2026 18:39:08 -0800 (PST)
Received: from localhost.localdomain ([96.44.128.241])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4efc2sm17819912c88.15.2026.11.11.18.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 18:39:07 -0800 (PST)
From: Weihong Guan <weihong.guan@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Weihong Guan <weihong.guan@gmail.com>
Subject: [PATCH BlueZ 2/2] mgmt-tester: Add single advertising set tests
Date: Thu, 12 Nov 2026 02:38:58 +0000
Message-ID: <20261112023858.892176-3-weihong.guan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261112023858.892176-1-weihong.guan@gmail.com>
References: <20261112023858.892176-1-weihong.guan@gmail.com>
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With a controller supporting one advertising set the kernel gives
instance 1 handle 0x00. Check that the set's commands and events use
the handle rather than the instance number:

 - adding a non-connectable instance sets its random address on handle
   0x00;
 - an instance whose timeout the controller enforces (the set's
   duration) is removed when the set terminates on handle 0x00;
 - removing instance 1 removes the set on handle 0x00.

They pass on bluetooth-next, which has the fixes since commit
4dce35adafb5 ("Bluetooth: hci_event: Find the owner of a terminated adv
set") and the three before it, and fail without them: the random
address goes to handle 0x01, a set the controller doesn't have.

Assisted-by: Claude:claude-opus-5.5
---
 tools/mgmt-tester.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 201bd43..c8282f7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -367,6 +367,7 @@ struct generic_data {
 	bdaddr_t *setup_bdaddr;
 	bool setup_le_states;
 	const uint8_t *le_states;
+	uint8_t setup_adv_sets;
 	const uint16_t *setup_settings;
 	bool setup_nobredr;
 	bool setup_limited_discov;
@@ -505,6 +506,13 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (test && test->setup_le_states)
 		hciemu_set_central_le_states(data->hciemu, test->le_states);
 
+	if (test && test->setup_adv_sets &&
+			!hciemu_set_central_le_adv_sets(data->hciemu,
+							test->setup_adv_sets)) {
+		tester_warn("hciemu_set_central_le_adv_sets failed");
+		tester_pre_setup_failed();
+	}
+
 }
 
 static void test_pre_setup(const void *test_data)
@@ -9244,6 +9252,72 @@ static const struct generic_data add_ext_advertising_timeout_expired = {
 	.expect_alt_ev_len = sizeof(advertising_instance1_param),
 };
 
+/* A controller with a single advertising set: instance 1 is given handle
+ * 0x00, so the set's commands and events carry handle 0x00, not the
+ * instance number.
+ */
+static int set_adv_set_rand_addr_handle_0_check(const void *param,
+							uint16_t length)
+{
+	const struct bt_hci_cmd_le_set_adv_set_rand_addr *cp = param;
+
+	if (length != sizeof(*cp))
+		return -EINVAL;
+
+	return cp->handle != 0x00;
+}
+
+static const uint8_t remove_adv_set_handle_0_param[] = {
+	0x00,
+};
+
+/* Handle 0x00 and any address: printed if the check fails */
+static const uint8_t set_adv_set_rand_addr_handle_0_param[] = {
+	0x00,					/* handle */
+	0x00, 0x00, 0x00, 0x00, 0x00, 0x00,	/* address */
+};
+
+static const struct generic_data add_ext_advertising_1_set = {
+	.setup_adv_sets = 1,
+	.setup_settings = settings_powered_le,
+	.send_opcode = MGMT_OP_ADD_ADVERTISING,
+	.send_param = add_advertising_param_uuid,
+	.send_len = sizeof(add_advertising_param_uuid),
+	.expect_param = advertising_instance1_param,
+	.expect_len = sizeof(advertising_instance1_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_ADDED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_SET_RAND_ADDR,
+	.expect_hci_param = set_adv_set_rand_addr_handle_0_param,
+	.expect_hci_len = sizeof(set_adv_set_rand_addr_handle_0_param),
+	.expect_hci_param_check_func = set_adv_set_rand_addr_handle_0_check,
+};
+
+static const struct generic_data add_ext_adv_1_set_timeout_expired = {
+	.setup_adv_sets = 1,
+	.expect_alt_ev = MGMT_EV_ADVERTISING_REMOVED,
+	.expect_alt_ev_param = advertising_instance1_param,
+	.expect_alt_ev_len = sizeof(advertising_instance1_param),
+};
+
+static const struct generic_data remove_ext_advertising_1_set = {
+	.setup_adv_sets = 1,
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
+	.expect_hci_param = remove_adv_set_handle_0_param,
+	.expect_hci_len = sizeof(remove_adv_set_handle_0_param),
+};
+
 static const struct generic_data remove_ext_advertising_fail_1 = {
 	.send_opcode = MGMT_OP_REMOVE_ADVERTISING,
 	.send_param = remove_advertising_param_1,
@@ -15713,6 +15787,19 @@ int main(int argc, char *argv[])
 					setup_add_advertising_connectable_1m,
 					test_command_generic);
 
+	/* A single advertising set: instance 1 on handle 0x00 */
+	test_bredrle50("Add Ext Advertising - Success (1 set, Rand Addr)",
+					&add_ext_advertising_1_set,
+					NULL, test_command_generic);
+	test_bredrle50_full("Add Ext Advertising - Success (1 set, Timeout)",
+					&add_ext_adv_1_set_timeout_expired,
+					setup_add_advertising_timeout,
+					test_command_generic, 3);
+	test_bredrle50("Remove Ext Advertising - Success (1 set)",
+					&remove_ext_advertising_1_set,
+					setup_add_advertising,
+					test_command_generic);
+
 	test_bredrle50("Remove Ext Advertising - Invalid Params 1",
 					&remove_ext_advertising_fail_1,
 					NULL, test_command_generic);
-- 
2.47.3

