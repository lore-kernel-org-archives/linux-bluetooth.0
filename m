Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495C732E6AE
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Nov 2025 14:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762266322; cv=none; b=FgLiWTndzJ3W+ZHj26Ertp7MFMrJdzZfLJXVQ7Uo+lQtwposYOP8+KlQSlt78C8uxZiJt7C1vNYdgtBf3dhLjrPQq/Y3UosPdVHbJa9HRRZm0tgk3GIO1AVmIhmq9AhyGFw5WNMRD/vjgOGyrh+0nEJMdFto07ofEgjpMy0eutU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762266322; c=relaxed/simple;
	bh=g8prTLxYhqOqWOgrCXedj1AC9wpROuEzpckhxvtuwUg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBgopeFMPAvegLbpXK2v3kANVrziKAVPa/9bdo5+vqwodqEMg930uN9jw9eredaGuPY1ESe3MrgorFgWE8+aAXhX63ui198u7e06s2I236JU2rIkVtPWUQBiiUMY50qBnQ86VOmPlRuRjGR9ujxKHcnmBWx+dfIbxaOPSUccPuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JD3Jsb4K; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JD3Jsb4K"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5596e2a99faso279581e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Nov 2025 06:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762266319; x=1762871119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U9lXi9rXjCUXyhFkyA83hbXVChAHMDQwSPl7FKVw4HM=;
        b=JD3Jsb4K6KueGFppeQ8LGMV3am7da5RTE/wRoKAjz/RnU792QF67vvJdXCWtmBVjXH
         rRNYqzzMIhXgcn6TK0B4aRijlj0nR6D/55O+pFEP7bGLfG5ciE6SEIuhMlL9kl3YODna
         3MVJ+Ses3JuLDYQ8wh+/9VtROwWIpSaau5XUrdM+Q+NFX+XSBrzKPQCnp4JPjjihqXOD
         I0omIxMsvniVzmjHvvPxK6sFclYUyBmT4zwHstkZVAiwLxnlMd8pOebKRy5sMEF8W6Sf
         TILgoDbgGmLdaeLEae3z0Vk/dbKCs1n/dOI2+mcbhuvoHkA9UVhf9O3fBlqwkGS+LfWE
         VVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762266319; x=1762871119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9lXi9rXjCUXyhFkyA83hbXVChAHMDQwSPl7FKVw4HM=;
        b=YOr4Bgos6cqWTUSKhdR9BplmxNGpw4cstTxkZtQX3kS200Z9CzTPFXeGn+/vpyaeUd
         JDt98b6wCmWfhj4NeMnAuXUUy+QCl6RIxQZ1AFicAOVQWFhqkipTKrW8Rm2ojNexxRPc
         83OVGNJZorU53wSZ/ktLVdfuadVrvMxaUAdqz180b98FfaeKOSCjEmDpa3KvQFWQBzMH
         p/B3WTXYUj/B20EVmC7T4kh1PghJYq88G1EPaRZL4vgFwjkx4nQUCL/2VqFQK90xuFkI
         Jd86TJ2bRnG126iqii/6iuiJoEmSB9qp8BETfq4cbr1RF3sC7OJrO6bNjDMuHfGcUEI/
         J4uQ==
X-Gm-Message-State: AOJu0YwkyML4TraXmZ1x7G63EMIgqCzyauSqculM0OKAKKTYXP3tFN/e
	RETA5+BL8qpPoUhTm6FOU/vblAT4F4glOIjiIgja6yvyaCQElPpfTGIXVLVTNu4ycX0=
X-Gm-Gg: ASbGncv6IEnrv/o8RcL1C2E3hhAbtDfJ/N5dAtz7HfmVC2DlScuE/sHj8FlXSdvNwBD
	8IK0hDAYAj8obUHOWRAvlupAX4qA5pB+okbA0fm6i9MGxfCeqRZHsBQOIq82jPhWKwjGx6cHhft
	wZF6K09IOh9miehRdgRiC/1UdW0sU1ah7kgcT+vh9caYdq/lm1SMLNXWtXpw7H0oj5t2+qe8wnd
	Q0hKWwE+YXmmKN94ixH8IvL9qHtAze4YjeBafBA2tElF5SUMHs3p6dqH4v0Q5GyABpksOok2mtr
	7P0q5Tx0A+NRn0k2yz5RrD4bFfjKY/whCe0hIhbZMLfGSsO5X+lo6/cHFBaMPXpc7b6xUZxttIl
	WmDQQKNAzIoZmwbNxGDydSHbZBVF/UD4vke4hrDQsv73KQEklPR10SB4bpfmaz/ign4DmeeNwZ2
	a7yvA=
X-Google-Smtp-Source: AGHT+IFEKg3mPK+b0OVEjZQii5CwrT5HfvBajVy0aKsSR8h/SWXqUszDmRMgYZ89N7wRTIf45amU/g==
X-Received: by 2002:a05:6102:c8c:b0:5db:d60a:6b24 with SMTP id ada2fe7eead31-5dbd60a7ce4mr2128726137.22.1762266318819;
        Tue, 04 Nov 2025 06:25:18 -0800 (PST)
Received: from lvondent-mobl5 ([50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5dbf31267easm1074306137.8.2025.11.04.06.25.16
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 06:25:16 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 3/3] mgmt-tester: Add tests for 5.2 and 6.0 Bluetooth version
Date: Tue,  4 Nov 2025 09:25:06 -0500
Message-ID: <20251104142506.12356-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104142506.12356-1-luiz.dentz@gmail.com>
References: <20251104142506.12356-1-luiz.dentz@gmail.com>
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

