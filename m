Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B499C7EE21
	for <linux-bluetooth@archiver.kernel.org>; Thu,  4 May 2023 21:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjEDV5B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 4 May 2023 17:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjEDV5A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 4 May 2023 17:57:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85EC1249F
        for <linux-bluetooth@vger.kernel.org>; Thu,  4 May 2023 14:56:58 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7665e607d1bso24058039f.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 May 2023 14:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683237418; x=1685829418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uuF8GtPmsCviF7muYC7XdIAU8vokEygK6vid8/gUL2Q=;
        b=e/PyOQnXk5sssShPKVFj77fnKuh/dk3Akv8JWxGC6OWH2dljWBJLnYQt975TCWFBmL
         1H3U73n/AX5z9UkobDzPLKU20x40br3XHJ31Latz42paNPrEK/nTrk4XHb/HC73Jhohc
         FDsKxO6wWRGNEvVfXZQ7R3aazKiUaW3gw7N00prDQduq1t6PTvg33swNtwZEGfuDWwFh
         o9tQTZYzNLlQGgho2vjYh3aRoOcALRnL9pTAOft9ITCFBlq0cOusIxIdUEdY1O+3pgco
         sw4niASoVZ72sF0O5FucOzMG3FoFPcfgtFsFGATcmp8NDCuStmToRx1Bya+bRCGbTh8F
         tJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683237418; x=1685829418;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uuF8GtPmsCviF7muYC7XdIAU8vokEygK6vid8/gUL2Q=;
        b=HOwBUl2kpAFACsLSdpaMRgtWzqdn/FLBdMlvjfLJMxZ1s2yHm6v1HsDfFUNqwtDl76
         mZuJTQMIfplwBQgNMTEVNBh6CdNAJBkLAvN+LjfxnL53xgjLrGwmNoyPpJ05qdlOXie8
         sUnWRU0OAd6yObVgvMQiWLEyGrSIIj8JG1O3Mss6RLxCPpwklGAVGJvMflipmjPQxzWP
         +SGUCHNXjlq7Er7IO7OnpWUCzz8YcmvunO/1qwV64prjf8512qfjClr7lF3xUkHaNnpn
         crKz3dJHIMrGLdeHJny1dwSCxIIyUdzC4NVDLWT7cAFZdhspxzOqRsDdugrzYb/0qAIM
         nIBA==
X-Gm-Message-State: AC+VfDw2H05jShDcjoDP4QcWsnx8Uzlmib0EcvCriFhMDSgd3dsN+M6g
        jQon1vfuclGs3P1s8lCRKOCGbZSlADI=
X-Google-Smtp-Source: ACHHUZ436fcxQ+R5IA2hr1aNbS9nWzDn5DPO+xMYqnycUoIdMfwqrAPb0gOM+m20Ol44akStW4i0Gw==
X-Received: by 2002:a6b:dc17:0:b0:760:ee29:5103 with SMTP id s23-20020a6bdc17000000b00760ee295103mr157267ioc.15.1683237417992;
        Thu, 04 May 2023 14:56:57 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.93.7])
        by smtp.gmail.com with ESMTPSA id w16-20020a6b4a10000000b007594fbab87fsm21288iob.1.2023.05.04.14.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 May 2023 14:56:57 -0700 (PDT)
Message-ID: <64542a29.6b0a0220.37447.00af@mx.google.com>
Date:   Thu, 04 May 2023 14:56:57 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0816957039391621794=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.gora@gmail.com
Subject: RE: [1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations.
In-Reply-To: <20230504212843.18519-1-dan.gora@gmail.com>
References: <20230504212843.18519-1-dan.gora@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0816957039391621794==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=745113

---Test result---

Test Summary:
CheckPatch                    PASS      0.62 seconds
GitLint                       FAIL      0.54 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.49 seconds
CheckAllWarning               PASS      35.43 seconds
CheckSparse                   PASS      40.11 seconds
CheckSmatch                   PASS      108.90 seconds
BuildKernel32                 PASS      31.32 seconds
TestRunnerSetup               PASS      445.68 seconds
TestRunner_l2cap-tester       PASS      17.26 seconds
TestRunner_iso-tester         PASS      21.37 seconds
TestRunner_bnep-tester        PASS      5.61 seconds
TestRunner_mgmt-tester        PASS      117.27 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         PASS      8.30 seconds
TestRunner_ioctl-tester       PASS      9.74 seconds
TestRunner_mesh-tester        PASS      7.15 seconds
TestRunner_smp-tester         PASS      8.16 seconds
TestRunner_userchan-tester    PASS      5.91 seconds
IncrementalBuild              PASS      29.61 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations.

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T3 Title has trailing punctuation (.): "[1/1] Bluetooth: btrtl: Add missing MODULE_FIRMWARE declarations."


---
Regards,
Linux Bluetooth


--===============0816957039391621794==--
