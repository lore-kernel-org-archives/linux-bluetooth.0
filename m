Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE862C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 22:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiJDWKT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 18:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbiJDWIg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 18:08:36 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAD91EEF2
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 15:08:33 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d10so14278535pfh.6
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=yfLNJHVKuhwI0boQuyUADQEEWIuPUI39pohTdgkIpko=;
        b=mRuO+AnY5vGmxk/8ZmPgfqFbJL7/2X7w/57ouV7wLFpi0JTWDBucZHXU/VytInhRzs
         y1EIqZNvZVnfLfCA71Xvq2Vx/24tQet3RO2WAdAVyHFvLCkTGKtuCr4m2iA4wN2aIG68
         dIuv26ttGvOJqJn5nhCSs02TKisb8o+VJ1YOTiTRidSqut5/BixlaLASzgX8fsy6qQDZ
         AcwYQsija2WYjfbkxfu54vfZcAInKRAeUZgFIEwKrhPWa3H7d+elbTUDflJQea8H4CYy
         PHO/f2NlXZ50hyk5NtQE2a07I7TwsnMULfdJ8NV+UkiuJvvWolitNPp3sQ36j4DtlS6M
         mBlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=yfLNJHVKuhwI0boQuyUADQEEWIuPUI39pohTdgkIpko=;
        b=yCzQJShwWeMtnhjIBUHmCLE1BqIuoxFGJjbDk03k1xaFe3lGCE2FF+AA7/XDNxDXVT
         DYcDbbVOY8dTpWsNOkLnQdvK2427ZlFZK0wnfjvcQAwnJrQSxiNaOAfonjX7Cgf6k1PA
         uYFQBQu3TCkp5P/urgYKSURvBfMBj419pUF+wmAgXVI7FB71JFuyOl/N9f3djZ0snTCJ
         lS5u7d/Vsmhr4I4CqcvpFnbnWJ5at7riap2+7KQ5TvlBhXuVZq3XAd6SZ9rVhEPMNF2c
         7FaBZvNXXqX/0wV/fNbyq90QJnKvkuCo9pXCMkPLTpK8xKjfuq1G2fc9dzq+hHNuWwrj
         cw3g==
X-Gm-Message-State: ACrzQf1Vr0xpcWQbUyQz3cbPm+udBg2K8DN/wawXuqe9nWzhY8b55nN8
        e7aJ+kCmkUATZ/DJo02QamLMNjxLT+I=
X-Google-Smtp-Source: AMsMyM7m2f8a0POEb/PQzy8qMTgVDV2Z/ZX7LRRDi6IV2wKakn8sMsc4lmhkJbg9cAF922vubfYp+Q==
X-Received: by 2002:a63:36c7:0:b0:452:86db:3e8e with SMTP id d190-20020a6336c7000000b0045286db3e8emr7675651pga.99.1664921312076;
        Tue, 04 Oct 2022 15:08:32 -0700 (PDT)
Received: from [172.17.0.2] ([138.91.166.160])
        by smtp.gmail.com with ESMTPSA id n17-20020aa79851000000b00537eacc8fa6sm4288241pfq.40.2022.10.04.15.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 15:08:31 -0700 (PDT)
Message-ID: <633caedf.a70a0220.6c159.7746@mx.google.com>
Date:   Tue, 04 Oct 2022 15:08:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3924287937666750028=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, maxtram95@gmail.com
Subject: RE: [v3] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221004212718.504094-1-maxtram95@gmail.com>
References: <20221004212718.504094-1-maxtram95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3924287937666750028==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683096

---Test result---

Test Summary:
CheckPatch                    FAIL      0.94 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.35 seconds
BuildKernel                   PASS      39.46 seconds
BuildKernel32                 PASS      34.23 seconds
Incremental Build with patchesPASS      48.74 seconds
TestRunner: Setup             PASS      580.27 seconds
TestRunner: l2cap-tester      PASS      18.67 seconds
TestRunner: iso-tester        PASS      18.00 seconds
TestRunner: bnep-tester       PASS      7.03 seconds
TestRunner: mgmt-tester       PASS      112.97 seconds
TestRunner: rfcomm-tester     PASS      10.98 seconds
TestRunner: sco-tester        PASS      10.42 seconds
TestRunner: ioctl-tester      PASS      11.88 seconds
TestRunner: smp-tester        PASS      10.37 seconds
TestRunner: userchan-tester   PASS      7.27 seconds

