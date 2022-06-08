Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCA7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jun 2022 14:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbiFHOWl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Jun 2022 10:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbiFHOWb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Jun 2022 10:22:31 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EEA941984
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Jun 2022 07:22:30 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id j8so12224891qtn.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Jun 2022 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=agORLYlq3zpbORzNp8Yf3UrYvPSv860YJiryu3FAJ7w=;
        b=KhmslM8nZoa7lOFa2eXdRwnK4WoZINK8G/1w5qwDA8nmP4aBnwLdmSXsSoTHf57kMN
         Cz7e59OpZvrUFEoOB9zciK4t3lZMqBG1qZ7pLbity7168jGIDdBp5bKRTMFacEOUARZV
         dKKuufVtTm/5LaZgXkPAGuNlJYp73xML3lgoVvQ970GFEkNLFHomnxShdiSW1acVZUmJ
         n08TocQ4g03GO1lY2qaSguwtTH8QOB2IQ6faiY02vY+RdujBPM8/3mfEzkU5FwU5MO+d
         3uTSQpjpsRMGHD+LBtmGNWda2AFluFV/IrPzK6OnUhP1UzNTecJZhD1bz1LCFR6gORql
         suhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=agORLYlq3zpbORzNp8Yf3UrYvPSv860YJiryu3FAJ7w=;
        b=KyFFrZeRvQady3iJaomGrkK2/GGLrEPwtpd0bNHXBQWrIRNJtauKUfkcScJn87bqRJ
         ivaSgaVQaWnLWKTFSI+UKhSvVYTRoeAQp4gvbDF8shpA7EHnpDHOM0HsIn7+buZdRwGK
         PeV/Qh8LR0OOjkfmt1nHPsjujE+jouqynShcTfK3PxtBpBBK5c/422hQTD44WgvqCib1
         hHat/AeHJcqvKkyT51QdYu8D5qXvivJ/Qezx6CPXe0jX3SdRbV2PVb8vRdwm3haLaAT3
         ig376Ck1pEG7SKIL9rQSN9twKuRsQD49/TV+sj/8L8BmCgVXoPUvUcsDqcFs8OuCt8cT
         LogQ==
X-Gm-Message-State: AOAM533EJlfEKB9KhqzwQc9URolL5gsZ+k4uY0BuOT0E1hTXcggCrQlH
        hQU4+6bMrligEjl8JPiphGBdcvyRz5v+Lw==
X-Google-Smtp-Source: ABdhPJy0D2P8nkoB11iiqvMDx/CrCaEpobnvMWRDkXuh5pW8IFyoC0KBs3KjA6GAsCl5NvdmUffDLQ==
X-Received: by 2002:ac8:5cd2:0:b0:304:e740:d444 with SMTP id s18-20020ac85cd2000000b00304e740d444mr16925146qta.341.1654698149591;
        Wed, 08 Jun 2022 07:22:29 -0700 (PDT)
Received: from [172.17.0.2] ([20.122.151.65])
        by smtp.gmail.com with ESMTPSA id r2-20020a05620a298200b006a680f2811bsm15927979qkp.104.2022.06.08.07.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 07:22:29 -0700 (PDT)
Message-ID: <62a0b0a5.1c69fb81.b1d18.6101@mx.google.com>
Date:   Wed, 08 Jun 2022 07:22:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0788492972567436505=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, soenke.huster@eknoes.de
Subject: RE: Bluetooth: RFCOMM: Use skb_trim to trim checksum
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220608135105.146452-1-soenke.huster@eknoes.de>
References: <20220608135105.146452-1-soenke.huster@eknoes.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0788492972567436505==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=648480

---Test result---

Test Summary:
CheckPatch                    PASS      1.66 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.90 seconds
BuildKernel                   PASS      34.48 seconds
BuildKernel32                 PASS      29.81 seconds
Incremental Build with patchesPASS      41.25 seconds
TestRunner: Setup             PASS      508.23 seconds
TestRunner: l2cap-tester      PASS      17.90 seconds
TestRunner: bnep-tester       PASS      6.34 seconds
TestRunner: mgmt-tester       PASS      107.06 seconds
TestRunner: rfcomm-tester     PASS      10.63 seconds
TestRunner: sco-tester        PASS      10.42 seconds
TestRunner: smp-tester        PASS      10.39 seconds
TestRunner: userchan-tester   PASS      6.76 seconds



---
Regards,
Linux Bluetooth


--===============0788492972567436505==--
