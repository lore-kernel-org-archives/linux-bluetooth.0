Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E76C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 20 Jul 2022 15:02:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbiGTPCZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiGTPCY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 11:02:24 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFD253D0B
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 08:02:24 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x11so7827806qts.13
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 08:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=X/T1p4zdqFEArmdAyQTJal8n0gHWSyxDmp2lXOd8L6c=;
        b=VdFDJaYDAbYnbNKRG3vukwtAiJhvPurkT9ZbgWjjcuW53aNS/mlAo9JLQgmFvpPk1W
         n/3aw3a5rkYk9/CVkxfGR4rt6NEz4GX1IZz8YXEl34OwspsUQjTv60srkDE1+tVuy9WU
         XRrA39oVJ2tKaufPeo96JU5f4ezy7iyLDCgMyN+Eld5VrkDhHfFBDdSpM35E8mJfBsJr
         mxV1+Nrel0IelPNlGcHXvxgXiMPgf5lu1z7s/LqZrntRz4wAKt1fiJjuLBr+I0QsLvKB
         kN5WaBOYnlOsCjlGuEcy5fd5euUrxblolmgWjuC6RGgUlnqxnEzZ/Mt34dCDPt23GlR/
         pr0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=X/T1p4zdqFEArmdAyQTJal8n0gHWSyxDmp2lXOd8L6c=;
        b=5NUUGMjayYXuId51/cnz49CoJesZESHxewAT6hKv+akEYGjFqCCcaUZ13tq6GGH0az
         Ngc829RqIuDytgOUNbg0Mg+mGhf4noJWrhTRg9ICZ5UiOHwlnJ3++FmFONEMyhhkULSz
         LqgL1UdHGiqJC3jZoYnMAuECDQnpot09kMHKroLZMK5H7QXSqaIhcYe88mTi/JpSspsi
         v0HKQPwwFFwovErp41ebs7JEbWXINILW2Lksw3cRn12qUwpcd3OXGlSef4exnnY91P4L
         Js5GgYXePDd0iitOwH1NXkTO5TQuPnjRfvTnoCEysEdzCTEAsptlQvn5HlkZKhA/OvQi
         hc4g==
X-Gm-Message-State: AJIora87mtKnOdYoPtsUaFaMFFOW02I1aUEP+n5bEVeT4Env0mZRqf3D
        nLGjhlBaJwqT52b3fk7waOYjnpWdNCE=
X-Google-Smtp-Source: AGRyM1vsbRccCK8Mmi+GRr2d6GMcSCidRFyhaCG12zHb0hUZidYn1PlDhPrOTybyg1Fz4GwrTYNj2w==
X-Received: by 2002:ac8:7d4d:0:b0:31e:f6b4:f3de with SMTP id h13-20020ac87d4d000000b0031ef6b4f3demr9288627qtb.639.1658329342888;
        Wed, 20 Jul 2022 08:02:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.232.122.218])
        by smtp.gmail.com with ESMTPSA id z3-20020a05622a028300b0031ef108e6a8sm6066833qtw.42.2022.07.20.08.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:02:22 -0700 (PDT)
Message-ID: <62d818fe.1c69fb81.237ba.ea53@mx.google.com>
Date:   Wed, 20 Jul 2022 08:02:22 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6899204815076617635=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dengshaomin@cdjrlc.com
Subject: RE: Bluetooth: btrtl: Fix typo in comment
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720141033.12521-1-dengshaomin@cdjrlc.com>
References: <20220720141033.12521-1-dengshaomin@cdjrlc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6899204815076617635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661489

---Test result---

Test Summary:
CheckPatch                    PASS      2.00 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.83 seconds
BuildKernel                   PASS      35.16 seconds
BuildKernel32                 PASS      31.07 seconds
Incremental Build with patchesPASS      45.10 seconds
TestRunner: Setup             PASS      537.85 seconds
TestRunner: l2cap-tester      PASS      17.60 seconds
TestRunner: bnep-tester       PASS      6.18 seconds
TestRunner: mgmt-tester       PASS      100.57 seconds
TestRunner: rfcomm-tester     PASS      9.60 seconds
TestRunner: sco-tester        PASS      9.30 seconds
TestRunner: smp-tester        PASS      9.31 seconds
TestRunner: userchan-tester   PASS      6.26 seconds



---
Regards,
Linux Bluetooth


--===============6899204815076617635==--
