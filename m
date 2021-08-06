Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0181BC4338F
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 00:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D14A161184
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 00:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbhHFAeL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Aug 2021 20:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240378AbhHFAeK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Aug 2021 20:34:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04C5C0613D5
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 17:33:54 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso13824781pjo.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 17:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqa3ZfwfJQEIkfHQBiLBPTeEnis5mNzoJnL2EQOuxRc=;
        b=u4TuXtNz0w5SMldI0F0fZqtHBl9Yeyc15HdNem+bEZpjKHWVBzf7GObcYCT3D2fTqi
         zB/9IF9SnUmO001ZC7pFfyuVkRBf7SQ0yYgu1HNdMhznK4OEwSGv8GsiwdO5UPvznR/y
         3N95xOAfTgNB16Kg/ICP3786KJLZW5JUsBlDUxwwWHIMWPL/zYRbRkIhN8ZVUyQ2cXdz
         PyjmQU3wI11fUZ/NgSYr8syBjUBFWhzAkX2GBQP2swg/ZwkVWYb/68btV7rfrKaI9xqJ
         fIkQod/i/X49HYtaJQ4xiRAeM1YfrFLURLT/COKAsBjJCs6MNa5FyP5ftyGqgVpYRlMh
         LOcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zqa3ZfwfJQEIkfHQBiLBPTeEnis5mNzoJnL2EQOuxRc=;
        b=cqM8IQIWqAgFzk/cKcIUfXI2PFtOSk9Goi1pSAjR5TmWQQEQh9KvPRX+CJAuSnHnbC
         PteHh23K7PgPbnvgvn1EKAcV7f9QLLNWn9TDHT4ZmhcKqYoA+1bnxNNN4hQUTkvUMnZV
         WOA2CYz5pMMsmdgpwoN95jemB/CtQqyha+LutReeDre9qHNMYq5gfWd9jKVoE9q4u/ee
         Fh6mOKK07wbxKICEo2T11H1gO2XCMTKx1YWjGICAhbVUVLRVJ6Ie9buVv2y/bZV/564c
         lA6FHmPfzHA17eFOnQrlzFrAMSrZ7D7fpCL7mdS019Ox75S0ddpEake+6IVN6mAdT3P5
         EPlg==
X-Gm-Message-State: AOAM5322bm/Qyj9brMYhDMaN2MRaFMtkNMJFfO2jI+HGb6ld/5YexuSh
        jvCRlnVphBVtCNLvCRG3otSKLumvKRs=
X-Google-Smtp-Source: ABdhPJw7AYQ5x+7B5hKzJHb32ZuLMSZ5fqOvwNvWTWUsC0bTDWeTZbYeBdE8OV9mD/ecHeIvjxnT2w==
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id 189-20020a6205c60000b0290341e0b1a72cmr7725791pff.71.1628210033776;
        Thu, 05 Aug 2021 17:33:53 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:93f5:285f:92e6:eeb4])
        by smtp.gmail.com with ESMTPSA id z33sm8930886pga.20.2021.08.05.17.33.52
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 17:33:53 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2] doc: Add a doc for Intel hardware variants
Date:   Thu,  5 Aug 2021 17:33:52 -0700
Message-Id: <20210806003352.49664-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds a document for Intel hardware variants currently
supported by the kernel and its firmware list.
---
 doc/intel-variants.txt | 155 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 155 insertions(+)
 create mode 100644 doc/intel-variants.txt

