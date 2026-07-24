Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3A388E59
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784920362; cv=none; b=AReWya+v/O3NqkVC2r429av+2kJDzP0JK9G5Qz91BO6AYkJ3Fz/4kw1D4FYj0JumNn4XKgPiIh3Fh4v90ry7g7swUS07erZmok+aQoOjo9+THu14wLgchyCwI9oUaAnb5f960RkkTvei6YCOUf6IojFF3grS7dPmMEdM8kfxkZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784920362; c=relaxed/simple;
	bh=DSF2U+cjIpqh6REbEfDSAE3ucU97oh1Fjz9MJtvX7Ug=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwBQnQGboRqOKbS6RRPYEBms/O14DHR5eRpCfoj63688xTMDHCobFonEAfATZAN6Y/byqo8sEoC99Dhk+lpRErjn8JqaRN6wKzzHoNwiYPG0P5fCNbBrppCNA9KbD1NPBpA0NaohfeSgaUP1UjE95+Y/79QY6NYFaNc/N1X4Ur4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JzVNe+ru; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JzVNe+ru"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-966eabad303so204932241.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 12:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784920360; x=1785525160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BbC5y1ENLBKqZtnh2l0648DJezi+Islz5l3MYXqJt88=;
        b=JzVNe+ruPdMkk5eAfTJu3P5SM3XszliW3e59T7rCqJ/ILocq+OpH1ZQo4YJWdm6/vM
         FBMJD+S5Ba3OO63FWrPSjiuF5rKJ98GN1ZuGZsS2OsLNqaHoNacNgRUVmRwFTYOR6VOe
         iB6c05KtMvc3aZG0pBgN24j6tQrxMPmkRBYRzT5k8NnEEPNVHtsS3TSp5EDR9IHhQFNH
         +Rhbj0U7752EJXPKYOH77mP5nHd0etaoQF25fbBHZuV8GKG+Mt9P0N/ZsGH75j9w5J5V
         kGMVSeMnF3fXUq8s7ey4Vj+k3ZOu1iarxhV8BREDIZudoHXiwVxS4ADVt2vHEtty33Ep
         +RNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784920360; x=1785525160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=BbC5y1ENLBKqZtnh2l0648DJezi+Islz5l3MYXqJt88=;
        b=FDTqdBEaQ+GF3hZQV3uH+xfXygPh8S+p/SmCjrYeJhrBTwyytmXDw/RaMxzHhqvPE3
         4mODh4a6TPDXaepsm7pu95ddc4D22dOF9TxyHTCkdcZ8cPig3hMyRz9xhIp5+XQRXEQR
         OWNrp+C3++20iLBh5C5wpXtWep1VYICqM/KiTgN64YZtTlRQOMOiLTHCCdsRn3k0Isej
         rFCQaOR9heR2earKCXNpRktaI16bXty+r5a3ewzmkneam9FZlyfJRKYOSQWYjoK+acAt
         gLZa2MFuF1GXG9lWDrHAS5CAtxB/J0tcQn63lX8Pu2/HJoQhiXYAiuXRyFtfGt0/vZ9E
         iNJQ==
X-Gm-Message-State: AOJu0YyKg25p4gyff3rf6sC4vgSGFt4WoFmylwzXycigCSJSEQHGhRhi
	ZLSbZKlNo+oFcYDBsFXnJrH/koFDartJR9/52maDQIALJ4oY7jn0QWcseP++NMQO
X-Gm-Gg: AR+sD13dZpkmUpHV44PCGrakki6eR7FCPUoFH7XoN8HlOkEtDAJpuOW51DH/WYtZOkO
	9wUoxILROFIjhgNi0XiGdRklU67RMXMybdAYPOkrfX+f6zVvlKkSii7O8bHvh8qrhN6AnlVO+Bj
	Ux7QFbULow1PjfzDgMMNSsv5h7qAgSulreRHy1ePK2bfYP7UWwQEUy4yNcKoCJ+NUXnBYi9t/Zp
	XFMtf35jrgtKUl0tC+abx/W4g5X7siiVk/B484ep+VPNmvRiCTSVBWHZZrcvtZSlIIsFT7v9N9K
	E39kmnLbUlQNy+jJbBCbltv/oomV2BzZhe0PY7iOWtHpeOwNnfhrsHRgSkQcJzOnWL6PR4Pc03u
	kYhlo+wRXfBHmOZcGNgj5ptFgpWpx4CJLzkki5NQQuKlXcs2y59V+5tq21G3H0xHlTtg2gxbo7p
	fIR9MemG9HOdHjDSCVyJ/uLeOuudVIsbMlY0/X27EL2N5Mmeg0LHG1vrarGC+jbX99hsN7d+6F
X-Received: by 2002:a05:6102:5046:b0:740:2d81:c2a2 with SMTP id ada2fe7eead31-74d5e6ca2b2mr4288125137.10.1784920359968;
        Fri, 24 Jul 2026 12:12:39 -0700 (PDT)
