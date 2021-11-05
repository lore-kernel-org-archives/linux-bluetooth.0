Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E38C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 16:57:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4BC2610D0
	for <linux-bluetooth@archiver.kernel.org>; Fri,  5 Nov 2021 16:57:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbhKERAV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Nov 2021 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbhKERAV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Nov 2021 13:00:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76661C061714
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Nov 2021 09:57:41 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gn3so3460681pjb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Nov 2021 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1B5bU4roHeJjWa1sv9PYTg2xk2377dqrQzSk9tMM2eM=;
        b=q3Q5F3GLMhS6di+UKawcqTNbj1/msGEfvoCEjspCa/CaudVzwfy9ZVnwVo+NXPB7f2
         8oby/WsW2kvBLAMO0YopLO2SCCH5k8XF+omXksnQc0t0l5NBMpFDgkSwL6cN/W46HGBB
         H4KEgoKfc6LaYz+gCYw6wLtSQZxWxfxc04agA8XM1z6/8SltRbwK0z3w+EevRffgmmii
         x2Mvq3uIq4LLADTm8+dc74xCkAstDTvkfi5WldpIdtgiPQuKkfhLms5frqsMqOwoEllH
         DSXSBujxYVlBhvhmuBsc1U3vcylE6i6txRK8zN4LLmrLA5yVMwud3EgdUWDC9W8J+5gA
         l5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1B5bU4roHeJjWa1sv9PYTg2xk2377dqrQzSk9tMM2eM=;
        b=buKJ2LIJxR3gKJpnpsPFjic1USMjrjH04uLrndZ6sX82Q2SyJu1rFtIG4vm2JE0RX6
         VB2JMJ6bdmYSDg0/d6WfO/uYoNvUb9IkY7BB1/tH7uZOi2JGMAt58K/BZU0C2B890PBX
         gOoSObUYzito8W70KtkLAtRTPFlhjSRHFeCwraKjro0gJB5y355mYDGmbDoOCTd6Di5u
         iYpalEedyHspEC0mgim9AYpwAX7A8fOBuBQsGLxmGSOzRoWjh7ODHM4qnz5fJKprkH6T
         J9cCUsrKGcw63g+rEefyBW76mF+YIgdOrU15sO4mOZlQRaiFHc/xK+PM0Rf1OFYs0fdk
         asmQ==
X-Gm-Message-State: AOAM531sZ1n51cH4YwKGrucbDolJkKuoogqwXEKDpuFBMk0DqFcxw9Nc
        rKdKIlek2gwah+tA7Tyojd5xOhL+eFdIuA==
X-Google-Smtp-Source: ABdhPJyS84gduvdRuvnUa4MGt+fDycfVyYG/FR5DU7AbTNdK1+RMStXOqKv+ztQaB1jcX0PpV1317A==
X-Received: by 2002:a17:90a:9dca:: with SMTP id x10mr31660546pjv.170.1636131460802;
        Fri, 05 Nov 2021 09:57:40 -0700 (PDT)
Received: from localhost.localdomain ([69.196.88.170])
        by smtp.gmail.com with ESMTPSA id k73sm6361486pgc.63.2021.11.05.09.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 09:57:40 -0700 (PDT)
From:   Jefferson Zhai <goodgame13241324@gmail.com>
X-Google-Original-From: Jefferson Zhai <GoodGame13241324@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Jefferson Zhai <jefferson@zhai.ca>
Subject: [PATCH BlueZ 0/1] *** Meshctl "sub-add" command oversight fix ***
Date:   Fri,  5 Nov 2021 09:57:34 -0700
Message-Id: <20211105165735.13606-1-GoodGame13241324@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Jefferson Zhai <jefferson@zhai.ca>

What motivated me to do this patch was that I noticed that the meshctl's
"sub-add" command in the config menu strangely did not support adding 
subscriptions to vendor models, while all the other similar commands
like "pub-set" and "bind" all do support vendor model IDs. This patch
fixes this odd oversight.

Jefferson Zhai (1):
  FIX: Fixed oversight of not supporting vendor model in Meshctl tool's
    sub-add command

 tools/mesh-gatt/config-client.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

-- 
2.25.1

