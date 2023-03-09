Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1145C64EC4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Mar 2023 10:02:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCIKCW (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjCIKCM (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 05:02:12 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5298ECB661
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 02:02:11 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id ne1so1033197qvb.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 02:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678356130;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Apyq7JUpKvglJaTYHduVqSQM1WLkaW9bjLJFKMScdGE=;
        b=k+B2Sl4zHvbKe4HtbRdrxO0riNydRRhlsGa9Pn+Lp/GXzQxizHbA+LOl7DJdTNUdwV
         PIFakNr8EqMzFNdo70CZQzpo/gbpvy8/h4fz5wnMRFVJkSD5GtVvuLp7TzGTDx0X0z23
         qp83TD8WX4YahnqwjT9k2Ov42UbyxVF00jDdJ4eXfnjIYZsz28ezbx4UQ/TMxvGLRJTV
         UYwUihvJbFZd1eq9xZTGBUJCEeQbuyzW9vKoLzpXY1YYpFcR5xCHEmkG21lwZ03UAHnf
         Nb7zYTIpXcTOh35La24iT/Mc/ko3QDwuD/85GlLOrkan1p5ajvwUBiXkrllVMFl1kyU/
         Up2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678356130;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Apyq7JUpKvglJaTYHduVqSQM1WLkaW9bjLJFKMScdGE=;
        b=fxv2JkUmt1Lcqeg9LtiJx9K+nbYKpGqhENtHwEaZbRvlWpF6mOwWQs0IFEZilcrG7g
         zXlz2shErkDlyr6e/atIIx8O0obkLvcJDXH3eBx3qZPDGclVjG1iV44VxpI3KU+kwxLS
         tCksQF/LcQ0FvH1+u+Xkb/RzL6Mou3OfEBaIxu41P0dfNPa/i09Hz8XpU2LvksBC2TYy
         NpYJNzmDFSlc+MTfxHMkrnXpHwU7unXQzUo5uLW+/ExpWhEAXhFR0p/YwnMgJQlY3ypE
         TNNxWdbdM5avrTbl91C91yJi0WHSx6c8QyynA6GHZTk19KtLKuAIAGA2FVOJjAfeHtkC
         QbvQ==
X-Gm-Message-State: AO0yUKUv+gqDDQCkylGFBpeUdOUyfQ78XkgBuvnbK56JOHcmY0dOhwqq
        WPfuIqePKVHcHYISr5nRQMgA1WdPuvU=
X-Google-Smtp-Source: AK7set/ERB3K+a11yZzwe9t70HLBbfZpjuAxVS6TjzxDxeclPK2NCYQYO8raRrdJf91bf5FoSeiXsA==
X-Received: by 2002:a05:6214:405:b0:56e:bb5b:3dfc with SMTP id z5-20020a056214040500b0056ebb5b3dfcmr39063203qvx.38.1678356130264;
        Thu, 09 Mar 2023 02:02:10 -0800 (PST)
Received: from [172.17.0.2] ([20.185.156.80])
        by smtp.gmail.com with ESMTPSA id c26-20020a05620a0cfa00b0073b81e888bfsm12775280qkj.56.2023.03.09.02.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:02:10 -0800 (PST)
Message-ID: <6409aea2.050a0220.6601f.8ca4@mx.google.com>
Date:   Thu, 09 Mar 2023 02:02:10 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0851564141515445869=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wzhmmmmm@gmail.com
Subject: RE: Bluetooth: Fix double free in hci_conn_cleanup
In-Reply-To: <20230309093442.74618-1-wzhmmmmm@gmail.com>
References: <20230309093442.74618-1-wzhmmmmm@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0851564141515445869==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728193

---Test result---

Test Summary:
CheckPatch                    PASS      0.76 seconds
GitLint                       FAIL      0.76 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      39.46 seconds
CheckAllWarning               PASS      43.50 seconds
CheckSparse                   PASS      48.67 seconds
CheckSmatch                   PASS      129.92 seconds
BuildKernel32                 PASS      39.50 seconds
TestRunnerSetup               PASS      543.39 seconds
TestRunner_l2cap-tester       PASS      18.91 seconds
TestRunner_iso-tester         PASS      24.66 seconds
TestRunner_bnep-tester        PASS      7.19 seconds
TestRunner_mgmt-tester        FAIL      130.80 seconds
TestRunner_rfcomm-tester      PASS      10.79 seconds
TestRunner_sco-tester         PASS      10.10 seconds
TestRunner_ioctl-tester       FAIL      12.00 seconds
TestRunner_mesh-tester        PASS      9.13 seconds
TestRunner_smp-tester         PASS      9.75 seconds
TestRunner_userchan-tester    PASS      7.58 seconds
IncrementalBuild              PASS      36.34 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix double free in hci_conn_cleanup

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
32: B1 Line exceeds max length (87>80): "Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 5, Not Run: 0

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.144 seconds
Read Ext Controller Info 2                           Failed       0.176 seconds
Read Ext Controller Info 3                           Failed       0.148 seconds
Read Ext Controller Info 4                           Failed       0.144 seconds
Read Ext Controller Info 5                           Failed       0.180 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No test result found


---
Regards,
Linux Bluetooth


--===============0851564141515445869==--
