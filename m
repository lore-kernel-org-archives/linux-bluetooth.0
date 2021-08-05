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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4749EC4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 188BA6109F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Aug 2021 00:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234288AbhHEAVn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 4 Aug 2021 20:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhHEAVl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 4 Aug 2021 20:21:41 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D900C061765
        for <linux-bluetooth@vger.kernel.org>; Wed,  4 Aug 2021 17:21:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id o44-20020a17090a0a2fb0290176ca3e5a2fso6061461pjo.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 04 Aug 2021 17:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+25Wyl1BV/JFnEC/wncQqg1axvhmIzJC3BNIh49kPyE=;
        b=MFHTNdaXjbsFqIslhbYaAbE2GX5Wxfr4PVslI7JeRiZWWxmE1DL9tS0zQsS8EBTaTp
         w6mCKgoVchUiAoGo/kJBhvAaNPKPEJqSRI3bVWDEskAgRRW3jwuQhxWaYFYkT7sa0BBd
         Tj51TyciFLAlfWTYLYLh9zNrieGf4mKqBS18lL74+7blIz6Yk/zBMrJn5V9MiQcrxyoM
         WRla9zcAzkm7Ysk+dv9fsfJy7REV5MkNCgIaDZYzsovgp7LjHgZ05oH65NfUM+QOeSa4
         3M+zlL6KfBRr7Xz1nXTH5eTNCVc7my44/Dc2tSFCZFz8qxW+tA4RnXCkJ+EAir4Bjw/E
         pJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+25Wyl1BV/JFnEC/wncQqg1axvhmIzJC3BNIh49kPyE=;
        b=U8GReGc6BdJBL6B3TpgWVkq6fAFHtFZCedyaal5gV9ribqNIbFdVYgVSMPCRpPK82v
         3riADZVqTFDoYW08l9ZggWfFVeG0uPrEyx4fG0t/fdAiL0C0vuK2xbIu7Efkon8Xe68f
         cQ8RG0ghKngZR1QsjiqaYNqSg2T5V8D4lT2FQrFaLQEOEdup8snPw6DwTFAfHn0ilVpq
         kDKFmnKCe3VClEqNCAsCxkNzL6TnwCh0fj0+u16mozAxCYfXTaQBGaEs75mk5cTwH1TU
         0gZhEnxCUwQFdA36kSp9CmH7DZ0s+1ZgEsR06zWHvqolq1FhoceHo9IWIMA9SSgghOCQ
         KZ/Q==
X-Gm-Message-State: AOAM531H0LDoIE6/4V/aWw7ZdIX/t5GQoancaup//AAPWuKcVh2/ELw7
        ykgc7t9vjcJj0Owf68yYZ2YEAgMjLKA=
X-Google-Smtp-Source: ABdhPJx9WTT3dgG/l4Hs7ko1P+9iVicDrCZUCnMG2wZDQ4qnSaK+PUFJPkAVfoFxVPZgtQ4u5CI9eA==
X-Received: by 2002:a17:903:32cd:b029:12c:18ad:7e58 with SMTP id i13-20020a17090332cdb029012c18ad7e58mr1795473plr.67.1628122885354;
        Wed, 04 Aug 2021 17:21:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:e0b8:5332:84:7056])
        by smtp.gmail.com with ESMTPSA id w18sm4043221pjg.50.2021.08.04.17.21.24
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 17:21:24 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH] doc: Add a doc for Intel hardware variants
Date:   Wed,  4 Aug 2021 17:21:23 -0700
Message-Id: <20210805002123.22339-1-hj.tedd.an@gmail.com>
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
 doc/intel_variants.txt | 134 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 134 insertions(+)
 create mode 100644 doc/intel_variants.txt

