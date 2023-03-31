Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE47BC761A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 21:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233214AbjCaV6Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 17:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbjCaV6X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 17:58:23 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4377161B7
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:57:58 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r5so23027808qtp.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 14:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680299869;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQUZoz45DUdJQ0974+IZ8egO26aPUXhkzxMk6lGByuo=;
        b=OW8/gpwwkIgdlf9rerUbgYmVzyG0kbk1tBT3gWaF8dNGCVRDoFyMnakn58gQBrugrU
         F5qm+n5dJMGmoSbNAypchdrC8jNTus2n88h8jWM9XXUfheDMEl0p8pc2b+Nxx/7EZLvt
         PnGWhctu30GvxbXmrrg7S2eLlVLGkTrmBdnL4XHhZOwAtrkI16WvKnBP/kS1t4/5AkNZ
         54yypxcntvCT9oOgJ0AGFQDP6/YvgKs+fKeIvoI6pgvwW3Xt320O1ZcdMNK/TLEbIRW9
         cTxd682ZuUs+mN0jzwNsesCbbJis+gXZaVZ+NL7ME5pvZvCtwVtS9WWtoaNCByxc+Qks
         znlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680299869;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jQUZoz45DUdJQ0974+IZ8egO26aPUXhkzxMk6lGByuo=;
        b=tYazhGahLO2bqxjQOpe3gzqD8C0LIekdHWYBmgIwZpfqxWQ+2ViKIir5s+W0wK9KuJ
         CpSYafO3aTJIs7rPtZow7BvOATzTF3epEEjqpj+Fbdkf9+bpTlOTACHjsIBU+AZKVwRl
         F2y0Vj91dhkyEIyo268eOZbiSLQ7s58tQZOMgdzPl2vL6Md6rZ8MFBf2HUhhGqK3RrMy
         q6dZHlLBhrUZse+c5u3pJ0xMHNipBn1bYeX3p2eUlH//ChqBnlZTfgOaOOxkkop8162q
         ULTraLCXr0GBefgoRQjmzXiKQhKyJefmnNI6fgs4zK/Tm2Z6/5U8fDJ7MHM9nwVdCZpe
         HABw==
X-Gm-Message-State: AO0yUKVzZ47sbSe1JE229L4lL/AyK6fZY8k1iGD4k5wT8+OUYQPKxZE1
        2HsctoGw/fz2Hc5rzHBnUWtcFl+jP7A=
X-Google-Smtp-Source: AK7set/CxpQu86/9vUuFLojQhI0COUm0RBs2nnt8zer7346ekDAS6SLAi83EBlnVpWRT9FVHJBlhUw==
X-Received: by 2002:ac8:5901:0:b0:3e3:7ce1:e746 with SMTP id 1-20020ac85901000000b003e37ce1e746mr46996449qty.15.1680299869546;
        Fri, 31 Mar 2023 14:57:49 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.202.166])
        by smtp.gmail.com with ESMTPSA id s194-20020a37a9cb000000b007469b5bc2c4sm975162qke.13.2023.03.31.14.57.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 14:57:49 -0700 (PDT)
Message-ID: <6427575d.370a0220.a808e.55c8@mx.google.com>
Date:   Fri, 31 Mar 2023 14:57:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5845690670725418076=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_bcm: 4 fixes / tweaks
In-Reply-To: <20230331211124.463003-2-hdegoede@redhat.com>
References: <20230331211124.463003-2-hdegoede@redhat.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5845690670725418076==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735976

---Test result---

Test Summary:
CheckPatch                    PASS      2.81 seconds
GitLint                       FAIL      1.69 seconds
SubjectPrefix                 PASS      0.50 seconds
BuildKernel                   PASS      33.49 seconds
CheckAllWarning               PASS      35.91 seconds
CheckSparse                   PASS      42.56 seconds
CheckSmatch                   PASS      112.38 seconds
BuildKernel32                 PASS      32.33 seconds
TestRunnerSetup               PASS      453.00 seconds
TestRunner_l2cap-tester       PASS      16.21 seconds
TestRunner_iso-tester         PASS      16.31 seconds
TestRunner_bnep-tester        PASS      5.30 seconds
TestRunner_mgmt-tester        PASS      110.12 seconds
TestRunner_rfcomm-tester      PASS      8.36 seconds
TestRunner_sco-tester         PASS      7.77 seconds
TestRunner_ioctl-tester       PASS      9.03 seconds
TestRunner_mesh-tester        PASS      6.68 seconds
TestRunner_smp-tester         PASS      7.69 seconds
TestRunner_userchan-tester    PASS      5.59 seconds
IncrementalBuild              PASS      44.53 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[3/4] Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (93>80): "[3/4] Bluetooth: hci_bcm: Add Lenovo Yoga Tablet 2 830 / 1050 to the bcm_broken_irq_dmi_table"
[4/4] Bluetooth: hci_bcm: Add Acer Iconia One 7 B1-750 to the bcm_broken_irq_dmi_table

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (86>80): "[4/4] Bluetooth: hci_bcm: Add Acer Iconia One 7 B1-750 to the bcm_broken_irq_dmi_table"


---
Regards,
Linux Bluetooth


--===============5845690670725418076==--
