Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E04FFEC8744
	for <linux-bluetooth@archiver.kernel.org>; Thu,  7 Sep 2023 16:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbjIGQrb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 7 Sep 2023 12:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbjIGQrH (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 7 Sep 2023 12:47:07 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7ACF270D
        for <linux-bluetooth@vger.kernel.org>; Thu,  7 Sep 2023 09:46:40 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-792707f78b5so49686539f.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 07 Sep 2023 09:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694105143; x=1694709943; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fw8inKkjgqt3bT9HDpAVWMzMPrc3fA9nTENEkdfuSUs=;
        b=qwMZv+lv+Jh6CCxrn95F9WgpbcBpmGgRCxsOxOuWRX3GTW/qvV1BmbVLrICP73eO/i
         EsJXTpKYgB86vPviTXC249f9A3o+kj9IRhyY+sQ1JGc/cddCLmcf5VaPV6y25I7rXNme
         kEdu5R2rqf1VD98+RXawhelYBcBCzKWxmheDE5jql2rYeixo3Xj8rW8T0yIldnfx8xgV
         f4CGyV6+DylaBNkjYOn+0d/w31TFU7/YWTAlpnpQCBOCra/eKRyM0m/uY6BGLLHgJjXN
         n1mJEHiy6vlVgrSLvd3WJhZHKq7OfOeNhSKYhf7PjgLd0V0Of+rGoGoQKNWtkYqGwujo
         C5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694105143; x=1694709943;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fw8inKkjgqt3bT9HDpAVWMzMPrc3fA9nTENEkdfuSUs=;
        b=W5LenClEWM/R8dpYvonVLGunvpDBjhRreXcv0OpqzJ0DSra4MnO/O4g1Ins6xX3QYV
         LscqqzFIqUNwpfzDvZXILlV1z0d/wkwGdRfFVIxs2lNUeQZ84CXbbQmPTRWSZqZkybrd
         ikCdXpdg+MtxK2SUEhIoC3nX/ZCUsEO61YFWRYdHPAY7Rs1p5lKnFLxyG5Yas0lzq+Bs
         NzsLV9o5lpn2UagPty2JdeWQFN4lI3hyapV3SXCOT3OKPHD9xQxY98zTr7rUXy7y2Krn
         LuUiuxBWIZEZnBaRuwjxrR4Pup9L072toIjGT1GrZNWQPZeM/Fh1XpcfRwHFeHtDn4tv
         4G8A==
X-Gm-Message-State: AOJu0Yz2LAHF6Mfgu4wHJAYjlQn2IvwRtXYdqtMO41Hl/ZCB3hqnv0vZ
        fmKx1wtqwVm/WocbXqOkEQyXgsX2eVQ=
X-Google-Smtp-Source: AGHT+IEwOgFzB9DT8kW79yt5gVUwm3eeeSwuWrINogFodYC7GuQwSTqZzgyN3dDoFY4qc0UGJhPgOg==
X-Received: by 2002:a6b:5915:0:b0:786:fff8:13c2 with SMTP id n21-20020a6b5915000000b00786fff813c2mr261675iob.11.1694105142757;
        Thu, 07 Sep 2023 09:45:42 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.115])
        by smtp.gmail.com with ESMTPSA id k15-20020a02c64f000000b0043012f6139fsm5436126jan.32.2023.09.07.09.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 09:45:42 -0700 (PDT)
Message-ID: <64f9fe36.020a0220.4c801.6d71@mx.google.com>
Date:   Thu, 07 Sep 2023 09:45:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0384335466450564894=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, vlad.pruteanu@nxp.com
Subject: RE: Bluetooth: ISO: Set CIS bit only for devices with CIS support
In-Reply-To: <20230907093005.58439-2-vlad.pruteanu@nxp.com>
References: <20230907093005.58439-2-vlad.pruteanu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0384335466450564894==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=782238

---Test result---

Test Summary:
CheckPatch                    FAIL      1.00 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      43.07 seconds
CheckAllWarning               PASS      46.19 seconds
CheckSparse                   PASS      52.59 seconds
CheckSmatch                   PASS      142.30 seconds
BuildKernel32                 PASS      42.02 seconds
TestRunnerSetup               PASS      630.56 seconds
TestRunner_l2cap-tester       PASS      35.90 seconds
TestRunner_iso-tester         PASS      83.27 seconds
TestRunner_bnep-tester        PASS      14.64 seconds
TestRunner_mgmt-tester        PASS      280.46 seconds
TestRunner_rfcomm-tester      PASS      22.30 seconds
TestRunner_sco-tester         PASS      24.38 seconds
TestRunner_ioctl-tester       PASS      23.92 seconds
TestRunner_mesh-tester        PASS      17.77 seconds
TestRunner_smp-tester         PASS      18.96 seconds
TestRunner_userchan-tester    PASS      15.15 seconds
IncrementalBuild              PASS      38.71 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[1/1] Bluetooth: ISO: Set CIS bit only for devices with CIS support
ERROR: Missing Signed-off-by: line(s)

total: 1 errors, 0 warnings, 0 checks, 8 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13376524.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============0384335466450564894==--
