Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD68CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABF806109E
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233785AbhJLVeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbhJLVeC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:34:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206DEC061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id x4so411333pln.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zo3acUqq8twKFzumVmhpJkegGdJmcwOMCz2VVIrU+J8=;
        b=RTHEs/dsaG9HqkCX1zmv/djpAsJ46Z//FhWJRQayAnUsYweD7gQ4QzAHv6UgUH9wRd
         UlHRL4HDQvEVjKuJrv2m+VcfpQcIDMRfeAEGOWi4SdaNMx+mBrwXpAlKuzhqnv2oXpZg
         cRvwksZ+qzzhuvzhwRd7A8ZStJBNfhVgZikUhj3hUnMwnz0ZvoOZKHJ3swfyIwZUffSd
         aotIBcIo/6sS7d9sbBHWoOF7ugy9nudq+pfi7P7J5C17EiwhCzTuLirHq6OCtwOeJOsV
         mr3Klqxo5PO1boYjWvxKz3lwHmekdvWluZeed9u1kEDthtXgt53CJUpBv7gB9C9mztAf
         xXUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zo3acUqq8twKFzumVmhpJkegGdJmcwOMCz2VVIrU+J8=;
        b=K96HExVIH8rkQ24wVwV3tVtgJkTvBWI3PzyG888zbSiPpxitrzeifqh0h1ZUD15r7K
         KrDfc9l89+7+E4pXczPXIifPhcy/8TJ0lA9Jhb0HB+oq5RPNOg7fZ4XPVqcHg2inNgwC
         WkxmpcMSyLzBjh7KFYSNi+xRrNXBdvwYhkh8muEQig/WoQyUMNilZGB+BKhDqYpL47CL
         MYxzkSckbGjkLDBP0UWoEG3lnSpOjTX1E7F670e0AW670EbFZohx5WpZKTSIzskh58K3
         1FlHrYcrs8t0AOGj/wnaLMagDQI1QOuF6LOPOFbb5FLesjpbmL927uPC7f/tqUvQG1MW
         wg9w==
X-Gm-Message-State: AOAM531vr3dO7qQfHMGwW2Xkd0moikwi/XnGaJ4YyckYe8FP9NLc8Cq6
        q6V6bTIvpTSvzeSp2viTBDO4ZuDV55U=
X-Google-Smtp-Source: ABdhPJxb9kCbauvCUmc5Gq3BKNZ5aDEB9ndOo6Lyb9eg7C3Fdz7F4QPfZSDm8EXGNM/B4lZOofW9sQ==
X-Received: by 2002:a17:90b:1910:: with SMTP id mp16mr8837155pjb.30.1634074319256;
        Tue, 12 Oct 2021 14:31:59 -0700 (PDT)
Received: from lvondent-mobl4.intel.com (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id on17sm3940900pjb.47.2021.10.12.14.31.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 14:31:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Only allow setting msft_opcode at setup stage
Date:   Tue, 12 Oct 2021 14:31:55 -0700
Message-Id: <20211012213158.2635219-1-luiz.dentz@gmail.com>
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

