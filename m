Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECC7C19F2A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 11 Aug 2022 09:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiHKJID (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 11 Aug 2022 05:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiHKJIC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 11 Aug 2022 05:08:02 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5073C8E9A9
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 02:08:00 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id n133so20727013oib.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 11 Aug 2022 02:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=UcvBdseIAiQOtGJPOa1CRNxhb6RRIDMh9EPK7XJQtyQ=;
        b=TfHzSlgGTl+zupXcqK9vpSRPKxuxOazFksnNeb4e6ahqio2BFa48ja/er02iYVr/SM
         KP0T93KIZFAuwfvPE7Ecw4bxJEhmTwxdb8XAh2HACo1TycWoEhQDy8vpsGhnUoOMOi94
         FkJaul5G9xe2VYv/orU1caxl+/NtXPvuABUk1QiToJIO9zQbEflYinvG2ELoHyaNRd06
         wEKCDOhk6T3QN8k07hWyTebRjSnWmseDeVmyesj9C+dMa1Sjjtjhwy7uyplgyAUUu86z
         m1dIE0OhjnbXLFPXItpVn3pXBnJ2aKa2TEb00B/n+9qR7V0SpQ+h0GcHA6inb6g3Ho8S
         OqDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=UcvBdseIAiQOtGJPOa1CRNxhb6RRIDMh9EPK7XJQtyQ=;
        b=oaYmJLcLSkH0oaBPkax2DXaDqZedDHy1/z5B8SeeJYC8pzO48pibcsSokvsQRA3utK
         O3mKdCgJnH55fhvh5hDZb/wYJndczU5TIMtTkkfTZ772TVv3dkFyALbbDHk0Zrfv+pFS
         phcwd6XiMDmVolO3gVJ8tbW9KkFqDkFJ0EpbNN/8oc3fUENYHj4E+6een2UNXZ+S8ntJ
         SsYLtmxnglMgnCQxmHC6MZAKZDZZbN5aJJYo6ZqrMT6KMtyFXqrwFlfwE2YWjkwd9rl0
         tl1feprfWJMe5veCbIIgN8MgwRFiWerJZNw8vfWFr1mseo3yt0LSX1N7BQ4qpwFgpyrU
         JaZw==
X-Gm-Message-State: ACgBeo3CUMMslm95VIiC4WScXNy0TdhX0YGguu8y2INY3HMYTbbbSoXI
        AsF1i3PMNDi7SdCwrocJm8f4LDEZddk=
X-Google-Smtp-Source: AA6agR4NS//y/s3hri+/nVd68yUplrdElPSlnQGFI+NxKP286kr7DpoMCOu9Qhz+vO3uxHQEedh+Hg==
X-Received: by 2002:a05:6808:1385:b0:33b:1552:1765 with SMTP id c5-20020a056808138500b0033b15521765mr3056585oiw.159.1660208879512;
        Thu, 11 Aug 2022 02:07:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.97.58.104])
        by smtp.gmail.com with ESMTPSA id f24-20020a4ada58000000b0041ba304546csm1031223oou.1.2022.08.11.02.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 02:07:59 -0700 (PDT)
Message-ID: <62f4c6ef.4a0a0220.23439.3bb2@mx.google.com>
Date:   Thu, 11 Aug 2022 02:07:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8326960041384178826=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mst@redhat.com
Subject: RE: [v2] Bluetooth: virtio_bt: fix device removal
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220811080943.198245-1-mst@redhat.com>
References: <20220811080943.198245-1-mst@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8326960041384178826==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=666797

---Test result---

Test Summary:
CheckPatch                    FAIL      1.23 seconds
GitLint                       PASS      0.72 seconds
SubjectPrefix                 PASS      0.57 seconds
BuildKernel                   PASS      33.46 seconds
BuildKernel32                 PASS      29.34 seconds
Incremental Build with patchesPASS      41.81 seconds
TestRunner: Setup             PASS      494.72 seconds
TestRunner: l2cap-tester      PASS      17.54 seconds
TestRunner: bnep-tester       PASS      6.66 seconds
TestRunner: mgmt-tester       PASS      103.84 seconds
TestRunner: rfcomm-tester     PASS      10.01 seconds
TestRunner: sco-tester        PASS      9.85 seconds
TestRunner: smp-tester        PASS      9.93 seconds
TestRunner: userchan-tester   PASS      6.82 seconds

Details
##############################
Test: CheckPatch - FAIL - 1.23 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2] Bluetooth: virtio_bt: fix device removal\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#110: 
The cost of the hack used here is a single skb wasted on an unused bt device.

total: 0 errors, 1 warnings, 46 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12941237.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8326960041384178826==--
