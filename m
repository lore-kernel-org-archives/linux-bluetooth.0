Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B360CC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 21 May 2022 02:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239378AbiEUCmJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 May 2022 22:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiEUCmI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 May 2022 22:42:08 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E47C5C669
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 19:42:07 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id n145so889029iod.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 May 2022 19:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=OL+FujXizNJi5K4mp/kOrxPYY+gau54KPL71Af2+vms=;
        b=lOyAmSgpN+gJmfeD9rmw+GJdqMpKbkbrg68otQf5z/DRzoaJxXpSRwS0fwusk/4dFD
         5kQMwWYxLpubgKei3PLVO2/eMy3DMTUdc8jywS8WFpV9/OOzv0acd0ag/1GpwRSyQ/R0
         yfrx53RKXI/oAVmDc7Ss1inB3Olwg5wvm/jCNCtvvyH3JG6P2g3bvmyV23WFysS/iGT9
         CWS4AuBsO3Jxtr7FdiLlN7asKKldPmzaGwV71COayWYdddhDbSRIUYJbzri+3Njmg0iw
         tdaXPDXMa98H4w2Zri4Cwb7RbMUTDbOlcbpxCYqM4iE+2TOy6fu13whjnlzN4z1vtkgi
         Pv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=OL+FujXizNJi5K4mp/kOrxPYY+gau54KPL71Af2+vms=;
        b=U97SoNoqXXF5J0AHBuSIOmnNg8mORGmTaXbDJvOAwBRcbRQq0vMEyMfrg8aiB9dTjo
         cysWRa2tHeKmP1r4QKll55ApRFq8tPJkbyWh6Y3wCPQD7YYVJV3LvH40XCDUGnmUgxo+
         9OH3AI4TtfMe9g7/SMRzpcJAt5Y0JWQCahRVWeKYERr0N6qsm3iUjb17u91BXFKJqeRJ
         U12AYBVrZahY1r8bQLhjp/hKpZi+jsJl3i+NjEOn9/wUErMT8TFp58VLTW1CRzQFlh/e
         O38jbx0QOX+mBqkYPxR8uSwkV4CLxMd7AL0f5ryVjzX0w97a1dDkEcNe185scZFTyIFa
         +4xw==
X-Gm-Message-State: AOAM530t293ziX1LjLQdVwbrrc2AsyLmfa6IJWrpWb3BATn4TwpTH1os
        DPC/2TDB0fxMTHaTAkPLmuU/yxbqWd4=
X-Google-Smtp-Source: ABdhPJzsWgQC/TxX9z8qM0Mqmf+R5A+48MBHs4H1brpZDaye2vN+DCPU3sNX7QrMJqTVcF81jfGp8Q==
X-Received: by 2002:a05:6602:2b0d:b0:649:b2f:6290 with SMTP id p13-20020a0566022b0d00b006490b2f6290mr6203219iov.94.1653100926429;
        Fri, 20 May 2022 19:42:06 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.160.228])
        by smtp.gmail.com with ESMTPSA id d25-20020a02a499000000b0032eaac8e978sm382067jam.153.2022.05.20.19.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 19:42:05 -0700 (PDT)
Message-ID: <6288517d.1c69fb81.f2d82.18f3@mx.google.com>
Date:   Fri, 20 May 2022 19:42:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6400437288374257842=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: [BlueZ] client: Fix settingof advertisement interval
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220520234151.19286-1-inga.stotland@intel.com>
References: <20220520234151.19286-1-inga.stotland@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6400437288374257842==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=643797

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.74 seconds
Prep - Setup ELL              PASS      42.95 seconds
Build - Prep                  PASS      0.64 seconds
Build - Configure             PASS      8.42 seconds
Build - Make                  PASS      1388.92 seconds
Make Check                    PASS      11.32 seconds
Make Check w/Valgrind         PASS      432.13 seconds
Make Distcheck                PASS      212.52 seconds
Build w/ext ELL - Configure   PASS      8.00 seconds
Build w/ext ELL - Make        PASS      1287.78 seconds
Incremental Build with patchesPASS      0.00 seconds



---
Regards,
Linux Bluetooth


--===============6400437288374257842==--