diff --git a/doc/intel-variants.txt b/doc/intel-variants.txt
new file mode 100644
index 000000000..e30053f9c
--- /dev/null
+++ b/doc/intel-variants.txt
@@ -0,0 +1,155 @@
+Intel Hardware Varaints
+=======================
+
+These are the list of Intel Bluetooth devices and its information.
+
+Some of devices were tested the following test cases:
+	Firmware loading after cold boot
+	Firmware loading after restart
+	Device discovery
+	Connection to LE Mouse
+	A2DP
+	HFP
+	Update to new firmware if available
+
+All Intel firmware can be found from linux-firmware git repo.
+https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
+
+
+Device List
+-----------
+
+Wilkins Peak (WP)
+- HW ID:	USB(0x8087:0x07dc)
+- Device Type:	Legacy ROM device
+- Driver flag:	BTUSB_INTEL_BROKEN_INITIAL_NCMD
+- HW variant:	0x07
+- FW files:
+	WP2 B3
+	intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
+		tested: Patch Version: 87    Release Version: 20.60.0.2
+			70353356f ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3/B4)")
+	WP2 B5
+	intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
+		tested: Patch Version: 42    Release Version: 20.60.0.2
+			629a5e089 ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5/B6)")
+
+	WP1 B3
+	intel/ibt-hw-37.7.10-fw-1.0.1.2d.d.bseq
+
+	WP1 B3
+	intel/ibt-hw-37.7.10-fw-1.0.2.3.d.bseq
+
+
+Stone Peak (StP)
+- HW ID:	USB(0x8087:0x0a2a)
+- Device Type:	Legacy ROM device
+- HW variant:	0x08
+- FW files:
+	StP
+	intel/ibt-hw-37.8.10-fw-1.10.2.27.d.bseq
+
+	StP D1
+	intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
+		tested: FW Build: REL_50_0002    Release Version: 20.60.0.2
+			9489f5524 ("linux-firmware: Update firmware patch for Intel Bluetooth 7265 (D0)")
+
+
+Sandy Peak (SdP)
+- HW ID:	USB(0x8087:0x0aa7)
+- Device Type:	Legacy ROM device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+- HW variant:	0x08
+	intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
+		tested: FW Patch Version: 0x42(66)
+			195ecf149 ("linux-firmware: Intel BT 7265: Fix Security Issues")
+
+
+Snow Field Peak (SfP) / Windstorm Peak (WsP)
+- HW ID:	USB(0x8087:0x0a2b)
+- Device Type:	Legacy Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+- HW variant:	0x0b
+	SfP
+	intel/ibt-11-5.sfi
+		tested: FW Build: REL0522    Release Version: 20.100.0.3
+			f0896585b ("linux-firmware: Update firmware patch for Intel Bluetooth 8260")
+- HW variant:	0x0c
+	WsP
+	intel/ibt-12-16.sfi
+		tested: FW Build: REL1221    Release Version: 22.50.0.4
+			4116d72b9 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
+		tested: FW Build: REL0306    Release Version: 21.10.0.6
+			1f8ebdfc2 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
+
+
+Jefferson Peak (JfP)
+- HW ID:	USB(0x8087:0x0aaa)
+- Device Type:	Legacy Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+		HCI_QUIRK_VALID_LE_STATES
+- HW variant:	0x11
+	intel/ibt-17-0-1.sfi
+	intel/ibt-17-16-1.sfi
+
+
+Thunder Peak (ThP)
+- HW ID:	USB(0x8087:0x0025)
+- Device Type:	Legacy Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+		HCI_QUIRK_VALID_LE_STATES
+- HW variant:	0x12
+	intel/ibt-18-0-1.sfi
+	intel/ibt-18-16-1.sfi
+		tested: FW Build: REL19718    Release Version: 22.50.0.4
+			687d64a4d ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
+		tested: FW Build: REL13313    Release Version: 21.120.0.4
+			db3038082 ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
+
+
+Harrison Peak (HrP)
+- HW ID:	USB(0x8087:0x0026)
+- Device Type:	Legacy Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+- HW variant: 	0x13
+	intel/ibt-19-0-0.sfi
+	intel/ibt-19-0-1.sfi
+	intel/ibt-19-0-4.sfi
+	intel/ibt-19-16-4.sfi
+	intel/ibt-19-240-1.sfi
+	intel/ibt-19-240-4.sfi
+	intel/ibt-19-32-0.sfi
+	intel/ibt-19-32-1.sfi
+	intel/ibt-19-32-4.sfi
+
+
+Cyclone Peak (CcP)
+- HW ID:	USB(0x8087:0x0029)
+- Device Type:	Legacy Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+- HW variant:	0x14
+	intel/ibt-20-0-3.sfi
+	intel/ibt-20-1-3.sfi
+		tested: FW Build: REL25791    Release Version: 22.60.0.3
+			34803c20f ("linux-firmware: Update firmware file for Intel Bluetooth AX200")
+	intel/ibt-20-1-4.sfi
+
+
+Typhon Peak (TyP)
+- HW ID:	USB(0x8087:0x0032)
+- Device Type:	TLV based Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+- HW variant:	0x17
+	intel/ibt-0041-0041.sfi
+		tested: FW Build: REL25171    Release Version: 22.60.0.3
+			25ddc612f ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
+		tested: FW Build: REL17510    Release Version: 22.20.0.3
+			28185ecdc ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
+
+
+Garfield Peak (GfP)
+- HW ID:	USB(0x8087:0x0033)
+- Device Type:	TLV based Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+		HCI_QUIRK_VALID_LE_STATES
+- HW variant:	0x18
-- 
2.25.1

