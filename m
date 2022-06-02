Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED20C43334
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Jun 2022 19:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238383AbiFBT6z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Jun 2022 15:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbiFBT6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Jun 2022 15:58:54 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E089D1
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Jun 2022 12:58:53 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id s12so5398803plp.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Jun 2022 12:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=qzKUZS9cPsRn3cxWPvtE/Rj7D4XT3RI+8nwJznPBAVk=;
        b=qZA/8PWpXLr9AYnSJtgzdXyIGIvTUMiu4WhlS4OT1jrRUsP1V3P4p6rSOiYAeor78l
         qHPGLbbdDe4mWOaTqMkhMans40Zx16cl9DCj24w0n2Xvl28lc1+ec0WunQ2rKUFqA6cd
         5jnBSHUv+kYuQAMlH6y3H/ItuXPzpUj0ZOpoaBW9T+oqd+c9CgxOosHBk8HBE4/lh/DO
         Eq5ZGJA1gJ5fp3BjJ6T+jllX43UXUoWyQZGIPbK2bLf7oZUpuuVQijgr7JBWVsnLq+TC
         djOGvLovhnYgipHhAOXZZYUqco+5PxcnG5QZCiHgP8a9CLAkTDU7cpMMCVw4a+mM0bFe
         L1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=qzKUZS9cPsRn3cxWPvtE/Rj7D4XT3RI+8nwJznPBAVk=;
        b=wm9N60E+TvZzjgz/CbPUhX7yTcOEQLiIUFUSw5c4acJWfpPvYCtyZbjm78J59qx5YS
         ws4wnoQywcrxVaVnNXG93UeQwg3T8IM8opfPrX/Dpr9Cc7GD8nMbMZcAOZwDd9FulhGh
         17ZdzCdERiqIkGGxDmFfbeHlOHidFzdCaZzidCpKEXM0cVuFDbrO1foi+HsMNBRwNmh0
         CYQsnfGWxtBRUqjNKPNf75erqj4HGE/sEE2FeG9HGd9j6XXfW1GiX8R3/LPfNJy+0s5+
         Yc6iQKdfm8J7iKlPENZrT0FpS9D7oSispXVkdhEmFlBm4f4/IbWzu6am+KOZX6QwvNiR
         cQZA==
X-Gm-Message-State: AOAM532x/Gbf91fOu272qIHyMhG4iedRkqIarHLJuo0+HaljDjd4G5AC
        osw8bdgvaVz1VMpNK2U92jjGZTIEConE9g==
X-Google-Smtp-Source: ABdhPJwAhdQrgrMpGgvUkXnF/TfEQkAuFq16gud+h0LRCEbXDkDjQYJ329+GayVU4LIxBHhdH8i6gQ==
X-Received: by 2002:a17:902:a406:b0:161:1642:692f with SMTP id p6-20020a170902a40600b001611642692fmr6436076plq.134.1654199932637;
        Thu, 02 Jun 2022 12:58:52 -0700 (PDT)
Received: from [172.17.0.2] ([20.125.115.72])
        by smtp.gmail.com with ESMTPSA id z28-20020aa79e5c000000b005184af1d72fsm3982554pfq.15.2022.06.02.12.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 12:58:52 -0700 (PDT)
Message-ID: <6299167c.1c69fb81.c0ec0.8c88@mx.google.com>
Date:   Thu, 02 Jun 2022 12:58:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3811416908226714360=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, schspa@gmail.com
Subject: RE: [v2] Bluetooth: When HCI work queue is drained, only queue chained work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220602191949.31311-1-schspa@gmail.com>
References: <20220602191949.31311-1-schspa@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3811416908226714360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646968

---Test result---

Test Summary:
CheckPatch                    PASS      1.32 seconds
GitLint                       FAIL      0.56 seconds
SubjectPrefix                 PASS      0.40 seconds
BuildKernel                   PASS      37.80 seconds
BuildKernel32                 PASS      33.80 seconds
Incremental Build with patchesPASS      45.84 seconds
TestRunner: Setup             PASS      566.98 seconds
TestRunner: l2cap-tester      PASS      18.27 seconds
TestRunner: bnep-tester       PASS      6.34 seconds
TestRunner: mgmt-tester       PASS      106.26 seconds
TestRunner: rfcomm-tester     PASS      10.02 seconds
TestRunner: sco-tester        PASS      9.71 seconds
TestRunner: smp-tester        PASS      9.88 seconds
TestRunner: userchan-tester   PASS      6.58 seconds

Details
##############################
Test: GitLint - FAIL - 0.56 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: When HCI work queue is drained, only queue chained work
49: B1 Line exceeds max length (84>80): "        - Move the workqueue drain flag to controller flags, and use hci_dev_*_flag."




---
Regards,
Linux Bluetooth


--===============3811416908226714360==--
