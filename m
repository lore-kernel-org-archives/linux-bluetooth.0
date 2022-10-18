Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFCFC4332F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 Oct 2022 03:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiJRDs1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 23:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiJRDs0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 23:48:26 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF99D1CB06
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 20:48:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id o21so10229486ple.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 20:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=QkGBEFOMsCm006DTiRGt9AXDfilZCzXdFfBsy2+FPLs=;
        b=jCEAO26okkooay8mAHEkGCdqoxYA70e7Sue3bZR76iVRrfSosuL1+SGFgyUsYwHf4y
         g0NF6eD6DNfQCufLzUhV3TPdyB41nEJ+PGDwm5OjdWm3NssC+pgU64v6AFt3AYPDWi/m
         9i3+7ZszGBq5UiTpVahTOTOonI8qjpIRlDkOYyjbJxtFnni64hAf8U+/G5IwFzw+kwDc
         GjejPeoUAkjGOpO2AsLYd7kNwOgbEPWxUCUWEXh4PIIF6X7jNJlBK0OyjY9G/eZc+eyo
         OYqukCX2jR2z8f/RuU+0xql4jVwW9uXETPwTFrsh8o9mumEisf8b9V/JgjTZ8eaEjABB
         0ZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QkGBEFOMsCm006DTiRGt9AXDfilZCzXdFfBsy2+FPLs=;
        b=VksstjOpRFgPqpnjxPKTa6OyJKaqroCdZWr1GDMDmXcLverdY+DiXF14dPg6WDena9
         CIjutCm051Fpd6M3qiyuR9WVnl5GXKzpdQY5zICbFhAuugVIQlMGK9ObuBlLzHOIc4yk
         Ui8EJfY2wz3TLPT6xJ5GPUOXw3cWfF261SkvakOmx/x7KcRZOl6VLXaXf7/RC3LGhr3P
         I1OlZPW7EdSwHi6ZBsgDuGjR0vRWktLQ/p8jqloBQmYCQzFk4A4Ic7XKu7WBcOs5kubS
         dEej1/2XQOJQc8ceidqSncDHCBBk4hlP/HQ10dqLWnDTf7s+ADOqHM/HAdeOfv60S0vl
         JhAQ==
X-Gm-Message-State: ACrzQf1IVDno/VgM2JxjVN5pFXHNnQkygZxTv6SwP3fqGFUtwaMiHqBc
        AlDA0ESfKEuwZzlm5vi+c2vHh0VyIEQ=
X-Google-Smtp-Source: AMsMyM7inqJXRNQuI5QFZdhcV4F8ReA4KU/6XoAWWR1wvvclneda3Wdgj2Ohy9nPTImSQOaPlerCDA==
X-Received: by 2002:a17:90b:4f8e:b0:20c:c3a8:38b with SMTP id qe14-20020a17090b4f8e00b0020cc3a8038bmr1296486pjb.10.1666064905153;
        Mon, 17 Oct 2022 20:48:25 -0700 (PDT)
Received: from [172.17.0.2] ([20.66.83.110])
        by smtp.gmail.com with ESMTPSA id y3-20020aa79423000000b00563176d1701sm7998347pfo.3.2022.10.17.20.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 20:48:24 -0700 (PDT)
Message-ID: <634e2208.a70a0220.de313.ef50@mx.google.com>
Date:   Mon, 17 Oct 2022 20:48:24 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4882682248512078065=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yin31149@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix memory leak in vhci_write
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221018021851.2900-1-yin31149@gmail.com>
References: <20221018021851.2900-1-yin31149@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4882682248512078065==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=686047

---Test result---

Test Summary:
CheckPatch                    FAIL      1.04 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.32 seconds
BuildKernel                   PASS      44.60 seconds
BuildKernel32                 PASS      39.35 seconds
Incremental Build with patchesPASS      57.76 seconds
TestRunner: Setup             PASS      655.28 seconds
TestRunner: l2cap-tester      PASS      19.96 seconds
TestRunner: iso-tester        PASS      20.38 seconds
TestRunner: bnep-tester       PASS      7.97 seconds
TestRunner: mgmt-tester       PASS      128.27 seconds
TestRunner: rfcomm-tester     PASS      12.55 seconds
TestRunner: sco-tester        PASS      11.92 seconds
TestRunner: ioctl-tester      PASS      13.82 seconds
TestRunner: mesh-tester       PASS      9.65 seconds
TestRunner: smp-tester        PASS      11.43 seconds
TestRunner: userchan-tester   PASS      8.15 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.04 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: L2CAP: Fix memory leak in vhci_write\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#124: 
Reported-and-tested-by: syzbot+8f819e36e01022991cfa@syzkaller.appspotmail.com

total: 0 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13009800.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.48 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: L2CAP: Fix memory leak in vhci_write
14: B1 Line exceeds max length (84>80): "    [<ffffffff833f742f>] bt_skb_alloc include/net/bluetooth/bluetooth.h:469 [inline]"




---
Regards,
Linux Bluetooth


--===============4882682248512078065==--
