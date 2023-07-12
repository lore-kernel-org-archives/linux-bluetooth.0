Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5C4CEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 12 Jul 2023 22:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjGLWXO (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 12 Jul 2023 18:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231494AbjGLWXF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 12 Jul 2023 18:23:05 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA5199E
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:23:01 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b73a2d622dso18946a34.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 12 Jul 2023 15:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689200580; x=1691792580;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+mOVCpxuz0xAbayGN2WkTrDGqVIrCMlxRj8pNm+nZG8=;
        b=V1Otj6DOslNUoim/30ncEsBXzgY5Fyumu6Toi6H7icTT2hUQDEBbNzrjNZeNUyTCCO
         vsOZL1uggT0wm3GOif+MEI9IGxvmkqcFYDs1B5vBwXS5fAs+Z0FG3YaoUyZ16s27jb9r
         WZ7OwzXzwtABvFUnR04SdLo+TiLTcDTTjJwtcXgG5nb9082tGwylZMPKYIJVrqvMsq9B
         ub6UYR/hhstTaDGdi0FB2q3Q3ZX01NGnZ6eACnTsxq5s4tpsFuWqT9+sMnqFACcYoiQj
         v+dERZMJfUrg89jdHSc2ki4k5KM+/KdJzuFlGGYGvksJeTVeRMa1IYqXpLHvVOnjqlSF
         AubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689200580; x=1691792580;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+mOVCpxuz0xAbayGN2WkTrDGqVIrCMlxRj8pNm+nZG8=;
        b=XJVezUaaEzQikmntXjntqxJqjlkcR40ud/FxBlNxe/lFzc7j1MXdQ6f97PHogCQWVL
         Vu/SBA17Z+BAIIRwNa7Gh7ZwfmR8I55fzSQ5nVRQTNkaWnWtb7pMYeOc+RuE7t4QFuyx
         H0VAXdiWaOiBuquUSEyapWYsfCQQUGWyXfQYWGt/Wz/C3V1gRHdjHXhmAKEgKVYwGHcS
         0VhHVqr7SDDk+iGq02pyoH+CtDEG8/xCDn/bp10FeUVEDHgYEYNBqhXdhJg5huQbn1b+
         xIuvV3HaW+jrCIjr8MCRPd1AbVaHcl7nA68Zq4ce3/RIXNNgwA1C6/EcJjTAKJKpjaA4
         ApmA==
X-Gm-Message-State: ABy/qLZTe1gKbY1QLkr3a9IIXDcG+NrlQ4kz/DBc4z9CJxmVVfT7+tp2
        KLWiREjVbR9Dd1dNGKMiR4XlCfFY3kI=
X-Google-Smtp-Source: APBJJlGRm41eEXnLbPKwq8GadL/DZ4wn80K7BPgskjxJ6TwT5/72q2w7RE3OlhZ/zDvxZ+xSxRhFhA==
X-Received: by 2002:a9d:5889:0:b0:6b9:57d2:8ec1 with SMTP id x9-20020a9d5889000000b006b957d28ec1mr2292621otg.2.1689200580499;
        Wed, 12 Jul 2023 15:23:00 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.178])
        by smtp.gmail.com with ESMTPSA id t22-20020a05683022f600b006b83a36c08bsm2330450otc.53.2023.07.12.15.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:23:00 -0700 (PDT)
Message-ID: <64af27c4.050a0220.97b0c.00db@mx.google.com>
Date:   Wed, 12 Jul 2023 15:23:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1613848106919635557=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, rgammans@gammascience.co.uk
Subject: RE: [v2] Bluetooth: btusb: Add support for another MediaTek 7922 VID/PID
In-Reply-To: <20230712213602.15280-1-rgammans@gammascience.co.uk>
References: <20230712213602.15280-1-rgammans@gammascience.co.uk>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1613848106919635557==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=765029

---Test result---

Test Summary:
CheckPatch                    PASS      0.73 seconds
GitLint                       PASS      0.31 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      44.98 seconds
CheckAllWarning               PASS      48.87 seconds
CheckSparse                   PASS      55.33 seconds
CheckSmatch                   PASS      150.94 seconds
BuildKernel32                 PASS      43.73 seconds
TestRunnerSetup               PASS      661.90 seconds
TestRunner_l2cap-tester       PASS      33.25 seconds
TestRunner_iso-tester         PASS      82.81 seconds
TestRunner_bnep-tester        PASS      14.81 seconds
TestRunner_mgmt-tester        PASS      274.49 seconds
TestRunner_rfcomm-tester      PASS      22.71 seconds
TestRunner_sco-tester         PASS      22.70 seconds
TestRunner_ioctl-tester       PASS      25.52 seconds
TestRunner_mesh-tester        PASS      18.91 seconds
TestRunner_smp-tester         PASS      19.70 seconds
TestRunner_userchan-tester    PASS      15.92 seconds
IncrementalBuild              PASS      40.85 seconds



---
Regards,
Linux Bluetooth


--===============1613848106919635557==--
