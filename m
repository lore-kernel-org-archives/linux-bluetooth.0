Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9887EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat,  7 May 2022 13:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238574AbiEGNZC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 7 May 2022 09:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbiEGNZB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 7 May 2022 09:25:01 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADFB36177
        for <linux-bluetooth@vger.kernel.org>; Sat,  7 May 2022 06:21:14 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id s4so7826652qkh.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 07 May 2022 06:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=uI0csNWsiA8RM0yVlx/Oyk6gzPDPFdyjUkNEcybLUVY=;
        b=eoCgTimQhlwkiKsf4zmZPV3KaUMGVNLF5QfPGyqiQDGQLQr2tR95vsxTSjxCV3r5MR
         cupT5qzsBzx/6zHzz+1iQcbsSTg5Rc4D2PYj1vgPioMugmHIX2VFh6uFdbs6nPpVJVOf
         XSnEQYzslWuAEipOwyd6pEv2mArYv339wg4aTuACDUn+Y/6AQxJKG22QsPgv82aFP0AI
         A3qB5P1OfGPNydEYta88SGV7JDOakClMhEfA5g9HWHXyJ34LTrX4/WumctGuZRhrcuKu
         bPQqh9hm2Hsub7xfSevjSic1+HL56QkW3kKfIDwC/qXn4pxKG+ohmbSy0bX9WYmtNbyD
         mHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=uI0csNWsiA8RM0yVlx/Oyk6gzPDPFdyjUkNEcybLUVY=;
        b=ciJ0GSU5fAqOs1er8zET1r1OduZffcnGYZLHPILAo8M1oOtIgpv4a2zsAy2eMaPtXk
         i+HS5zn56+OkBTvNqd/1I3BbPzfdjLUL3APQj3ufAQqSCcKdvLbRJTd9DKLbE5qe4BCk
         kOAsdfBy/kh0Psq1r31jMYRP+mSJgJ2g7slZbCRxU5Pgedtjhq96oLyvN0bSrkpWUReN
         7RIfuP0kV2iajmHBhMq/zqzHNXDOUyWDMWcepevmIQartE54C2Sp7OG1Q0tNe0OFNT+3
         cFydN0Nmt0pb8+bfQS91QL7mEEJmiLEJimqyaGHWZlqPg3DHCcrnDOHjYD7ucUO0anaH
         PBpg==
X-Gm-Message-State: AOAM532Bw8djL8dezBJvpRUCKMZpVMNKjIcS1Qg19lcu5Rf2Vl6kxgPP
        nDO/x4RuyCo74m63r2XyqhKmL3lo4e3sgw==
X-Google-Smtp-Source: ABdhPJyoKzimg9Y2z7g3QQMZFEau1q2bDlJ/h4pfA4NzGH7ZAZCN8A93J8j+zhNkKGgjBxU6P7bM+w==
X-Received: by 2002:a37:6287:0:b0:69f:c147:405c with SMTP id w129-20020a376287000000b0069fc147405cmr5924665qkb.16.1651929673466;
        Sat, 07 May 2022 06:21:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.184.140.116])
        by smtp.gmail.com with ESMTPSA id z7-20020ac875c7000000b002f39b99f6b5sm4108488qtq.79.2022.05.07.06.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 06:21:12 -0700 (PDT)
Message-ID: <62767248.1c69fb81.f2e95.563f@mx.google.com>
Date:   Sat, 07 May 2022 06:21:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3919695958413783975=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ieitayie@gmail.com
Subject: RE: Bluetooth: Fix the creation of hdev->name
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220507123248.432213-1-ieitayie@gmail.com>
References: <20220507123248.432213-1-ieitayie@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3919695958413783975==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=639380

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       PASS      0.98 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      32.10 seconds
BuildKernel32                 PASS      28.15 seconds
Incremental Build with patchesPASS      37.92 seconds
TestRunner: Setup             PASS      468.75 seconds
TestRunner: l2cap-tester      PASS      17.43 seconds
TestRunner: bnep-tester       PASS      6.13 seconds
TestRunner: mgmt-tester       PASS      101.11 seconds
TestRunner: rfcomm-tester     PASS      9.61 seconds
TestRunner: sco-tester        PASS      9.35 seconds
TestRunner: smp-tester        PASS      9.46 seconds
TestRunner: userchan-tester   PASS      6.35 seconds



---
Regards,
Linux Bluetooth


--===============3919695958413783975==--
