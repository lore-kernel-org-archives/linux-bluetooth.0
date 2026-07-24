Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8136450917
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920367; cv=none; b=OCPSuPUNWS+BBd1UeMXlqxEf/mdoYLdE/wUVESWyq2FBp7/zjnu0Jcue5R+7CqdtXUX1nQCqKpxjiFkyoQJl8HY+FKztFPDUSf7kSrhPI9YwT6/IuNxRgLUrNJWK3WfdHvUBRgp5Jz69kIMnE2jJwF9qzcqH0D14FAjfUukdpu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920367; c=relaxed/simple;
	bh=iQ/V5/NhNRu5l1qSbyYeYSiwiGw0RriWg9knJcZtG8w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOjVR6qgcWfRPyFIzZTpFVnCT/tLYepUfJ4tCH9naCPhgr8k3iYB88BJpbcRawjlGBDvW8DW4sYp9dcVwlW7GhCvw869fkeP7U6S6XejPGNKFvMKUv0j3EsJ+YAtcB5j+tk/zHkNeQlXg6PjhTi+VCC88Wul+EiEWpPjO4JyxYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nVNJqRdB; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVNJqRdB"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-96723c7151eso253141241.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920364; x=1785525164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kJEK77u7IozM7I1Qkyt4WdbGNj5dqUW09/KgAdHOw1o=;
        b=nVNJqRdBonkaWWqT/iLzD/UilPbdTzEq0bHmUKkURU0s5tgYf1dUFD0XS2eRojyKIr
         iUbc0ORucbRbV7xb/UBgDpkbfYowH7qx1h0Z7eqm0c+a+re0r2TsEUZNALVmvh/Un2Wz
         hg7b1l+Oj0lLhO8hOvDFfEZl4t12LdsaWmp5ylXYv23TV++BDjlXNqQ6EyYG+Uvmcd8C
         HdE9VcmYAFEFsHm1cldH2w6s1WysYjhXjNMK9HkodHpZIKw2C3o5YwRfWe3TTaVCLGK+
         Cw+4mtWiel+sMxr7Iq9zLtASVqn0oAEcHBLOcGRjhgwp08tXpRAHw2dedoBX5OSMzCq0
         Q2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920364; x=1785525164;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kJEK77u7IozM7I1Qkyt4WdbGNj5dqUW09/KgAdHOw1o=;
        b=REbATO1Q+n8IpM8AI5XfvQO8IeS9hm2xGqFSCz0GNJHPb6/HSZmwIDo2cdbjRRG8KC
         ITmcnrrqLEAm7DszALbyAY/b2qBEn7YqqXXhgt1L+aUQrfdka3SH2B4/o8dVg+WUTDiY
         +vkRlHUOEcMFzhrAZFFSneYlEASzwfsTBl46DNBN821tnAN8i1DDRWljsYbMNbj2UZV7
         U1WUkGcKv6rquWpPZjtUi3G0M89skaoiu5Rftfkua90UC7t5n1ZxXX4hrso6J3fxUj9Z
         I1mEcUEii6z49l7txmol9g7mzJrZQLxmtiV/bOXl2xsq3AS+jA4cm5h5+copSRtPA/QA
         ayyw==
X-Gm-Message-State: AOJu0YwFY0RdCeZmTnY7eYFUFDEpgxAc7f8WgwzXELaly1qNWZBkgdBc
	NmldTQAp8gf+pbmCD+iReDURk5BVcCAxZ0Qanks+9RSQc3enxIpx4qYV8M41DfnR
