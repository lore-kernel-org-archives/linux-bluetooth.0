Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EECEC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Mar 2022 22:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234523AbiCCWR5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 3 Mar 2022 17:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiCCWR5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 3 Mar 2022 17:17:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3181BB0D3A
        for <linux-bluetooth@vger.kernel.org>; Thu,  3 Mar 2022 14:17:11 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id v1-20020a17090a088100b001bf25f97c6eso202874pjc.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Mar 2022 14:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TQDQy7MH2XtSDgwJqWJrXwBWjsknhbxjzl287lmoqs=;
        b=ZEpD9LfmQyDBrGkUPDN1vq2uzlPt2w/5yiauquaVxj/2HBw2WwHTvqd5Frcf/WN0t1
         yEBjlzzWD+pf7dtllWZBCiVlS1qIXrfYIFL0zhnniLZUTDm9FJd4Xvh8v5Ttj938m6Ls
         v/LyCzlLd9wEqFO14Oj+1/TlIws+/c8sN57lm/tJuxzq5wvSO4CWNnxkkgpZHFcZ7mhp
         kIjQBP34JPw1X7CHwmX0EFUi/XPupb7USeY5poMu2ANMu4xQnsiACr1IraQXqto9a5Db
         PZvd5wcf6Sx0R/nY4HAYLHlFEMCKBs2QkNXjpcSaWY/YYf/L5/nBlckZP2A8ReZXmgIs
         0twg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8TQDQy7MH2XtSDgwJqWJrXwBWjsknhbxjzl287lmoqs=;
        b=0CBBwyj3GX2SL5ymLFgZzZOLtN2agngK8iVwEllzpAt4Ma+7kTd2d5aOhdG+ktpmll
         61vyZbuGkrLWKAiXwb/4hslCQJbc9JL44LaLoJn4lg2Yaa10TEJFHJUVG9Ezv55gMgn6
         PiteNmSug5/s0ONNE5uFZ0iVHxpFOuLmNXP8mGK6tIBYplbyksIRBYAGTeXYyMQGVn9Z
         +3MgR5MJlylRsTr9SXmwxBFLoAnF2pl9SOXXagPfZ4KcwicWlsv47+SBkEPWD3gTbJk8
         TympzbHAdIO2YoUuloJnZEUICI/8fzGaP3pajqlKwJZr3lRM2CLRvqdrt/2bZTM8+qsl
         p9TQ==
X-Gm-Message-State: AOAM5315GUTgeS3kuEka5zEDBT26LZeMHxXk8YDBnFw9QTSOylkxNYHw
        LXBmI8pGhuIi3DYihUeaFlxEgr3kdvI=
X-Google-Smtp-Source: ABdhPJxfbZsctDOTwWmQbqKisV0AmBa7697nW4vuUX2G6dVOLfx0u5CVb1pmTSSkblHPJaoXB7blmA==
X-Received: by 2002:a17:90a:4289:b0:1bc:275b:8986 with SMTP id p9-20020a17090a428900b001bc275b8986mr7522239pjg.153.1646345830290;
        Thu, 03 Mar 2022 14:17:10 -0800 (PST)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b004f6519e61b7sm3856932pfh.21.2022.03.03.14.17.09
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:17:10 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: btusb: Make use of of BIT macro to declare flags
Date:   Thu,  3 Mar 2022 14:17:07 -0800
Message-Id: <20220303221709.387865-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes use of BIT macro when declaring BTUSB flags which makes it
understand how many bits are in use and many are left.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/btusb.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 558151f2f150..34d008380fdb 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -36,33 +36,33 @@ static bool reset = true;
 
 static struct usb_driver btusb_driver;
 
-#define BTUSB_IGNORE		0x01
-#define BTUSB_DIGIANSWER	0x02
-#define BTUSB_CSR		0x04
-#define BTUSB_SNIFFER		0x08
-#define BTUSB_BCM92035		0x10
-#define BTUSB_BROKEN_ISOC	0x20
-#define BTUSB_WRONG_SCO_MTU	0x40
-#define BTUSB_ATH3012		0x80
-#define BTUSB_INTEL_COMBINED	0x100
-#define BTUSB_INTEL_BOOT	0x200
-#define BTUSB_BCM_PATCHRAM	0x400
-#define BTUSB_MARVELL		0x800
-#define BTUSB_SWAVE		0x1000
-#define BTUSB_AMP		0x4000
-#define BTUSB_QCA_ROME		0x8000
-#define BTUSB_BCM_APPLE		0x10000
-#define BTUSB_REALTEK		0x20000
-#define BTUSB_BCM2045		0x40000
-#define BTUSB_IFNUM_2		0x80000
-#define BTUSB_CW6622		0x100000
-#define BTUSB_MEDIATEK		0x200000
-#define BTUSB_WIDEBAND_SPEECH	0x400000
-#define BTUSB_VALID_LE_STATES   0x800000
-#define BTUSB_QCA_WCN6855	0x1000000
-#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	0x2000000
-#define BTUSB_INTEL_BROKEN_INITIAL_NCMD 0x4000000
-#define BTUSB_INTEL_NO_WBS_SUPPORT	0x8000000
+#define BTUSB_IGNORE			BIT(0)
+#define BTUSB_DIGIANSWER		BIT(1)
+#define BTUSB_CSR			BIT(2)
+#define BTUSB_SNIFFER			BIT(3)
+#define BTUSB_BCM92035			BIT(4)
+#define BTUSB_BROKEN_ISOC		BIT(5)
+#define BTUSB_WRONG_SCO_MTU		BIT(6)
+#define BTUSB_ATH3012			BIT(7)
+#define BTUSB_INTEL_COMBINED		BIT(8)
+#define BTUSB_INTEL_BOOT		BIT(9)
+#define BTUSB_BCM_PATCHRAM		BIT(10)
+#define BTUSB_MARVELL			BIT(11)
+#define BTUSB_SWAVE			BIT(12)
+#define BTUSB_AMP			BIT(13)
+#define BTUSB_QCA_ROME			BIT(14)
+#define BTUSB_BCM_APPLE			BIT(15)
+#define BTUSB_REALTEK			BIT(16)
+#define BTUSB_BCM2045			BIT(17)
+#define BTUSB_IFNUM_2			BIT(18)
+#define BTUSB_CW6622			BIT(19)
+#define BTUSB_MEDIATEK			BIT(20)
+#define BTUSB_WIDEBAND_SPEECH		BIT(21)
+#define BTUSB_VALID_LE_STATES		BIT(22)
+#define BTUSB_QCA_WCN6855		BIT(23)
+#define BTUSB_INTEL_BROKEN_SHUTDOWN_LED	BIT(24)
+#define BTUSB_INTEL_BROKEN_INITIAL_NCMD BIT(25)
+#define BTUSB_INTEL_NO_WBS_SUPPORT	BIT(26)
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
-- 
2.35.1

