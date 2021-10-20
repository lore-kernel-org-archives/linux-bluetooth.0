Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80BAC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 18:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8774C610D0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Oct 2021 18:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhJTShM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Oct 2021 14:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhJTShL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Oct 2021 14:37:11 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308F4C06161C
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 11:34:57 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id g184so23278001pgc.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Oct 2021 11:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/SVYsIR2StYOqXvfu6m6LEiFo9GblS/ex/TQW/2Wb0=;
        b=U09o65ocSM8NvCkMyhO/8TBE3/RZEr140K6uCCoKGkhCOX8rG/VN4rieGQ4Da0WTQM
         9nUX4GKtGL1Z+z8ud2J0MOnhT9T4Oe1GSwcok4ayfaVKRvlFXXBM/BEMM1bmGnc6G5C9
         eQvK+W81CnnPAiAeDqXWJyo1zn2GQ97zN5YY3DlZwwulUkhGk+NaGUlwkHPUhpjpvuJG
         A/16axCjPllslIkBazxbbadC0bdKdfk7yzakHL9EG9IjOormlzwYhOfVwXGUWAcYPTtw
         5kvLxvpK1N2cg2o0H3FDF+GH9ggb5dtypN80143FGBuGBjo7C/CgXsKnadtdlzRehmne
         HLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y/SVYsIR2StYOqXvfu6m6LEiFo9GblS/ex/TQW/2Wb0=;
        b=1GLT7EkhAAUVzAZSXi1nubGmDrE7M0+Cxc6NVQuu1HE4+KRTb5dgJ88oY9Fym84Nke
         zlSGd9iLJLK+QroYavOwKLwZYL3Y+cKlchsK9jCFrOFNfl3mQhwBg6rgnY0E+IC6o0WW
         dAjA/2sae/Q8t79GjBvnD8npzA82S2aM+PqSJx7rxMndCZVSRCGbQ3SXyee+eYKv3ySE
         Tjrm+hop2JpNlMLOjlVaFjDD9LZMm8KyeqZ6be9OYPtkiVOH2B+wXJkmrCuwPuVwQkBI
         bjb5pr5aHTApSl7W7yYlIbO1NEFS4TV7+iUWkjorAuqo7eejg6n8ediuuyh3bAENJ9zW
         yUOA==
X-Gm-Message-State: AOAM530Tw7aywlyJfkh0oyhvrzgaBx3xMdHHO9faY0c050izS8fNW4u0
        9PkYZSy7CCGlRofF6BBsyjP+NE6pVTQ=
X-Google-Smtp-Source: ABdhPJxsTU1RWJ4JVGtoAqLUrfa37kNpExVIiFzxCiUz9mAKHnV/Prc6IGAya9H2zaLHjAd1iblp4w==
X-Received: by 2002:a63:6f4c:: with SMTP id k73mr723229pgc.61.1634754896440;
        Wed, 20 Oct 2021 11:34:56 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id oo9sm3366950pjb.53.2021.10.20.11.34.55
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Oct 2021 11:34:55 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: vhci: Fix checking of msft_opcode
Date:   Wed, 20 Oct 2021 11:34:53 -0700
Message-Id: <20211020183453.324777-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

msft_opcode shall be use a vendor ogf (0x3f) but the check was
swifting the bits in the wrong order due to a missing parantesis
over val & 0xffff, but since the code already checks for values over
0xffff it shall not be necessary to perform that operation it now just
removes which makes it work properly when setting opcodes like 0xfce1.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 9cb7c8fafbf9..0eb90e7c3c82 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -200,7 +200,7 @@ static int msft_opcode_set(void *data, u64 val)
 {
 	struct vhci_data *vhci = data;
 
-	if (val > 0xffff || (val & 0xffff >> 10) != 0x3f)
+	if (val > 0xffff || (val >> 10) != 0x3f)
 		return -EINVAL;
 
 	if (vhci->msft_opcode)
-- 
2.31.1

