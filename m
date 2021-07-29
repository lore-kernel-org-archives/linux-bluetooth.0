Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E1CC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 02:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5605F6103A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 02:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhG2CPL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jul 2021 22:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhG2CPL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jul 2021 22:15:11 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072ECC061757
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 19:15:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so4381209pjz.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jul 2021 19:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pieJupk7tCt0wBOdPy1PnlhT4fSICDJbopsvr0wMo0Y=;
        b=RHW+FxWRPI6h32WahhE+3k1eqXzce47t2mMtIJcAdM+TnwG8gQeRO/maztwwPMynPV
         kFLL8rr+phDmGfje4+TXfl7jHfC6Cnqh8RoKksAINkuDBK94vGrvfi/spF7Ai4V4vNHV
         aFc3TbIjOhfEvjeAfXtJVbw8HJ1fysT6Q1wTckuOCL2nhEeBYnM8NwtwsAnIlcZ0PAov
         kSjk6UzzLujmZ9LyPclKZqlbExxPY3TNJcEThf8AG4sd9z8rBgJ2VbCJlrCAZY8UjCOv
         2HMFNkUAFYIhWZ/L4c01WHuQsWW2XRYJIidk0qX/BBWnAFe58UXWk/SbRrPnWJ0JyBuA
         PV6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pieJupk7tCt0wBOdPy1PnlhT4fSICDJbopsvr0wMo0Y=;
        b=uMKXhADa4mPFtk769M7MftUdm4THRE/5nE7OcrlZzPWhoA1oBH1wHfHpT1AtczRl6t
         Wvl9THp5P2Dl4P0iwEafZVdYvEExmDB6HY5i08Ue+DdNO9MOR/SOieV21h+xkuyn7uSf
         ZM1KE/IJ5M9Gk0opOsznuJWwnXLSpYGQGMPDYuScElA773LafGSvb3qysu0zHaJzx+4X
         jSxdrwfoimbH6ddfWImtKUU3zU582sy1rEMhIhZYv1+QHacVWMbstXFIjnqS1Gl6APfw
         Fpv43jFXabHUq9EzM0BamMqnOx9c03SZ+ythWILaoiRoYnBVOprFV7UJ/sXjHBFCHXtB
         /gJQ==
X-Gm-Message-State: AOAM531DqJtAN0MGK5XNOIHKbFYdyh6u3HaDa5nFxEl+Pq5CDFWdo3PH
        xWYTyjUiZk3UZCekpXksC1VjhV/KITc=
X-Google-Smtp-Source: ABdhPJxIPNl2SIp3S+0bxCbF1es9/X3nkJ7z0f088c6NDPJOF2+HjwGhQB3KxuwyYpsAZhKNilLrlA==
X-Received: by 2002:a65:4785:: with SMTP id e5mr1778819pgs.186.1627524907234;
        Wed, 28 Jul 2021 19:15:07 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:526d:680f:c3db:8ce9])
        by smtp.gmail.com with ESMTPSA id w22sm1349398pfu.50.2021.07.28.19.15.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 19:15:05 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] monitor: Add support for tlv based version format for Intel vendor
Date:   Wed, 28 Jul 2021 19:15:04 -0700
Message-Id: <20210729021504.189617-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Some Intel device supports two different formats of the
HCI_Intel_Read_Version command depends on the command parameter and this
patch parses the command and response parameters depends on the format.
---
 monitor/intel.c | 219 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 217 insertions(+), 2 deletions(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index 7591df4ee..e9984bfe3 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -164,6 +164,168 @@ static void reset_cmd(const void *data, uint8_t size)
 	print_field("Boot address: 0x%8.8x", boot_addr);
 }
 
