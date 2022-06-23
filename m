Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B4CC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Jun 2022 21:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiFWVCV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Jun 2022 17:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiFWVCU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Jun 2022 17:02:20 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8820B62BD6
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 14:02:19 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id t16so1885288qvh.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Jun 2022 14:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=//WxcUBlQFRs9xaxUvep1NIpAaNP61AmtpWVnTJInWw=;
        b=YwFrFCuCvCTUizDBCloEedbcihlChcOzHkTZfydEdqCKC/nr1MFMpdEl4j8hjaLCSn
         7X0PqsEzhF/dKX0JYW45/4igr68SQRtfLL4savRk6wBfJ+ja6qSCWmUDgCAgBprYDgXc
         qS0c0X5/lC0EIRKs+5AIjIRwgfEbq3bB1F9H4o6rUh0AS+SMJnO2yq9xSUYgZjeLLv+P
         L4R0HKDVon9kuUcgK4YFla9Y5E/Uyy9+y//xQ3eHku4Bcd4QJL+hb4BowkZ7k0WOZKE+
         b10c1R5Pauo92n18SjjpPYRvB60BupttzRTDGp9VXNSgH9UAh0sMspKgm2BHWV+FvYRK
         Gv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=//WxcUBlQFRs9xaxUvep1NIpAaNP61AmtpWVnTJInWw=;
        b=MTChYXcpUuF7sFwkJN4WJSOUB+Q52BX7dXYcz539RyE1SN3vtL2qMFcUt6AsYAFgMQ
         vojUUIJVF49AYwn6RfPs05bUVp6q9HC0WlxaE62gsbLg7QaPCaARIgxbxxCY9H+PzLcr
         Y3np5ewfLvxzmb/lXOKMwGol7BdED8CQSWfWaq0scVnlONmNkjPUJblYINNs85oyk5TA
         OFVI0PCoZIBQPELU6/T2VL5Od/93vnYqcAplKWgMn54D28He9LjWHnfTbyM7+tSlsZae
         qUX9s/Lctnyjm4lYq9iMi+fHtEDowRUaM6ZG7MLfQ2Q+SfmC1M48F0VW3/k/Bkhj3vFT
         XY3g==
X-Gm-Message-State: AJIora/mYv04WIlRyBCh4ubcrTjuos1jXgPrOTTo1s2OoA10zKvpbSC5
        Z7LjHsAQwXG21nne3dYTRJ2AlIDbHNkgLQ==
X-Google-Smtp-Source: AGRyM1vpeomGRoAI4gaqDuuv4L22/szNQ+lh49t3ZAhzCSx054mtJgXvY/vqaFZzx05uz2N3ABjU8g==
X-Received: by 2002:a05:622a:390:b0:306:7777:63c3 with SMTP id j16-20020a05622a039000b00306777763c3mr9847727qtx.309.1656018138294;
        Thu, 23 Jun 2022 14:02:18 -0700 (PDT)
Received: from [172.17.0.2] ([20.7.54.127])
        by smtp.gmail.com with ESMTPSA id a6-20020a05622a02c600b002f93be3ccfdsm315344qtx.18.2022.06.23.14.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 14:02:17 -0700 (PDT)
Message-ID: <62b4d4d9.1c69fb81.4a22a.1165@mx.google.com>
Date:   Thu, 23 Jun 2022 14:02:17 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1651911082089325586=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v2,1/2] Bluetooth: Add support for devcoredump
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220623123549.v2.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
References: <20220623123549.v2.1.Iaf638bb9f885f5880ab1b4e7ae2f73dd53a54661@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1651911082089325586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=653346

---Test result---

Test Summary:
CheckPatch                    FAIL      3.12 seconds
GitLint                       PASS      2.26 seconds
SubjectPrefix                 PASS      1.98 seconds
BuildKernel                   PASS      32.24 seconds
BuildKernel32                 PASS      28.83 seconds
Incremental Build with patchesPASS      46.96 seconds
TestRunner: Setup             PASS      479.27 seconds
TestRunner: l2cap-tester      PASS      17.47 seconds
TestRunner: bnep-tester       PASS      6.18 seconds
TestRunner: mgmt-tester       PASS      102.90 seconds
TestRunner: rfcomm-tester     PASS      9.68 seconds
TestRunner: sco-tester        PASS      9.51 seconds
TestRunner: smp-tester        PASS      9.47 seconds
TestRunner: userchan-tester   PASS      6.41 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.12 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,1/2] Bluetooth: Add support for devcoredump\Traceback (most recent call last):
  File "scripts/spdxcheck.py", line 6, in <module>
    from ply import lex, yacc
ModuleNotFoundError: No module named 'ply'
WARNING:FILE_PATH_CHANGES: added, moved or deleted file(s), does MAINTAINERS need updating?
#130: 
new file mode 100644

WARNING:SPDX_LICENSE_TAG: Improper SPDX comment style for 'include/net/bluetooth/coredump.h', please use '/*' instead
#135: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
#135: FILE: include/net/bluetooth/coredump.h:1:
+// SPDX-License-Identifier: GPL-2.0-only

WARNING:SPLIT_STRING: quoted string split across lines
#585: FILE: net/bluetooth/coredump.c:300:
+				    "Devcoredump complete with size %u "
+				    "(expect %u)",

WARNING:SPLIT_STRING: quoted string split across lines
#604: FILE: net/bluetooth/coredump.c:319:
+				    "Devcoredump aborted with size %u "
+				    "(expect %u)",

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#687: FILE: net/bluetooth/coredump.c:402:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump init");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#730: FILE: net/bluetooth/coredump.c:445:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump pattern");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#756: FILE: net/bluetooth/coredump.c:471:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump complete");

WARNING:OOM_MESSAGE: Possible unnecessary 'out of memory' message
#778: FILE: net/bluetooth/coredump.c:493:
+	if (!skb) {
+		bt_dev_err(hdev, "Failed to allocate devcoredump abort");

total: 0 errors, 9 warnings, 0 checks, 669 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12893145.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1651911082089325586==--
