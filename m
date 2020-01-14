Return-Path: <SRS0=HCMd=3D=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C9C33CB1
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E5D924676
	for <linux-bluetooth@archiver.kernel.org>; Tue, 14 Jan 2020 11:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=silvair-com.20150623.gappssmtp.com header.i=@silvair-com.20150623.gappssmtp.com header.b="ZeNh0d1C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgANLtZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 14 Jan 2020 06:49:25 -0500
Received: from mail-lj1-f179.google.com ([209.85.208.179]:36837 "EHLO
        mail-lj1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANLtZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 14 Jan 2020 06:49:25 -0500
Received: by mail-lj1-f179.google.com with SMTP id r19so13998846ljg.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2020 03:49:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=silvair-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odiswOmWdP9J63oVVjmIcDqYkYZ3fPz+uCxHFe2nZlk=;
        b=ZeNh0d1CIkpfnLpKSJDXOhj+r7fvHu9Br2Y0g11u3dAADLBHvxB00i+8BxPpq/5Run
         HYROvFHl2d+iXiTf/Js07N1fEi7H9qapdhNXwrDWuUyAeMMtdhO60agGtVrdVhW1AgNr
         JMdE5o/WbVk+QU7BOhBNPNacAFjlO3nGPspmbmvjmaYw74ouWXiggalNUpvJeT00vv7D
         VIfNvKXhvZ9OG985i1aB6np87ifyiDYhFNuzqF2INhC5b0Uyke4ev2qkcq1pcdisytAT
         RgcHhX83pWVucRslmcSrqvwPrUnwUg8ey1mXAgh9vmm4k7ifEOAsjKLPq52ec37stPkP
         hPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=odiswOmWdP9J63oVVjmIcDqYkYZ3fPz+uCxHFe2nZlk=;
        b=SP1TPrAX8WnDd0D76cjSkZ+kb87PVkavFVbl8scQnjgcLpyJBT+OSkuVLMsOhGzNNe
         aCdzjPvcKdivMLshirpM2Y1mZq9Kc+CxEOuAFFEmbxL1tmq8M5RnxtDsUfFLG5C9P6uy
         NzIkyaX6KJtRisiqBOsRyspG//HhMtQRsJlrxL6+PPkQQfMxUFgPV4b3dUc8cpqzghf4
         YWwJULVYgZa6/gALpSDPs4NmutPVCFE+8okPVsvVzXlMh2IngOd55o+YBnJW6HDrAQ9m
         5DX9l95ukQBpwf4Q6rqVjBzPzI0XOzbw6768Z2fik5Df4vIDLZ3/udOnE+qp5Q0NB6pk
         HG0g==
X-Gm-Message-State: APjAAAVk/L4Ds1eIJrmQGZNg4IkcDLkkp6bCMS0gAF/3WXlbUKdrB3ar
        NzjGXF/qj8OCZtmS0dWIhed1dKnjmSQqaA==
X-Google-Smtp-Source: APXvYqyzWvZnzB0Sjy0ZSoNcpnMki5BmySmZIfNW6/Lv3x29Qsip2aEUlu18bZISPkwYcOwCetTzmA==
X-Received: by 2002:a2e:7a07:: with SMTP id v7mr11956438ljc.271.1579002562203;
        Tue, 14 Jan 2020 03:49:22 -0800 (PST)
Received: from localhost.localdomain ([217.153.94.18])
        by smtp.gmail.com with ESMTPSA id g15sm7349578ljl.10.2020.01.14.03.49.21
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 03:49:21 -0800 (PST)
From:   Jakub Witowski <jakub.witowski@silvair.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] mesh: Add sequence nr getter to the doc
Date:   Tue, 14 Jan 2020 12:49:13 +0100
Message-Id: <20200114114914.25868-1-jakub.witowski@silvair.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 doc/mesh-api.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/doc/mesh-api.txt b/doc/mesh-api.txt
index ebff8492a..d83c68bdc 100644
--- a/doc/mesh-api.txt
+++ b/doc/mesh-api.txt
@@ -441,6 +441,11 @@ Properties:
 
 		This property contains unicast addresses of node's elements.
 
+	uint32 SequenceNumber [read-only]
+
+		This property may be read at any time to determine the
+		sequence number.
+
 Mesh Provisioning Hierarchy
 ============================
 Service		org.bluez.mesh
-- 
2.20.1

