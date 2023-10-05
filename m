Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CBAE92714
	for <linux-bluetooth@archiver.kernel.org>; Thu,  5 Oct 2023 15:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbjJEPrY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 5 Oct 2023 11:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbjJEPqr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 5 Oct 2023 11:46:47 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E33C11AFB
        for <linux-bluetooth@vger.kernel.org>; Thu,  5 Oct 2023 08:03:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-3515aad4a87so4445615ab.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 05 Oct 2023 08:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696518197; x=1697122997; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ztsjtOTO4zYi9+HdqFuAJDPBwTXk0/TkmoDzAqSb75o=;
        b=ZPQc+Wfp+jeffegHDJEd5IY7fQGBwD2Th8ImY6pOdWUupzK3uXpYRsu5foXdATrets
         mmUUKSGKbZktGEUET5vXXL8Y+x/66zoOJkdKaPQzDWx2uHtdELI9Tei+yFeX4tZf17ND
         +75w8gNGLwx/LhcBxvgcQaaX8N2jbt+c6xm0Kd0fHo3LeEMvdL1Ox5mT2t5okQBrhDd7
         lhSXAZGasGp9024umTZm8FIlVmRo6VZRSy8HUsXr4fUh7JBaxN3XxHOKaMtYIxEoSuRC
         L9m0IqG+y6lCjMP7CYiZZ41+yq2ukne4fbcez0/lmV97rj6Jb/DBkGp4K+aCpqerKq4m
         3kUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696518197; x=1697122997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ztsjtOTO4zYi9+HdqFuAJDPBwTXk0/TkmoDzAqSb75o=;
        b=I3nKsYbJWV+y3J3eNBJNUZ5VObJZVsJJw/xERdErFQohSvb0d9ZVkt/ydFO6WMrJ+Q
         sy/ks5GtJgRkHbiNIbE75gtvwK3Sa9rmwZMH0gRpK2dvtFOlSCE9nJ/YLiwcFDIcy+lO
         PJt+p+zbFMriGSIbXqq/C93rRsntGxvOV7hYpjjENGKK75YFvNcHrzkXLNOtzUIyvY0Z
         iECQ/SD/94YKxhXEWKOpsjW83k5qg6eyUOPzWb+PT5PxuCgJG4tcIs/UXuhdAGv/cTC+
         o1YjcbtKEaSK9sNyrrG52Jwr1iXGUXtslzkYTQXDbdtSesnYszedlPowgSvbB0XqFuUl
         RE+Q==
X-Gm-Message-State: AOJu0Ywkt23lr/kT+DWA1aVxSDioFsLQi5bfiEZJUraK6ZppnNlBEnmr
        XYsa4P7tnZlLpk37kZYV0VV/8Ud3RJg=
X-Google-Smtp-Source: AGHT+IH9/yVTQaCkWdbj7iAcvPeWXp2bIqzZi6aQ5wDWjqPsGhcllVT4Xo5REbM2ye2CbqboMbzDMQ==
X-Received: by 2002:a05:6e02:b4f:b0:342:655f:6f25 with SMTP id f15-20020a056e020b4f00b00342655f6f25mr6801583ilu.31.1696518197623;
        Thu, 05 Oct 2023 08:03:17 -0700 (PDT)
Received: from [172.17.0.2] ([13.86.66.39])
        by smtp.gmail.com with ESMTPSA id l9-20020a02cd89000000b0043d7ef4de07sm480911jap.5.2023.10.05.08.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 08:03:17 -0700 (PDT)
Message-ID: <651ed035.020a0220.cb416.0a14@mx.google.com>
Date:   Thu, 05 Oct 2023 08:03:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7049487712042566280=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, dan.carpenter@linaro.org
Subject: RE: Bluetooth: msft: __hci_cmd_sync() doesn't return NULL
In-Reply-To: <5fffad33-4d19-4645-a21f-57321d1c82a6@moroto.mountain>
References: <5fffad33-4d19-4645-a21f-57321d1c82a6@moroto.mountain>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7049487712042566280==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=790270

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.61 seconds
CheckAllWarning               PASS      37.11 seconds
CheckSparse                   PASS      42.41 seconds
CheckSmatch                   PASS      113.72 seconds
BuildKernel32                 PASS      32.68 seconds
TestRunnerSetup               PASS      501.17 seconds
TestRunner_l2cap-tester       PASS      31.09 seconds
TestRunner_iso-tester         PASS      52.47 seconds
TestRunner_bnep-tester        PASS      10.49 seconds
TestRunner_mgmt-tester        PASS      221.38 seconds
TestRunner_rfcomm-tester      PASS      16.03 seconds
TestRunner_sco-tester         PASS      19.58 seconds
TestRunner_ioctl-tester       PASS      18.45 seconds
TestRunner_mesh-tester        PASS      13.57 seconds
TestRunner_smp-tester         PASS      14.41 seconds
TestRunner_userchan-tester    PASS      11.19 seconds
IncrementalBuild              PASS      31.16 seconds



---
Regards,
Linux Bluetooth


--===============7049487712042566280==--
