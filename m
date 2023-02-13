Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B82C636D4
	for <linux-bluetooth@archiver.kernel.org>; Mon, 13 Feb 2023 22:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjBMW6w (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 13 Feb 2023 17:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjBMW6v (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 13 Feb 2023 17:58:51 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B984BDE6
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:58:50 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id z5so15678976qtn.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Feb 2023 14:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=YLPKYL5fC2JwKHEq1Yl+MhAylmbAftzE/R9r7+ZtMPc=;
        b=NpCO+GZiVND1mDridJCDFAO5FPphcXtfm+Q3FgIyb5jqIPuiZUP6yUgteefI7duUSy
         tgUpnVprpBeQ936sZQiBqrmsnuKqi441+7zsCNQtTotAbTF/3bjEM+a3C5aFZUWLuKMm
         ngDVoY22/eYEN5ZoLqwvGEjT+uwCztvkguIgFn2VuPFFURr0RNM+m6qb3YneNVlOrtPV
         kIfM+F8bvgZlWLKcc0IyGRl+S2zG/dJJ0XLGXh4LrWOP6mVoVzfIAixO5HvJ5T3Jd1SO
         OOlG8gCHVe7tF4SyPC2Y/hiT9shr8rCPxPwqjBTxrAh+K9NdceNu6Hu3q907lxh7xRze
         fgEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YLPKYL5fC2JwKHEq1Yl+MhAylmbAftzE/R9r7+ZtMPc=;
        b=CiT0kHJ46StVFg470VSLJ1o8CwWXWJWlJO7E9bdsvHuNnlx9BNDCqLiCah9o+95IN4
         0M8AHx7+FSVb9t1oLtLInbgY5xVNnmtC2NY7CP6KbEPhIxCCRZVExn0AaUuqhbfYfR96
         l3xx2RYItCfNQ+rj+WdRaQkFjgpTFRyGJPgXvOpMm4h+/NVQDvy5hI/PyIYnqHlKwq1b
         Zggq4J72/mh6lQ+nS3zDGop08tj3JRgcLvhAeSdrgcW2yAAdlYb7Lt+80GFp2MqJOh7R
         MRe7/RqVkSqm/xKMkvW8JweOhB4BqcBhKPkAlWg7Yl8ek9mZwj92BIX8GdQWNlb1X32q
         agRw==
X-Gm-Message-State: AO0yUKVtGv0CJK0E1u56SFI1pK1lNVr6WAWUnIfEq3+3g6w+ECHJOSdh
        bHHETkixHPpWTYMXshRT+kt+djiSkfI=
X-Google-Smtp-Source: AK7set8Rntwpe3BgK2InYrzUJpeyXspLlLdrJSBYEzejXiMDgaNlLeQWze+T6vB4BMV1JAaFsKQEeA==
X-Received: by 2002:ac8:5e0a:0:b0:3b0:98c3:217c with SMTP id h10-20020ac85e0a000000b003b098c3217cmr197011qtx.6.1676329129529;
        Mon, 13 Feb 2023 14:58:49 -0800 (PST)
Received: from [172.17.0.2] ([172.177.65.65])
        by smtp.gmail.com with ESMTPSA id i25-20020ac871d9000000b003a527d29a41sm9871418qtp.75.2023.02.13.14.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:58:49 -0800 (PST)
Message-ID: <63eac0a9.c80a0220.672c4.d113@mx.google.com>
Date:   Mon, 13 Feb 2023 14:58:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============7234263034324007137=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: MGMT: Use BIT macro when defining bitfields
In-Reply-To: <20230213223042.575952-1-luiz.dentz@gmail.com>
References: <20230213223042.575952-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============7234263034324007137==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=721471

---Test result---

Test Summary:
CheckPatch                    PASS      0.68 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      30.59 seconds
CheckAllWarning               PASS      33.61 seconds
CheckSparse                   PASS      37.94 seconds
CheckSmatch                   PASS      106.26 seconds
BuildKernel32                 PASS      29.68 seconds
TestRunnerSetup               PASS      429.26 seconds
TestRunner_l2cap-tester       PASS      15.86 seconds
TestRunner_iso-tester         PASS      16.15 seconds
TestRunner_bnep-tester        PASS      5.31 seconds
TestRunner_mgmt-tester        PASS      106.74 seconds
TestRunner_rfcomm-tester      PASS      8.59 seconds
TestRunner_sco-tester         PASS      7.84 seconds
TestRunner_ioctl-tester       PASS      9.17 seconds
TestRunner_mesh-tester        PASS      6.71 seconds
TestRunner_smp-tester         PASS      7.74 seconds
TestRunner_userchan-tester    PASS      5.62 seconds
IncrementalBuild              PASS      27.74 seconds



---
Regards,
Linux Bluetooth


--===============7234263034324007137==--
