Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34637C6FD1C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 22 Mar 2023 07:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjCVH44 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 22 Mar 2023 03:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCVH4z (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 22 Mar 2023 03:56:55 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC085CEC8
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 00:56:50 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id s1so3524043ild.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 22 Mar 2023 00:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679471809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=c+AlLIDyArUaGt6ds+EZDk/RKHu0JkY70BLd2xt4dEg=;
        b=TRcCWiMC52Zv/hHhrn4wnIjErsZD3jrzVIG+tz25xBcDtXbsc7d6xReDx15YFrhy+K
         yehAODlqH5j0yeL6lbTotIcs6VU0rqsNxghRdhmKh9SDxD/mL6uyd9kB3zXwicF/PWuX
         q/d1JMpE9ej88WQ7xFvgERF4Xl5EllGcgcnNF1DLib1Gx3S2FJSba/lbD0u0h8nhTsxr
         iJVi/PTbcq7yPRnSdTB5J1w/nMeFYmMtRGSj3iEmCoz8342kXcvlv9kw4rgfru7vzGUN
         EqJewQsdX9M+LUmCjtLUhxVWKwedZfx2hlMLY+vd8Ly6V/8KThtzZDzOEyAOyPEOWiqN
         9XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679471809;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+AlLIDyArUaGt6ds+EZDk/RKHu0JkY70BLd2xt4dEg=;
        b=c3oQKVHnaUk+p6NRfJy0WZBwsC0qAMCsvqSzyYU/Ngw+a4LkWYT2iPAuR+CLppb4V6
         RJ3vIktuWTzFs7TQEi6vuLGKg7TkDYnRJ0W9FUGvx6obFHGkjV5C/DuGClU+Hen6kG+1
         RtA7JB6smuIyFY1sND/x0+iNkF5ybTLjPz0+Ug/kJhZDqdjH6GI8VNHGCdIdaza3Q7Q/
         j2zfDEg4IqNhPuiiQyB6mI6E0M2J/ypYYpNuJpG1S8nhKXPtthLkXMVyZ4mdT40bwU4G
         YuKYEkoPek1/Rwgd1gCWn5IcD2tAWCsrnguhj4z8jPEd9eSsPtRmEudgdC+beB0N6H0R
         HlAw==
X-Gm-Message-State: AO0yUKWNB7SeL3KYhMj/hZRkoSIFKImevJ3mRy3dvJ7dEprEdWJ3NGVr
        dC+NT5y5heORGVNodsXhmbj2H4PXRKs=
X-Google-Smtp-Source: AK7set/u7ePPnzMjRmSqDcwzG2cbaM9efhAxnYSjV+dmn5QWCkSwSr27+v0qb1PUSUxHINuVn8To6A==
X-Received: by 2002:a92:c80c:0:b0:315:365d:534f with SMTP id v12-20020a92c80c000000b00315365d534fmr3750119iln.19.1679471809297;
        Wed, 22 Mar 2023 00:56:49 -0700 (PDT)
Received: from [172.17.0.2] ([40.122.242.99])
        by smtp.gmail.com with ESMTPSA id g26-20020a02271a000000b003a60da2bf58sm4654450jaa.39.2023.03.22.00.56.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 00:56:49 -0700 (PDT)
Message-ID: <641ab4c1.020a0220.f9cea.9120@mx.google.com>
Date:   Wed, 22 Mar 2023 00:56:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4336071834536335652=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hildawu@realtek.com
Subject: RE: [v2] Bluetooth: msft: Extended monitor tracking by address filter
In-Reply-To: <20230322072712.20829-1-hildawu@realtek.com>
References: <20230322072712.20829-1-hildawu@realtek.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4336071834536335652==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=732614

---Test result---

Test Summary:
CheckPatch                    PASS      1.08 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      31.02 seconds
CheckAllWarning               PASS      33.92 seconds
CheckSparse                   PASS      38.46 seconds
CheckSmatch                   PASS      107.50 seconds
BuildKernel32                 PASS      29.95 seconds
TestRunnerSetup               PASS      432.21 seconds
TestRunner_l2cap-tester       PASS      16.43 seconds
TestRunner_iso-tester         PASS      16.64 seconds
TestRunner_bnep-tester        PASS      5.32 seconds
TestRunner_mgmt-tester        PASS      107.77 seconds
TestRunner_rfcomm-tester      PASS      8.61 seconds
TestRunner_sco-tester         PASS      7.81 seconds
TestRunner_ioctl-tester       PASS      9.23 seconds
TestRunner_mesh-tester        PASS      6.63 seconds
TestRunner_smp-tester         PASS      7.74 seconds
TestRunner_userchan-tester    PASS      5.61 seconds
IncrementalBuild              PASS      27.89 seconds



---
Regards,
Linux Bluetooth


--===============4336071834536335652==--