diff --git a/doc/intel_variants.txt b/doc/intel_variants.txt
new file mode 100644
index 000000000..ef406a530
--- /dev/null
+++ b/doc/intel_variants.txt
@@ -0,0 +1,134 @@
+Intel Hardware Varaints
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
+
+Device List
+-----------
+
+WP2
+- USB(0x8087:0x07dc)
+- Legacy ROM device
+- Driver flag: BTUSB_INTEL_BROKEN_INITIAL_NCMD
+- HW variant: 0x07
+- FW files:
+	intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
+		tested: Patch Version: 87    Release Version: 20.60.0.2
+			70353356f ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B3/B4)")
+
+	intel/ibt-hw-37.7.10-fw-1.80.1.2d.d.bseq
+		tested: Patch Version: 42    Release Version: 20.60.0.2
+			629a5e089 ("linux-firmware: Update firmware patch for Intel Bluetooth 7260 (B5/B6)")
+
+
+StP
+- USB(0x8087:0x0a2a)
+- Legacy ROM device
+- HW variant: 0x08
+	intel/ibt-hw-37.8.10-fw-1.10.3.11.e.bseq
+		tested: FW Build: REL_50_0002    Release Version: 20.60.0.2
+			9489f5524 ("linux-firmware: Update firmware patch for Intel Bluetooth 7265 (D0)")
+
+
+SdP
+- USB(0x8087:0x0aa7)
+- Legacy ROM device
+- Driver flag: BTUSB_WIDEBAND_SPEECH
+- HW variant: 0x08
+	intel/ibt-hw-37.8.10-fw-22.50.19.14.f.bseq
+		tested: FW Patch Version: 0x42(66)
+			195ecf149 ("linux-firmware: Intel BT 7265: Fix Security Issues")
+
+
+LnP/SfP/WsP
+- USB(0x8087:0x0a2b)
+- Legacy Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH
+- HW variant: 0x0b
+	intel/ibt-11-5.sfi
+		tested: FW Build: REL0522    Release Version: 20.100.0.3
+			f0896585b ("linux-firmware: Update firmware patch for Intel Bluetooth 8260")
+- HW variant: 0x0c
+	intel/ibt-12-16.sfi
+		tested: FW Build: REL1221    Release Version: 22.50.0.4
+			4116d72b9 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
+		tested: FW Build: REL0306    Release Version: 21.10.0.6
+			1f8ebdfc2 ("linux-firmware: Update firmware file for Intel Bluetooth 8265")
+
+
+JfP
+- USB(0x8087:0x0aaa)
+- Legacy Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH | BTUSB_VALID_LE_STATES
+- HW variant: 0x11
+	intel/ibt-17-0-1.sfi
+	intel/ibt-17-16-1.sfi
+
+
+ThP
+- USB(0x8087:0x0025)
+- Legacy Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH | BTUSB_VALID_LE_STATES
+- HW variant: 0x12
+	intel/ibt-18-0-1.sfi
+	intel/ibt-18-16-1.sfi
+		tested: FW Build: REL19718    Release Version: 22.50.0.4
+			687d64a4d ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
+		tested: FW Build: REL13313    Release Version: 21.120.0.4
+			db3038082 ("linux-firmware: Update firmware file for Intel Bluetooth 9260")
+
+
+HrP/QnJ/IcP
+- USB(0x8087:0x0026)
+- Legacy Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH
+- HW variant: 0x13
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
+CcP
+- USB(0x8087:0x0029)
+- Legacy Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH
+- HW variant: 0x14
+	intel/ibt-20-0-3.sfi
+	intel/ibt-20-1-3.sfi
+		tested: FW Build: REL25791    Release Version: 22.60.0.3
+			34803c20f ("linux-firmware: Update firmware file for Intel Bluetooth AX200")
+	intel/ibt-20-1-4.sfi
+
+
+TyP
+- USB(0x8087:0x0032)
+- TLV based Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH
+- HW variant: 0x17
+	intel/ibt-0041-0041.sfi
+		tested: FW Build: REL25171    Release Version: 22.60.0.3
+			25ddc612f ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
+		tested: FW Build: REL17510    Release Version: 22.20.0.3
+			28185ecdc ("linux-firmware: Update firmware file for Intel Bluetooth AX210")
+
+
+GfP
+- USB(0x8087:0x0033)
+- TLV based Bootloader device
+- Driver flag: BTUSB_WIDEBAND_SPEECH | BTUSB_VALID_LE_STATES
+- HW variant:
-- 
2.25.1

