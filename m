Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E57C433FE
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 01:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbiJHBOU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 21:14:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJHBOT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 21:14:19 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051D5B48A9
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 18:14:16 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bh13so6026519pgb.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 18:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qhM9uwt9zGCQSo0L+d9fkAjpX8v5G+qjdr2EHhc4mao=;
        b=Pnk5g1O4Bn/ZG5K9E+LVCxCSgBTXyJhOzvaYAGD3b46FO+qZYKrds93t0ecb0AR5cX
         i0v2fYFKxKlw0caTjavO3XTqu0NMKoXZITr4UkG3sj+wSzUNcOLB+G71sZdqTnZoyQff
         PNFskQ+DX0v3vtMH/jhHxaiHyIZSacKc+aIf8Yla+u28vM9TeKRUzP83PPa8UodzTUAN
         1eGFhyVYQRVpnUyielW/v/Ey+yIvGx767BpcjS4ipjJ6ci9si8znNDZHCsJ81alsTfmM
         F+FDlwA95NIUtokQxP7pO3+gVZ9e3UE6Jof9ElWCkYeGvDHXsIZHxFbYWVE9uM0iSE1D
         bxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qhM9uwt9zGCQSo0L+d9fkAjpX8v5G+qjdr2EHhc4mao=;
        b=3ZNn4yTvAAr0uRZtoWV1i3zAOBcgf2uwEW6wZDHFLvbkBXhLgUa6P0f2qu2+9qpzvN
         L5yOW5QvJSWCJUDSi2EoAVtbRZN3ID9mcoFgGmSGgJG1b1j3W2baFQAU5ZeEvE3XVP+M
         n1SkxxRKwLxsPs6HE0NuLMM0K3V4LDyBuHF6AZ4rrewqWikCTC8FEqC8OdHwSuvihw9s
         fCP9ryim7I2WJKkYVGzreORHsf4H4nEv3SKK6HWBw9TNSGd8/SahipalEQsleGPaoUQn
         otrT2B08yRGAFFf1Yw94w2x1dwdm7wVff7cMjPynRx2sv5jfgHN7HUNFt0qvtdIroIvo
         agQg==
X-Gm-Message-State: ACrzQf2FvoPXI6Kxqb0Ericp0f6CYNUK925gsc9XXUoku1I3XU4NUCwr
        mqX1/nhcMLfd/BXc23Qx6ZvNT5DPiDiAyg==
X-Google-Smtp-Source: AMsMyM6uABNH7crH6fgFHihAhXUCpbA3kGllosx5nXfMNCnr1DXhiGxdWKwmoQd/Ypx+8ngiyC1aOA==
X-Received: by 2002:a63:84c6:0:b0:45a:c93:988c with SMTP id k189-20020a6384c6000000b0045a0c93988cmr6794082pgd.605.1665191654921;
        Fri, 07 Oct 2022 18:14:14 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 131-20020a621989000000b00561969ea721sm2291938pfz.147.2022.10.07.18.14.13
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 18:14:14 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/3] mgmt-tester: Fix Set Static Address tests
Date:   Fri,  7 Oct 2022 18:14:10 -0700
Message-Id: <20221008011410.1907549-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221008011410.1907549-1-luiz.dentz@gmail.com>
References: <20221008011410.1907549-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Set Static Address tests needs to power after setting the address since
the programming of the address using the HCI command only happens during
power on procedure.
---
 tools/mgmt-tester.c | 63 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 12 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 7bb219953a7c..a56c38173fb7 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -14,6 +14,7 @@
 
 #include <stdlib.h>
 #include <stdbool.h>
+#include <string.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <sys/types.h>
@@ -33,6 +34,7 @@
 #include "emulator/vhci.h"
 #include "emulator/bthost.h"
 #include "emulator/hciemu.h"
+#include "emulator/btdev.h"
 
 #include "src/shared/util.h"
 #include "src/shared/tester.h"
