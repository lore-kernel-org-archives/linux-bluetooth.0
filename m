Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F4DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B596B611CB
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 21:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbhJTVvD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 17:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbhJTVvD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 17:51:03 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE70C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:48 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id oa12-20020a17090b1bcc00b0019f715462a8so3393433pjb.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 14:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=21gUSS+z8TZ4xAsuXLZlxljZz7d4uxALyn/+MkD3yDE=;
        b=OtkkXdoEBaKVTxXM5HzLZZCicECqyKhqTSEeIxHxVt9nji/aaAKh83ZrvgVoqewgaR
         cQQLIYl8XGlMTY7ys41bLBtnBH0E/pGv4BP70yBE2f7AMnAVAUka3tTJe2KJoxYSa2KR
         LyNyodoVNv0GuKGEQ5eHi/zV/e8YuSt1h03iW9mWm06/HmdoV1C9ygPWv/argoWOVfCn
         3UQVGI/5gimdhDS0mpISs/3rynTCveLds507s2ivQ5pgm5RGYrNM+ZLiVDFl2RtTneGA
         fiQivWZaudnuIOFuY4dHJ7LbyXzlmWaL2VO0PUFfn+QgZICBydblb+fvj9Mt68Wf06Hh
         vQ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21gUSS+z8TZ4xAsuXLZlxljZz7d4uxALyn/+MkD3yDE=;
        b=z9QLs9bfniU1qefZ5kfAr++b6y/vA1huesbko+dNZT+ontI2eaHLLo2hPWOW4SMYnU
         kFIz+zMKD0eJlxdvvl4WBCu3LE/OSzkH6iDlu3X3ohxdgK0Vq/AoFq0ZmQZ0HVtoSF5L
         QEBNIFpTTmhDXxCJdtJqws+pS2Vr5cmEOWunYBUcxpNgjp1fyG6O+dDA4S8TFdWO5gTJ
         In0//OZHIue8ZSQbIYP5pgAJYraqEQv9AoqNyMId4EYux13gXd4RWBmBGd7nDouJUnSz
         GDNwllzK1Mg4pndMSpa9p25XU9ACveUlTSLgbQR6ysD5GRBFfZc87prMIxaoWckZwmEr
         IFiQ==
X-Gm-Message-State: AOAM531keeVJLUsdESCQDPsf6aLP64ZGPfNJu/tg9xZBpZ+weT81JHgt
        uqM9B2Y9Ch6YlyWzWbGxke5+ZA4yyrU=
X-Google-Smtp-Source: ABdhPJxKa7ypesK3duJ+1yZw8RitwLPp94y3TgIIQq6fyDYFDoxNMAC9cBnII49UUcYDQDGjDy5CkA==
X-Received: by 2002:a17:902:e743:b0:13f:18ba:c8a8 with SMTP id p3-20020a170902e74300b0013f18bac8a8mr1520814plf.72.1634766527548;
        Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id b13sm7257664pjl.15.2021.10.20.14.48.46
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 14:48:47 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/6] emulator/vhci: Fix writing msft_opcode using binary format
Date:   Wed, 20 Oct 2021 14:48:40 -0700
Message-Id: <20211020214843.431327-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211020214843.431327-1-luiz.dentz@gmail.com>
References: <20211020214843.431327-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

debugfs expects values in string format not binary format.
---
 emulator/vhci.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index f8560e0c5..59ad1ecb8 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -230,7 +230,16 @@ int vhci_set_force_wakeup(struct vhci *vhci, bool enable)
 
 int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode)
 {
-	return vhci_debugfs_write(vhci, "msft_opcode", &opcode, sizeof(opcode));
+	int err;
+	char val[7];
+
+	snprintf(val, sizeof(val), "0x%4x", opcode);
+
+	err = vhci_debugfs_write(vhci, "msft_opcode", &val, sizeof(val));
+	if (err)
+		return err;
+
+	return btdev_set_msft_opcode(vhci->btdev, opcode);
 }
 
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable)
-- 
2.31.1

