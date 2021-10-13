Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA50CC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A029460C4B
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235584AbhJMAdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234252AbhJMAdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 20:33:04 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C01C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:30:58 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id y4so676176plb.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KDBDjWGMWNxPegqj3vEp16+36ACDu0Y7P+XN13iVDLY=;
        b=Ne70nxdK8yABgjBKTXR0Z99bxoCo5SuqOq5ZZwq0UHDReKiacg7MTxjRS7MZUz8bt1
         F8yVXQYg7ASAtwim5rtRlTq2hSvZw37i5J/h9TacrGGcMne8a7IskB/JEoj0BYUTRtd6
         ZaVFhX91rggrb444JDdfjKI5sm4v4f2oVK9wIDG4ZpPy2J+5SpUx+sh1WnRWtAv9j5+J
         bXqr1h4itpngxNiQKtHUbmcMkzbXXNe1y0UmR1wkCR4eCNGtg3wZULPBdHBGYgECHB8S
         lucWkRXxHugoz0U0NH8CeW60+CyNOhvclN+gst6agof5i8RZx1JYmihbD1S3r7NwxxMS
         B4GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KDBDjWGMWNxPegqj3vEp16+36ACDu0Y7P+XN13iVDLY=;
        b=UokBsxLR0lslCOvowXf4dadpqVPTBFihtbyXPiGmJQP6Ua8BWExZcdvJ1IYAkUaTiy
         H9iiUfXLUk3RPc01gJw1fMlLWBLg9bKripGoxsiF8EaFwK8TLm2dyk1e74nRWV7wVvet
         YuzpXuyNbg314fEI/jUDN46urccAnaMbpn+k402utjjpeLT8J5p94ZUwQ+6dTEHhSTwx
         uUyr4WwCCbWgO6/RAwM0YIOCaNjL3FP2arzh8zN6OHxAdsvuTZVO0mM/v/JKhivwVqFL
         lvddzSK103LbZQy+f27fxZP43bZXnbrnpLoUGLW+rQorhclY05TQqiZk8ELVhnNSl+p0
         1B4Q==
X-Gm-Message-State: AOAM531Tfmr2NDUB9EFbvdW4gTenaVVtxSh6O09ZpRck2ncrDGwZc3kR
        bWwmvbGZ1XwjiuW+ddJTftl9m77Ldgc=
X-Google-Smtp-Source: ABdhPJw/LgQU03IkQxAp9jlD+ucDKK12zX0K7xlRt2MHecGGGEdJXeZgtbRMAqsSmjTl6ul+6DivnQ==
X-Received: by 2002:a17:90a:cb90:: with SMTP id a16mr9672583pju.7.1634085058090;
        Tue, 12 Oct 2021 17:30:58 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s2sm11839996pfe.215.2021.10.12.17.30.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:30:57 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: Only allow setting msft_opcode at setup stage
Date:   Tue, 12 Oct 2021 17:30:52 -0700
Message-Id: <20211013003055.2664728-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The msft_opcode shall only be changed while at the setup stage otherwise
it can possible cause problems where different opcodes are used while
running.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
v2: Fix typos: s/extention/extension/g

 include/net/bluetooth/hci_core.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd8840e70e25..eb5d4ea88c3a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1272,11 +1272,15 @@ int hci_recv_diag(struct hci_dev *hdev, struct sk_buff *skb);
 __printf(2, 3) void hci_set_hw_info(struct hci_dev *hdev, const char *fmt, ...);
 __printf(2, 3) void hci_set_fw_info(struct hci_dev *hdev, const char *fmt, ...);
 
-static inline void hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
+static inline int hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
 {
+	if (!hci_dev_test_flag(hdev, HCI_SETUP))
+		return -EPERM;
+
 #if IS_ENABLED(CONFIG_BT_MSFTEXT)
 	hdev->msft_opcode = opcode;
 #endif
+	return 0;
 }
 
 static inline void hci_set_aosp_capable(struct hci_dev *hdev)
-- 
2.31.1

