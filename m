Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95079C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 05:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69C8361100
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 05:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhJHFo6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 01:44:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbhJHFo5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 01:44:57 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5268DC061570
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Oct 2021 22:43:03 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id k23so6748713pji.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Oct 2021 22:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb8KnJ3skiflfLlObqVQY/XrKpSYGl1Yg0t7YexW514=;
        b=civVxl+LNWUFYAB2cxA/76xTrYmzFhQ009ZIt04oGy6UXluAZbrxB8nFhQ42a1pf2x
         D+k6q5PfxkZXd/CsmGvW+ZjwELDC5LPXYd6sbSPSwFsyFwi7sfamRiLJmCziB6Uyp5DO
         zVVldMqgZ8AkipiWjolgmQIr3VEfJ13wJpjZaAOkwS/sBhTnrHvD9RYXsAipDNOiFrXa
         irfISDf4rcpXwlkqOAmws0+oS/TxnOm43c9kJPrwEFUXlwWmuUNeAyHAys34ktNZZ5ZQ
         DbUn03iTRvcxpPoi8n6Yu61eqL7OrnhrIBXkZhWTjY64fWNubi+UwzqzpiLbQbXUcyjA
         gTiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Tb8KnJ3skiflfLlObqVQY/XrKpSYGl1Yg0t7YexW514=;
        b=CJFADWX1NSl0MJfj9H1s5/VsQ4/PkQ63ah8uyMznpIQ3qivhKk6yDzHrFV/a53ZDUw
         w61bxL6ACROrrpbOn5fRbXua0QCWIIcBSGgFzy3N+PXz2ccBpnQzmQiwI0ELlKdYRBUG
         2t6KWY913UXIwoCsDE638IH1KvrqUiKtTNWYbvh9XHj6+gDXyfwzcSZiiE7uP2QEKFnT
         ZoGWaJ/qhofLtuMI7sCIVSRsoJ7fJG1gbuZUE9XiA2SrTJYNud2WzqfUDT3mf5nT0R5D
         SKz1PMF07BInQN4EWJAuvHLstxUwt/9wSxRgCqF/SoJHvc5Aulg7gaB9QJe1XN2QN4Ch
         nV1Q==
X-Gm-Message-State: AOAM531CPQKus0j3kxEz104UOI32MaRyJMuOqTVRDBU0bsHHg0FJgkyq
        sz2Xkl+5pK/ck9P/gTD56GpGYrJMvr+4yw==
X-Google-Smtp-Source: ABdhPJxymD8mF/dcDYTG5gvmbTudVyKNDRTY48qwM5RUeTvQob6PXu1prpZ1r8YBg4FMLZ6sOYfFoA==
X-Received: by 2002:a17:902:c214:b0:13e:cc54:7ca2 with SMTP id 20-20020a170902c21400b0013ecc547ca2mr7726340pll.52.1633671782407;
        Thu, 07 Oct 2021 22:43:02 -0700 (PDT)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a01:d830:3e91:8dc3:f28b:c60b])
        by smtp.gmail.com with ESMTPSA id x23sm1266315pfq.146.2021.10.07.22.43.00
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 22:43:01 -0700 (PDT)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [BlueZ PATCH v2 1/3] doc/tester-config: Enable Runtime Debugging Feature
Date:   Thu,  7 Oct 2021 22:42:58 -0700
Message-Id: <20211008054300.27989-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This patch adds CONFIG_BT_FEATURE_DEBUG=y in tester config to enable the
runtime debug option.
---
 doc/tester.config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/tester.config b/doc/tester.config
index 892fd5eb3..011475661 100644
--- a/doc/tester.config
+++ b/doc/tester.config
@@ -32,6 +32,7 @@ CONFIG_BT_LE=y
 CONFIG_BT_HS=y
 CONFIG_BT_MSFTEXT=y
 CONFIG_BT_AOSPEXT=y
+CONFIG_BT_FEATURE_DEBUG=y
 
 CONFIG_BT_HCIVHCI=y
 
-- 
2.25.1

