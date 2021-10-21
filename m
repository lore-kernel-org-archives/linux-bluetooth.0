Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6885BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 18:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4748161213
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Oct 2021 18:44:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhJUSqz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 21 Oct 2021 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbhJUSqy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 21 Oct 2021 14:46:54 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58F5C061764
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 11:44:38 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ls18so1167706pjb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 Oct 2021 11:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qr385icj1IkPFXDsmk2v6F9GwDYOAyuXWfbIcAO5sJo=;
        b=f1O7l3AubCK6HXISVNiTC4VhX6zHK0tIBHA3opwPpeGNiHUe6wvWTf0PwYxMNSgPhy
         UUG3thZqs8DCnVYdlo9EiAGKR7C3xnxeZ5FcxluXNzoHV7C+znC12YN7+bRPmNMVe780
         4REUrBchkWy6xbtcQodAhfyoYX73Jsgko7+Zjl3CZ+nIgUtjmh+W9vDFZCDUWnrGx11p
         m4FYg6JgPmHjxwlMRnDQpICvi+GnsM/kh+n1zeWjLG7Rysw/0gI/MdS6MCko0Gc8xwi5
         h3P2DYVwTYPnH6yeEgErfNQ6U25dwJCR5Q9GoSUf9qEaOQxvLhlAAc8LzsqvfdUIMHzM
         4C/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qr385icj1IkPFXDsmk2v6F9GwDYOAyuXWfbIcAO5sJo=;
        b=O2qZs/N4WKzdX09dXDkVtwYC3ZQKU3R1Sdio8bhXAipl0PIM7MGHnhg/tZuVr7M4jW
         pqTGa9mXiRRJOjp3VI2uDhYnowuEEHIXnW8dVp8u3KWhzi59O55wvHyH3kuQef7YBvOw
         ykx9hRAmGa9UZ2e61Ib5ydpKMuTdH8GRiaZC1qlquL3J0IhcInDYgBESztyGIReMhBSz
         NmY3EZqWvF8PV35CAsUSaXLHerAg+acWPr0fd0skikGYlqPtlDG/BRpnqrF+pdflZjnD
         z8nRNU05uDvPDzarG7sjsEXGDjihtzy3df2zqN6NnDa/N0s3FTPmNpEFYRRup7VZoFpN
         6h5Q==
X-Gm-Message-State: AOAM531Y3I6s5gnYzuG9KEWpJEK68uMCox0fmUb7YPYq5mp7bI3MDe8w
        /98uwPjfATnEOI59A0EOHF9NaWZm2aE=
X-Google-Smtp-Source: ABdhPJzMjZsQEv+vVibXaXn59s2CIfjNdrUJABCu2v+bISHUh7sSbZ6idFd1/CNZS83pPADXtnLO5w==
X-Received: by 2002:a17:90a:be02:: with SMTP id a2mr3803981pjs.123.1634841878177;
        Thu, 21 Oct 2021 11:44:38 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id k35sm10317359pjc.53.2021.10.21.11.44.37
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 11:44:37 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: vhci: Fix checking of msft_opcode
Date:   Thu, 21 Oct 2021 11:44:35 -0700
Message-Id: <20211021184435.614575-1-luiz.dentz@gmail.com>
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

Fixes: b8f5482c9638 ("Bluetooth: vhci: Add support for setting msft_opcode and aosp_capable")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 drivers/bluetooth/hci_vhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index 9cb7c8fafbf9..49ac884d996e 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -200,7 +200,7 @@ static int msft_opcode_set(void *data, u64 val)
 {
 	struct vhci_data *vhci = data;
 
-	if (val > 0xffff || (val & 0xffff >> 10) != 0x3f)
+	if (val > 0xffff || hci_opcode_ogf(val) != 0x3f)
 		return -EINVAL;
 
 	if (vhci->msft_opcode)
-- 
2.31.1

