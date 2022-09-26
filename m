Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB11C07E9D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 26 Sep 2022 10:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235004AbiIZKWj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 26 Sep 2022 06:22:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiIZKVZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 26 Sep 2022 06:21:25 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BD44BA76
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 03:16:05 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id a80so6213606pfa.4
        for <linux-bluetooth@vger.kernel.org>; Mon, 26 Sep 2022 03:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Klgl7KNTPZX6/7bHHE20SbQAQo3ilxqE72hmsPzAr74=;
        b=UklklmZfXeJCf+I+g8Yoh4MwnpUiMSG5eOXOeRhZNqO/S3dYp4z9ZyEClSFxABeu7P
         21KflDpF1US4q11otXEnuYtfF9XrAORmKE4Jyq2wJlzO6ASH5pb1VzQeiiIFDufUltVH
         t1E6daqkXunjDbCpluYjCJDp012so8Bg2GayIMDrYx/UC9gym5dsx9XqYWwDFToWN4vm
         NIgOPnSAUMGJTWChgD5sOpUzL0DK5aZWVdEgTliaAyuyfYDId72GyLORpgM5E+RtCrIK
         qWcrKxb9Mr0Rb1ODnli3NNGbTF4ox77SfGZdvu2aFaHEexqW+iLLipk59SeUwsoRGe/t
         b6NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Klgl7KNTPZX6/7bHHE20SbQAQo3ilxqE72hmsPzAr74=;
        b=tSNUGvDKBoE7DhnsrTSmpjXtKyTqBtxYr/LGa8M8hVHqOn6ow48r/zMSdzJWtkyssO
         GpU9Q0nQI5obcter6dru5XakC6RnwppdlUMKwY+HeJdynWgixoq5UFDhm+v1lOQ1n6Mm
         VJV07QNuoDolFcP1JwkEAK+iphQzrneSqsutyMQrMirqjoIsG3kHKqjjC+1WLyHzRCVX
         OQ+qSK/h3wEnMQyzj1v7wcabxlGeG25XTfPbE4puFjMs6RSTiiPkR8yJFq/A13SPphm7
         sIs6pgocD5pweNsq9x10kq/g46WbEdmJtRm8g+awPPEFByq0v4bn+YbgsMMnhrdctwxl
         T1gg==
X-Gm-Message-State: ACrzQf0jbgvF3kxzjG/PD1op1xwjkmXiU2WAfZA42dtVN6HfN8vpMNL0
        VLSBAh26afNJb4gzcKh0TVLlNE7cNEE=
X-Google-Smtp-Source: AMsMyM6GQEVJG5a+hRpsTGEWpONgoUz7s9vFukBIaPPUkZs1idqSDYCZiC8q3Y5uq32OWwN+NslyPA==
X-Received: by 2002:a63:da4b:0:b0:439:14a8:52b with SMTP id l11-20020a63da4b000000b0043914a8052bmr18546191pgj.500.1664187364430;
        Mon, 26 Sep 2022 03:16:04 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.136.171])
        by smtp.gmail.com with ESMTPSA id r62-20020a17090a43c400b0020255f4960bsm6131078pjg.24.2022.09.26.03.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:16:04 -0700 (PDT)
Message-ID: <63317be4.170a0220.632bc.a65f@mx.google.com>
Date:   Mon, 26 Sep 2022 03:16:04 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3790145020839843307=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ruanjinjie@huawei.com
Subject: RE: [-next] Bluetooth: btrsi: Add __init/__exit annotations to module init/exit funcs
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220926092002.1191313-1-ruanjinjie@huawei.com>
References: <20220926092002.1191313-1-ruanjinjie@huawei.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3790145020839843307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=680405

---Test result---

Test Summary:
CheckPatch                    PASS      0.89 seconds
GitLint                       FAIL      0.46 seconds
SubjectPrefix                 PASS      0.33 seconds
BuildKernel                   PASS      46.37 seconds
BuildKernel32                 PASS      38.80 seconds
Incremental Build with patchesPASS      57.07 seconds
TestRunner: Setup             PASS      665.96 seconds
TestRunner: l2cap-tester      PASS      21.02 seconds
TestRunner: iso-tester        PASS      20.54 seconds
TestRunner: bnep-tester       PASS      7.89 seconds
TestRunner: mgmt-tester       PASS      129.42 seconds
TestRunner: rfcomm-tester     PASS      12.36 seconds
TestRunner: sco-tester        PASS      11.65 seconds
TestRunner: ioctl-tester      PASS      13.25 seconds
TestRunner: smp-tester        PASS      11.49 seconds
TestRunner: userchan-tester   PASS      8.15 seconds

Details
##############################
Test: GitLint - FAIL - 0.46 seconds
Run gitlint with rule in .gitlint
[-next] Bluetooth: btrsi: Add __init/__exit annotations to module init/exit funcs
1: T1 Title exceeds max length (81>80): "[-next] Bluetooth: btrsi: Add __init/__exit annotations to module init/exit funcs"




---
Regards,
Linux Bluetooth


--===============3790145020839843307==--