+struct intel_version_tlv {
+	uint8_t type;
+	uint8_t len;
+	uint8_t val[];
+};
+
+static void print_version_tlv_u32(const struct intel_version_tlv *tlv,
+				  char *type_str)
+{
+	print_field("%s(%u): 0x%8.8x", type_str, tlv->type, get_le32(tlv->val));
+}
+
+static void print_version_tlv_u16(const struct intel_version_tlv *tlv,
+				  char *type_str)
+{
+	print_field("%s(%u): 0x%4.4x", type_str, tlv->type, get_le16(tlv->val));
+}
+
+static void print_version_tlv_u8(const struct intel_version_tlv *tlv,
+				 char *type_str)
+{
+	print_field("%s(%u): 0x%2.2x", type_str, tlv->type, get_u8(tlv->val));
+}
+
+static void print_version_tlv_enabled(const struct intel_version_tlv *tlv,
+				      char *type_str)
+{
+	print_field("%s(%u): %s(%u)", type_str, tlv->type,
+					tlv->val[0] ? "Enabled" : "Disabled",
+					tlv->val[0]);
+}
+
+static void print_version_tlv_img_type(const struct intel_version_tlv *tlv,
+				       char *type_str)
+{
+	const char *str;
+
+	switch (get_u8(tlv->val)) {
+	case 0x01:
+		str = "Bootloader";
+		break;
+	case 0x03:
+		str = "Firmware";
+		break;
+	default:
+		str = "Unknown";
+		break;
+	}
+	print_field("%s(%u): %s(0x%2.2x)", type_str, tlv->type, str,
+							get_u8(tlv->val));
+}
+
+static void print_version_tlv_timestamp(const struct intel_version_tlv *tlv,
+					char *type_str)
+{
+	print_field("%s(%u): %u-%u", type_str, tlv->type,
+				tlv->val[1], tlv->val[0]);
+}
+
+static void print_version_tlv_min_fw(const struct intel_version_tlv *tlv,
+				     char *type_str)
+{
+	print_field("%s(%u): %u-%u.%u", type_str, tlv->type,
+				tlv->val[0], tlv->val[1], 2000 + tlv->val[2]);
+}
+
+static void print_version_tlv_otp_bdaddr(const struct intel_version_tlv *tlv,
+					 char *type_str)
+{
+	packet_print_addr(type_str, tlv->val, false);
+}
+
+static void print_version_tlv_unknown(const struct intel_version_tlv *tlv,
+				      char *type_str)
+{
+	print_field("%s(%u): ", type_str, tlv->type);
+	packet_hexdump(tlv->val, tlv->len);
+}
+
+static void print_version_tlv_mfg(const struct intel_version_tlv *tlv,
+					 char *type_str)
+{
+	uint16_t mfg_id = get_le16(tlv->val);
+
+	print_field("%s(%u): %s (%u)", type_str, tlv->type,
+						bt_compidtostr(mfg_id), mfg_id);
+}
+
+static const struct intel_version_tlv_desc {
+	uint8_t type;
+	char *type_str;
+	void (*func)(const struct intel_version_tlv *tlv, char *type_str);
+} intel_version_tlv_table[] = {
+	{ 16, "CNVi TOP", print_version_tlv_u32 },
+	{ 17, "CNVr TOP", print_version_tlv_u32 },
+	{ 18, "CNVi BT", print_version_tlv_u32 },
+	{ 19, "CNVr BT", print_version_tlv_u32 },
+	{ 20, "CNVi OTP", print_version_tlv_u16 },
+	{ 21, "CNVr OTP", print_version_tlv_u16 },
+	{ 22, "Device Rev ID", print_version_tlv_u16 },
+	{ 23, "USB VID", print_version_tlv_u16 },
+	{ 24, "USB PID", print_version_tlv_u16 },
+	{ 25, "PCIE VID", print_version_tlv_u16 },
+	{ 26, "PCIe DID", print_version_tlv_u16 },
+	{ 27, "PCIe Subsystem ID", print_version_tlv_u16 },
+	{ 28, "Image Type", print_version_tlv_img_type },
+	{ 29, "Time Stamp", print_version_tlv_timestamp },
+	{ 30, "Build Type", print_version_tlv_u8 },
+	{ 31, "Build Num", print_version_tlv_u32 },
+	{ 32, "FW Build Product", print_version_tlv_u8 },
+	{ 33, "FW Build HW", print_version_tlv_u8 },
+	{ 34, "FW Build Step", print_version_tlv_u8 },
+	{ 35, "BT Spec", print_version_tlv_u8 },
+	{ 36, "Manufacturer", print_version_tlv_mfg },
+	{ 37, "HCI Revision", print_version_tlv_u16 },
+	{ 38, "LMP SubVersion", print_version_tlv_u16 },
+	{ 39, "OTP Patch Version", print_version_tlv_u8 },
+	{ 40, "Secure Boot", print_version_tlv_enabled },
+	{ 41, "Key From Header", print_version_tlv_enabled },
+	{ 42, "OTP Lock", print_version_tlv_enabled },
+	{ 43, "API Lock", print_version_tlv_enabled },
+	{ 44, "Debug Lock", print_version_tlv_enabled },
+	{ 45, "Minimum FW", print_version_tlv_min_fw },
+	{ 46, "Limited CCE", print_version_tlv_enabled },
+	{ 47, "SBE Type", print_version_tlv_u8 },
+	{ 48, "OTP BDADDR", print_version_tlv_otp_bdaddr },
+	{ 49, "Unlocked State", print_version_tlv_enabled },
+	{ 0, NULL, NULL },
+};
+
+static void read_version_tlv_rsp(const void *data, uint8_t size)
+{
+	uint8_t status = get_u8(data);
+
+	print_status(status);
+
+	/* Consume the status */
+	data++;
+	size--;
+
+	while (size > 0) {
+		const struct intel_version_tlv *tlv = data;
+		const struct intel_version_tlv_desc *desc = NULL;
+		int i;
+
+		for (i = 0; intel_version_tlv_table[i].type > 0; i++) {
+			if (intel_version_tlv_table[i].type == tlv->type) {
+				desc = &intel_version_tlv_table[i];
+				break;
+			}
+		}
+
+		if (desc)
+			desc->func(tlv, desc->type_str);
+		else
+			print_version_tlv_unknown(tlv, "Unknown Type");
+
+		data += sizeof(*tlv) + tlv->len;
+		size -= sizeof(*tlv) + tlv->len;
+	}
+}
+
 static void read_version_rsp(const void *data, uint8_t size)
 {
 	uint8_t status = get_u8(data);
@@ -177,6 +339,16 @@ static void read_version_rsp(const void *data, uint8_t size)
 	uint8_t fw_build_yy = get_u8(data + 8);
 	uint8_t fw_patch = get_u8(data + 9);
 
+	/* There are two different formats of the response for the
+	 * HCI_Intel_Read_version command depends on the command parameters
+	 * If the size is fixed to 10 and hw_platform is 0x37, then it is the
+	 * legacy format, otherwise use the tlv based format.
+	 */
+	if (size != 10 && hw_platform != 0x37) {
+		read_version_tlv_rsp(data, size);
+		return;
+	}
+
 	print_status(status);
 	print_field("Hardware platform: 0x%2.2x", hw_platform);
 	print_field("Hardware variant: 0x%2.2x", hw_variant);
@@ -191,6 +363,49 @@ static void read_version_rsp(const void *data, uint8_t size)
 	print_field("Firmware patch: %u", fw_patch);
 }
 
