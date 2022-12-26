Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A99C4167B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Dec 2022 00:55:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbiLZAzh (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 25 Dec 2022 19:55:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiLZAzf (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 25 Dec 2022 19:55:35 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40461E7F
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 16:55:35 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id u4-20020a17090a518400b00223f7eba2c4so9508360pjh.5
        for <linux-bluetooth@vger.kernel.org>; Sun, 25 Dec 2022 16:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=n2VkbX3Z25q2qP5aLvxzErczZPWPbnw0jFBKn11DChg=;
        b=lGS9R0CCRslMR8ApgJeNEkPyJKGgsivIks1y6kXQiHVaTub4UUuDRU4F1n7C0gHvhV
         t+UB5kokkKVW9Mk/AEI4ahk8v/bxP90AHemtgzjGEnv/atEL59GZ2B9zt/dH0tTqZLHE
         YfCuUoqSE2BIoBMEJj6jOZmqEcqWRZtOP/ukfbhMRm0amXEpG/qPnBPV0cD+mfoFbhC6
         VRqbKmq4S/CdO1eyVpC1dFxJXDz4hUdo+2pQlvlpJHTyDp/LuJ6qMFG1PWpCK77k9wUB
         rW7aPdwMsWVD4NRTRGi2VXh1k6OSobddSmZwROH5X/9Cg+NsomoY6gR90CKtc5WAzND5
         PCGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n2VkbX3Z25q2qP5aLvxzErczZPWPbnw0jFBKn11DChg=;
        b=MuXEM0KRQ5NE6ZoHLTfcyouMBmxygpnT+Va5atxzbn8HQ/73dr8jwUvYrwZGAFJC12
         L6/XlvmJdzddugCmmNR+ZBImTH+0mFo1Io+RHyBVkMv+zSd2G9+hL8vxKg2n5Ov5CpcR
         E+pikiaRd0hMpR74DaxLh9+gnUu5cCJWZwUPX+6y/WFjLyKM3WtOtVDzv1g5xcEoULLe
         f0JfjRVIF+iQCvKzXdmmjXUPbj0BsmfrrLUdn4anFIk3Ycy9alIdN2FFN1ZfJ32PoEcp
         mORvMyRSwMDG3lhkUZnTFLOLSv60+QLj70KxogPCz9QuyQX/39k0v9noivdMvH/y5JHE
         5BRw==
X-Gm-Message-State: AFqh2konkXt28doKURbPFDdbyHtDLo5+XvFmFndaDLZ391MfYw2AbbUc
        3gV5q8Pal+9BLXTFBoYy290IUyVBaxealQ==
X-Google-Smtp-Source: AMrXdXuRDmzPcogPLIqSxiezvT4+CeDMNw84CxJHawWVnmpSDrrFvL8fUrZnwW3scCQCueGJ/qJHFA==
X-Received: by 2002:a17:903:2603:b0:192:6854:3ecf with SMTP id jd3-20020a170903260300b0019268543ecfmr7330072plb.31.1672016134500;
        Sun, 25 Dec 2022 16:55:34 -0800 (PST)
Received: from fedora.hsd1.or.comcast.net ([2601:1c0:5e81:6f50::f30b])
        by smtp.gmail.com with ESMTPSA id x10-20020a17090300ca00b00189e1522982sm5842122plc.168.2022.12.25.16.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Dec 2022 16:55:34 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH v5] Bluetooth: doc: test patch - DO NOT MERGE
Date:   Sun, 25 Dec 2022 16:55:32 -0800
Message-Id: <20221226005532.119835-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch. DO NOT MERGE.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 README | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/README b/README
index 669ac7c32292..f6fd6fc4d1bf 100644
--- a/README
+++ b/README
@@ -1,6 +1,8 @@
 Linux kernel
 ============
 
+THIS IS THE TEST PATCH. DO NOT MERGE.
+
 There are several guides for kernel developers and users. These guides can
 be rendered in a number of formats, like HTML and PDF. Please read
 Documentation/admin-guide/README.rst first.
-- 
2.38.1

