Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C991EC63797
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 Jan 2023 23:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbjALXVc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 12 Jan 2023 18:21:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjALXV3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 12 Jan 2023 18:21:29 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D6F11473
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 15:21:26 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id c133so16530385oif.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 12 Jan 2023 15:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zOPkcjVsSmSdjRmNnY2abwBKS1g5ZjrtXRlyMy4P0uM=;
        b=WQw//2Suz2+1K70eXdBEn9ZLpwPiCqA65K8+gUkThnVgZOYd6LdQxlnHcC6To/K4G3
         YgsIXotLn6yrBybJruWsNW1rPO74gwNCpetM0rqVzFk5Y+d8jcBcA0hh6DS2jlquBn0k
         5QlZEHp8c+nOp/ZKtAxAR8aso5lI2oPmE3igtzLsch0x0kOB5p8PeXEikNZ1L62LDA4W
         5Ka11ZGIizHONQnf7SVvERm9lgWqowavLHZ/zNIjA8XDby3cts1XDVSDiCCeEAPaLJ5U
         KiCdNfEYRbPBLnUwbOpM/8i1seeJ/8GVIqK/JbHRHOFkYnXtJRtHabx22MxgkZTkykeK
         5D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOPkcjVsSmSdjRmNnY2abwBKS1g5ZjrtXRlyMy4P0uM=;
        b=c5AlVafRhe2xaS0mEEEx49dOa/4adiC82Kntzz0JpLF53u8ONLS65mZ0r7VXk0BSHT
         3+6kwoYdvBmb6un4lNMaXTVnunhnodWS3nOHaIewX/F6Wt2A0FNnuFXxfsDHw4Wy0d2s
         GRRfd2t2u/RDf0oyukA0FhbQqXWvvSw0QWH/GDaNeVA3JwH2cmxX0uvMOsu9xtlI8txg
         4+tZVE79D8LSO/GGMmLICpIVjUyud2WLLC4SNn8KWIG/ikf32IuLQlv/B8SVKewn64Eo
         ZOHYNFmLk8APoQP3pkLiAA/6qPgucfPOpiSMIFVRqJBlpGFCbwKsGwgWW8xhF9L7QR+g
         NBcw==
X-Gm-Message-State: AFqh2kr3DearsUvU0iExDs8F59+ZcJJbK57RhSWFR79H04JiyuBGccIo
        1NyqUWM+dCkOtrf5zMbT6F36nGe4WJc=
X-Google-Smtp-Source: AMrXdXuvuCAUxf/FPrmdp3HPg5yRqdZkejNM6eCL33vQaNbNt+5/sRFw0fgk1SiO2XSa379W79KP2g==
X-Received: by 2002:a05:6808:189d:b0:360:d0db:d3c2 with SMTP id bi29-20020a056808189d00b00360d0dbd3c2mr5079501oib.15.1673565685562;
        Thu, 12 Jan 2023 15:21:25 -0800 (PST)
Received: from EDP-LAB-JQIAN2.PD.CalAmpCorp.com ([69.110.165.186])
        by smtp.gmail.com with ESMTPSA id k22-20020a056830169600b00684c7de281fsm1028827otr.6.2023.01.12.15.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 15:21:25 -0800 (PST)
From:   Jing Qian <jingq77@gmail.com>
X-Google-Original-From: Jing Qian <jqian@calamp.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jing Qian <jqian@calamp.com>
Subject: [PATCH BlueZ 0/1] *** hcidump: fix array boundary issue le_meta_ev_dump ***
Date:   Thu, 12 Jan 2023 17:21:10 -0600
Message-Id: <20230112232112.212021-1-jqian@calamp.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

*** BLURB HERE ***

Jing Qian (1):
  hcidump:fix array boundary issue le_meta_ev_dump()

 tools/parser/hci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


base-commit: 4e2ae14ea31178ebbbcb0bc81dfe74bd56b4885f
prerequisite-patch-id: 575020e7a5c285246441a91a4273d7eadaed45ac
prerequisite-patch-id: 6d2faa9ddc42fb2e346c0708d7624f9e7ed67c98
prerequisite-patch-id: 039c4d44eae6e358148da5a1d04a3ef9602f6a67
prerequisite-patch-id: ec5b1c0ec7a429dbbbf0367adb61b191ee231b59
prerequisite-patch-id: 6ea9dc8e56804c2755e9dc8cdc811690fb6c2c17
-- 
2.25.1

