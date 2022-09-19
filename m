Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0181ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Mon, 19 Sep 2022 18:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbiISSWl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 19 Sep 2022 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiISSWk (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 19 Sep 2022 14:22:40 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B602945060
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 11:22:39 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id cj27so101349qtb.7
        for <linux-bluetooth@vger.kernel.org>; Mon, 19 Sep 2022 11:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=atI2EanVKO0ASoUGJMVYqK882MeIxmYofNmzQNwXsyM=;
        b=En0iwWy3axc+rTtUbeuJaEY/QIU463IR3JenwUhmUUUj08G5WrcWjdv6OQUWMuO5Pc
         MZk4IrZiv3SRRgFxCcdaIJNhtt26V2tJg5fCKFxt96/dB1CJQAFVChPnA3U9ri6DaFcR
         IN6gH/YNyouc+NLL94ztPyVDDx6RKIaeCz70zIX+e1aR0OwxxLkGyAs2De+xHtIqDrlM
         UdC/A3P1MFVjmCpo0wjfaNDQsbERtNIcLm1MJGmvlLvImeBrBJ+231B4QSyAWooFYhgu
         VzPDSTMfwck+2VtndQCDz+JHxKbkTpdggOAId7HIqucwIvKNLUGTbAnvvULgIQBPmBZC
         ykAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=atI2EanVKO0ASoUGJMVYqK882MeIxmYofNmzQNwXsyM=;
        b=oou8OnD7meesHPQpgzLieLMQswiv6txIEtsL6SuB3pym+w8GkID0IbxwrM9DbouZ6G
         au/rSjsoM/CHd5vR1P9E9kW64gN00xpJDoM6IDxGhTVzdUATMVjsIqAMClIHm463BTcc
         MTsbSyfPLTgOmCfh3tr/wuINK8AnXTwmPxwM3rYE2y8M7UekseJxaH0qON/sPehOnQ3d
         TiuZVaCHSmBeShlCiBptaWcF+fG1r4Xgb62gmkOIgCfnf+e0Agj/ERoUDgV9alg4oss4
         EzyqYh58byr6Ln/ms8R+yuUpAP/lm11DiHvV9PZwviLwU6mn2tpP/bPu7mbzbINEp+9g
         cdCg==
X-Gm-Message-State: ACrzQf1QGVm2PpR4yt8aufw+HEtV6BkqkF53laFa/SxAPM5J0p/lPK4y
        u9UhHiYnANnKU8lnIRp0G0Ou1cJRcSNrzg==
X-Google-Smtp-Source: AMsMyM462cd042dDVJCJiQ7Dx7IkZU05b8islCxkr0VsrDRa1Cxdh0QvCJbbnMo6Co/UQlmhccX7Ng==
X-Received: by 2002:ac8:664b:0:b0:35b:aff2:9684 with SMTP id j11-20020ac8664b000000b0035baff29684mr15725880qtp.686.1663611758468;
        Mon, 19 Sep 2022 11:22:38 -0700 (PDT)
Received: from [172.17.0.2] ([104.41.131.12])
        by smtp.gmail.com with ESMTPSA id r12-20020ac85e8c000000b00342f8143599sm10745300qtx.13.2022.09.19.11.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 11:22:38 -0700 (PDT)
Message-ID: <6328b36e.c80a0220.4a21d.e21c@mx.google.com>
Date:   Mon, 19 Sep 2022 11:22:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5330890328114106706=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220919175700.1649726-1-luiz.dentz@gmail.com>
References: <20220919175700.1649726-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5330890328114106706==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=678331

---Test result---

Test Summary:
CheckPatch                    PASS      3.63 seconds
GitLint                       FAIL      1.07 seconds
SubjectPrefix                 PASS      1.70 seconds
BuildKernel                   PASS      36.19 seconds
BuildKernel32                 PASS      31.49 seconds
Incremental Build with patchesPASS      50.95 seconds
TestRunner: Setup             PASS      509.27 seconds
TestRunner: l2cap-tester      PASS      17.28 seconds
TestRunner: iso-tester        PASS      16.25 seconds
TestRunner: bnep-tester       PASS      6.65 seconds
TestRunner: mgmt-tester       PASS      103.96 seconds
TestRunner: rfcomm-tester     PASS      10.30 seconds
TestRunner: sco-tester        PASS      9.75 seconds
TestRunner: smp-tester        PASS      9.83 seconds
TestRunner: userchan-tester   PASS      6.76 seconds

Details
##############################
Test: GitLint - FAIL - 1.07 seconds
Run gitlint with rule in .gitlint
[1/2] Bluetooth: hci_sysfs: Fix attempting to call device_add multiple times
37: B1 Line exceeds max length (83>80): "Link: https://syzkaller.appspot.com/bug?id=da3246e2d33afdb92d66bc166a0934c5b146404a"




---
Regards,
Linux Bluetooth


--===============5330890328114106706==--
