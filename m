Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C240C433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Oct 2022 22:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbiJGWzc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 18:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJGWza (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 18:55:30 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7F840562
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 15:55:30 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id fw14so5527097pjb.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 15:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IbF95eHZ2RUxmwb6nGp4/t/NK7QcVM0zQJIL6M3g4f0=;
        b=MEnZskuZTteLakr0pQ5AlayTj9/5xBOU0YuneBrbN5FgByctgUSSlnx1OBZJZOKslL
         e1wSS9OlmIME7KFl6MJ8xnjd4GQe8d54zl/LdQExdXX2Mx8fAlFF6HjTC9kOVr/Tr/sc
         E90d7wPRZfxGLSZDlT1HM/epD6zKUxDvFpybRPl3cGb8gIfrtfAhIRLLRd/+sE7WYzfm
         F4Qv/PkVSsF8qIa7LUd0Idk5yV2NSqUgezJz2ayOh6tCUAQ0tqofS0A5lugH3QJxAoEr
         SDnL20VwI8/gDtPHyvPy+o39ThM3nWRHIVYVUdusCbi1TbIL9L3WWiV8F0eP5zX32ZyL
         ik/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbF95eHZ2RUxmwb6nGp4/t/NK7QcVM0zQJIL6M3g4f0=;
        b=SS8RCXSHq5sSm1FELiEhyRsz0m0/v/9autMpJwu8E3E5nHmUHk6zC7X9UvTyO21sRV
         E8tdBRd0XlLOShXbH8K0srTCzbI/sLP6rFt08WFaeaoubLfgt6h63bRpTYAj8NLD+rdg
         i/5GQ2pt7+zaxayfBDoFJXxN5NVMO72NBt7IHDSkRx2tHby/GW2WJTaVp3AbSuUpKov+
         Ve4t3yY7jiQGFp66uKFHBYOOOl50TtTmf76TCQ/XKw859dGawDOPOt53IDwE8phsRzYM
         irbEewAzHUseVcJXBcw7h8DtdONWkhoDBXyVaA+rJ7QTiiyIslCQHj/31gQz50npbhXe
         e5sw==
X-Gm-Message-State: ACrzQf107ZKnFAjxhGcBpVYegh0rC1ZiRC8iYeTsD93t0yBMjsYGDY1C
        /7EDLM4YNI2Qn3ngf1RkfMxkN9Tyvw0=
X-Google-Smtp-Source: AMsMyM4EWDZsd5R4yqxBv6VGuu3DvY8qyKfhHSUDz9eB3Ft67fzN3atevJvfqIHZp1U+dbPc6THN0g==
X-Received: by 2002:a17:902:be03:b0:17b:80c1:78c2 with SMTP id r3-20020a170902be0300b0017b80c178c2mr7056109pls.34.1665183329007;
        Fri, 07 Oct 2022 15:55:29 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id d1-20020aa797a1000000b00562362dbbc1sm2157963pfq.157.2022.10.07.15.55.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 15:55:28 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] vhci: Add function to interact with force_static_address
Date:   Fri,  7 Oct 2022 15:55:27 -0700
Message-Id: <20221007225527.1838767-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds functions that can be used to set debugfs
force_static_address.
---
 emulator/vhci.c | 10 ++++++++++
 emulator/vhci.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/emulator/vhci.c b/emulator/vhci.c
index 4295e30ef980..a12b11e0f305 100644
--- a/emulator/vhci.c
+++ b/emulator/vhci.c
@@ -257,3 +257,13 @@ int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode)
 {
 	return btdev_set_emu_opcode(vhci->btdev, opcode);
 }
+
+int vhci_set_force_static_address(struct vhci *vhci, bool enable)
+{
+	char val;
+
+	val = (enable) ? 'Y' : 'N';
+
+	return vhci_debugfs_write(vhci, "force_static_address", &val,
+							sizeof(val));
+}
diff --git a/emulator/vhci.h b/emulator/vhci.h
index c42e8bde1cd5..6da56cb589fe 100644
--- a/emulator/vhci.h
+++ b/emulator/vhci.h
@@ -28,3 +28,4 @@ int vhci_set_force_wakeup(struct vhci *vhci, bool enable);
 int vhci_set_msft_opcode(struct vhci *vhci, uint16_t opcode);
 int vhci_set_aosp_capable(struct vhci *vhci, bool enable);
 int vhci_set_emu_opcode(struct vhci *vhci, uint16_t opcode);
+int vhci_set_force_static_address(struct vhci *vhci, bool enable);
-- 
2.37.3

