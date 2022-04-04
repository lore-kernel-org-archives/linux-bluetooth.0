Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBB1C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  4 Apr 2022 02:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376923AbiDDCmH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 3 Apr 2022 22:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356313AbiDDCmG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 3 Apr 2022 22:42:06 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA824092
        for <linux-bluetooth@vger.kernel.org>; Sun,  3 Apr 2022 19:40:10 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id t2so6666715qtw.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 03 Apr 2022 19:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=TGRo0g/Rnqyo2kjT2dTHVz57BlIjFuDhvQ7vHgyGP6g=;
        b=VqBp4NYZFDf660fM1ZBE2dIlju5qDgLcu/2KKpahgrvMPobGj3Hue+ARom2tvTCXu8
         kMsY0RlslNDRW3B6WV0pwOObU4UWgALF+TR33rd5dzqmNmAH47Zdl6y94AfhlliS7MpQ
         3j9EATb5HyVFjbuJr1zBwxAnTsA29ZTR7UzdY//8cDM4E1GRTupFrshsvwDASpr8ZzTF
         9Ung2nKmVbyJgFTRE9QvQ6CtxMrDGh8LS5b4V9rVArfz7hTJnBsFf57Woh8EotKrKfTG
         5fU+tkiSDEbYnsCnyEZXDOru71dfhg9GDFyKPcJhUfvRsEG2kjuv7YImgiLBnqR5l2T7
         fcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=TGRo0g/Rnqyo2kjT2dTHVz57BlIjFuDhvQ7vHgyGP6g=;
        b=bpBQ/GrnPpy4fc9HuUN35xX2KeYVoNgpVId3FD8He8g8JTQRYzupeAbBQkmZ3tarU1
         UbRPNJtc7NWXD+EQBLwKRycvZYzbXgz/pR/lNwxLA5BNNR1ub5KJ6hkbeTtYgenak3CB
         ys5xJF5QPPv4W6mboevvaXqyTJjcfEA4SejMsD8Ac17njLhwWsAeukYieWVI+WvLGAwD
         vcUJlfcHDq+tgb35zAZNl0UPSJPFJuIYLxWJrjvZmzIMFrmnrlrPN5iLQFr1GnA+BaKN
         3U2Hnr+nfuRfNKzBXOwcm1zUSDvemSiDoa5u2pbyXqE+HQLyfHBfAznGxwZIXSDIV6AT
         bjkg==
X-Gm-Message-State: AOAM530MCD8bmI5e932rJWyhjUPO3nDCAT44BwyNV1eD4pqvBd60JdyY
        EKF+O6ik1xnekX0XoWe7l3UmN/g493Q=
X-Google-Smtp-Source: ABdhPJw+45DRkpq3sx5EsVY+iLyatuzPqmWQqUCZ21zoPHpmxDoy/GhLS29LwUHX4a/PfmlS2TlOOQ==
X-Received: by 2002:a05:622a:1906:b0:2e0:77a7:16c4 with SMTP id w6-20020a05622a190600b002e077a716c4mr16065846qtc.119.1649040009688;
        Sun, 03 Apr 2022 19:40:09 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.93.141])
        by smtp.gmail.com with ESMTPSA id v5-20020a05622a144500b002e1c7d027b1sm7513044qtx.66.2022.04.03.19.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 19:40:09 -0700 (PDT)
Message-ID: <624a5a89.1c69fb81.a00b3.1b2a@mx.google.com>
Date:   Sun, 03 Apr 2022 19:40:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4479506395778650708=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dossche.niels@gmail.com
Subject: RE: Bluetooth: use hdev lock for accept_list and reject_list in conn req
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220404003403.35690-1-dossche.niels@gmail.com>
References: <20220404003403.35690-1-dossche.niels@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4479506395778650708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=628619

---Test result---

Test Summary:
CheckPatch                    PASS      1.54 seconds
GitLint                       PASS      1.01 seconds
SubjectPrefix                 PASS      0.89 seconds
BuildKernel                   PASS      30.05 seconds
BuildKernel32                 PASS      27.33 seconds
Incremental Build with patchesPASS      38.38 seconds
TestRunner: Setup             PASS      458.46 seconds
TestRunner: l2cap-tester      PASS      15.27 seconds
TestRunner: bnep-tester       PASS      6.04 seconds
TestRunner: mgmt-tester       PASS      99.50 seconds
TestRunner: rfcomm-tester     PASS      7.31 seconds
TestRunner: sco-tester        PASS      7.24 seconds
TestRunner: smp-tester        PASS      6.75 seconds
TestRunner: userchan-tester   PASS      5.87 seconds



---
Regards,
Linux Bluetooth


--===============4479506395778650708==--
