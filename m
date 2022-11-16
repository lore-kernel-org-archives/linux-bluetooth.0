Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A04DDC4332F
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Nov 2022 05:27:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbiKPF1U (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Nov 2022 00:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiKPF1T (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Nov 2022 00:27:19 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C007A2CE26
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 21:27:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id gw22so15546267pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 15 Nov 2022 21:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0VmNoS4IqSO2wjmPc/8fNttFTA1tRb7id0xvRwawHI=;
        b=I3RDXlLiLqSRstkGslS2KnLvcouohvKuUlZ03wmAw9PuxyWU+lb8xfgz1vteHNPWai
         AmaiYwbCqFX0wx5uJr7arIkHt7xouEq8DdREd04qA/j2DGNTs73hs8cJp3tkfKWYK/bD
         Cbov5NDW45wocW3vS1pYi7VwF/SuQ0X9omRRxbMHO9ndp8y2LUlzvE7rJJ1DdiSQKODW
         u4bp+fTkB9umzGv8M2efw3PqX1C+MWX0ykODn+kQp1se4ay7B/Hh/vvjlbCpKiTAJtBk
         j+M431yTrH0EWRPrAEejDLSaz1sf/g3lz/peH2c2Tp90ihfpCl/QfSZpe1XDB4+CQZxB
         zHvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0VmNoS4IqSO2wjmPc/8fNttFTA1tRb7id0xvRwawHI=;
        b=wt92tSsA3GqdbLhVK8tHHHVaZaoJ+Nh0uiliJaJLWKjbZ4zTG4jXjoyRYsRDVMVKTW
         sMY9UaipNx5KAvMgr4DP+NYBB2GGtt1ACPOPId58DwKGghbawZ2Z3wUqrVlB97013dMD
         lKMXgyZvNPumnYJkHg7e87AteL1uHPB07nkTI89mU9vXEvGRCfYM3R4bstthOpzGKOlJ
         nNj+kHsoo/3ulTt+ijQi3nXmj0LASntvLCdREV/B4JNfBfpWJBOK1ycNwFVpDx7tzkiP
         31DMdpVuXEcavJDnR4Bz6uofKJDhP1meHcpnb+HpMGqNS7hq4/DRQvJrUtIh+cofx++V
         R9Ew==
X-Gm-Message-State: ANoB5pl0yxcEw7gsVKGc/rrYH6nL2esS+plTS4lAFxVd4uV860Hvpp1l
        /OM4cZBD4jgUNUFegpoAc5dZlXdCCv4=
X-Google-Smtp-Source: AA0mqf6GyVkprCofPPN5xpIk0JsAg1vuMS/k3LWbg0ysQ+G6paGRto1+ibtLB2lbAfxe+8psEWgZfQ==
X-Received: by 2002:a17:902:76c5:b0:187:282c:9b95 with SMTP id j5-20020a17090276c500b00187282c9b95mr7571359plt.41.1668576438109;
        Tue, 15 Nov 2022 21:27:18 -0800 (PST)
Received: from han1-NUC8i7BEH.hsd1.or.comcast.net ([2601:1c0:6a80:cc40:e20a:cac0:723c:9cb4])
        by smtp.gmail.com with ESMTPSA id x10-20020aa7940a000000b0053b723a74f7sm10098194pfo.90.2022.11.15.21.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 21:27:17 -0800 (PST)
From:   Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Tedd Ho-Jeong An <tedd.an@intel.com>
Subject: [DNM PATCH v3] Bluetooth: doc: test patch - DO NOT MERGE
Date:   Tue, 15 Nov 2022 21:27:16 -0800
Message-Id: <20221116052716.57521-1-hj.tedd.an@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Tedd Ho-Jeong An <tedd.an@intel.com>

This is the test patch and do not merge.

Signed-off-by: Tedd Ho-Jeong An <tedd.an@intel.com>
---
 COPYING | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/COPYING b/COPYING
index a635a38ef940..9960087a95d8 100644
--- a/COPYING
+++ b/COPYING
@@ -18,3 +18,5 @@ In addition, other licenses may also apply. Please see:
 for more details.
 
 All contributions to the Linux Kernel are subject to this COPYING file.
+
+TEST LINE. DO NOT MERGE
-- 
2.34.1

