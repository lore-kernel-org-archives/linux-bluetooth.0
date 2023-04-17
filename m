Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79449C77B61
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Apr 2023 03:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbjDQDJO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Apr 2023 23:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjDQDIx (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Apr 2023 23:08:53 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8591B4C1E
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 20:08:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id ej15so12294704qtb.7
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Apr 2023 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681700793; x=1684292793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=u+4BZPBme6eq5gNBe9xql4VbCQhRoEjhrm4n6ZzFYAw=;
        b=Ltgin/u1wn+lp141PrZ2Ea/UVSD+8o9bTlZkNaJ5klhSFKvMS9B4WX4QCiBjxLeHCj
         OU+jEEs1FdD9VRbfc4FEEAONKqhMo8yZ/X1UVHugeaIPUd1BzQECl91v4BrlhmbKPkBH
         Do1xS5IiuhoKwUq0PCb1Ryy/2mAvkgqB3QoxMxJ1rbXXOM+q8ZTx4BN+8pA/64rC3zxq
         h8AfjgD7A9/i6xylGLOO7Xi5G5VDE3+vG0kLLGyxj2eIU6bMeUx10WLmBtc+3IGbj1j7
         YUW68FsjCszosKPxjsImzPKYSNv67vXfPs6om5bDa/d2SoRbEmXPGBSELKcuWVv9NiOZ
         9FWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681700793; x=1684292793;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u+4BZPBme6eq5gNBe9xql4VbCQhRoEjhrm4n6ZzFYAw=;
        b=ahzufyAm5NDxe5jqKLoeoh2MOIMaQUyXUvH0kqqQCnHWdcpxigXUwkrqTobBzveOS8
         K6ivPZWLcJjB9dDdZK9l+jjLBycBg4IFH4xVjjriNP//av3atmMu6o4BOXqZfOwozd5K
         9c9zh/7OjUHmZ8ZbJs/fpP42yLxx/euB5C6Tpwl10A4URCNMZL/m/Gc9m/WWJDd2J5ky
         RZ1OANBiANpJcCMRtx4neCSxJjIrZHx59q7hFUlO5Nl2ITQWCh9MczKpbj0vc188csj9
         4Mt0cbnZBEUyxV81zNHLMj+HLVUZMTdEPXdnOf1kIkd3XrFrwv5TJ18EUDDA+tR9+haD
         ynKw==
X-Gm-Message-State: AAQBX9f6+09+W+0OSJ8/X7rrOpn1f14EIgqKQg7OxTg+SD0mRdV+ubar
        atpc/CvEFw3w9rkv7gn0LuBMSGdSmg4=
X-Google-Smtp-Source: AKy350YFxUnJW+N1dci5pFpx9zs9tq4fqVMmHl+XYJicR8jVU5Nr47nSTxtuqCZJc6Y8iRtAudgTYw==
X-Received: by 2002:a05:622a:1042:b0:3e6:4e5e:89f with SMTP id f2-20020a05622a104200b003e64e5e089fmr20855395qte.18.1681700792805;
        Sun, 16 Apr 2023 20:06:32 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.205.119])
        by smtp.gmail.com with ESMTPSA id h17-20020ac87451000000b003ef239e3d5csm660905qtr.17.2023.04.16.20.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 20:06:32 -0700 (PDT)
Message-ID: <643cb7b8.c80a0220.18cdb.23f4@mx.google.com>
Date:   Sun, 16 Apr 2023 20:06:32 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6195185157446806066=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lm0963hack@gmail.com
Subject: RE: Bluetooth: L2CAP: fix "bad unlock balance" in l2cap_disconnect_rsp
In-Reply-To: <20230417022754.4925-1-lm0963hack@gmail.com>
References: <20230417022754.4925-1-lm0963hack@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6195185157446806066==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=740288

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      31.13 seconds
CheckAllWarning               PASS      34.38 seconds
CheckSparse                   PASS      38.65 seconds
CheckSmatch                   PASS      108.88 seconds
BuildKernel32                 PASS      30.23 seconds
TestRunnerSetup               PASS      430.89 seconds
TestRunner_l2cap-tester       PASS      16.20 seconds
TestRunner_iso-tester         PASS      19.26 seconds
TestRunner_bnep-tester        PASS      5.19 seconds
TestRunner_mgmt-tester        PASS      109.74 seconds
TestRunner_rfcomm-tester      PASS      8.39 seconds
TestRunner_sco-tester         PASS      7.82 seconds
TestRunner_ioctl-tester       PASS      8.98 seconds
TestRunner_mesh-tester        PASS      6.55 seconds
TestRunner_smp-tester         PASS      7.62 seconds
TestRunner_userchan-tester    PASS      5.47 seconds
IncrementalBuild              PASS      28.74 seconds



---
Regards,
Linux Bluetooth


--===============6195185157446806066==--
