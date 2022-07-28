Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD604C04A68
	for <linux-bluetooth@archiver.kernel.org>; Thu, 28 Jul 2022 23:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbiG1XDH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 28 Jul 2022 19:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbiG1XDE (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 28 Jul 2022 19:03:04 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB1EC79694
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 16:03:01 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so2229106otk.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 28 Jul 2022 16:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Xi86JIJcu1EkoaTHpYuiqkPN47gv4PA9I5+RSWPX0f8=;
        b=FrMakrVqW6gBtHB+/mF+iKjNMLG6aeGSLn4WMzmLRyFmsnkKobGJ1w/g2NNx08hVbt
         gYbM3bwYCiODL89qeQ6Q7HCrvikJxENxzE2QSYfGlnwXI10kX3XMF3xlHAcqI7kaaQUs
         iBt33fzr2t5hMX2aD37h37T7FuRRQh6hQAw4YuahPTzyQdREFNmc5ygdocHMNNgk1ZX9
         jp1jt6DKzeTXrO0zuAN2V4jZZ78Y5cm5Qq2f2az7ymSUEr9mxhjbxSgD202oOyl8/0Os
         zreRYp1Q2ZhLqMyIaBh23ywqXa0ebt2RSrpywNMjr+eb6R6VYcKmZ24DptzABjNeZdEi
         lEJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Xi86JIJcu1EkoaTHpYuiqkPN47gv4PA9I5+RSWPX0f8=;
        b=uItO8L4iQte4ecs8RaPBQSLY61VWzImJ9OTyeIWe0JRsPEUm6VheyccezD4zZeQnVY
         b0UTuZxb4Xg/EUMe56ofs3GiZsvLDP9HIrm+T+Yvb8xttAEBKpBrBl+2ti06pfcnd0T4
         wzJGBepFdtf4BJFwEfJAPg7XjTecdChaEzgoUBb2n1UvRem46BsOJUNIePB5Z69H8Jwe
         0l1s85wimffyEuzT02ab9UxuJaNB4Zx/BlonnkGAMAf0KGxQUXmqWVdPslKLxw/SZwij
         jOh0DlkOiUH+puMXVoqWnPGLbylNsKRPHZ4NlAIE4i2hVIZVITs28J9voyzp01YylL7N
         tzEQ==
X-Gm-Message-State: AJIora+tgMtGwqCZz/l6InaEo2da+DtDCUgZDjro+WqqDHQLz6miz7BK
        K4LjJkLtpsC906XUI6pSlxxYfw5xmQI=
X-Google-Smtp-Source: AGRyM1vk2BljK2OucTGcOhVzb1B2OoixsWMuC70SpDWe0dPSD0R52Jil7vKbFgZu2zC011F0ZAJlNA==
X-Received: by 2002:a05:6830:3183:b0:61c:9cc6:ebf0 with SMTP id p3-20020a056830318300b0061c9cc6ebf0mr432390ots.185.1659049380887;
        Thu, 28 Jul 2022 16:03:00 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.231.58])
        by smtp.gmail.com with ESMTPSA id u7-20020a056808150700b0033aa53c549dsm800901oiw.25.2022.07.28.16.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 16:03:00 -0700 (PDT)
Message-ID: <62e315a4.050a0220.75f5.41f7@mx.google.com>
Date:   Thu, 28 Jul 2022 16:03:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7184819413054922352=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: ISO: Fix info leak in iso_sock_getsockopt()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220728221145.1301230-1-luiz.dentz@gmail.com>
References: <20220728221145.1301230-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7184819413054922352==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=663892

---Test result---

Test Summary:
CheckPatch                    FAIL      2.39 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.72 seconds
BuildKernel                   PASS      32.56 seconds
BuildKernel32                 PASS      28.31 seconds
Incremental Build with patchesPASS      39.94 seconds
TestRunner: Setup             PASS      465.81 seconds
TestRunner: l2cap-tester      PASS      16.35 seconds
TestRunner: bnep-tester       PASS      6.51 seconds
TestRunner: mgmt-tester       PASS      101.11 seconds
TestRunner: rfcomm-tester     PASS      9.82 seconds
TestRunner: sco-tester        PASS      9.07 seconds
TestRunner: smp-tester        PASS      9.62 seconds
TestRunner: userchan-tester   PASS      6.30 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.39 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
Bluetooth: ISO: Fix info leak in iso_sock_getsockopt()\ERROR:NO_AUTHOR_SIGN_OFF: Missing Signed-off-by: line by nominal patch author 'Dan Carpenter <dan.carpenter@oracle.com>'

total: 1 errors, 0 warnings, 0 checks, 24 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12931756.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============7184819413054922352==--
