Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3223D8908
	for <linux-bluetooth@vger.kernel.org>; Sun, 20 Sep 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789936562; cv=pass; b=U64QoQQ/ob5het5W57zcBzBTGVKdMJijtkhk6mzKR2jiriTBHlHJ3/bQG2RD6Q0THCNlqxwHiM/aZ0EllO47idVKqX5QCfDu9XVFUmRkK66cFSmwB9BrkgpLE4bDYApRKkOUSTTQeLsbyIUGBkrXCfL/tFiPBOWWXJuu1ne7rag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789936562; c=relaxed/simple;
	bh=lxzoof8Bjw/H3de0h5CBR/K4UHwup/vjTa4OQdt1rfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r2IDkHEw9/rvRqTk5ytS7ukDuSDnFWCAna3n6BAUV49NkmsPQih0S3mx65KCqHcKzEnJgQqgrMJscDZAbFHfq51UTwopu9PApimH4b6FdIm6kYtmwyZEyYJpS/kr17LXzBFinsNXqC83fJdt5ozoOqHnhuyyX9AyMPGdRdKE1+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=qQG/icfg; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="qQG/icfg"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:4:f011::d901])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4hnymh3nzFz117G;
	Sun, 20 Sep 2026 23:35:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1789936548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqJhwRlVhTmoIE4Kz2LVl/yG+3vEXCgns/Vl9FXY3xw=;
	b=qQG/icfgsFMaoFLJYcKsSldh5wtign2AOoeVCfYnMh+CHjVVjvS/n8M3lIiupl7CRljSSr
	fW0NbLJYiBsPvM0u6sBQWK+vWYq4aHxvk4Il3R//ZoQ6M4bKooh0ELTBphM9tFHbnsT650
	sB5aFRydzhvGZkAjOJM0zN/pDJbSeew=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1789936548;
	b=mwirMZDJz/BJalCAXOlDuFTD9IONaSAfg2L8RE9sU49MrPMpOvhQEThgTUwiTQZVmC+idK
	yAk+M3bqnQsAOGUWusKY+GPlx8oa4vax6cor5bpxe0oc+biJRFZkDn1/2Wx8Kx0HMFYT2j
	UCZww9AsX3a4gOCWVlYf5ip2goK7fZs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1789936548;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LqJhwRlVhTmoIE4Kz2LVl/yG+3vEXCgns/Vl9FXY3xw=;
	b=jqDBCqNktkLsjqaGvZExzZ/lhibevak/vsjoxgTLoH+MI8T+hsbMEClD6Fofq7PHt4aDJv
	hrpBryCycSjYEwwPtyh8am4Oxsr0H/K2W04+FHGxGsul30unjYZbdzCJ8Qz4wUK6PAgd+H
	sv+PyGe++A6JjbrnstfPvUfz3ENRJVA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH BlueZ 1/5] mgmt-tester: ignore Debug feature in Read Exp Feature tests
Date: Sun, 20 Sep 2026 23:35:09 +0300
Message-ID: <0e4c18a987bae5d3729514e3e1bd383c7c8ed9aa.1789934710.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789934710.git.pav@iki.fi>
References: <cover.1789934710.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CONFIG_BT_FEATURE_DEBUG controls whether Debug experimental feature is
present. mgmt-tester hardcodes one configuration.

CONFIG_BT_FEATURE_DEBUG is incompatible with DYNAMIC_DEBUG, so requiring
test configurations to have it enabled is inconvenient.

Instead, adjust test to accept either debug present or not.

Fixes failures in "Read Exp Feature - Success"
---
 test/functional/test_kernel_testers.py |   2 -
 tools/mgmt-tester.c                    | 110 ++++++++++++++++++++-----
 2 files changed, 89 insertions(+), 23 deletions(-)

