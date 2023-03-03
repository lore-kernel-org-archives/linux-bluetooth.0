Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE75C678D4
	for <linux-bluetooth@archiver.kernel.org>; Fri,  3 Mar 2023 02:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjCCCjk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Mar 2023 21:39:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCCCjj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Mar 2023 21:39:39 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9FD3BDA0
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Mar 2023 18:39:38 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s18so683838pgq.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Mar 2023 18:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677811177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFgYFr2/nL19xUPIYc1SpKeVwJXgxeuhJ0U0CMBYlq4=;
        b=p+1QDfCsUax54siHTF67BwR5GYsYuoO+Rbad9t4GKqSs+VkngOiUcXu7nPxZ2BGSor
         4E4smQ6WsI6ZxDfpj6s67yeWyMWkVUz/X0GvYoWMywPTPNxoWqvE/t3lHETn3o7Yl7xa
         uh+UxZ/S6DCnXbJpzGBioMnpvXkac61WQoubLGLOQdsPPZbqZ6cKejP+MR9ekv/izmTB
         9IyBFRcQO39VgZlGYX/fsg9HnwB30/BpWwLMt1eIo5xtX4hMz/YeJU+ps6K66XDPM3b+
         KhW6fbjmYhn9TDTvb1oPekQkbtAZRbuLv9kfkCFMiVDpfwYULYqPfZu2q9mTbgaGxr5Z
         /ooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677811177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFgYFr2/nL19xUPIYc1SpKeVwJXgxeuhJ0U0CMBYlq4=;
        b=Af4JacK+yvrKxKz8isSwSqqIIy/E60OTZnWHVKXCeN2pULAwZnmf2EQ/zFy8QxbyFr
         pDeBFDjwMbplG00mT/L21IOVrI1+I1qj4nfXy8Zg4UiDAYb0KweK+yJRRNoauN32znBi
         OidOJFrSGXQp2xmErtf4/Ft/j7ljfMQsFk/lgV5Ngl+KnKp+rQFhTu1WDQ7h93XGKuRU
         kP+itMOIi879/5sBUKbtl8q5Sy9R2EgZ9lfZQApl7I2HHzTDL13Vswtl3a+BlR9TmCom
         6izmnum8O3+Tautv5qjr1ODMcOD+MIW4I71BqVJCNP6q8apGkvOmc/opF6k8autKOjC7
         dwlA==
X-Gm-Message-State: AO0yUKUbyvU9aK7OkE29j/LvKd9/ehlOKICQg8xpmfQmtAL5f4Flv1Cc
        zJVvAhWz693kqPLjprJn2igHbl7jX1A=
X-Google-Smtp-Source: AK7set/Kn0cU5oKoQDBZQhRohiDQ19Q+o/lvRKoXFSoPqayyCxAkEDDUeqpHm/tT6+00F5zUfJ0leQ==
X-Received: by 2002:a62:648c:0:b0:5a8:58b5:bfa9 with SMTP id y134-20020a62648c000000b005a858b5bfa9mr621049pfb.12.1677811177165;
        Thu, 02 Mar 2023 18:39:37 -0800 (PST)
Received: from [172.17.0.2] ([13.87.244.131])
        by smtp.gmail.com with ESMTPSA id e23-20020aa78c57000000b005a75d85c0c7sm385749pfd.51.2023.03.02.18.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 18:39:36 -0800 (PST)
Message-ID: <64015de8.a70a0220.b6063.17da@mx.google.com>
Date:   Thu, 02 Mar 2023 18:39:36 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4914081547124413466=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v7,1/4] Bluetooth: Add support for hci devcoredump
In-Reply-To: <20230302151413.v7.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
References: <20230302151413.v7.1.I9b4e4818bab450657b19cda3497d363c9baa616e@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4914081547124413466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=726259

---Test result---

Test Summary:
CheckPatch                    FAIL      5.34 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      38.30 seconds
CheckAllWarning               PASS      41.72 seconds
CheckSparse                   PASS      47.01 seconds
CheckSmatch                   PASS      127.02 seconds
BuildKernel32                 PASS      36.80 seconds
TestRunnerSetup               PASS      520.01 seconds
TestRunner_l2cap-tester       PASS      18.28 seconds
TestRunner_iso-tester         PASS      20.23 seconds
TestRunner_bnep-tester        PASS      6.61 seconds
TestRunner_mgmt-tester        PASS      126.52 seconds
TestRunner_rfcomm-tester      PASS      10.49 seconds
TestRunner_sco-tester         PASS      9.64 seconds
TestRunner_ioctl-tester       PASS      11.37 seconds
TestRunner_mesh-tester        PASS      8.43 seconds
TestRunner_smp-tester         PASS      9.46 seconds
TestRunner_userchan-tester    PASS      6.96 seconds
IncrementalBuild              PASS      53.41 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v7,1/4] Bluetooth: Add support for hci devcoredump
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#145: 
new file mode 100644

WARNING: quoted string split across lines
#621: FILE: net/bluetooth/coredump.c:300:
+				    "Devcoredump complete with size %u "
+				    "(expect %zu)",

WARNING: quoted string split across lines
#640: FILE: net/bluetooth/coredump.c:319:
+				    "Devcoredump aborted with size %u "
+				    "(expect %zu)",

WARNING: Possible unnecessary 'out of memory' message
#734: FILE: net/bluetooth/coredump.c:413:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING: Possible unnecessary 'out of memory' message
#777: FILE: net/bluetooth/coredump.c:456:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING: Possible unnecessary 'out of memory' message
#803: FILE: net/bluetooth/coredump.c:482:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING: Possible unnecessary 'out of memory' message
#825: FILE: net/bluetooth/coredump.c:504:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 7 warnings, 0 checks, 684 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13158029.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4914081547124413466==--
