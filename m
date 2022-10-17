Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD24C4332F
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Oct 2022 08:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbiJQIhZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 Oct 2022 04:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiJQIhY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 Oct 2022 04:37:24 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149062BCC
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 01:37:23 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 129so9853557pgc.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 Oct 2022 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C88GMMutHDpD4IUxWO8hgco9bK6r9V9hyJZJh/kRWcc=;
        b=lD88EMjrzYNehWrQAWwUDddaP0CGT9WaqK7cVl56vR8kmKLjJt6f5WTPMF0GrBMJKl
         FKbm+kH3TnRMjTY+6YzlkxRYBsbWt3aefZDfBELdYfg8QKxPngvFDV+cAX3RpT+HWZPW
         Eqr5cBKnifQgOzw8n3gnF+9SMEnZOK9zDHG+9zNvDE8LHX0PvI8hu+21b6UZLWGtSXl8
         A83AC9i6OaLrXXM2tT4fYVBlw9ZPctIg83NyVUbkGcAib+EV9oAssUPmn/pei6tlqyzm
         fnX20bTI/0nkKz1nJ6HUz5UKuKY5JED6qbWeT++nNc8jO6WzzbcjvprcBYt9YHdDcLlU
         eJww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C88GMMutHDpD4IUxWO8hgco9bK6r9V9hyJZJh/kRWcc=;
        b=mdnlCEUbtB23oCLlKbnFhELatBt3sDtQ/wiNl/UCKxECRYPzgHocezu48d/GsqlkJR
         cZ4UJdBrH+IrWc5X67B58oFaRZS96zMaxEuV+pQPZByvRO8MU5VtBE+MbyJstZXyvk8a
         TEm0GuCg/daBMyA92d62s6pCb7WX8b7mbsgHRYTZMU4T4udiuyeiaLipwiepR5eGJd53
         hU3M/eQgHY0f2Q/bB+6CRQ36YXJgJsQpNbObOT8OPlflFki4tGSTz5cdRpm9hQyZajpV
         kHqmPtBmu4dVOIXSh3+R2574WHMT2xWGjmlN4JR3UzvUKJbBhOQn3M4oN5EbM0gnrXkM
         bMUw==
X-Gm-Message-State: ACrzQf1GNxOyKILkAFyjBwNFhtZY4tgx6uE2seofiubrqBV+7XgkAh51
        4mqOYkCw83n5Dn9pY95SpCMxTzgAnBY=
X-Google-Smtp-Source: AMsMyM7UPecl3wwPFPll0qBbahrarLpTqcC3PErzulSgEm9g/9UGxC4BorM7Lhq+gZ3D9iUCG0Q8Yw==
X-Received: by 2002:a05:6a02:190:b0:43c:7997:4d69 with SMTP id bj16-20020a056a02019000b0043c79974d69mr9707479pgb.15.1665995842225;
        Mon, 17 Oct 2022 01:37:22 -0700 (PDT)
Received: from [172.17.0.2] ([20.59.120.129])
        by smtp.gmail.com with ESMTPSA id y27-20020aa793db000000b0056263bf7109sm6502460pff.28.2022.10.17.01.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 01:37:21 -0700 (PDT)
Message-ID: <634d1441.a70a0220.201d3.b4c9@mx.google.com>
Date:   Mon, 17 Oct 2022 01:37:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1669096335726246305=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, yin31149@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix memory leak in vhci_write
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221017074432.12177-1-yin31149@gmail.com>
References: <20221017074432.12177-1-yin31149@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1669096335726246305==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=685727

---Test result---

Test Summary:
CheckPatch                    FAIL      0.99 seconds
GitLint                       FAIL      0.49 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      44.65 seconds
BuildKernel32                 PASS      40.74 seconds
Incremental Build with patchesPASS      58.75 seconds
TestRunner: Setup             PASS      661.99 seconds
TestRunner: l2cap-tester      PASS      21.06 seconds
TestRunner: iso-tester        PASS      21.23 seconds
TestRunner: bnep-tester       PASS      8.15 seconds
TestRunner: mgmt-tester       PASS      133.51 seconds
TestRunner: rfcomm-tester     PASS      12.73 seconds
TestRunner: sco-tester        PASS      11.87 seconds
TestRunner: ioctl-tester      PASS      13.82 seconds
TestRunner: mesh-tester       PASS      10.06 seconds
TestRunner: smp-tester        PASS      11.82 seconds
TestRunner: userchan-tester   PASS      8.53 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.99 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: L2CAP: Fix memory leak in vhci_write\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#124: 
Reported-and-tested-by: syzbot+8f819e36e01022991cfa@syzkaller.appspotmail.com

total: 0 errors, 1 warnings, 0 checks, 19 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/13008275.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.49 seconds
Run gitlint with rule in .gitlint
Bluetooth: L2CAP: Fix memory leak in vhci_write
14: B1 Line exceeds max length (84>80): "    [<ffffffff833f742f>] bt_skb_alloc include/net/bluetooth/bluetooth.h:469 [inline]"




---
Regards,
Linux Bluetooth


--===============1669096335726246305==--
