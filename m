Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B2B7C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Apr 2022 19:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiDGTOm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Apr 2022 15:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233095AbiDGTOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Apr 2022 15:14:41 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD2D23178B
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Apr 2022 12:12:39 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so2805061pja.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Apr 2022 12:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=W5ws87pARnQKyuu6habaKO4FTeIwdHumEBaNkUnt8kU=;
        b=oJdKPw1sAhMQMPLsJaTg+zgiauGkyksXzD8xJFJEKzho89wzw5XV9OAVFWue3/dNBM
         tehH2ZfwtBzVmdufYgqXrzwEyiTuheth95ROfDih/gGeugLbOGbd6PZn9AouFQTIXKz6
         wVRO0bK4nz/VS7cWpb1CO/Xpp9wNJaUtzW3RqRqJcC/jCd4md6yfRAgszmWizzxK0D2N
         uNz3lGeU9BIV5tS5wS+K6H0n/+Cihxb+UiABtFq1iUv1YcBAa/SAREVn09Xs3sl5+GJ8
         hvu88xd6ogTcbNmXdey5A9JJlP52QqNc+3Gttkfs2igt/6Bo6tMFLBq/dIyzSjgMBJPd
         45dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=W5ws87pARnQKyuu6habaKO4FTeIwdHumEBaNkUnt8kU=;
        b=iDg/mZBBsyZPk+Gsf8UXb/9QP5jINVGK97X5YXpSab5y/Csnb3gOhVTJz/OM984m6x
         DIVK8HWwWL9PHuwpCtd4QMtV0wfALmbe3BG3cd702Igvdve9EvQrcYZx5FtN15qmrX01
         FEyQg5TZOhGkMfBw5XyhsWBhXE2Y0fj/LY6eQSVWtCXUs/Ysqfptlej5byWj1bCPFS2p
         smutfssGjiSQeCQke8TNCsUP+tcLyEptK4ODyV5LWTOfdLN0hi6ngzMjcMKnuYcFqb5Z
         rFPpwdaqKEnPqQMAei5sjVfXXeOzRMmO4dK9mCafydacLU5fivB3jPziEZCk41RO2MKp
         FOig==
X-Gm-Message-State: AOAM533V32lfLZeqK7qIpGWF/BHByoDIJQqZONSiYD9lzrwTzS3U2zKc
        jInDPpaxi+jdb1CH6zaI4swcideC76I=
X-Google-Smtp-Source: ABdhPJxe7oyXH7hw2uGubGt8UlIKu0+OKjZH65h7zPequ3qjFWt3Q40042Ps84v97nbpvRqDXaP3HQ==
X-Received: by 2002:a17:903:22d1:b0:154:4cfa:2b12 with SMTP id y17-20020a17090322d100b001544cfa2b12mr15083246plg.47.1649358759045;
        Thu, 07 Apr 2022 12:12:39 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.229.251])
        by smtp.gmail.com with ESMTPSA id t34-20020a056a0013a200b004faa8346e83sm25118408pfg.2.2022.04.07.12.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:12:38 -0700 (PDT)
Message-ID: <624f37a6.1c69fb81.2c63d.22f8@mx.google.com>
Date:   Thu, 07 Apr 2022 12:12:38 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8795786343444876212=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dossche.niels@gmail.com
Subject: RE: Bluetooth: use hdev lock in activate_scan for hci_is_adv_monitoring
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220407180651.14871-1-dossche.niels@gmail.com>
References: <20220407180651.14871-1-dossche.niels@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8795786343444876212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=630120

---Test result---

Test Summary:
CheckPatch                    PASS      0.93 seconds
GitLint                       PASS      0.46 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      40.03 seconds
BuildKernel32                 PASS      35.93 seconds
Incremental Build with patchesPASS      48.96 seconds
TestRunner: Setup             PASS      609.44 seconds
TestRunner: l2cap-tester      PASS      19.44 seconds
TestRunner: bnep-tester       PASS      7.62 seconds
TestRunner: mgmt-tester       PASS      129.20 seconds
TestRunner: rfcomm-tester     PASS      9.98 seconds
TestRunner: sco-tester        PASS      9.58 seconds
TestRunner: smp-tester        PASS      9.77 seconds
TestRunner: userchan-tester   PASS      7.95 seconds



---
Regards,
Linux Bluetooth


--===============8795786343444876212==--