X-Gm-Gg: AR+sD12IeFjmynXrq/APRMRbi8jiK8gc6CzM2u44tLHNNTk2tALr0ddyUwiugFnihap
	P5pfqCAk1ZEgKB/HrAsZhaUgvGWYdS0wlgXJ0OY34n2w/FoFUAE9DaSSumEhOV14QjIcE4KY394
	8LLrIEHhcQzNCH3R1SiJPgbYG2I33OUL/pdcrtgKnWKA7uDuMA/X5xzb4SK1VyMu2YdIpdCSofi
	ZI3lPaqO51BeGBgXnYSS74NjRfohV390PDiLLuTTrIvUX8XyEaNsiu7+dzouURQn7LdPsXlVc0Q
	ftXbWY151OH+ZPVlDiVD81LYgO/yazLgq9G4v0B4bGAfhIhJKFSWq7u7Rq3GrON7P74t99+1iuE
	5KxmI5tWC089dt8Q+csl8xCQWGOTFcHruBPxs0WmSJXEpRNPlWMANDmzAFmnB7BxWF9ndnFF1on
	EVqlBtUutF/Z4GU6ADFsGeaTaa9lN7dGnRMS5/YU7aaB3ENzaUAadGcibmj/BqAVwAfF/pejl82
	mVe7MXluUE=
X-Received: by 2002:a05:6102:3f87:b0:73e:5068:824d with SMTP id ada2fe7eead31-74d5fdd01a9mr4493779137.14.1784920364499;
        Fri, 24 Jul 2026 12:12:44 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 09/12] mgmt-tester: Add HIDS recommended SCI parameter tests
Date: Fri, 24 Jul 2026 15:12:22 -0400
Message-ID: <20260724191225.1815634-10-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724191225.1815634-1-luiz.dentz@gmail.com>
References: <20260724191225.1815634-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Add Load Connection Subrate test cases using the recommended
connection subrate parameters from the HOGP v1.2 specification for
each of the four HID modes:

 - Fast: interval 1.25-5 ms, latency 0, subrate 1-4, cont_num 3
 - Default: interval 7.5-15 ms, latency 0, subrate 1-4, cont_num 0
 - Low Power: interval 7.5-15 ms, latency 100, subrate 1-4, cont_num 0
 - Full Range: interval 1.25-15 ms, latency 0, subrate 1-4, cont_num 1

Supervision timeouts are computed as (1 + Peripheral Latency) *
Subrate Max * Connection Interval Max * 2 per the spec.
---
 tools/mgmt-tester.c | 104 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 104 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 15c9254e307e..4b432002d49f 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -4478,6 +4478,98 @@ static const struct generic_data load_conn_subrate_success_1 = {
 	.expect_status = MGMT_STATUS_SUCCESS,
 };
 
