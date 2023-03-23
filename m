Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82A4C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 10:32:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231530AbjCWKci (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbjCWKcK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 06:32:10 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0598D1C31C
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:29:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o12so84265617edb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 03:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1679567341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=36/uaXy9d/2Hy3Md3LDwKTljrKto/ponzkSPHd4rOaE=;
        b=iZvs5harFcb1MesyYLpJtqE3/mROhj9KA5fn0SMGFywesSqCvWchUu8oT2lu8tiU2B
         Or0J7ACkjWvEsWSBjVJ/31cQZxvru0Ny16jTI2/eblnyQ1Q5fHRB+z0WOCoNScuD6FPH
         eeCEnl1dEJ13/Aw8J62G3nVECA3iX8fKtR4GE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679567341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36/uaXy9d/2Hy3Md3LDwKTljrKto/ponzkSPHd4rOaE=;
        b=GBeli6HCreVrVXoXpBPUp1EGroWG/qsJag1H2J33CWQ/CHhLFyL6XUQMz5znZdyiA0
         ACNlapBxEVYvN3r5v9wporfPUJ4t7EbsDCfBk49Dir0iN5mvB5DX+HMfAYQ8zgkOuntU
         I3qH/e5mBX6cCozQmhs32AoUAm08Ifu0Ksknx03EBt0NUCnIGA7yNSKE5NOp/BJyYpLV
         VMEIT3aHbVkEO2hc8QYmLLs15w8wKgk2pF+MPmyZDK2rzmR2Jy2v8ruNz8H0A5ENan1Z
         Sn3rhtHaNghtUJHMCKOLz1Qv5XS53yKg9LBUvP6Z8GrInY+aT4GurscXnUDr8oSRlALl
         5Elg==
X-Gm-Message-State: AO0yUKWh37pPe/sgqy89ZYt5ke4tOU1zUIgbIBDWz6eic3rRI4Y9Tj+6
        iXNFIVi8Mw5CVS33RMO77H0F2XhnLJOg+gIUj/E=
X-Google-Smtp-Source: AK7set+aa4yxXKsubGQ85cSQMC9rzL/03/yFGR66/c4X2hMekDIEUNjUQj5IKtM/ryPz0aoRpsx82A==
X-Received: by 2002:a17:906:1345:b0:92e:b1dd:cff2 with SMTP id x5-20020a170906134500b0092eb1ddcff2mr9623143ejb.28.1679567341273;
        Thu, 23 Mar 2023 03:29:01 -0700 (PDT)
Received: from smi-ubuntu.sueba ([2a01:390:0:101:4f8c:7da4:48b2:8bd2])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906454900b008f89953b761sm8459883ejq.3.2023.03.23.03.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:29:01 -0700 (PDT)
From:   Simon Mikuda <simon.mikuda@streamunlimited.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Simon Mikuda <simon.mikuda@streamunlimited.com>
Subject: [PATCH BlueZ 0/2] monitor
Date:   Thu, 23 Mar 2023 11:28:56 +0100
Message-Id: <20230323102858.566934-1-simon.mikuda@streamunlimited.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello!

I'm sending some fixes to btmon.

Best regards.

Simon Mikuda (2):
  monitor: Fix crash when there is no write handler
  monitor: Fix printing Signed Write Command

 monitor/att.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

-- 
2.34.1

