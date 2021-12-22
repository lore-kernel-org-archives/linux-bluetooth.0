Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C098C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Dec 2021 20:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbhLVUWJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Dec 2021 15:22:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238079AbhLVUWI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Dec 2021 15:22:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859CBC061574
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z9-20020a17090a7b8900b001b13558eadaso6873691pjc.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Dec 2021 12:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qTrx+L6FW9g7yqhhKCHYnn1SvK/9FgnPwBFbiQtz+K8=;
        b=mgFAbjCeWPK869b9aXUO5AMD2Ro3Is+3nMWztfTVRriavuKRmaaN1hu3evn9fEqM+A
         xQKacLlU6nCHUp6Hg6bWoibrIG30GSVONgoj26dEp79kLojsBPv9VRhUtfNuLGr8MPRF
         6tov70yocnvRbabFaP2dte+frjeQleUvaOgq8GXSj/WMpwxN0yNEBMfZN1N3nMatvqsH
         AsmVRnkONo0pl7Xsfhi5I7ncGgYdler/050+m9QN0QF9pSRBAgBXD3zS+Acb1bDx22lF
         lH+CkbHdx6OJbqkvAZquzld/U/GsVAAseiD64G9kSMMUW+LYaCNLjQZypt8+iDWHAFmp
         soHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qTrx+L6FW9g7yqhhKCHYnn1SvK/9FgnPwBFbiQtz+K8=;
        b=Gl8yMj1a761Cpl1ywZl7xAV99nmxRSq9ZRkiuwLBWs6k2jI2iXOvWoGd9yGQ9zaG9K
         kgIWrl0JwQElFYQ99JkMSuaWN6tvXHfCSXJoCMEVao7abKeXQnAH2iLlnbxhSpGwZI45
         X9loFIiwJIwEcjocxMuUCLwK0m/CbFEKXbf9gqxFWXA2II+AhIA2oikB9lsbheL/HVV3
         bUceWjeYXGauEYoHKzb2PkYAZoncKaIaC9Y/wabIMldqORntH5a5fUFzvUjO7DhGlmEf
         YCeEiZU+xDMV7oQa3LlYCCS+OjotSwF7bCDU6Vj83IAuLJVjoErXFPW0W/CD+7wXzS6o
         WIFg==
X-Gm-Message-State: AOAM533C/npcnnu013c8CHOjbjh3dQsFq5PcRWZzMSHjk8LR3luxtuTr
        z29b3AZ9kR9/Zjt//taUR2LdFHyasC4=
X-Google-Smtp-Source: ABdhPJz2bIu92aEQ7Vnz0fqZW7Cr7BQXXUpIm4xV6ShxeR1LOcGtAAweE0w7QFQlRBx3kt9wcWaGBg==
X-Received: by 2002:a17:902:cd18:b0:149:3573:a9c8 with SMTP id g24-20020a170902cd1800b001493573a9c8mr4021865ply.17.1640204527755;
        Wed, 22 Dec 2021 12:22:07 -0800 (PST)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id x25sm1285266pfu.113.2021.12.22.12.22.06
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 12:22:07 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 6/6] Bluetooth: vhci: Set HCI_QUIRK_VALID_LE_STATES
Date:   Wed, 22 Dec 2021 12:22:01 -0800
Message-Id: <20211222202201.977779-6-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211222202201.977779-1-luiz.dentz@gmail.com>
References: <20211222202201.977779-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This set HCI_QUIRK_VALID_LE_STATES quirk which is required for the likes
of experimental LE simultaneous roles.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 49ac884d996e..c443c3b0a4da 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -331,6 +331,8 @@ static int __vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (opcode & 0x80)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
+	set_bit(HCI_QUIRK_VALID_LE_STATES, &hdev->quirks);
+
 	if (hci_register_dev(hdev) < 0) {
 		BT_ERR("Can't register HCI device");
 		hci_free_dev(hdev);
-- 
2.33.1

