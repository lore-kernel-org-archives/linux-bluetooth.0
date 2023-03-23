Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C0FC6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjCWKl5 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjCWKla (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:41:30 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469EC3B0CC
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so84354592ede.8
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Kee+3n1RrsPBTsD+CrAHR1FBqgQq4iOdVLGKQPr0qXA=;
        b=WNrDksroZNi2Nh/ZVMARskZau+Jy/PzENbtXWlb0Ib9bzeImJSYJqbbRYJHzvHUQC2
         x/IUvgWHS4q5lh/T/VfIPt1ToJETY/Uz3q2gk4DoSkeJAafqjF/5QjPI/gvm5Y54MmJ/
         fFuNFyIx4KAuWi4gWO1kPr+vB6OPJKZnktJ3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Kee+3n1RrsPBTsD+CrAHR1FBqgQq4iOdVLGKQPr0qXA=;
        b=PZJz6QxDOlEohCP2WQwtvtOcUS7hZZtgSynrGMmcNT9KmscMUtDWNjjYNDz0CMKcgS
         iQ/ulNgPd7Lf1qz6sg5qCnz1XLA0OP4C2pDvNcEy0CzjNL0Hus6g7ItV6hjw/z7YGvg+
         CSYRAge45bmNKsGEpLl0GazVSgzD0F8BjtweS4DBNgtWjmJ5Mzwoh11TV+1hhDf1GNsp
         KbB27L8LzkT/KRYqRDPTuJ7W837SbduFj2GaGECTXq3SohGXrTzKdoLxoprTDoeJ/xpn
         qrmN4ybTYIO8Qru/dVoIuxMZYjMx6TZOTIC2aEFLEbqkcy5Rhl+DeHeswQBdZzBYDdS7
         Ij6A==
X-Gm-Message-State: AO0yUKVNFCxCTTj0YeJVnQV8mdcph36HqUmvKBbBT8sGQG8iINF1TRAv
        gqH3mfRHf2aazluDk5wqmlfisYh/dlK/udfRt5s=
X-Google-Smtp-Source: AK7set9fn6QSnEMRW+uSetv7fSgZKYjTnLFTGJSdNmOGWH+J2Dpqz6IX1RiMbIIjM1q5otS8N1DsJA==
X-Received: by 2002:a17:906:eb8b:b0:884:930:b017 with SMTP id mh11-20020a170906eb8b00b008840930b017mr11390383ejb.60.1679567918225;
        Thu, 23 Mar 2023 03:38:38 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id bv1-20020a170906b1c100b00939e76a0cabsm3513208ejb.111.2023.03.23.03.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:38:37 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/9] gatt-db fix + btgatt-client features
Date:   Thu, 23 Mar 2023 11:38:26 +0100
Message-Id: <20230323103835.571037-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

We're doing PTS testing in company and I've made some fix for gatt-db.

Also I've extended btgatt-client utility so that we can use it more
efficiently:
- connect+disconnect commands
- don't wait for discovery - you can read, write attributes immediately.
- use bt_shell - you'll have commands history in that way
- you can use: bytes <value> <count> to generate long inputs

Also we've added:
- read by type command (needed for some PTS test cases)

Best regards.

Simon Mikuda (9):
  gatt-db: Fix crash during calculating hash from ATT handles
  btgatt-client: Add option to connect to ATT over BR/EDR
  btgatt-client: Don't wait for discovery on read/write commands
  btgatt-client: Rewrite to use bt_shell
  btgatt-client: Implement disconnect and connect commands
  btgatt-client: Implement read by type
  btgatt-client: Implement common read bytes procedure
  btgatt-client: Add 'bytes <value> <count>' option
  btgatt-client: Implement filter service by start handle

 Makefile.tools        |    2 +-
 src/shared/gatt-db.c  |   13 +-
 src/shared/shell.h    |    1 +
 tools/btgatt-client.c | 1436 ++++++++++++++++++-----------------------
 4 files changed, 644 insertions(+), 808 deletions(-)

-- 
2.34.1

