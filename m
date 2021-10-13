Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6BFC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F7260F23
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 00:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234252AbhJMAdF (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 20:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbhJMAdE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 20:33:04 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A04DCC061746
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:30:59 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id i65so895120pfe.12
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 17:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=6UoyUe+ax+jaKr28X/12cCN2wqR6maKQNLjAocK5Tr0=;
        b=M5g2Gdq2K1CQgIhiugXeF3LSdLf2YOvfIOQEclIVa9UHj1WOaNJsmGLnpzQHsyyA/E
         45g6jyI+cCJjcF1rgagBknnjpcb0nLNvZ3fYcQSiz/wW0w3Es7FokZOp3Jt6fNIsoHu/
         ZeBPD44ejajTkVBiJUnbJF6qgJm5r8M5KvJi4cXIBy0PV08ROfeX2ueZfIokscyE99pt
         pzwsVhQCg2lwjAZpxkyxPlgfJlak96EdFxCocsaNzkGKMg2xk6acQmbvj2Bdj3xlkR52
         g8Heg6JHkw7g9Tv2fUzrfjyxAbHKz3LhITorpujcrxSfoSPNKjFlKhKMogaX+aVUdcYV
         H2dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6UoyUe+ax+jaKr28X/12cCN2wqR6maKQNLjAocK5Tr0=;
        b=iYXa2W27b0bk9fFKKv9rzoeWw2BQYlil/pKxiA4mq6TzAbHAnRtci5sTsINyWx9jV4
         ew6oaNe/6YGrI6mNr2sE4JsHhvnCGZyQyG+mjGjyeCFmYbgAP+mxLTR3CL3CKTQi+7L9
         n/CH5jF+segfmQLCCgNqxGnc2a8X6G0Rwoy6/uq97yrYiiqxSEU4Lso1bMj0MyGUvK9X
         GkixdRx1NimdktponuIDhA3Cx4keNWhqLZMlTLY8IDicdSVCJkV0+hpC+Em9bPdmxNlk
         VZRdzWos0zj1gPORqWES8s6IQFv9u8nnKYhPfv0JrB5LAUReDAppTIp1ab2lQ0/j1eZL
         6pUg==
X-Gm-Message-State: AOAM533eJpI9Rtj0YgEKkKnm7c0J6eqXoonJNpRZDqjycSh79j4zseDS
        HO5d37wf/uDmueO4KWswHtVbvnmdsHc=
X-Google-Smtp-Source: ABdhPJz3Rpn6A1OYpe+Knt21gAyUf3YP5ocZ9E5mD0LHZtRMXHYvjFryfcNJ051KqHzVDcK19W5ggw==
X-Received: by 2002:a05:6a00:b41:b0:44c:4d36:7f61 with SMTP id p1-20020a056a000b4100b0044c4d367f61mr34585980pfo.59.1634085058885;
        Tue, 12 Oct 2021 17:30:58 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id s2sm11839996pfe.215.2021.10.12.17.30.58
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 17:30:58 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/4] Bluetooth: Only allow setting AOSP capable at setup stage
Date:   Tue, 12 Oct 2021 17:30:53 -0700
Message-Id: <20211013003055.2664728-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211013003055.2664728-1-luiz.dentz@gmail.com>
References: <20211013003055.2664728-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The aosp_capable flag shall only be changed while at the setup stage
otherwise it can possible take no effect.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index eb5d4ea88c3a..ac81745d2ac4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1283,11 +1283,16 @@ static inline int hci_set_msft_opcode(struct hci_dev *hdev, __u16 opcode)
 	return 0;
 }
 
-static inline void hci_set_aosp_capable(struct hci_dev *hdev)
+static inline int hci_set_aosp_capable(struct hci_dev *hdev)
 {
+	if (!hci_dev_test_flag(hdev, HCI_SETUP))
+		return -EPERM;
+
 #if IS_ENABLED(CONFIG_BT_AOSPEXT)
 	hdev->aosp_capable = true;
 #endif
+
+	return 0;
 }
 
 int hci_dev_open(__u16 dev);
-- 
2.31.1