diff --git a/test/functional/test_kernel_testers.py b/test/functional/test_kernel_testers.py
index bfdfb03e7..4c847bd43 100644
--- a/test/functional/test_kernel_testers.py
+++ b/test/functional/test_kernel_testers.py
@@ -37,8 +37,6 @@ XFAIL = {
         "Mesh - Send cancel - 2",
     },
     "mgmt-tester": {
-        # Always fail:
-        "Read Exp Feature - Success",
         # Flaky, randomly fail:
         "LL Privacy - Add Device 1 (Add to AL)",
         "LL Privacy - Add Device 2 (2 Devices to AL)",
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4b432002d..3eb2b20ad 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -340,7 +340,8 @@ struct generic_data {
 	bool expect_ignore_param;
 	const void *expect_param;
 	uint16_t expect_len;
-	const void * (*expect_func)(uint16_t *len);
+	const void * (*expect_func)(const void *param, uint16_t param_len,
+							uint16_t *len);
 	uint32_t expect_settings_set;
 	uint32_t expect_settings_unset;
 	uint32_t expect_settings_spontaneous;
@@ -3158,7 +3159,8 @@ static const void *pair_device_send_param_func(uint16_t *len)
 	return param;
 }
 
-static const void *pair_device_expect_param_func(uint16_t *len)
+static const void *pair_device_expect_param_func(const void *p, uint16_t plen,
+								uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
 	const struct generic_data *test = data->test_data;
@@ -4292,7 +4294,8 @@ static const void *get_clock_info_send_param_func(uint16_t *len)
 	return param;
 }
 
-static const void *get_clock_info_expect_param_func(uint16_t *len)
+static const void *get_clock_info_expect_param_func(const void *p,
+						uint16_t plen, uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
 	static uint8_t param[17];
@@ -4312,7 +4315,8 @@ static const void *get_clock_info_expect_param_func(uint16_t *len)
 	return param;
 }
 
-static const void *get_clock_info_expect_param_not_powered_func(uint16_t *len)
+static const void *get_clock_info_expect_param_not_powered_func(const void *p,
+						uint16_t plen, uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
 	static uint8_t param[17];
@@ -4339,7 +4343,8 @@ static const void *get_conn_info_send_param_func(uint16_t *len)
 	return param;
 }
 
-static const void *get_conn_info_expect_param_func(uint16_t *len)
+static const void *get_conn_info_expect_param_func(const void *p, uint16_t plen,
+								uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
 	static uint8_t param[10];
@@ -4355,7 +4360,8 @@ static const void *get_conn_info_expect_param_func(uint16_t *len)
 	return param;
 }
 
-static const void *get_conn_info_error_expect_param_func(uint16_t *len)
+static const void *get_conn_info_error_expect_param_func(const void *p,
+						uint16_t plen, uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
 	static uint8_t param[10];
@@ -4402,7 +4408,8 @@ static const struct generic_data get_conn_info_ncon_test = {
 	.expect_func = get_conn_info_error_expect_param_func,
 };
 
-static const void *get_conn_info_expect_param_power_off_func(uint16_t *len)
+static const void *get_conn_info_expect_param_power_off_func(const void *p,
+						uint16_t plen, uint16_t *len)
 {
 	struct test_data *data = tester_get_data();
 	static uint8_t param[10];
@@ -7645,7 +7652,8 @@ static void command_generic_callback(uint8_t status, uint16_t length,
 
 	if (!test->expect_ignore_param) {
 		if (test->expect_func)
-			expect_param = test->expect_func(&expect_len);
+			expect_param = test->expect_func(param, length,
+								&expect_len);
 
 		if (length != expect_len) {
 			tester_warn("Invalid cmd response parameter size %d %d",
@@ -10206,24 +10214,83 @@ static const uint8_t read_exp_feat_param_success[] = {
 	0x01, 0x00, 0x00, 0x00,			/* Flags */
 };
 
+/* Kernel Debug feature (d4992530-b9ec-469f-ab01-6c481c47da1c) is present only
+ * for CONFIG_BT_FEATURE_DEBUG. Accept either configuration.
+ */
+static const uint8_t read_exp_feat_param_success_debug[] = {
+	0x05, 0x00,				/* Feature Count */
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
+	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
+	0x30, 0x25, 0x99, 0xd4,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0xd6, 0x49, 0xb0, 0xd1, 0x28, 0xeb,	/* UUID - Simultaneous */
+	0x27, 0x92, 0x96, 0x46, 0xc0, 0x42,	/* Central Peripheral */
+	0xb5, 0x10, 0x1b, 0x67,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0xaf, 0x29, 0xc6, 0x66, 0xac, 0x5f,	/* UUID - Codec Offload */
+	0x1a, 0x88, 0xb9, 0x4f, 0x7f, 0xee,
+	0xce, 0x5a, 0x69, 0xa6,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x76, 0x6e, 0xf3, 0xe8, 0x24, 0x5f,	/* UUID - Mesh support */
+	0x05, 0xbf, 0x8d, 0x4d, 0x03, 0x7a,
+	0xd7, 0x63, 0xe4, 0x2c,
+	0x01, 0x00, 0x00, 0x00,			/* Flags */
+};
+
+static const uint8_t read_exp_feat_param_success_index_none[] = {
+	0x01, 0x00,				/* Feature Count */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+};
+
+static const uint8_t read_exp_feat_param_success_index_none_debug[] = {
+	0x02, 0x00,				/* Feature Count */
+	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
+	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
+	0x30, 0x25, 0x99, 0xd4,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
+	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
+	0x88, 0xf1, 0xba, 0x6f,
+	0x00, 0x00, 0x00, 0x00,			/* Flags */
+};
+
+static const void *read_exp_feat_success_expect(const void *param,
+					uint16_t param_len, uint16_t *len)
+{
+	if (param_len == sizeof(read_exp_feat_param_success_debug)) {
+		*len = sizeof(read_exp_feat_param_success_debug);
+		return read_exp_feat_param_success_debug;
+	}
+
+	*len = sizeof(read_exp_feat_param_success);
+	return read_exp_feat_param_success;
+}
+
+static const void *read_exp_feat_success_index_none_expect(const void *param,
+					uint16_t param_len, uint16_t *len)
+{
+	if (param_len == sizeof(read_exp_feat_param_success_index_none_debug)) {
+		*len = sizeof(read_exp_feat_param_success_index_none_debug);
+		return read_exp_feat_param_success_index_none_debug;
+	}
+
+	*len = sizeof(read_exp_feat_param_success_index_none);
+	return read_exp_feat_param_success_index_none;
+}
+
 static const struct generic_data read_exp_feat_success = {
 	.send_opcode = MGMT_OP_READ_EXP_FEATURES_INFO,
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = read_exp_feat_param_success,
 	.expect_len = sizeof(read_exp_feat_param_success),
-};
-
-
-static const uint8_t read_exp_feat_param_success_index_none[] = {
-	0x02, 0x00,				/* Feature Count */
-	0x1c, 0xda, 0x47, 0x1c, 0x48, 0x6c,	/* UUID - Debug */
-	0x01, 0xab, 0x9f, 0x46, 0xec, 0xb9,
-	0x30, 0x25, 0x99, 0xd4,
-	0x00, 0x00, 0x00, 0x00,			/* Flags */
-	0x3e, 0xe0, 0xb4, 0xfd, 0xdd, 0xd6,	/* UUID - ISO Socket */
-	0x85, 0x98, 0x6a, 0x49, 0xe0, 0x05,
-	0x88, 0xf1, 0xba, 0x6f,
-	0x00, 0x00, 0x00, 0x00,			/* Flags */
+	.expect_func = read_exp_feat_success_expect,
 };
 
 static const struct generic_data read_exp_feat_success_index_none = {
@@ -10232,6 +10299,7 @@ static const struct generic_data read_exp_feat_success_index_none = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = read_exp_feat_param_success_index_none,
 	.expect_len = sizeof(read_exp_feat_param_success_index_none),
+	.expect_func = read_exp_feat_success_index_none_expect,
 };
 
 static const uint8_t set_exp_feat_param_offload_codec[] = {
-- 
2.55.0