Received: from lvondent-mobl5 ([72.188.211.115])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-97774c8b921sm488554241.4.2026.07.24.12.12.38
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 12:12:39 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 04/12] mgmt-tester: Add tests for SCI setting and Load Connection Subrate
Date: Fri, 24 Jul 2026 15:12:17 -0400
Message-ID: <20260724191225.1815634-5-luiz.dentz@gmail.com>
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

Add HCIEMU_TYPE_BREDRLE62 device type for testing Bluetooth 6.2
features and add test cases:

- Set Low Energy on 6.2 - SCI Setting: verifies that the SCI
  setting bit (25) is reported in supported/current settings
  for a 6.2 controller.
- Load Connection Subrate - Invalid Params 1: verifies invalid
  parameters are rejected.
- Load Connection Subrate - Success 1: verifies loading valid
  connection subrate parameters succeeds.
---
 tools/mgmt-tester.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4d28090271e9..15c9254e307e 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -597,6 +597,13 @@ static void test_condition_complete(struct test_data *data)
 #define test_bredrle60(name, data, setup, func) \
 	test_bredrle60_full(name, data, setup, func, 2)
 
+#define test_bredrle62_full(name, data, setup, func, timeout) \
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE62, \
+					0x0e, 0x0201beff, 0x00000080)
+
+#define test_bredrle62(name, data, setup, func) \
+	test_bredrle62_full(name, data, setup, func, 2)
+
 #define test_hs_full(name, data, setup, func, timeout) \
 	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE, \
 					0x09, 0x0001bfff, 0x00000080)
@@ -4429,6 +4436,48 @@ static const struct generic_data load_conn_params_fail_1 = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const char set_le_settings_param_sci[] = { 0x81, 0x02, 0xfc, 0x03 };
+static const struct generic_data set_le_on_success_sci = {
+	.setup_settings = settings_le,
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_sci,
+	.expect_len = sizeof(set_le_settings_param_sci),
+	.expect_settings_set = MGMT_SETTING_LE,
+	.expect_hci_command = BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED,
+	.expect_hci_param = set_le_on_write_le_host_param,
+	.expect_hci_len = sizeof(set_le_on_write_le_host_param),
+};
+
+static const uint8_t load_conn_subrate_nval_1[16] = { 0x12, 0x11 };
+static const struct generic_data load_conn_subrate_fail_1 = {
+	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
+	.send_param = load_conn_subrate_nval_1,
+	.send_len = sizeof(load_conn_subrate_nval_1),
+	.expect_status = MGMT_STATUS_INVALID_PARAMS,
+};
+
+static const uint8_t load_conn_subrate_valid_1[] = {
+	0x01, 0x00,				/* param_count */
+	0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,	/* address */
+	0x01,					/* address type */
+	0x08, 0x00,				/* min_interval */
+	0x80, 0x0c,				/* max_interval */
+	0x01, 0x00,				/* subrate_min */
+	0x04, 0x00,				/* subrate_max */
+	0x00, 0x00,				/* max_latency */
+	0x02, 0x00,				/* cont_num */
+	0xc8, 0x00,				/* supv_timeout */
+};
+static const struct generic_data load_conn_subrate_success_1 = {
+	.send_opcode = MGMT_OP_LOAD_CONN_SUBRATE,
+	.send_param = load_conn_subrate_valid_1,
+	.send_len = sizeof(load_conn_subrate_valid_1),
+	.expect_status = MGMT_STATUS_SUCCESS,
+};
+
 static const uint8_t add_device_nval_1[] = {
 					0x12, 0x34, 0x56, 0x78, 0x9a, 0xbc,
 					0x00,
@@ -13329,6 +13378,9 @@ int main(int argc, char *argv[])
 	test_bredrle60("Set Low Energy on 6.0 - Success 5",
 				&set_le_on_success_test_4,
 				NULL, test_command_generic);
+	test_bredrle62("Set Low Energy on 6.2 - SCI Setting",
+				&set_le_on_success_sci,
+				NULL, test_command_generic);
 	test_bredrle("Set Low Energy on - Invalid parameters 1",
 				&set_le_on_invalid_param_test_1,
 				NULL, test_command_generic);
@@ -13812,6 +13864,13 @@ int main(int argc, char *argv[])
 				&load_conn_params_fail_1,
 				NULL, test_command_generic);
 
+	test_bredrle62("Load Connection Subrate - Invalid Params 1",
+				&load_conn_subrate_fail_1,
+				NULL, test_command_generic);
+	test_bredrle62("Load Connection Subrate - Success 1",
+				&load_conn_subrate_success_1,
+				NULL, test_command_generic);
+
 	test_bredrle("Add Device - Invalid Params 1",
 				&add_device_fail_1,
 				NULL, test_command_generic);
-- 
2.54.0

