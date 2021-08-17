Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EB4C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA0960C40
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 22:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbhHQWrT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 18:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229466AbhHQWrS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 18:47:18 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C6C061764
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:46:45 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id w68so222190pfd.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AakUyIouEa2A19NyFf2YgLxre/KvVpfpai7uIXPumLU=;
        b=STwOk19r1DMYf+aIEz2DO1gXDqLfjJyNBPg2tNFo+pvb0HMOn/QgLbfEbKmzd1QKFr
         co1BofmxvxY4cSF7OnCw6hGMyk1+x1cK+Dclqb3RPia/8jUlb4+B79rAWs7/NQkY2t+H
         nOLu2AftF16q4iBzReVJsIN35i9ikEViDj5CtEcstl3WKXBsq6pD4FmAoV2fLWKXqoSf
         I8bE9XxHUUB7AoduBGFF4JVMKMpCNhXETaqhZAYmV+YTCytVXzhUBIFFcyIWMXvn1Ceu
         FtgcK+RutavBuydATQ+/R1jWXIfrhtvDOpjzNYKVQZ+q7GEyQc3b9/M9po/DObe0oslo
         zq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AakUyIouEa2A19NyFf2YgLxre/KvVpfpai7uIXPumLU=;
        b=JXH3tbil1XRrLfY9aiYErZesofiSlo0P51DfsXGgU3g7xHPhiwPf19wLAcQ+3RH/rI
         PdVo5V2p/Sm39RBjn+uksZxXK9DNS77fHIOmuMe6HEy7AG/cNuCJj6lpLn8ACzqJKQXS
         klTaQZOKZ8JDv91GHFSwE8sNJdz2XLKFjpdEOHMUyZqtf3tJNbhpXPMYUVy0fgaigNlk
         cDuCEEKNB5keMt2ZjL5YD0+i+ZtqBs+tszPH+NWNZMloHUP0GzQ3Sq032avmG61ulzrs
         Xe5UIvFtVF5B1p9GCnG3O7XqmtsB4+zyVXiv9gytCThdNwfMFZYmMxmyRYzHofzKbu6r
         45Vg==
X-Gm-Message-State: AOAM53116GaVoOP5huLvmeIir56WHgPnrfnq362fzHhQdV7dOiG6G1mE
        6KQ2vxzY2+kZ2Cs84DzKnfUFwTWeamI=
X-Google-Smtp-Source: ABdhPJy40sRWEo5UdiLS4XVCgl5KRbwMqgJZfGguKKUvab/87H8LsIfb+wy38ivhNn9PLl2iviAeVw==
X-Received: by 2002:a63:ba5c:: with SMTP id l28mr5569681pgu.311.1629240404787;
        Tue, 17 Aug 2021 15:46:44 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c0:6a01:d830:9d2d:9805:b76a:427e])
        by smtp.gmail.com with ESMTPSA id y7sm3413326pfi.204.2021.08.17.15.46.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 15:46:44 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ DNM PATCH] Build: Test patch - Do Not Merge
Date:   Tue, 17 Aug 2021 15:46:43 -0700
Message-Id: <20210817224643.412566-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

Do Not Merge this path.
This is a test patch to trigger the CI test.
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 3dc226ff1..1d3eb20eb 100644
--- a/README
+++ b/README
@@ -1,3 +1,5 @@
+
+
 BlueZ - Bluetooth protocol stack for Linux
 ******************************************
 
-- 
2.25.1

