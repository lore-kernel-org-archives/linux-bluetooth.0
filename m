Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F758C61DA4
	for <linux-bluetooth@archiver.kernel.org>; Thu,  9 Mar 2023 08:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjCIIoV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 9 Mar 2023 03:44:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjCIIoC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 9 Mar 2023 03:44:02 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1C83C795
        for <linux-bluetooth@vger.kernel.org>; Thu,  9 Mar 2023 00:43:56 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id s12so1173955qtq.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Mar 2023 00:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678351436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZPWqAUzB1lbFYFNbTKZm+Iy5gho3F+L3+1s6qJyBnTM=;
        b=iVLYIQDnscvZ1z5C1NQH9oVbwjl6kPAOpf6HlH9obhm3v3weEMQ2uHrdmnLX+MwqyW
         QjYFy2xINsFW1oGb+BiitTwZQi7jpHX5J3WXXODC4n1GmSSSMvZQZ4lDP8pGFVyGQY+Z
         tPQNAgTqb7pTdE4KtgRISBPFPH8cNABRpCSlUIhRi7RKdD1G6iBdAsIiDtGyC0i8Wmjj
         yeApgOtt9wcMTS6CG30YDC0/Q2Cyp9cXzzm86fh7W0GGOOFCD3jXwV+s547s28zWoI6r
         8wXvY8iH1irrOlLEpZZmSpBvI29ZzuJGw9vE2txAM3Sw9jfmI4CsyGGxSk+GbcgV2PJG
         00dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678351436;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZPWqAUzB1lbFYFNbTKZm+Iy5gho3F+L3+1s6qJyBnTM=;
        b=wU3ZfpOPv2qQF8RVS2ZH9OCgcJxPs9TgC+cd/DuvxP5wlPf0nAnID0pqyvITugZk2L
         sa0p0lJVtDw4zDPn0UGyWUg0S29Bgnf0wUXjonP7IPh6WVf0+BMdudwDfsJKQWMUJ8ht
         Bo9W2BGpwf0YYOMjs4E1sM6/WYv5kqTjdKyGFrGYGNHiMZwaWsZsEP1M05CI/DBQW4pm
         rXajoh18ac6zfUFY8dn3U+rfAWx+ItJLryZpwfQ4IuGeHa0hy2l5OmPsqd6u15M8TR0J
         z6qTBV+wTeIkJj2XoYimVZGWhto/0M+beYYVTqzJv8AyH9yRsLMpGmT/I+m8tNs1ajeo
         apjg==
X-Gm-Message-State: AO0yUKXHPUELQyFEwCEVNxtmN+Smva8K9/+G3XDxmTSyklLPAWJdzMx/
        EZTUAcnjruz6Ixfd2Q84qhtqe96i8OI=
X-Google-Smtp-Source: AK7set9dQ1A3qOna7y88U420MUqMeBdo9l2vHQ47CWXwKkrO5X1o1peTK/USHpXl3sKneOEwK0xNmQ==
X-Received: by 2002:ac8:7fc3:0:b0:3c0:3c25:1b9f with SMTP id b3-20020ac87fc3000000b003c03c251b9fmr1440022qtk.56.1678351435797;
        Thu, 09 Mar 2023 00:43:55 -0800 (PST)
Received: from [172.17.0.2] ([20.42.13.2])
        by smtp.gmail.com with ESMTPSA id i10-20020ac871ca000000b003bfb950f670sm13146870qtp.41.2023.03.09.00.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 00:43:55 -0800 (PST)
Message-ID: <64099c4b.c80a0220.20c25.9ea9@mx.google.com>
Date:   Thu, 09 Mar 2023 00:43:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8811965886856071397=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, wzhmmmmm@gmail.com
Subject: RE: Bluetooth: Fix double free in hci_conn_cleanup
In-Reply-To: <20230309074645.74309-1-wzhmmmmm@gmail.com>
References: <20230309074645.74309-1-wzhmmmmm@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8811965886856071397==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=728135

---Test result---

Test Summary:
CheckPatch                    PASS      0.79 seconds
GitLint                       FAIL      0.66 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      46.02 seconds
CheckAllWarning               PASS      50.61 seconds
CheckSparse                   PASS      56.37 seconds
CheckSmatch                   PASS      151.79 seconds
BuildKernel32                 PASS      44.10 seconds
TestRunnerSetup               PASS      629.37 seconds
TestRunner_l2cap-tester       PASS      20.59 seconds
TestRunner_iso-tester         PASS      22.83 seconds
TestRunner_bnep-tester        PASS      8.18 seconds
TestRunner_mgmt-tester        FAIL      146.90 seconds
TestRunner_rfcomm-tester      PASS      12.44 seconds
TestRunner_sco-tester         PASS      11.54 seconds
TestRunner_ioctl-tester       FAIL      13.13 seconds
TestRunner_mesh-tester        PASS      10.25 seconds
TestRunner_smp-tester         PASS      10.93 seconds
TestRunner_userchan-tester    PASS      8.58 seconds
IncrementalBuild              PASS      41.29 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
Bluetooth: Fix double free in hci_conn_cleanup

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
4: B2 Line has trailing whitespace: "After releasing an object using hci_conn_del_sysfs in the "
5: B2 Line has trailing whitespace: "hci_conn_cleanup function, releasing the same object again "
28: B2 Line has trailing whitespace: "This patch drop the hci_dev_put and hci_conn_put function "
29: B2 Line has trailing whitespace: "call in hci_conn_cleanup function, because the object is "
32: B1 Line exceeds max length (87>80): "Link: https://syzkaller.appspot.com/bug?id=1bb51491ca5df96a5f724899d1dbb87afda61419 [1]"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 5, Not Run: 0

Failed Test Cases
Read Ext Controller Info 1                           Failed       0.168 seconds
Read Ext Controller Info 2                           Failed       0.196 seconds
Read Ext Controller Info 3                           Failed       0.172 seconds
Read Ext Controller Info 4                           Failed       0.184 seconds
Read Ext Controller Info 5                           Failed       0.220 seconds
##############################
Test: TestRunner_ioctl-tester - FAIL
Desc: Run ioctl-tester with test-runner
Output:
No test result found


---
Regards,
Linux Bluetooth


--===============8811965886856071397==--
