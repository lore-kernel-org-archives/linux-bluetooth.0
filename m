Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955BBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Thu, 12 May 2022 00:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349653AbiELA2f (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 May 2022 20:28:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349652AbiELA2e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 May 2022 20:28:34 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819311A6AD7
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 17:28:33 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cu23-20020a17090afa9700b001d98d8e53b7so4987340pjb.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 May 2022 17:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blac2gkekiCR/N+3veVySx5+NNNuZs8L9MfqZlFBgdc=;
        b=irfI1QRFl4Tjv05wzuIRdfz3UkOSb367d7ooSE+K2AldjVsLgjUQdkrLpIR26itHQ5
         5NTKYnrKBhedmozeKHy/pTPIZeByXkjmo93h8tcDMcGezqDWx+HGP2SFIssmNOypqoAM
         agukAgZJEWd+PSkyZ5CuUTaWlhpzFWW0rgmUINMtK4FJ0W2ZyxtSiBrRFW5Qn161eQUV
         w9Zmdo2CJY435RMc/6b6FDIyXLMcF9U7g/lH/w+V4A8ud9oEwRlqfXwp0nEi40M7CN99
         n7xTEGChcZOEc+8J44p34gAplegc71UfX8YlhL39k9wS0JPLpR45T8skyGgPz3PjvDZ9
         vNNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=blac2gkekiCR/N+3veVySx5+NNNuZs8L9MfqZlFBgdc=;
        b=tSCngj5LbYJWzq4l98PJFHukNZsYOsmXyUgYwWmvc1NmyzG2Z1xoy7J1/8cMHSzA3T
         1wWtQrBNOgxgunzbSxkUOz/rVvmlCp+4Bo4xht95E65pFKR9R7fXkuZis28qcdTRrkTZ
         yoK9zVpfVFlS3jale2DGRz30H9UnmNJGsBLcDVA8VqihpAVon55iWgzI4BR66edB6jXZ
         wwoLUuOVqS7FmjnS1NEtkbGhuwRTSj+oXrcCSQ+N3EXFkvgJYs+qW0dR5/tglPbzQn6C
         7z/w/ucIMnE8xboiTkFvFp2bYIzkpDx/LEPzUICKwizzMwUFAdiVBAAFt+vKC2Y/D46w
         a7Hw==
X-Gm-Message-State: AOAM530Nbbq16EEi4vcyEIYK8R/sgDZIBpU5UDPaSXTZwhZiFbnzhpSo
        7q1ZgAt7VRhifWEXXnF9hEQZIRP0viY=
X-Google-Smtp-Source: ABdhPJwPl7+xZOnISan0xo2YyuxpCedKuBpPFa4n+tIX3t1LIfM9zQb6jc3Ux8mDTLsLBNe/koBE5g==
X-Received: by 2002:a17:90b:3904:b0:1dc:8fe0:df69 with SMTP id ob4-20020a17090b390400b001dc8fe0df69mr7830260pjb.59.1652315312632;
        Wed, 11 May 2022 17:28:32 -0700 (PDT)
Received: from lvondent-mobl4.. (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id 4-20020aa79104000000b0050dc76281d5sm2353721pfh.175.2022.05.11.17.28.31
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 17:28:32 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: pull request: bluetooth 2022-05-11
Date:   Wed, 11 May 2022 17:28:31 -0700
Message-Id: <20220512002831.823565-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The following changes since commit 3f95a7472d14abef284d8968734fe2ae7ff4845f:

  i40e: i40e_main: fix a missing check on list iterator (2022-05-11 15:19:28 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2022-05-11

for you to fetch changes up to 103a2f3255a95991252f8f13375c3a96a75011cd:

  Bluetooth: Fix the creation of hdev->name (2022-05-11 17:18:42 -0700)

----------------------------------------------------------------
bluetooth pull request for net:

 - Fix the creation of hdev->name when index is greater than 9999

----------------------------------------------------------------
Itay Iellin (1):
      Bluetooth: Fix the creation of hdev->name

 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_core.c         | 6 +++---
 2 files changed, 6 insertions(+), 3 deletions(-)
