Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90C7C001DF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 16 Aug 2023 08:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242980AbjHPIrL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 16 Aug 2023 04:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243024AbjHPIqu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 16 Aug 2023 04:46:50 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB209E56
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 01:46:48 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6887c3aac15so480609b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Aug 2023 01:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692175608; x=1692780408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mgHKlBzE7us+iuNoNqjEutcBQiF9l0c+u8QYfT89iE0=;
        b=MGDB7lqnsyJRYXcgqABfNbALkAhO9I6VTwrBqVJkA2F4wwkHBudGIx+qAUKPE1BUG+
         HmcDJEjqw0aDveh+wOGXUU0aJTu1RpGAKg1f/+pJJjsWAjWZR6vbJ6VwDyG7g5gcV6ox
         voJR0BQIWFhbHwUXJXz6nG68nYQzI89nGSNGtQIO+A+0bVUAI2cYHxvFQJYLRDjSsnvY
         WEj44z8AIeNSEk9shg2GtKHlzwQHQJxXgxEIekIcty6xcakp014nQIBz3ljGlm0J/Hym
         4GrzO6N9GiKpX/jiWjI3/yOBYqBHV2viy6cby6IapEjLrcrjsQPW1efB7gFeZS0zNU4W
         zZLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692175608; x=1692780408;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mgHKlBzE7us+iuNoNqjEutcBQiF9l0c+u8QYfT89iE0=;
        b=PJFHHt4cLtTSRfPCyM5la989hjCZF9zs+necT7j1tfB5wB4AiaAPLjUGTQMZjnbd86
         qiuBz7xkevLOXEcI/XQclD09GvWMz+oormUcKdZy/sU0rHcDLuE4X9BTXNA7S+LxIzFc
         T6mH+FQPcRdhhJ+YCtcK8l8P66Eg48flH/UsHQfgInV3s3Kv+2jQ9nqV17oE3N5kW9uo
         cTgSdfT733aDywK+4/k6SilB6eZ+0YiPW6qd7ODOJBN3YU0vvJcv3vrW2NMDNG1cY5tb
         dQHnk7D7Ej4qtOXUdX3kWiAV/EZWpQIbocr4FzuiXy9hZJ4ekKIJCkr9foLVyoFGx1GI
         P5tQ==
X-Gm-Message-State: AOJu0Yz74SH2rLVVO6GfiMpQrUstTfgyPiuaFTtBqt3SotV9aLX3Tkzt
        T4qeqn1Rjdks+ns7XOMk7wXb1Rv1sSA=
X-Google-Smtp-Source: AGHT+IHBlxHP23p5L4T0GWH/JdIrqEQZ6IvB0uEc3s/PvKEY0dqqMF4lEXIqtuugBLOe39jwkmpJ+w==
X-Received: by 2002:a05:6a20:160b:b0:133:5f6a:fb6 with SMTP id l11-20020a056a20160b00b001335f6a0fb6mr1878691pzj.1.1692175608146;
        Wed, 16 Aug 2023 01:46:48 -0700 (PDT)
Received: from [172.17.0.2] ([13.88.101.194])
        by smtp.gmail.com with ESMTPSA id u18-20020a17090341d200b001b05e96d859sm12525377ple.135.2023.08.16.01.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 01:46:47 -0700 (PDT)
Message-ID: <64dc8cf7.170a0220.d5fac.730e@mx.google.com>
Date:   Wed, 16 Aug 2023 01:46:47 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5303446466055327199=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, neil.armstrong@linaro.org
Subject: RE: Bluetooth: qca: enable WCN7850 support
In-Reply-To: <20230816-topic-sm8550-upstream-bt-v4-1-2ea2212719f6@linaro.org>
References: <20230816-topic-sm8550-upstream-bt-v4-1-2ea2212719f6@linaro.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5303446466055327199==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=776541

---Test result---

Test Summary:
CheckPatch                    PASS      3.09 seconds
GitLint                       PASS      0.80 seconds
SubjectPrefix                 FAIL      0.53 seconds
BuildKernel                   PASS      46.18 seconds
CheckAllWarning               PASS      50.37 seconds
CheckSparse                   PASS      55.14 seconds
CheckSmatch                   PASS      144.62 seconds
BuildKernel32                 PASS      42.04 seconds
TestRunnerSetup               PASS      638.09 seconds
TestRunner_l2cap-tester       PASS      33.48 seconds
TestRunner_iso-tester         FAIL      111.63 seconds
TestRunner_bnep-tester        PASS      15.16 seconds
TestRunner_mgmt-tester        PASS      273.86 seconds
TestRunner_rfcomm-tester      PASS      22.61 seconds
TestRunner_sco-tester         PASS      25.56 seconds
TestRunner_ioctl-tester       PASS      26.29 seconds
TestRunner_mesh-tester        PASS      19.40 seconds
TestRunner_smp-tester         PASS      20.37 seconds
TestRunner_userchan-tester    PASS      16.39 seconds
IncrementalBuild              PASS      52.60 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 95, Passed: 93 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
ISO Connect Suspend - Success                        Failed       4.522 seconds
ISO Connect2 Suspend - Success                       Failed      14.651 seconds


---
Regards,
Linux Bluetooth


--===============5303446466055327199==--
