Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBE1C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri,  1 Jul 2022 10:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiGAKZ0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiGAKZZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 1 Jul 2022 06:25:25 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE5A45528
        for <linux-bluetooth@vger.kernel.org>; Fri,  1 Jul 2022 03:25:24 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id z7so1487777qko.8
        for <linux-bluetooth@vger.kernel.org>; Fri, 01 Jul 2022 03:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=EMud3wYbmmKUtZK4+742RRT2iUBgELQBvtu+iVfg9wU=;
        b=FHhehVSdEpNiZJ8TiHYGDLh6kII6UW7Uy/lcrEl1Bv3mJ1T5/Kcr8lMzg/gRnvZbdy
         /ao5Q3SNyzwfS90bh/Ni8C+Yi7VmwfEB9b/9nn6fB0KOTpnTtDZSmNXl0p4EVqiUXZSL
         ASSt2F2fSNHqbKGzfkND4kkOeHIO0/zj5nOIo6bXWHPG/hPE52/L3aUqxMNinEv4q+go
         YAer41I1ey4MaAvHpxYU1S0lzH+yXnE7GuAeJfx20oSoc7SoRTgn1mum6KTNoY5VD3Ca
         EnTlPAryxzcX8OG/AQTToMJwAIkwnelBCGFnGNpJqvDFhx+/oIWcVC4kCGreWfU1LLTM
         TayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=EMud3wYbmmKUtZK4+742RRT2iUBgELQBvtu+iVfg9wU=;
        b=ZTs6TWgCwjOWiLt6+DsQiOdG3AS0f3GfLQRtNjo6rhTTImjAAXINcpFLOmOv+cLSYo
         2UGvrX1gw69yTN5NwKxYreSz7FwBITRsjUBZ78LhkOuL5h9xnzJv2BPXPtfW9O4BdSSJ
         5k+tNcdm3BI9/1hUPQF3jhZH8TwmRRJzPkf9h89DNBsCJR+sLfy2jrRRHZ13nhFCenKj
         fM08m6KVnpYxCahBfmrEeQS7W8InsFXpxSgtGen1UdKrKyeFjyB360mQZISDSj5dGwz2
         HilZtRXw9Ix84oieCl2YWJERrYMjE7GbbE/b/qnTIRKRs7FcIBFLHkQoLJ1jDwl+uiTi
         +xVg==
X-Gm-Message-State: AJIora+g46fNNNTG68QdjgXb4te1aAQJxE4nttzYEytHQYCXO0DGc77V
        r2XzOadunXiMgKFDwD+t5AmyqL/IJpI=
X-Google-Smtp-Source: AGRyM1uWtlSPZRJKJ89By6MnfnG6RomT1C3/zho/zqId74uw9qh4tcRhrXTt1oU8aPWrAMbyiJ3DNA==
X-Received: by 2002:a05:620a:1374:b0:6ae:e8e5:5e3c with SMTP id d20-20020a05620a137400b006aee8e55e3cmr9788995qkl.607.1656671123191;
        Fri, 01 Jul 2022 03:25:23 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.141.97])
        by smtp.gmail.com with ESMTPSA id bs36-20020a05620a472400b006a6ab8f761csm18369946qkb.62.2022.07.01.03.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:25:22 -0700 (PDT)
Message-ID: <62becb92.1c69fb81.cd732.a3fe@mx.google.com>
Date:   Fri, 01 Jul 2022 03:25:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8927846409546783534=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wangyouwan@uniontech.com
Subject: RE: obexd: fix crashed after cancel the on-going transfer
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220701094102.25917-1-wangyouwan@uniontech.com>
References: <20220701094102.25917-1-wangyouwan@uniontech.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8927846409546783534==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=655762

---Test result---

Test Summary:
CheckPatch                    PASS      1.71 seconds
GitLint                       PASS      1.01 seconds
Prep - Setup ELL              PASS      32.21 seconds
Build - Prep                  PASS      0.90 seconds
Build - Configure             PASS      10.07 seconds
Build - Make                  PASS      952.54 seconds
Make Check                    PASS      12.37 seconds
Make Check w/Valgrind         PASS      331.34 seconds
Make Distcheck                PASS      274.42 seconds
Build w/ext ELL - Configure   PASS      10.30 seconds
Build w/ext ELL - Make        PASS      94.52 seconds
Incremental Build w/ patches  PASS      0.00 seconds
Scan Build                    WARNING   564.04 seconds

Details
##############################
Test: Scan Build - WARNING
Desc: Run Scan Build with patches
Output:
*****************************************************************************
The bugs reported by the scan-build may or may not be caused by your patches.
Please check the list and fix the bugs if they are caused by your patch.
*****************************************************************************
gobex/gobex-transfer.c:421:7: warning: Use of memory after it is freed
        if (!g_slist_find(transfers, transfer))
             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 warning generated.




---
Regards,
Linux Bluetooth


--===============8927846409546783534==--
