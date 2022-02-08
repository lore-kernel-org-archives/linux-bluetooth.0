Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1E3C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Feb 2022 23:03:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbiBHXDB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Feb 2022 18:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233343AbiBHXDA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Feb 2022 18:03:00 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853ACC061576
        for <linux-bluetooth@vger.kernel.org>; Tue,  8 Feb 2022 15:02:56 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id c3so628146pls.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 08 Feb 2022 15:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=+Li2qtdJz2VlMDcVLBK5/sVrvIhg0k0f1RAsVgcIq8o=;
        b=QyU79IOuNWxR7y26Vm+nIlpkcza3WBsdsXOUJ5eE+PkoM5HJ7n6BzfiqV/rxnQF2FP
         eeafC6BSIaoB8LeCXx9ofU0UG25/mxxeuRmSfbkSUYlLOnN5sg5y3WUxyn8I56UffyFl
         8p45cda7Ik9v0BPTopPi8jOkqiI7KvjPYpGcK04liZW87m2D6o5nr3STw0ja4B8VEkYj
         aF4kpsE7j419WO3wC8B/qMAgIFJ46Sk9OT++WYVbG+UuiN45XrQdGHq0eCgaSSdBsvzL
         oWLcQw5VALmI+18TSHOUtUGuWiT84AlHHoIFQg9zhaWtQSCn1IEUA5+CAihoJPw71Da8
         60zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=+Li2qtdJz2VlMDcVLBK5/sVrvIhg0k0f1RAsVgcIq8o=;
        b=PZDp0xIHe4gDd18NU39UyXDgP3Y9BoGThVCE6w7n8MPox5slsdfJuHP++zU+RTVM4q
         8enUGepSFpNhTZXTgJLtoE63aU1GAsk02SERgXGP0UBgEBkyuFd5vPPbnWJIvkq5y6xC
         vHVvDzH5VraAN0QAZWGmxU2XpRlixRxwaYu4cXiSoRlbnDRf9uR5zUjAj/lRn/SD2r/v
         2UMBuzhVeHbts3wFTosw/YBxaVJstW9tC4l5h+CD3o1P/nzUi/Pe7p49iRg0hWSE9nZn
         7zF+wZAEzNZhk/FBDtABpz5fBbhQk/quh6kWVwfsBgzlecZaPoFIyhd9UjzxJdiVSf35
         2wcg==
X-Gm-Message-State: AOAM5308hXauHQzDFjj6CMim/7J0AFJSJ5JajRKNWs94WAC6ofJCfhNq
        Bb5B4FXhtZ0obbKCT1/qs3Qk0/+5hXM=
X-Google-Smtp-Source: ABdhPJyGIpT7vcSIjH5EU8bDgRrymVpWdfEhFrM0ZUldAW1bbwOqX1o/7yMppdUaXP3aWEkPLH2bdg==
X-Received: by 2002:a17:903:11c9:: with SMTP id q9mr6530912plh.144.1644361375622;
        Tue, 08 Feb 2022 15:02:55 -0800 (PST)
Received: from [172.17.0.2] ([20.109.180.152])
        by smtp.gmail.com with ESMTPSA id on14sm3945668pjb.34.2022.02.08.15.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 15:02:55 -0800 (PST)
Message-ID: <6202f69f.1c69fb81.41e51.a4a9@mx.google.com>
Date:   Tue, 08 Feb 2022 15:02:55 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4899638340731640620=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, pmenzel@molgen.mpg.de
Subject: RE: [1/2] Revert "Bluetooth: Fix passing NULL to PTR_ERR"
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220208221911.57058-1-pmenzel@molgen.mpg.de>
References: <20220208221911.57058-1-pmenzel@molgen.mpg.de>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4899638340731640620==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=612351

---Test result---

Test Summary:
CheckPatch                    FAIL      2.11 seconds
GitLint                       FAIL      0.74 seconds
SubjectPrefix                 PASS      0.51 seconds
BuildKernel                   PASS      37.46 seconds
BuildKernel32                 PASS      33.75 seconds
Incremental Build with patchesPASS      51.88 seconds
TestRunner: Setup             PASS      597.35 seconds
TestRunner: l2cap-tester      PASS      15.94 seconds
TestRunner: bnep-tester       PASS      7.22 seconds
TestRunner: mgmt-tester       PASS      128.61 seconds
TestRunner: rfcomm-tester     PASS      9.02 seconds
TestRunner: sco-tester        PASS      9.47 seconds
TestRunner: smp-tester        PASS      9.21 seconds
TestRunner: userchan-tester   PASS      7.54 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.11 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[2/2] Revert "Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg"\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#69: 
    Attempting to send /lib/systemd/systemd to /org/bluez/obex/client/session0

CHECK:PARENTHESIS_ALIGNMENT: Alignment should match open parenthesis
#180: FILE: net/bluetooth/rfcomm/sock.c:586:
+		skb = sock_alloc_send_skb(sk, size + RFCOMM_SKB_RESERVE,
+				msg->msg_flags & MSG_DONTWAIT, &err);

total: 0 errors, 1 warnings, 1 checks, 121 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12739414.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.74 seconds
Run gitlint with rule in .gitlint
[2/2] Revert "Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg"
1: T1 Title exceeds max length (85>80): "[2/2] Revert "Bluetooth: RFCOMM: Replace use of memcpy_from_msg with bt_skb_sendmmsg""
25: B1 Line exceeds max length (95>80): "    [CHG] Transfer /org/bluez/obex/client/session0/transfer0 Transferred: 32737 (@32KB/s 00:55)"
31: B1 Line exceeds max length (141>80): "Link: https://lore.kernel.org/linux-bluetooth/aa3ee7ac-6c52-3861-1798-3cc1a37f6ebf@molgen.mpg.de/T/#m1f9673e4ab0d55a7dccf87905337ab2e67d689f1"




---
Regards,
Linux Bluetooth


--===============4899638340731640620==--
