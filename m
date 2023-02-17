Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A4DC05027
	for <linux-bluetooth@archiver.kernel.org>; Fri, 17 Feb 2023 10:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbjBQKeQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 17 Feb 2023 05:34:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBQKeP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 17 Feb 2023 05:34:15 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116CA6241A
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 02:34:14 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id u22so307091qtq.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 17 Feb 2023 02:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=12UpmDnzKDGKPRlr/Fhz2LhBAE2gDguaz+WKPR17c4Y=;
        b=ACxUun9/x7ylMsfZsAo1tm6lzvitx83kkVwdH88ItsaJre2A4MrzWPE2YCB5I62eVa
         C2TV/36jees7sBCvzDL9IcYJATfnGvHA44vLG5AEcCmHGb4RoDG+o8wmz+kZYiYNPgn/
         7Vog9Prurk8W+Nj7Rz9LYTNQDtzRN2jfqckRm/XaDkCZ4CeLgAHSMwm70G1lB3M7ZmoP
         l119KR7EA4T6tFMaRnSMidgLinSuMLbQ015o53ho0k/W0AiFkpvQi4uyQFska77ucRaf
         FGx0vP3raTNzmJwxeADWk6z36RejhObZZABqeYoo3gKTvCRsql/nrAkAplayxvmxsGHJ
         Gwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=12UpmDnzKDGKPRlr/Fhz2LhBAE2gDguaz+WKPR17c4Y=;
        b=ceHWt2Hm7RtZEpcHrnIPmsKish9D4qPqgOoXkhuAn0Zf44QGwtfhmlthz3uBmp2G/+
         r3wqoQv9NyKatNuO1H4Da4+st6fdjEerRbTVHYVmCV87SXN7U+GHQWfi5OqFphEHXcQr
         3ewRZ0qhKpqoAsrIHiF9Umk49NT1jtgRykuIyA6aFLezKpSnvO5tLgbJ1Np84JR9Orrh
         O4WJoAMxALUu9z3VuJXT6wIdcIljyF3qRi84bq1iyIBW69UeZeUkF4ysJsa+MmMEn68g
         FFs9nmNEN4auNM3asQu6Ei0R9P/ULGL67+/ucHrHFN7X7owk/ZRPk2TXQFeZK+y7oV8Y
         K56Q==
X-Gm-Message-State: AO0yUKXHVdDX1oSX2hpUpLYZIFY9ZBPuzLf56QAyS4kXn8K30LpKNSTz
        A/Wc5sL8BpaI0Hc+cu+GLnNucw58UGj+ZA==
X-Google-Smtp-Source: AK7set+c6a1V+PaH+1s74vhYbVeMUEC8lXG9oCJias9WHN7S7xhDhgIzDDjbGTeqa/exdSbMgS6QNA==
X-Received: by 2002:ac8:7e81:0:b0:3b9:bc8c:c20d with SMTP id w1-20020ac87e81000000b003b9bc8cc20dmr8860179qtj.24.1676630053026;
        Fri, 17 Feb 2023 02:34:13 -0800 (PST)
Received: from [172.17.0.2] ([172.176.128.179])
        by smtp.gmail.com with ESMTPSA id 7-20020a05620a040700b006fbb4b98a25sm2953402qkp.109.2023.02.17.02.34.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 02:34:12 -0800 (PST)
Message-ID: <63ef5824.050a0220.f2f71.9126@mx.google.com>
Date:   Fri, 17 Feb 2023 02:34:12 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1947590280026927262=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, zyytlz.wz@163.com
Subject: RE: [v2] Bluetooth: hci_core: Fix poential Use-after-Free bug in hci_remove_adv_monitor
In-Reply-To: <20230217100223.702330-1-zyytlz.wz@163.com>
References: <20230217100223.702330-1-zyytlz.wz@163.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1947590280026927262==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=722888

---Test result---

Test Summary:
CheckPatch                    PASS      0.80 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.50 seconds
CheckAllWarning               PASS      33.46 seconds
CheckSparse                   PASS      37.77 seconds
CheckSmatch                   PASS      107.02 seconds
BuildKernel32                 PASS      29.51 seconds
TestRunnerSetup               PASS      427.93 seconds
TestRunner_l2cap-tester       PASS      16.08 seconds
TestRunner_iso-tester         PASS      16.20 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      106.40 seconds
TestRunner_rfcomm-tester      PASS      8.53 seconds
TestRunner_sco-tester         PASS      7.86 seconds
TestRunner_ioctl-tester       PASS      9.20 seconds
TestRunner_mesh-tester        PASS      6.70 seconds
TestRunner_smp-tester         PASS      7.74 seconds
TestRunner_userchan-tester    PASS      5.63 seconds
IncrementalBuild              PASS      27.62 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: hci_core: Fix poential Use-after-Free bug in hci_remove_adv_monitor

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (83>80): "[v2] Bluetooth: hci_core: Fix poential Use-after-Free bug in hci_remove_adv_monitor"


---
Regards,
Linux Bluetooth


--===============1947590280026927262==--