+/* HIDS 1.2 recommended SCI parameters (see HOGP v1.2 spec).
+ * Connection intervals are in units of 0.125 ms, supervision timeout in
+ * units of 10 ms.
+ *
+ * Fast mode: interval 1.25-5 ms, latency 0, subrate 1-4, cont_num 3,
+ * timeout >= (1 + 0) * 4 * 5 ms * 2 = 40 ms.
+ */
+static const uint8_t load_conn_subrate_hids_fast[] = {
+	0x01, 0x00,				/* param_count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* address */
+	0x01,					/* address type (LE Public) */
+	0x0a, 0x00,				/* min_interval (1.25 ms) */
+	0x28, 0x00,				/* max_interval (5 ms) */
+	0x01, 0x00,				/* subrate_min */
+	0x04, 0x00,				/* subrate_max */
+	0x00, 0x00,				/* max_latency */
+	0x03, 0x00,				/* cont_num */
+	0x04, 0x00,				/* supv_timeout (40 ms) */
+};
+static const struct generic_data load_conn_subrate_hids_fast_test = {
+	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
+	.send_param = load_conn_subrate_hids_fast,
+	.send_len = sizeof(load_conn_subrate_hids_fast),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+/* Default mode: interval 7.5-15 ms, latency 0, subrate 1-4, cont_num 0,
+ * timeout >= (1 + 0) * 4 * 15 ms * 2 = 120 ms.
+ */
+static const uint8_t load_conn_subrate_hids_default[] = {
+	0x01, 0x00,				/* param_count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* address */
+	0x01,					/* address type (LE Public) */
+	0x3c, 0x00,				/* min_interval (7.5 ms) */
+	0x78, 0x00,				/* max_interval (15 ms) */
+	0x01, 0x00,				/* subrate_min */
+	0x04, 0x00,				/* subrate_max */
+	0x00, 0x00,				/* max_latency */
+	0x00, 0x00,				/* cont_num */
+	0x0c, 0x00,				/* supv_timeout (120 ms) */
+};
+static const struct generic_data load_conn_subrate_hids_default_test = {
+	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
+	.send_param = load_conn_subrate_hids_default,
+	.send_len = sizeof(load_conn_subrate_hids_default),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+/* Low Power mode: interval 7.5-15 ms, latency 100, subrate 1-4,
+ * cont_num 0, timeout >= (1 + 100) * 4 * 15 ms * 2 = 12120 ms.
+ */
+static const uint8_t load_conn_subrate_hids_low_power[] = {
+	0x01, 0x00,				/* param_count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* address */
+	0x01,					/* address type (LE Public) */
+	0x3c, 0x00,				/* min_interval (7.5 ms) */
+	0x78, 0x00,				/* max_interval (15 ms) */
+	0x01, 0x00,				/* subrate_min */
+	0x04, 0x00,				/* subrate_max */
+	0x64, 0x00,				/* max_latency (100) */
+	0x00, 0x00,				/* cont_num */
+	0xbc, 0x04,				/* supv_timeout (12120 ms) */
+};
+static const struct generic_data load_conn_subrate_hids_low_power_test = {
+	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
+	.send_param = load_conn_subrate_hids_low_power,
+	.send_len = sizeof(load_conn_subrate_hids_low_power),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
+/* Full Range mode: interval 1.25-15 ms, latency 0, subrate 1-4,
+ * cont_num 1, timeout >= (1 + 0) * 4 * 15 ms * 2 = 120 ms.
+ */
+static const uint8_t load_conn_subrate_hids_full_range[] = {
+	0x01, 0x00,				/* param_count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* address */
+	0x01,					/* address type (LE Public) */
+	0x0a, 0x00,				/* min_interval (1.25 ms) */
+	0x78, 0x00,				/* max_interval (15 ms) */
+	0x01, 0x00,				/* subrate_min */
+	0x04, 0x00,				/* subrate_max */
+	0x00, 0x00,				/* max_latency */
+	0x01, 0x00,				/* cont_num */
+	0x0c, 0x00,				/* supv_timeout (120 ms) */
+};
+static const struct generic_data load_conn_subrate_hids_full_range_test = {
+	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
+	.send_param = load_conn_subrate_hids_full_range,
+	.send_len = sizeof(load_conn_subrate_hids_full_range),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
 static const uint8_t add_device_nval_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0x00,
@@ -13870,6 +13962,18 @@ int main(int argc, char *argv[])
 	test_bredrle62("Load Connection Subrate - Success 1",
 				&load_conn_subrate_success_1,
 				NULL, test_command_generic);
+	test_bredrle62("Load Connection Subrate - HIDS Fast",
+				&load_conn_subrate_hids_fast_test,
+				NULL, test_command_generic);
+	test_bredrle62("Load Connection Subrate - HIDS Default",
+				&load_conn_subrate_hids_default_test,
+				NULL, test_command_generic);
+	test_bredrle62("Load Connection Subrate - HIDS Low Power",
+				&load_conn_subrate_hids_low_power_test,
+				NULL, test_command_generic);
+	test_bredrle62("Load Connection Subrate - HIDS Full Range",
+				&load_conn_subrate_hids_full_range_test,
+				NULL, test_command_generic);
 
 	test_bredrle("Add Device - Invalid Params 1",
 				&add_device_fail_1,
-- 
2.54.0

