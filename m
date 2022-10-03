Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE520C433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon,  3 Oct 2022 18:31:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiJCSbC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 3 Oct 2022 14:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJCSbA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 3 Oct 2022 14:31:00 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE3F30F5E
        for <linux-bluetooth@vger.kernel.org>; Mon,  3 Oct 2022 11:30:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id h8-20020a17090a054800b00205ccbae31eso16038287pjf.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 03 Oct 2022 11:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=Iv1IDdgO+vD0D5586LqFD3dEr1KeRLoQkw/uaVDgjkY=;
        b=OatGJKQq1zdFTxA0zQCoD7QFbZdJVLTf3k673xrE5xF6I5H4du/Eo2ZIcLap86Mdf1
         JN6ur+ReiF94CNdZWqZJFUNNvz4CiTvcGjrKTMYHkVRieY4NXokzmP7hCR1dSj4TKZ1a
         Qud455DCX8w0I+rHsjdLQdlVb4Ll4t7s7WMZQj5fFWLCqEjnNtzbclUA8a0f1yGo6sRz
         KOukG7+AFm5jS0NNjv3SfpP1YPzGLQFRcO4eTYoPJTSwitNd3E4YqtsY+8rfNJBCpk0F
         04GiuheDkg5c+vxdaAMjQmNzVXv2uOIHhmU2Z6ZR6zvDjqIOznDciW3l9GlZ7Ka+jNAf
         ynsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=Iv1IDdgO+vD0D5586LqFD3dEr1KeRLoQkw/uaVDgjkY=;
        b=UjBbZK4FLvs8ZwRON5dNmYXrOchfwMgc29xmEg3CE//C/ZA4suxuS0qqcMspawuaLv
         T2AiSZVQ3fzmv5QBpvtQtit8IMmx9P4TFuSkDlMzYMPweOQDC7+1PJ9INkJXTl28ud7X
         uxu8LbWcAPqh9u1Uq4PSuuXe5vhbKYgj9Jb3zbcO+U3cnJAS8NUGok3falegYKQ9g9V6
         3x2qckZ6+ZjA12gTt1FxbLfafNplYzjWhRP/SwQLTwUi3Xl5k5K3N80TV7LaZ2TI+TBO
         xnSWQ1JDa75EczeCIBBSaZEM1IQNppA7ulKNOo6ZRGZs4OM9fnhs5HQM1Ze2y10l8G3b
         crmg==
X-Gm-Message-State: ACrzQf1Ovb5a5oY6hJKsYa4/EAZh6M5JW17dlcI7jFEBxLzVoIvz2iq/
        CdqXN9lv6opVQcC78NV1/7y3/dNedZs=
X-Google-Smtp-Source: AMsMyM5Mncy4ZPHfTqVynPMxdmWUUmrTfyAXOhUJEJ2jRsSAPuHZKrV8SMEiRPe7X8ZwPHSZu+ckUg==
X-Received: by 2002:a17:902:cec8:b0:178:1b77:5afe with SMTP id d8-20020a170902cec800b001781b775afemr23034896plg.63.1664821859080;
        Mon, 03 Oct 2022 11:30:59 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.254.153])
        by smtp.gmail.com with ESMTPSA id ci17-20020a17090afc9100b001fd7fe7d369sm6652799pjb.54.2022.10.03.11.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 11:30:58 -0700 (PDT)
Message-ID: <633b2a62.170a0220.c9101.adbe@mx.google.com>
Date:   Mon, 03 Oct 2022 11:30:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2078781431527773233=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, maxtram95@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221003172506.479790-1-maxtram95@gmail.com>
References: <20221003172506.479790-1-maxtram95@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2078781431527773233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682811

---Test result---

Test Summary:
CheckPatch                    FAIL      1.43 seconds
GitLint                       FAIL      0.48 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      44.58 seconds
BuildKernel32                 PASS      40.50 seconds
Incremental Build with patchesPASS      59.79 seconds
TestRunner: Setup             PASS      678.57 seconds
TestRunner: l2cap-tester      PASS      21.22 seconds
TestRunner: iso-tester        PASS      21.65 seconds
TestRunner: bnep-tester       PASS      8.40 seconds
TestRunner: mgmt-tester       PASS      132.37 seconds
TestRunner: rfcomm-tester     PASS      12.71 seconds
TestRunner: sco-tester        PASS      12.05 seconds
TestRunner: ioctl-tester      PASS      13.91 seconds
TestRunner: smp-tester        PASS      11.98 seconds
TestRunner: userchan-tester   PASS      8.60 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.43 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#115: 
 l2cap_rx (net/bluetooth/l2cap_core.c:7236 net/bluetooth/l2cap_core.c:7271) bluetooth

total: 0 errors, 1 warnings, 0 checks, 50 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12997694.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL - 0.48 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: L2CAP: Fix use-after-free caused by l2cap_reassemble_sdu
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


--===============2078781431527773233==--
