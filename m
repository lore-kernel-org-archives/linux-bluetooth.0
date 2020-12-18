Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30834C4361B
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD4CD23B83
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Dec 2020 19:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725843AbgLRTHi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Dec 2020 14:07:38 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:41065 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgLRTHh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Dec 2020 14:07:37 -0500
Received: from mail-ed1-f70.google.com ([209.85.208.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <dave.jones@canonical.com>)
        id 1kqL5c-0004Fs-0j
        for linux-bluetooth@vger.kernel.org; Fri, 18 Dec 2020 19:06:56 +0000
Received: by mail-ed1-f70.google.com with SMTP id cm4so1494127edb.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 18 Dec 2020 11:06:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hb878HLWQcakkKzB1vi2USbhdF350viU3WRjzlWIL04=;
        b=RgGykoC8058eQZEBqzD4piYqYtGRlXuiMwJ0cIG75h5MSQ6dN1QM4xFlDh1jqYJh8P
         InxyaCN2XrU9Pm3C+tWM2U0qwFzUFZnMGu5ZkILl2bE+4WsO7KDQEUpI9pDgpZcy4KHE
         GdVp5f8N40L5xmqlZvM4L6UWyL/BvMatsMCwp4obASMpktH4ZZuiw6HghAK20Hd9ArJ1
         6Ci88rKxCROB4w7z5ZgN3dz5s5oizmsr5o3jcZHHA9/o49txYzhUSdwVkO01diggNdcX
         lZ2X9T2LB46MPnx2JS0KXJkY1Or1HBc5tFG8rYYdlEbs4z200vc1Qg0JDbjWw3QE4pon
         ECPA==
X-Gm-Message-State: AOAM5321S4roKOKI8s0wavInFTz1e2kwTYP3RvO2kXNBnU2JyJ8K58CA
        ayS0lMUPb2SHeYBq9Cq7jTS3tMpQxs4JurRErbQLaIlI8xPWiNsnXYRLtAWl9aLSNSQXz9tzPEe
        EZULGWRGgm+8kplfBu+GKN1abPyq61RitD+Gyeujr6Nu7mA==
X-Received: by 2002:a50:8b22:: with SMTP id l31mr5944294edl.149.1608318415374;
        Fri, 18 Dec 2020 11:06:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwgh3umpmdP5gzixgEhNZESznLg37VLkLvo2o/5uuMTarJFmMOYQmmEgvWh6jt8sxPV/t/7pQ==
X-Received: by 2002:a50:8b22:: with SMTP id l31mr5944271edl.149.1608318415157;
        Fri, 18 Dec 2020 11:06:55 -0800 (PST)
Received: from localhost (waveform.plus.com. [80.229.34.140])
        by smtp.gmail.com with ESMTPSA id e21sm25210073edv.96.2020.12.18.11.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 11:06:54 -0800 (PST)
From:   Dave Jones <dave.jones@canonical.com>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Dave Jones <dave.jones@canonical.com>
Subject: [PATCH v1 0/3] Support patches for Raspberry Pi boards
Date:   Fri, 18 Dec 2020 19:06:06 +0000
Message-Id: <20201218190609.107898-1-dave.jones@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

These patches are derived from Raspbian's bluez variant and implement
support for the Bluetooth modules found in the Raspberry Pi boards up to
and including the Pi 400, and the two UARTs that can be used to
communicate with them.

If these would be better submitted as individual threads, or as a single
monolithic patch, please let me know - I'm happy to revise things!

Dave Jones (3):
  hciattach: Add BCM43xx 3-wire variant
  bdaddr: Treat Cypress devices as Broadcom
  hciattach: Enable loading BCM43xx firmware on RPi

 tools/bdaddr.c            | 1 +
 tools/hciattach.c         | 3 +++
 tools/hciattach_bcm43xx.c | 5 +----
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.27.0