+static void read_version_cmd(const void *data, uint8_t size)
+{
+	char *str;
+	uint8_t type;
+
+	/* This is the legacy read version command format and no further action
+	 * is needed
+	 */
+	if (size == 0)
+		return;
+
+	print_field("Requested Type:");
+
+	while (size > 0) {
+		const struct intel_version_tlv_desc *desc = NULL;
+		int i;
+
+		type = get_u8(data);
+
+		/* Get all supported types */
+		if (type == 0xff)
+			str = "All Supported Types";
+		else {
+			for (i = 0; intel_version_tlv_table[i].type > 0; i++) {
+				if (intel_version_tlv_table[i].type == type) {
+					desc = &intel_version_tlv_table[i];
+					break;
+				}
+			}
+
+			if (desc)
+				str = desc->type_str;
+			else
+				str = "Unknown Type";
+		}
+
+		print_field("  %s(0x%2.2x)", str, type);
+
+		data += sizeof(type);
+		size -= sizeof(type);
+	}
+}
+
 static void set_uart_baudrate_cmd(const void *data, uint8_t size)
 {
 	uint8_t baudrate = get_u8(data);
@@ -498,8 +713,8 @@ static const struct vendor_ocf vendor_ocf_table[] = {
 			status_rsp, 1, true },
 	{ 0x002, "No Operation" },
 	{ 0x005, "Read Version",
-			null_cmd, 0, true,
-			read_version_rsp, 10, true },
+			read_version_cmd, 0, false,
+			read_version_rsp, 1, false },
 	{ 0x006, "Set UART Baudrate",
 			set_uart_baudrate_cmd, 1, true,
 			status_rsp, 1, true },
-- 
2.25.1

