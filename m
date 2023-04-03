Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDB3C76196
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Apr 2023 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjDCNOC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Apr 2023 09:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbjDCNN6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Apr 2023 09:13:58 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6461285D
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Apr 2023 06:13:57 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id k12so2163561qvo.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Apr 2023 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680527636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AFbvgBB8RRtThxShz067Uh2VLEdHZNE2neDRjbAQYe8=;
        b=D5ulbVLOSqZJRtixTiihcNzs3AaQ8QWpXgoGH8ta2NoCjZQorUgeH80kPbWvYauMaC
         tsVg3pgdDKA6DDgdWGgUS/8XT4S7DIByXMIQGwKo0ywVi+kdrsmrUatCR0btLGuCttT+
         bg1KoZL4NsT61dR98qHvBnk2RWztRVV/sDLxgZWICDQpXH2flBID2j2Y2v6UkeYsCdda
         xuML1MQe743kCkr1HHpoChwUyPhGZgR8tiTfy3V39DPBVh3ugvsF4mBaAnrBezF6sSOT
         rSOdFzKHRbQTIcwdTwilx9AZGXG0P1yaEqVtSTENnPJJScNVFoqKuzV+z5qf2oww7GIM
         qHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680527636;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AFbvgBB8RRtThxShz067Uh2VLEdHZNE2neDRjbAQYe8=;
        b=K2SrX5e6c7qemyY5UZD+u6VS3HM3gac0A/Fycw/0E+jkRIkS+j7RUVoV8eZhbvpgMx
         BGTvhLMHlQkgVe45vf7PxBMiyns1QZuB0R+NJsfD0m+5Ho11EQ8tSOyfRGmbf54pyPU8
         1qLSH7TIKgTKks/k5ViaoBq1gm7B5Ou53JriDPCQtei0bJNxT/T3lDQ13fFzDPhII2GO
         JU0U91h4qDCNAKe0TnuS0gmxpPxW+55uFHnkKJWk4SWF7HTEGuns3ZFp0R/+h849H6xZ
         egdyFTztZ9WjjHOlRC8yaWHNqoGHYwoCOuF7vaCX/tPmB2z6aC3KFcb8DwgFZtagDW2D
         cLkw==
X-Gm-Message-State: AAQBX9eB/2o5VGiPtaJiw2qNekWhSDTu5CK9fEg85wdDUcXFq9S99QGe
        Hqdi1mJfVyniFoyUEcoVm0muL7nGQUs=
X-Google-Smtp-Source: AKy350ZylSH6RprYeLsG22TItczGgHxh8Rv09aUSbagA/S0tJ04hiu6BWEtivBgs3GKST6xbfs5JLg==
X-Received: by 2002:a05:6214:260f:b0:5b8:c53:3a9 with SMTP id gu15-20020a056214260f00b005b80c5303a9mr67674400qvb.36.1680527636248;
        Mon, 03 Apr 2023 06:13:56 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.193.178])
        by smtp.gmail.com with ESMTPSA id n4-20020a37bd04000000b006ff8a122a1asm2755788qkf.78.2023.04.03.06.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 06:13:56 -0700 (PDT)
Message-ID: <642ad114.370a0220.ee9ec.a988@mx.google.com>
Date:   Mon, 03 Apr 2023 06:13:56 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5883412047909700708=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neeraj.sanjaykale@nxp.com
Subject: RE: [v1] Bluetooth: btnxpuart: Disable Power Save feature on startup
In-Reply-To: <20230403122430.1024235-3-neeraj.sanjaykale@nxp.com>
References: <20230403122430.1024235-3-neeraj.sanjaykale@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5883412047909700708==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736376

---Test result---

Test Summary:
CheckPatch                    PASS      0.69 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      33.88 seconds
CheckAllWarning               PASS      35.88 seconds
CheckSparse                   PASS      40.50 seconds
CheckSmatch                   PASS      110.02 seconds
BuildKernel32                 PASS      31.60 seconds
TestRunnerSetup               PASS      451.07 seconds
TestRunner_l2cap-tester       PASS      16.24 seconds
TestRunner_iso-tester         PASS      16.51 seconds
TestRunner_bnep-tester        PASS      5.36 seconds
TestRunner_mgmt-tester        PASS      109.77 seconds
TestRunner_rfcomm-tester      PASS      8.55 seconds
TestRunner_sco-tester         PASS      7.96 seconds
TestRunner_ioctl-tester       PASS      9.17 seconds
TestRunner_mesh-tester        PASS      6.76 seconds
TestRunner_smp-tester         PASS      7.85 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      30.57 seconds



---
Regards,
Linux Bluetooth


--===============5883412047909700708==--
