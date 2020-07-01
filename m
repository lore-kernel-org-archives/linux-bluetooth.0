Return-Path: <SRS0=mBsK=AM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B982C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D925C2073E
	for <linux-bluetooth@archiver.kernel.org>; Wed,  1 Jul 2020 10:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BsVTs5pR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgGAKA5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgGAKA4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 1 Jul 2020 06:00:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB964C061755
        for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2020 03:00:56 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h22so10826843pjf.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2020 03:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1qmXXl5ZAhM0NzsYkJWFojtWCUNBKrIwVskn/btnQl4=;
        b=BsVTs5pR5d3WyVtsRwUfGp7l5ggX5G1hEAXVmw3TOLYF17qMQRWTwohhUwCmCM1k/U
         6exB/CBq0mkKKSe06Qgv8GWbCaduJxq8x2b6ewJagbp/qtjQo3kCPXArVH9n8V2JV6H+
         v2neMmEZwu3q3j2qzaTTg3zxO4++Xpyz8VsSddu7U0FPqSoGAbAZkF1tFLeBaUv4/szC
         GoN3KHIRO8ZMnJUSwDIz/fQP8/UHFwOnZJ4Nn+RHm35tSHygDRI/egnmmGPq6qtcyFw4
         qQTgU4xnodkPMf9mr5b1ZvAzzFg6N66gOsMNoBgtSu3EjGHvCAXV3jQMgDnoZ4MPrTyW
         xVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1qmXXl5ZAhM0NzsYkJWFojtWCUNBKrIwVskn/btnQl4=;
        b=lac9Qn9gsMJOg/oZ6VgH22DoDf/EdQnMp1Iy8rDOu/bfzE2KRiuhr/pEW93xFYOVca
         x1smTgW3BYpPaHj01kAjcO7+8v+qSQMn0O/o8u/zTSloyXE/iuBmisOwydkW5cE6QLj+
         V0Lm3Ub6P2j1zbR2TgsRWmI1yy17hgoJD7/oqtyB7CNocviPsPzUDzRrjnKyNXAiqSfv
         wgAjWbsAe4tMcCNMAqEES1YCRwKrQ7uyZCo0TLanLCpLqcjan8CxmTj3KrfYN+rDlaB7
         chgNWUFI0j0F3j8HWaRcRBmdrHLN9whYvkGhkc++dxO1MW0VpwfgowGVm+fa1QO/tef8
         RaqQ==
X-Gm-Message-State: AOAM531ANOjkaWgSJNFHTEvJ54z82DTi5+wpP9r5TQH4yKNEHRhA0GXV
        XmIbqvhamyt0Nnyv1nL2Xuy0Dc0w+Lw=
X-Google-Smtp-Source: ABdhPJx7N5OT+j+URwqfDwbO+2RgSK857bLcz5H7pas7DLY42eJttHfEoK3j0Q88/cwRogC/r+4PIw==
X-Received: by 2002:a17:90a:de94:: with SMTP id n20mr17096644pjv.125.1593597655818;
        Wed, 01 Jul 2020 03:00:55 -0700 (PDT)
Received: from nsathish-Latitude-7480.iind.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id d37sm5381961pgd.18.2020.07.01.03.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2020 03:00:55 -0700 (PDT)
From:   Sathish Narasimman <nsathish41@gmail.com>
X-Google-Original-From: Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH v3 0/8] LL Privacy support
Date:   Wed,  1 Jul 2020 15:34:24 +0530
Message-Id: <20200701100432.28038-1-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

v3: rebased the patches
Add support to enable LL privacy using mgmt with existing
set_privacy command

Marcel Holtmann (3):
  Bluetooth: Translate additional address type correctly
  Bluetooth: Configure controller address resolution if available
  Bluetooth: Update resolving list when updating whitelist

Sathish Narasimman (5):
  Bluetooth: Translate additional address type during le_conn
  Bluetooth: Let controller creates RPA during le create conn
  Bluetooth: Enable/Disable address resolution during le create conn
  Bluetooth: Enable RPA Timeout
  Bluetooth: Add support to enable LL PRIVACY using set_privacy

 include/net/bluetooth/hci.h      |   9 ++-
 include/net/bluetooth/hci_core.h |   3 +
 net/bluetooth/hci_conn.c         |   7 +-
 net/bluetooth/hci_core.c         |  17 +++++
 net/bluetooth/hci_event.c        |  22 ++++++
 net/bluetooth/hci_request.c      | 123 +++++++++++++++++++++++++++----
 net/bluetooth/hci_request.h      |   3 +-
 net/bluetooth/mgmt.c             |   8 +-
 8 files changed, 170 insertions(+), 22 deletions(-)

-- 
2.17.1

