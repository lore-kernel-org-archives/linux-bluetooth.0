Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC8DC74A5B
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Mar 2023 21:57:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjCWV5m (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:57:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjCWV5l (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Mar 2023 17:57:41 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2EC18AB1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:57:40 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j3-20020a17090adc8300b0023d09aea4a6so3280605pjv.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Mar 2023 14:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679608660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xT74xSWmA5QHZ7V+aYakO6jXkw5S6mXvNpj9AQQXVgc=;
        b=BxN6pKhhTTilkElN7TObhmJwhiTXk5BIDj5xl41KYiuXGdtER4NDHoPalWgw9BatDg
         ZrJ7u7WLodlZHT99erVS38mmHDYOc4y8w9RnyUj7pKmJgrr65ua4/5eD3doDE2+uiKGZ
         Pi+6nTqHaWrTbkjcc0bL7ufW4626b7mzStFDH+Csh8DbFcFErfOWOHQhomEOJqy2ICHK
         PnBhLRPZ2WJUeLeoiLmYyXMqNsEIxRio8kcjrhVgRSzcjJksCZTl2gYvQrEDq1lQRjYy
         sQe/IM1PJLrMeNSkwH/QSdXyndFKcnIMREncV8r5TszY9UaEr02+RZp5Nzl9FyRYRBgA
         EzeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679608660;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xT74xSWmA5QHZ7V+aYakO6jXkw5S6mXvNpj9AQQXVgc=;
        b=WQ9FcbNsb8SyMRw2D3HYYLJpzy1O0qG0DaUS30atkjzVXjhmHJsVtZEu0bLloCwrtg
         EU4HiOgY9ZDJukbxXG0R0jl/1hdi8etJptLK4B7/gesTTO0b2i4uD7O4xcrTVUSm63IA
         6PkzXQIfmxQxG2TKJhXk4aoQw07X/QPbM8I1uq31gQprggmBvjwcxnq6M+qnJo5WjmqU
         9vzKwhIEZRqMXz5SgKkPKoR8zUvRjrM1Kmjtg5v+nbHVSPVGsQOWKXiqEQ8WfeigmD65
         iQ/FlJk2IPS+Q5G76XtD5L4K2FimeHfH3jb54jcxUCsR/ueXRsCUUifMugunDF7IVjcp
         o+MA==
X-Gm-Message-State: AO0yUKV0UPTdRpNkRLwxc8hIYu+sRwiVJINc4BFuTbcudkIJun+qhhdK
        Nj1cXiXKGAmIxecguMmvQlOJfOAmKBs=
X-Google-Smtp-Source: AK7set/vYYKRkNfPEREFIov0ExMu/dCHQ7ht8Atint+E2P0wmuMFLDtzYusHeFShwsFfwP5oD7//BA==
X-Received: by 2002:a05:6a20:b2f:b0:da:3903:f5e7 with SMTP id x47-20020a056a200b2f00b000da3903f5e7mr994698pzf.0.1679608659800;
        Thu, 23 Mar 2023 14:57:39 -0700 (PDT)
Received: from [172.17.0.2] ([4.227.9.24])
        by smtp.gmail.com with ESMTPSA id y22-20020aa78556000000b00627eac32b11sm9674978pfn.192.2023.03.23.14.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:57:39 -0700 (PDT)
Message-ID: <641ccb53.a70a0220.40aba.1d7f@mx.google.com>
Date:   Thu, 23 Mar 2023 14:57:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8755799726698420360=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v8,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230323140942.v8.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230323140942.v8.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8755799726698420360==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=733320

---Test result---

Test Summary:
CheckPatch                    FAIL      4.76 seconds
GitLint                       PASS      1.00 seconds
SubjectPrefix                 PASS      0.34 seconds
BuildKernel                   PASS      31.65 seconds
CheckAllWarning               PASS      34.64 seconds
CheckSparse                   PASS      39.17 seconds
CheckSmatch                   PASS      109.35 seconds
BuildKernel32                 PASS      30.47 seconds
TestRunnerSetup               PASS      439.87 seconds
TestRunner_l2cap-tester       PASS      16.09 seconds
TestRunner_iso-tester         PASS      15.83 seconds
TestRunner_bnep-tester        PASS      5.03 seconds
TestRunner_mgmt-tester        PASS      102.86 seconds
TestRunner_rfcomm-tester      PASS      8.13 seconds
TestRunner_sco-tester         PASS      7.41 seconds
TestRunner_ioctl-tester       PASS      8.62 seconds
TestRunner_mesh-tester        PASS      6.37 seconds
TestRunner_smp-tester         PASS      7.40 seconds
TestRunner_userchan-tester    PASS      5.26 seconds
IncrementalBuild              PASS      44.73 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v8,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#146: 
new file mode 100644

WARNING: Possible unnecessary 'out of memory' message
#471: FILE: net/bluetooth/coredump.c:149:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump prepare");

WARNING: quoted string split across lines
#615: FILE: net/bluetooth/coredump.c:293:
+				    "Devcoredump complete with size %u "
+				    "(expect %zu)",

WARNING: quoted string split across lines
#634: FILE: net/bluetooth/coredump.c:312:
+				    "Devcoredump aborted with size %u "
+				    "(expect %zu)",

WARNING: Possible unnecessary 'out of memory' message
#728: FILE: net/bluetooth/coredump.c:406:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING: Possible unnecessary 'out of memory' message
#771: FILE: net/bluetooth/coredump.c:449:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING: Possible unnecessary 'out of memory' message
#797: FILE: net/bluetooth/coredump.c:475:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING: Possible unnecessary 'out of memory' message
#819: FILE: net/bluetooth/coredump.c:497:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 8 warnings, 0 checks, 677 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13186091.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============8755799726698420360==--
