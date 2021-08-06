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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4075C4320A
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 05:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9366A611BF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  6 Aug 2021 05:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243339AbhHFFuI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 6 Aug 2021 01:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243322AbhHFFuE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 6 Aug 2021 01:50:04 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3650FC0617A1
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Aug 2021 22:49:45 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso15513480pjo.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Aug 2021 22:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsYoweLCw7+O48J/pxK2eZQ0QMiNqDJsIOw1mE1YMcs=;
        b=UY+6RRhQOrJcyNycVwSp05ibXYje3fYm2XYc6EF/IIBLLgwToBnC+9fMUSOOLUsatz
         i9TiZCOFeqsVm80wAkoV5nN7Cxdb4YKmg4uoDguqO+0r++VtX3EF9LFNHpOLPl3Wnk/z
         XzdHodv178sECpfnc2L0/CpJs9GfC9u4TqiXA6W4+CVY/LSH/Pb7ELFE0EDcCMyAtRx4
         aOkt7dQhBy+FWt8BPgvfYIpj8L5KQsDUxZxRJ7KaYdkCLV3pwS/MM9RjK3horAAQQXvC
         T/U/u3U5UKns5QKnxqLUowt60+ZNMhV6cds5GauY3s5Y/SXAxtlKfPXtuovGBO50qC19
         4lHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DsYoweLCw7+O48J/pxK2eZQ0QMiNqDJsIOw1mE1YMcs=;
        b=kp2qyrje7XVVgFBPPgTUx+YcqhXOqan6P0sHCyx35+9p5JnvrZr1jfcsbpLnTs5EAo
         Y+1pfq+swtwwv2xSluNTT2P7vPY1X9t7R0mH9olWhXO7UCAntTs0XyutLO0V+qNAiz7G
         H0AcprR3YVxISGQWF3hprdvDQ+K0EcEYa5kRaR7recR0uHkvY126O27UGsDN8vjkTO94
         OCjyAVHJw5Bh3hWwg64IheYm+cz1I9WnMqzgzY2JyBBNDPhUcYq8VktljB2Bzauziyyi
         t0QLG6ligm6jg2BIM6LCQixO3pKix7q0Fb2VGd9rlJsEeDxtPUsdokBkneHHD78dwXjZ
         nMRg==
X-Gm-Message-State: AOAM532c0x4jJGozuCEOYku/iLOuiG5eYaL0eXiDx+FdcUPuaWgCYjho
        QvK5BkR6fuhbNfVhXSAP0cBTGmu999k=
X-Google-Smtp-Source: ABdhPJwHfmbM0WwcBpNvaA0J41bhs5aKPNuRGazp0/PJmMJjm5gr8ZYQ9FTu/n2U9tIZcsS5syYuEw==
X-Received: by 2002:a62:65c7:0:b029:3c3:4eff:1b26 with SMTP id z190-20020a6265c70000b02903c34eff1b26mr3078092pfb.48.1628228984516;
        Thu, 05 Aug 2021 22:49:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:2000:d9b5:488c:cbd4])
        by smtp.gmail.com with ESMTPSA id g27sm9811080pgl.19.2021.08.05.22.49.42
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 22:49:42 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v3] doc: Add a doc for Intel hardware variants
Date:   Thu,  5 Aug 2021 22:49:41 -0700
Message-Id: <20210806054941.31387-1-hj.tedd.an@gmail.com>
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
 doc/intel-variants.txt | 159 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 159 insertions(+)
 create mode 100644 doc/intel-variants.txt

diff --git a/doc/intel-variants.txt b/doc/intel-variants.txt
new file mode 100644
index 000000000..4f51ca9f5
--- /dev/null
+++ b/doc/intel-variants.txt
@@ -0,0 +1,159 @@
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
+Quasar(QsR) / Harrison Peak (HrP)
+- HW ID:	USB(0x8087:0x0026)
+- Device Type:	Legacy Bootloader device
+- HCI Quirks:	HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED
+- HW variant: 	0x13
+	Quasar with JfP
+	intel/ibt-19-0-1.sfi
+	intel/ibt-19-240-1.sfi
+
+	Quasar with HrP
+	intel/ibt-19-0-4.sfi
+	intel/ibt-19-240-4.sfi
+
+	intel/ibt-19-0-0.sfi
+	intel/ibt-19-16-4.sfi
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

