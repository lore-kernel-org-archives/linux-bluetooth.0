Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB95EB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 22:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbjF3WeD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjF3WeB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 18:34:01 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6516423F
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:33:55 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-63588812c7aso10958416d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 15:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688164434; x=1690756434;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jo3/q+IkZSk1d5Fcv4MT6WpzfQAAtS4okKwlbwy0Hws=;
        b=PGjkLhpLgnoVi1qsd5C92d6lamBOQyjLgMCJjhCP0blDA9e9c329H+1ji0AbBsGJte
         KNpq8s8wLTbmtLP8NQNcYfGfnO/E4PY5a5f8cGcrw1KQDRaIKBfUTfAJAp+VyzXVdVye
         PUZm8V870c3K4X0aQlUiYLN5vhne3WpoChO1eYu6/lW4I4u9zTAfAI7HeVlWsZ9/2KIq
         Dv2miejo+BeeLmPZKNfE6LIGL1zwdKDSjl98PSaewkVsOA/1EpGcJ0qgTTJ1R3KayMQA
         vHh7NlvdaLt8qOpqC5ijO9Kbbnn94tFmf0EFByiHaBJkY1jmXLZIYV044lTwH2GXsXVL
         E2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164434; x=1690756434;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jo3/q+IkZSk1d5Fcv4MT6WpzfQAAtS4okKwlbwy0Hws=;
        b=kkXRU7wzGNNaoUGv054iHQar6j3znqFOoTbXKd6iOYpiGV8IWRK2JHM1uDHGPNqvaK
         tTMmpFCTt4SepphdOHU+xCLiaSohdvJou0lPFsHurzxT3dlv1pniQqKLfTgy28rX/95e
         xHCfGe27SZlQa2KPgUt4euOgmk4kfxduqPHMgWQGGLN6aoiT/qczPjAfxeZjNHoEN8Pz
         Hl8wUO26vsfnu8o5Yxcl3OwWyauGE9RvgS12PN6rTdHycE0mPXJukQCEcD2uA4ghTD6Z
         yEgz07iNITYqfNisYZ+WnjBhOug7mhlLX9Z/n3z8cntF336SgM3K26lEPUHCHyKlKM+H
         /6vg==
X-Gm-Message-State: ABy/qLaS92wYXGxXFXT25K5oLVHgrEXWJdC9OULMCaibhuc08k/obGdB
        +jd26PSyBXHni+UThjKY46RLQaJBpJ4=
X-Google-Smtp-Source: APBJJlFX3pCd9PbrmR90f6XKs5TCKFqQkevFq/eCAioUX042OWhnpEp0MqHjjrCGtE9XYZ9Yp6Eb/Q==
X-Received: by 2002:ad4:5cab:0:b0:5dd:b986:b44 with SMTP id q11-20020ad45cab000000b005ddb9860b44mr6337671qvh.6.1688164434015;
        Fri, 30 Jun 2023 15:33:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.176.217.72])
        by smtp.gmail.com with ESMTPSA id m16-20020ad44d50000000b00635eeb8a4fcsm4791679qvm.114.2023.06.30.15.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:33:53 -0700 (PDT)
Message-ID: <649f5851.d40a0220.6ab19.df43@mx.google.com>
Date:   Fri, 30 Jun 2023 15:33:53 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0175891301673091346=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dianders@chromium.org
Subject: RE: [v2,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
In-Reply-To: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
References: <20230630150906.v2.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0175891301673091346==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761688

---Test result---

Test Summary:
CheckPatch                    PASS      1.42 seconds
GitLint                       FAIL      0.95 seconds
SubjectPrefix                 PASS      0.25 seconds
BuildKernel                   PASS      33.76 seconds
CheckAllWarning               PASS      36.91 seconds
CheckSparse                   PASS      42.22 seconds
CheckSmatch                   PASS      113.64 seconds
BuildKernel32                 PASS      32.64 seconds
TestRunnerSetup               PASS      464.86 seconds
TestRunner_l2cap-tester       PASS      14.30 seconds
TestRunner_iso-tester         PASS      25.74 seconds
TestRunner_bnep-tester        PASS      6.16 seconds
TestRunner_mgmt-tester        PASS      140.60 seconds
TestRunner_rfcomm-tester      PASS      9.94 seconds
TestRunner_sco-tester         PASS      11.26 seconds
TestRunner_ioctl-tester       PASS      10.58 seconds
TestRunner_mesh-tester        PASS      7.70 seconds
TestRunner_smp-tester         PASS      8.97 seconds
TestRunner_userchan-tester    PASS      6.43 seconds
IncrementalBuild              PASS      36.49 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[v2,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()"


---
Regards,
Linux Bluetooth


--===============0175891301673091346==--
