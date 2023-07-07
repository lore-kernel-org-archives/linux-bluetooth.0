Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C7CEB64D9
	for <linux-bluetooth@archiver.kernel.org>; Fri,  7 Jul 2023 23:37:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjGGXhq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Jul 2023 19:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGXhp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Jul 2023 19:37:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C7210B
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Jul 2023 16:37:45 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6b711c3ad1fso2350511a34.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Jul 2023 16:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688773064; x=1691365064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Ako4ZmmU42Sy7rEuDP2Fa/IjHwDsE5AhwidqWukxHDw=;
        b=QLwYHpP1wpXnYacpmEjooXs9Q7Dbr9/X3jPSjoItyfZXfmZOTU6fxpwzB6b/rPRTWr
         2Cbp/OPf8DbxavblFkvte0F+IfNOa072IRS2RkvfECp3qqF0FTWOBmwQ0exQA19CtKDc
         hq7KoEQznkvgJXVC1zH5PuAa5XxlGAIy5Fq8Xg4F0zs5qIyGpGOJYjY/MM1kt+0z9K9X
         lSjCAJF8F9T7FsKggeFEUSvxGWwuT0go1Mc+lBxhLMsVOaCPFI6J7O2tnXq/mqQZ1zWi
         PTa4aYF4CqTgM8G7YPuLSVZSx+oolu+EgK4M2P9gslBibZ6WBOIZ2kmYflTvEESmeZPk
         Mu5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688773064; x=1691365064;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ako4ZmmU42Sy7rEuDP2Fa/IjHwDsE5AhwidqWukxHDw=;
        b=HM8DccQCapva4teso3sWRsC2fdckuAOYnT1IsPiZxqP1UI1aBNPczUvshAQxLyRPLW
         dKGtjvNJ1t8nJZQV+1RMq34KsuJKQRUGWTGQhMciqyDf7kkJhs9YA9uTiT6YAzVquePD
         gU/YCiM0VuQy56PF0H9GAvvzqiGFCtBny7W1TCQJuSUbcPEJtn1pSysadx4jD4xOCTJA
         ZpOhzfEcKO4D3yj9f+Y0tTEv24+UMZAR3AIdF9GQbKFS3+kTDsKMo+ALJfgo9Sl8yc77
         iAm7MZu/ANIPntkGZeawSEVqQpunaeoybOdmUGXux++MYNdVN9FxKVXmXCPRRdq35Esb
         6nWg==
X-Gm-Message-State: ABy/qLbduea/NuC72LX372QQVndKgZvaI+29vsrjjuMsO/2YqVTG+9Xo
        0iwJpWJyboseFm0AM7msHH5VaVYEI34=
X-Google-Smtp-Source: APBJJlHU3X1jiZIQkztrQ0qyi13sB2BHgxSwAwvruTrOabL+aOrgTNpDpzNCx0RW10BA8nMofCGSGA==
X-Received: by 2002:a05:6830:186:b0:6b8:886d:852 with SMTP id q6-20020a056830018600b006b8886d0852mr6679799ota.26.1688773064317;
        Fri, 07 Jul 2023 16:37:44 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.170.65])
        by smtp.gmail.com with ESMTPSA id h15-20020a9d6f8f000000b006b74bea76c0sm2180572otq.47.2023.07.07.16.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 16:37:44 -0700 (PDT)
Message-ID: <64a8a1c8.9d0a0220.65703.cf90@mx.google.com>
Date:   Fri, 07 Jul 2023 16:37:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4857896071001692524=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/2] Bluetooth: MGMT: Fix always using HCI_MAX_AD_LENGTH
In-Reply-To: <20230707224318.677205-1-luiz.dentz@gmail.com>
References: <20230707224318.677205-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4857896071001692524==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=763576

---Test result---

Test Summary:
CheckPatch                    PASS      1.76 seconds
GitLint                       PASS      0.56 seconds
SubjectPrefix                 PASS      0.18 seconds
BuildKernel                   PASS      34.73 seconds
CheckAllWarning               PASS      37.00 seconds
CheckSparse                   WARNING   42.19 seconds
CheckSmatch                   WARNING   113.61 seconds
BuildKernel32                 PASS      33.37 seconds
TestRunnerSetup               PASS      500.57 seconds
TestRunner_l2cap-tester       PASS      23.05 seconds
TestRunner_iso-tester         PASS      41.37 seconds
TestRunner_bnep-tester        PASS      10.82 seconds
TestRunner_mgmt-tester        FAIL      217.84 seconds
TestRunner_rfcomm-tester      PASS      15.73 seconds
TestRunner_sco-tester         PASS      16.70 seconds
TestRunner_ioctl-tester       PASS      17.81 seconds
TestRunner_mesh-tester        PASS      13.42 seconds
TestRunner_smp-tester         PASS      14.30 seconds
TestRunner_userchan-tester    PASS      11.15 seconds
IncrementalBuild              PASS      37.71 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 492 (99.0%), Failed: 2, Not Run: 3

Failed Test Cases
Read Ext Advertising Features - Success 3 (PHY flags) Failed       0.244 seconds
Ext Adv MGMT Params - (5.0) Success                  Failed       0.288 seconds


---
Regards,
Linux Bluetooth


--===============4857896071001692524==--
