Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC8B2C029A
	for <linux-bluetooth@vger.kernel.org>; Mon,  3 Nov 2025 21:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203928; cv=none; b=FVLcPt7IWwAwIPZ+0d0gYkSzBz9r2am0pBL5uOUfyzmehllF6/7jqeQUZkd5L6oaSM4iDGJPW3msscTEoSINKEO4u2P+ltnXoy/JZ5hhu93ZEZXSLJJ46o62wNrL1eEq3ifsDze9/m+PB4e6ES6TDz8GgYfF4kAQYFOdY+hOy3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203928; c=relaxed/simple;
	bh=g8prTLxYhqOqWOgrCXedj1AC9wpROuEzpckhxvtuwUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AInTRMsr5VPIS5EcwnM2Vt3h2sJ+ECS7TrSoXh0ctovODFJO1DZc9FTinGA/E/PJ/zVGUCai417eVWYtGg+ysaNxuU0qrD9wDjFxnEv6vAyIl7z1OYArht67MfVM0jq/Vp3yobwQLkNY4WHNyZ3X9IOvLH6jLTmrDYBHrwdcIAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BWB4ctwn; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWB4ctwn"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5596b9e46a2so798546e0c.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Nov 2025 13:05:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203925; x=1762808725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9lXi9rXjCUXyhFkyA83hbXVChAHMDQwSPl7FKVw4HM=;
        b=BWB4ctwncOCqt0vg+fPlK6hC7LFoqpuRaTFUqAupnDl2w+1+iaYnUfQ/4Rdu+zCc0p
         Or0rgRtr9jieG1kBX/5BvC4gDK/Ht3WVtfSgai4HLN0b1/aHS+ebfUO+QSWkEMbmB5zD
         S2kSOijDL+EoVsq0nPnYGmmTtUJ9oS7SC03iwg2GkyRIDm6z4h92ZH7uTYKeTv+zWMoH
         /zydV33UFioLOxtGMaePXhp+jm3HgpHGZHEY9iyLZe/yXY3SvZcrA+H6QHx968rlJszH
         3iRMTyqa9di0kAjpbwrtKT30pcZ00M0TsELn408ch74O2/Hcv4JQ7Ligm4FrduBF8H6B
         ZAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203925; x=1762808725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9lXi9rXjCUXyhFkyA83hbXVChAHMDQwSPl7FKVw4HM=;
        b=U2JP4wR16NIv7sUv5J1OTK0SRvjDIetORhwhHY+61k4uV/SWJcJPRJz0cgVL84ZKRl
         FgG7Ym7dCMsS7HAMhPT4ZHQe1UJVtitPlLpSy1Kn1u6O7esrY0zvrpqLj9tOcmalErXB
         mXhkLlBSwbreFW0RyAHQv+r0sYUMMCHuQ7iaBPVDMw8pSFWlV96jVVSXgtWXASy7jwHF
         VSJvIOVmuIC4vibhE81xyTmqs4E0hWBpzIj14QTllJpwUz6Q7ORL3kmo+wwPgT/fJhEI
         RrFClWcHvwu8sQZT0uVEhsOuoioYhwkyY296E8UMR5X0zOjdQ1Wefcgjp1XqxBIhliK8
         P3jw==
X-Gm-Message-State: AOJu0Yw8kF45EiG5iqcWCHSKAFDVJ7tWyLY4QFO8YmNNxpg5G25J+jIi
	tE5oTNKee6U1t9iv1LxMHizN6jNbIXVJ9fSPcV89nxRuQ81wvS1GK8MZq80WMh8x
X-Gm-Gg: ASbGncv2IJb7Tq235xpD4x7Zb0PN+fBDr3eoI+PmxRoqBW6//gr7Amq2TydGSMULmdu
	dJmBrVJzliWZQiFPXklse2u3zYAQ3yDLuhDKNl9qwp2KaSLP7yZ52n9b8zfLAu1XLfnftgZxOwU
	xrhCp8puNR+i089wrpBg6deiqrgKqIvu5jvVvV0eBX3zFeJoLAuae1mLbZCv47GbKaYF2equMMs
	YhAG1HIkn9YMfuYVkZB+ZQ8+JeFe3z70mfdj+bOo5gP9U0571fY2acTKZZ4FC8whCIdveXxcaF3
	Gw1IawEgLEgJ4lNN62l6wB8z26NS0xCcg8L9AR/me0RFE+fi8idSNMeu+pHbCOCT+UXSoLGDdrR
	RoWddk1IFBAVy3VBdvpOOKcUJCGgDllwk2v93xUxEkjlWSBbwUazC9rYyJWd4WDFn2fBaFjrQOi
	afio7U+4/hfVcFwhP+jpiyGqEY