@@ -299,6 +301,7 @@ struct hci_entry {
 };
 
 struct generic_data {
+	bdaddr_t *setup_bdaddr;
 	bool setup_le_states;
 	const uint8_t *le_states;
 	const uint16_t *setup_settings;
@@ -416,6 +419,16 @@ static void read_index_list_callback(uint8_t status, uint16_t length,
 	if (tester_use_debug())
 		hciemu_set_debug(data->hciemu, print_debug, "hciemu: ", NULL);
 
+	if (test && test->setup_bdaddr) {
+		struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+		struct btdev *btdev = vhci_get_btdev(vhci);
+
+		if (!btdev_set_bdaddr(btdev, test->setup_bdaddr->b)) {
+			tester_warn("btdev_set_bdaddr failed");
+			tester_pre_setup_failed();
+		}
+	}
+
 	if (test && test->setup_le_states)
 		hciemu_set_central_le_states(data->hciemu, test->le_states);
 
@@ -4055,30 +4068,38 @@ static const struct generic_data unblock_device_invalid_param_test_1 = {
 
 static const char set_static_addr_valid_param[] = {
 			0x11, 0x22, 0x33, 0x44, 0x55, 0xc0 };
-static const char set_static_addr_settings[] = { 0x00, 0x82, 0x00, 0x00 };
+static const char set_static_addr_settings_param[] = { 0x01, 0x82, 0x00, 0x00 };
 
 static const struct generic_data set_static_addr_success_test = {
-	.send_opcode = MGMT_OP_SET_STATIC_ADDRESS,
-	.send_param = set_static_addr_valid_param,
-	.send_len = sizeof(set_static_addr_valid_param),
+	.setup_bdaddr = BDADDR_ANY,
+	.setup_send_opcode = MGMT_OP_SET_STATIC_ADDRESS,
+	.setup_send_param = set_static_addr_valid_param,
+	.setup_send_len = sizeof(set_static_addr_valid_param),
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
-	.expect_param = set_static_addr_settings,
-	.expect_len = sizeof(set_static_addr_settings),
+	.expect_param = set_static_addr_settings_param,
+	.expect_len = sizeof(set_static_addr_settings_param),
 	.expect_settings_set = MGMT_SETTING_STATIC_ADDRESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_RANDOM_ADDRESS,
 	.expect_hci_param = set_static_addr_valid_param,
 	.expect_hci_len = sizeof(set_static_addr_valid_param),
 };
 
-static const char set_static_addr_settings_dual[] = { 0x80, 0x00, 0x00, 0x00 };
+static const char set_static_addr_settings_dual[] = { 0x81, 0x80, 0x00, 0x00 };
 
 static const struct generic_data set_static_addr_success_test_2 = {
-	.send_opcode = MGMT_OP_SET_STATIC_ADDRESS,
-	.send_param = set_static_addr_valid_param,
-	.send_len = sizeof(set_static_addr_valid_param),
+	.setup_send_opcode = MGMT_OP_SET_STATIC_ADDRESS,
+	.setup_send_param = set_static_addr_valid_param,
+	.setup_send_len = sizeof(set_static_addr_valid_param),
+	.send_opcode = MGMT_OP_SET_POWERED,
+	.send_param = set_powered_on_param,
+	.send_len = sizeof(set_powered_on_param),
 	.expect_status = MGMT_STATUS_SUCCESS,
 	.expect_param = set_static_addr_settings_dual,
 	.expect_len = sizeof(set_static_addr_settings_dual),
+	.expect_settings_set = MGMT_SETTING_STATIC_ADDRESS,
 	.expect_hci_command = BT_HCI_CMD_LE_SET_RANDOM_ADDRESS,
 	.expect_hci_param = set_static_addr_valid_param,
 	.expect_hci_len = sizeof(set_static_addr_valid_param),
@@ -11386,6 +11407,23 @@ static void test_command_generic(const void *test_data)
 	test_add_condition(data);
 }
 
+static void setup_set_static_addr_success_2(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	struct vhci *vhci = hciemu_get_vhci(data->hciemu);
+	int err;
+
+	/* Force use of static address */
+	err = vhci_set_force_static_address(vhci, true);
+	if (err) {
+		tester_warn("Unable to set force_static_address: %s (%d)",
+					strerror(-err), -err);
+		tester_test_failed();
+		return;
+	}
+	setup_command_generic(test_data);
+}
+
 static void check_scan(void *user_data)
 {
 	struct test_data *data = tester_get_data();
@@ -13233,10 +13271,11 @@ int main(int argc, char *argv[])
 
 	test_le("Set Static Address - Success 1",
 				&set_static_addr_success_test,
-				NULL, test_command_generic);
+				setup_command_generic, test_command_generic);
 	test_bredrle("Set Static Address - Success 2",
 				&set_static_addr_success_test_2,
-				NULL, test_command_generic);
+				setup_set_static_addr_success_2,
+				test_command_generic);
 	test_bredrle("Set Static Address - Failure 1",
 				&set_static_addr_failure_test,
 				NULL, test_command_generic);
-- 
2.37.3