Details
##############################
Test: CheckPatch - FAIL - 0.94 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#115: 
 l2cap_rx (net/bluetooth/l2cap_core.c:7236 net/bluetooth/l2cap_core.c:7271) bluetooth

total: 0 errors, 1 warnings, 0 checks, 81 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12998705.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.48 seconds
Run gitlint with rule in .gitlint
[v3] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu
21: B1 Line exceeds max length (93>80): "BUG: KASAN: use-after-free in l2cap_rx_state_recv (net/bluetooth/l2cap_core.c:6906) bluetooth"
33: B1 Line exceeds max length (85>80): " l2cap_rx (net/bluetooth/l2cap_core.c:7236 net/bluetooth/l2cap_core.c:7271) bluetooth"
35: B1 Line exceeds max length (278>80): " ? l2cap_chan_hold_unless_zero (./arch/x86/include/asm/atomic.h:202 ./include/linux/atomic/atomic-instrumented.h:560 ./include/linux/refcount.h:157 ./include/linux/refcount.h:227 ./include/linux/refcount.h:245 ./include/linux/kref.h:111 net/bluetooth/l2cap_core.c:517) bluetooth"
37: B1 Line exceeds max length (125>80): " l2cap_recv_frame (net/bluetooth/l2cap_core.c:7405 net/bluetooth/l2cap_core.c:7620 net/bluetooth/l2cap_core.c:7723) bluetooth"
39: B1 Line exceeds max length (86>80): " ? hci_rx_work (net/bluetooth/hci_core.c:3637 net/bluetooth/hci_core.c:3832) bluetooth"
41: B1 Line exceeds max length (93>80): " ? trace_contention_end (./include/trace/events/lock.h:122 ./include/trace/events/lock.h:122)"
43: B1 Line exceeds max length (126>80): " ? hci_rx_work (./include/net/bluetooth/hci_core.h:1024 net/bluetooth/hci_core.c:3634 net/bluetooth/hci_core.c:3832) bluetooth"
45: B1 Line exceeds max length (187>80): " ? __mutex_unlock_slowpath (./arch/x86/include/asm/atomic64_64.h:190 ./include/linux/atomic/atomic-long.h:449 ./include/linux/atomic/atomic-instrumented.h:1790 kernel/locking/mutex.c:924)"
50: B1 Line exceeds max length (84>80): " hci_rx_work (net/bluetooth/hci_core.c:3642 net/bluetooth/hci_core.c:3832) bluetooth"
56: B1 Line exceeds max length (191>80): " ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207 (discriminator 4) ./include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:270 (discriminator 4))"
65: B1 Line exceeds max length (86>80): " __kasan_slab_alloc (mm/kasan/common.c:45 mm/kasan/common.c:436 mm/kasan/common.c:469)"
68: B1 Line exceeds max length (100>80): " l2cap_recv_frag (./include/net/bluetooth/bluetooth.h:425 net/bluetooth/l2cap_core.c:8329) bluetooth"
70: B1 Line exceeds max length (84>80): " hci_rx_work (net/bluetooth/hci_core.c:3642 net/bluetooth/hci_core.c:3832) bluetooth"
83: B1 Line exceeds max length (96>80): " skb_free_datagram (./include/net/sock.h:1578 ./include/net/sock.h:1639 net/core/datagram.c:323)"
93: B1 Line exceeds max length (117>80): "Link: https://lore.kernel.org/linux-bluetooth/CAKErNvoqga1WcmoR3-0875esY6TVWFQDandbVZncSiuGPBQXLA@mail.gmail.com/T/#u"




---
Regards,
Linux Bluetooth


--===============3924287937666750028==--