X-Google-Smtp-Source: AGHT+IH3l+zyfiwy+jk6xZkMz0Ri8+VS9Bf8ynUr5j2XhSwU0kaBwchhlQ7EbpDT2W1VZw7AL/0oFQ==
X-Received: by 2002:a05:6122:6287:b0:557:c38b:4dbd with SMTP id 71dfb90a1353d-5593e4db39cmr4712161e0c.9.1762203925179;
        Mon, 03 Nov 2025 13:05:25 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55973bf63dbsm453983e0c.9.2025.11.03.13.05.23
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 13:05:23 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v1 3/3] mgmt-tester: Add tests for 5.2 and 6.0 Bluetooth version
Date: Mon,  3 Nov 2025 16:05:09 -0500
Message-ID: <20251103210509.1270568-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103210509.1270568-1-luiz.dentz@gmail.com>
References: <20251103210509.1270568-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the following tests that attempt to initialize controllers
with version 5.2 and 6.0:

 - Set Low Energy on 5.2 - Success 4
 - Set Low Energy on 6.0 - Success 5
---
 tools/mgmt-tester.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 242909117987..663879a8fcd7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -576,6 +576,20 @@ static void test_condition_complete(struct test_data *data)
 #define test_bredrle50(name, data, setup, func) \
 	test_bredrle50_full(name, data, setup, func, 2)
 
+#define test_bredrle52_full(name, data, setup, func, timeout) \
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE52, \
+					0x0b, 0x0001beff, 0x00000080)
+
+#define test_bredrle52(name, data, setup, func) \
+	test_bredrle52_full(name, data, setup, func, 2)
+
+#define test_bredrle60_full(name, data, setup, func, timeout) \
+	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE60, \
+					0x0e, 0x0001beff, 0x00000080)
+
+#define test_bredrle60(name, data, setup, func) \
+	test_bredrle60_full(name, data, setup, func, 2)
+
 #define test_hs_full(name, data, setup, func, timeout) \
 	test_full(name, data, setup, func, timeout, HCIEMU_TYPE_BREDRLE, \
 					0x09, 0x0001bfff, 0x00000080)
@@ -1696,6 +1710,7 @@ static const char set_le_invalid_param[] = { 0x02 };
 static const char set_le_garbage_param[] = { 0x01, 0x00 };
 static const char set_le_settings_param_1[] = { 0x80, 0x02, 0x00, 0x00 };
 static const char set_le_settings_param_2[] = { 0x81, 0x02, 0x00, 0x00 };
+static const char set_le_settings_param_4[] = { 0x81, 0x02, 0xfc, 0x01 };
 static const char set_le_on_write_le_host_param[] = { 0x01, 0x00 };
 
 static const struct generic_data set_le_on_success_test_1 = {
@@ -1736,6 +1751,20 @@ static const struct generic_data set_le_on_success_test_3 = {
 	.expect_hci_len = sizeof(set_le_on_write_le_host_param),
 };
 
+static const struct generic_data set_le_on_success_test_4 = {
+	.setup_settings = settings_le,
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_param = set_le_settings_param_4,
+	.expect_len = sizeof(set_le_settings_param_4),
+	.expect_settings_set = MGMT_SETTING_LE,
+	.expect_hci_command = BT_HCI_CMD_WRITE_LE_HOST_SUPPORTED,
+	.expect_hci_param = set_le_on_write_le_host_param,
+	.expect_hci_len = sizeof(set_le_on_write_le_host_param),
+};
+
 static const struct generic_data set_le_on_invalid_param_test_1 = {
 	.send_opcode = MGMT_OP_SET_LE,
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
@@ -13231,6 +13260,12 @@ int main(int argc, char *argv[])
 	test_bredrle("Set Low Energy on - Success 3",
 				&set_le_on_success_test_3,
 				NULL, test_command_generic);
+	test_bredrle52("Set Low Energy on 5.2 - Success 4",
+				&set_le_on_success_test_4,
+				NULL, test_command_generic);
+	test_bredrle60("Set Low Energy on 6.0 - Success 5",
+				&set_le_on_success_test_4,
+				NULL, test_command_generic);
 	test_bredrle("Set Low Energy on - Invalid parameters 1",
 				&set_le_on_invalid_param_test_1,
 				NULL, test_command_generic);
-- 
2.51.0

