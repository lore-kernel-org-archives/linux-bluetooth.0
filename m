Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A314BC0015E
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Jul 2023 17:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjGORmU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Jul 2023 13:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGORmT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Jul 2023 13:42:19 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278B9101
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Jul 2023 10:42:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-262ea2ff59dso1448694a91.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Jul 2023 10:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689442938; x=1692034938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=kqAjNG1ch7vZe1taIamltbtSx5MZR0TNovs7QQXEksg=;
        b=hXBcEyWaTysavoN+kflGrD+VISipc0+bkU8htV3FDOjejmyHOb2ldMbweU1ED7444w
         s/qHiMIFaqRKxrNpgEbFr+NtGucOmjbL6ApbVQP1sVrxQ10PTg1wYxALHIw9ZT0uQ5i6
         Omxf/KBWMlDxBsybAZLywu7ooQMqIIzMwhE0K21NL33FKFDfw1rGOP3XWSHEEcWrwYlV
         on3EkWp3uqRw1qywsN+7y6KUtz5uJzYu+ORBfVdHmHjKOCQbp990izFxE3JhOgLW8I+Q
         ZEyHv+qVNuhQVTI6SUAMeyfM8ANe2sJmwgiMDo06ZxrcPJ1+wqEUic0vg5lng5fDQUcj
         EnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689442938; x=1692034938;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqAjNG1ch7vZe1taIamltbtSx5MZR0TNovs7QQXEksg=;
        b=JTAri8t6bD/ZtDN2IPoMz2fVZmU/dkgtp0UYhg0GqaMvjOs8khfkJgKnyfczIrPmR6
         O9A8V/j3CxdkfAjbPqZvJy/nU/ErBQQ+2P9wVw9YCbsHIfAClYS7hHej/7Srpv+vSINt
         PNn1Fgv5ZudNo5aY7e+BwMvvHjIHNkf52uEj5a50Vk0AKeCoqdkipXUV94PywnyqJqWS
         NnvMd9sdhzJtMnR80axXIau8L9tj/M3Pk5slW5aKb/xLUM9O5Ta9UAoI5DJAC79mT7BG
         8afOs0q4PiHLuRlqnorfUzaAETUbmXV0aqNOgxzFJfdHF7etGUzGlUjrzxyLsoFKUdf/
         vxYg==
X-Gm-Message-State: ABy/qLY0FCYbE+j9w6Xs3SOhx/23sCIAQbWxornsoHvDxMK6/1uMdg5n
        zeR1c7S58Tt4ii5tmj5XqvgUON0B9LU=
X-Google-Smtp-Source: APBJJlGFYB/4Bw049wUbdK5Qnq1cwv6DgruWuGWy+HQt5BWqIB8dmVoXcfa8V3US5AdAyeedvGERVw==
X-Received: by 2002:a17:90b:1d90:b0:267:7743:985b with SMTP id pf16-20020a17090b1d9000b002677743985bmr2523735pjb.7.1689442938346;
        Sat, 15 Jul 2023 10:42:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.98.113])
        by smtp.gmail.com with ESMTPSA id a24-20020a17090abe1800b0025eaeaae318sm2649066pjs.7.2023.07.15.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 10:42:18 -0700 (PDT)
Message-ID: <64b2da7a.170a0220.dc1db.4880@mx.google.com>
Date:   Sat, 15 Jul 2023 10:42:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0207545331966816054=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mans@mansr.com
Subject: RE: Bluetooth: btbcm: add default address for BCM43430A1
In-Reply-To: <20230715164159.16368-1-mans@mansr.com>
References: <20230715164159.16368-1-mans@mansr.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0207545331966816054==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=766180

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      45.50 seconds
CheckAllWarning               PASS      49.17 seconds
CheckSparse                   PASS      55.67 seconds
CheckSmatch                   PASS      146.86 seconds
BuildKernel32                 PASS      42.67 seconds
TestRunnerSetup               PASS      656.97 seconds
TestRunner_l2cap-tester       PASS      31.97 seconds
TestRunner_iso-tester         PASS      79.53 seconds
TestRunner_bnep-tester        PASS      14.41 seconds
TestRunner_mgmt-tester        PASS      260.56 seconds
TestRunner_rfcomm-tester      PASS      21.71 seconds
TestRunner_sco-tester         PASS      21.87 seconds
TestRunner_ioctl-tester       PASS      25.22 seconds
TestRunner_mesh-tester        PASS      18.57 seconds
TestRunner_smp-tester         PASS      19.30 seconds
TestRunner_userchan-tester    PASS      15.28 seconds
IncrementalBuild              PASS      40.10 seconds



---
Regards,
Linux Bluetooth


--===============0207545331966816054==--
