Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C354E95A91
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Oct 2023 13:19:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377059AbjJINTd (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Oct 2023 09:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377045AbjJINTc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Oct 2023 09:19:32 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE709F
        for <linux-bluetooth@vger.kernel.org>; Mon,  9 Oct 2023 06:19:29 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 6a1803df08f44-66b024d26e2so21202556d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 09 Oct 2023 06:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696857569; x=1697462369; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+xGBYn/J+I8rjrz7RjAylc0cVMPLtrGjS+tLMqjeqj8=;
        b=Ww2eeqz3iT2C7TSyFcH5myMnqVXXd+fX29WdY8/MyW5Z9rkKLm8llsLz7D36XeQZwy
         6d7t2gGzsgq8yeB2q5efHW2ub7vFd7ZpbkX4ktWOGpqmBBdntDaHudzvWFWluSRnaMrY
         ea/5OKVMct8sd06rEGqjRHXusMdqsJ4rNpaZi5KE7jSrsGJh/uf2JfvOd9aFGoy9wbvO
         peaYm+Q21g7j/dK+2CQusXbiluICLiavx7xRa/tgHFcqMenTQ8yYzXy09U5vPzlQt77s
         jUdgw8/KOZhTNpLwGLZXIfNryNBtt+9SiqNiJ1rciTpGCueh7i9oqUEASETbctgKobq2
         Dlpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696857569; x=1697462369;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+xGBYn/J+I8rjrz7RjAylc0cVMPLtrGjS+tLMqjeqj8=;
        b=LKIFVkHn2u9ItK+54aRGv6qKyJ3SAqEz+g6nzxJ0RjNZtS+CU0BqKZeOegDdxak/tw
         Ac0GZ52H0v2itHZMuYPHv1mJCrhlvsiwUxGmQtvYewR/VE+AVWWhpncHhlNeecmTwUMQ
         CCahnp3zFC3iIz5q8l8xiv/MZw8M+82mmUqkEakUnxQigd8odKmlahabkuFYvU3tB5rr
         9Bls6/WQ+vAvqnwNra7KowtAhSrbLjUm9k/JiDmQSN60S4bLOi3mtnPxu7BrK7pVVFU4
         Na32k949ycDP+ZE79nbUih7MP6Hsl+VLYKuKOpRFcr0m8rO85QjH6V2EzxlW+GIKHUSp
         9dXA==
X-Gm-Message-State: AOJu0YxCwKGE5cbYZCS2XBg+ZDJm7XuGS3CvUWTXAqcHMUiOU1962tpi
        IkwQ1lNXk11ZvTGOF5aay06ouRsViKQ=
X-Google-Smtp-Source: AGHT+IFAzuMmL7BDbjsdxjXlFkUyIftplhyNiKANEp1AtnLO9C12RAcTpPzenqw/Oa1oxMwwc7UDmQ==
X-Received: by 2002:ad4:5ba9:0:b0:65a:f7b2:2057 with SMTP id 9-20020ad45ba9000000b0065af7b22057mr14488904qvq.24.1696857568869;
        Mon, 09 Oct 2023 06:19:28 -0700 (PDT)
Received: from [172.17.0.2] ([40.75.96.215])
        by smtp.gmail.com with ESMTPSA id k29-20020a0cb25d000000b006585069e894sm3853738qve.109.2023.10.09.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 06:19:28 -0700 (PDT)
Message-ID: <6523fde0.0c0a0220.110dd.ecbd@mx.google.com>
Date:   Mon, 09 Oct 2023 06:19:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6801451652225676264=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, william.xuanziyang@huawei.com
Subject: RE: [v2] Bluetooth: Fix UAF for hci_chan
In-Reply-To: <20231009123045.587882-1-william.xuanziyang@huawei.com>
References: <20231009123045.587882-1-william.xuanziyang@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6801451652225676264==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=791293

---Test result---

Test Summary:
CheckPatch                    PASS      1.09 seconds
GitLint                       FAIL      0.58 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      33.69 seconds
CheckAllWarning               PASS      36.74 seconds
CheckSparse                   PASS      42.62 seconds
CheckSmatch                   PASS      117.82 seconds
BuildKernel32                 PASS      32.91 seconds
TestRunnerSetup               PASS      500.40 seconds
TestRunner_l2cap-tester       PASS      29.86 seconds
TestRunner_iso-tester         PASS      51.52 seconds
TestRunner_bnep-tester        PASS      9.77 seconds
TestRunner_mgmt-tester        PASS      212.13 seconds
TestRunner_rfcomm-tester      PASS      15.62 seconds
TestRunner_sco-tester         PASS      19.26 seconds
TestRunner_ioctl-tester       PASS      17.43 seconds
TestRunner_mesh-tester        PASS      12.78 seconds
TestRunner_smp-tester         PASS      13.81 seconds
TestRunner_userchan-tester    PASS      10.62 seconds
IncrementalBuild              PASS      31.91 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2] Bluetooth: Fix UAF for hci_chan

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
5: B1 Line exceeds max length (88>80): "BUG: KASAN: slab-use-after-free in hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231"


---
Regards,
Linux Bluetooth


--===============6801451652225676264==--
