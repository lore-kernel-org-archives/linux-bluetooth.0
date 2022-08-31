Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11BF6ECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiHaRYE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 13:24:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231407AbiHaRYD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 13:24:03 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E91CB5DC
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 10:24:02 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so11285069pjq.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Nvk/Mg/F+oDaf0v0sSB3v7DApTubrR8/caOtZAFQoz0=;
        b=HXLOwL2L0mksowCZi+uBD9O1G2qt4Q4yv8e1B3tsfS3wQtQaT7E6WwG7bCZPLVFKRg
         8wDC7lnb5OM41BZE2dDzDZeUbWxyB4MGTpzZP8h22lCb7VifAC+w33ftO6H8KqhfNsX6
         jNmOG5Hyi6unx/0eV06M5pI3OwlXsIFGS7sdO83U24UNDAyZGzNircvsvrXBLLy+yj35
         WoK0G4wcSH6T0wjECNgKk9EIAlEEdfiYzj628J0GskY7RwexBVUqLML1/GJoG6AgsDhI
         cQFxNd9Xs1k/x4Dw7UGv2eDv+UJiW/Yo7Gz22tjrtxjeOZSfzbaVz2qEacQc+gr3MQBs
         NkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Nvk/Mg/F+oDaf0v0sSB3v7DApTubrR8/caOtZAFQoz0=;
        b=4zjCV93yfVEzH/FYnOmthnnk8IjBdYf2GgDIZLT/lWIRmIQnYb4Qce74ySUmXPNT05
         SqyZKLjZCdfb7/TAOmarZT9HjrIxZaWPt4XBCavEzXaNkUwFnRL1mCNedlrWGEN/ZpBP
         2ODoGFipIpHzTBJgcu86gMt5reogeNS3+hpCJhxdi/qYXJe7HLzvVFlfC2WB4eeIr6jv
         eG7NOhcfV6bt51yRF+z3KLoZXCTvdKMCjLCmlqWT1H52dbT0h9Ht2EQQFegYOd+0r7lc
         NueLMFXejNfMCAdlekEEOhBaKMGbVYn8GqwwBLtphOQ1qrdbZYUQJCsCFcCYiC3T3lcn
         nPjQ==
X-Gm-Message-State: ACgBeo3ZZldddYpycd0zq/q32foLTuoU2rMHnDTGzTvwI9s8V7iq0jFj
        8oesb8yQFBnLqYm4mZZA8QL07Yf1/wg=
X-Google-Smtp-Source: AA6agR4bFa33VtbQNfJdMVYMyi5j9pI5pHWBsyvmGFzZBVDgAwenaNZB2RCPr11FvfJnaQQikSZTMg==
X-Received: by 2002:a17:902:b08b:b0:174:78b0:11cd with SMTP id p11-20020a170902b08b00b0017478b011cdmr20719066plr.124.1661966641890;
        Wed, 31 Aug 2022 10:24:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.86.182])
        by smtp.gmail.com with ESMTPSA id w129-20020a623087000000b0052d4afc4302sm11858744pfw.175.2022.08.31.10.24.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:24:01 -0700 (PDT)
Message-ID: <630f9931.620a0220.65ea8.5c2e@mx.google.com>
Date:   Wed, 31 Aug 2022 10:24:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4107274078311800009=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, cgel.zte@gmail.com
Subject: RE: [linux-next] Bluetooth: remove redundant variable err
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220831155513.305604-1-cui.jinpeng2@zte.com.cn>
References: <20220831155513.305604-1-cui.jinpeng2@zte.com.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4107274078311800009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=672880

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.45 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      42.65 seconds
BuildKernel32                 PASS      37.28 seconds
Incremental Build with patchesPASS      54.81 seconds
TestRunner: Setup             PASS      615.01 seconds
TestRunner: l2cap-tester      PASS      19.00 seconds
TestRunner: iso-tester        PASS      18.95 seconds
TestRunner: bnep-tester       PASS      7.38 seconds
TestRunner: mgmt-tester       PASS      118.09 seconds
TestRunner: rfcomm-tester     PASS      11.07 seconds
TestRunner: sco-tester        PASS      10.92 seconds
TestRunner: smp-tester        PASS      10.85 seconds
TestRunner: userchan-tester   PASS      7.64 seconds



---
Regards,
Linux Bluetooth


--===============4107274078311800009==--
