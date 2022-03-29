Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78BEC433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 21:06:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbiC2VIA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbiC2VH7 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 17:07:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169A51890D3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 14:06:16 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gp15-20020a17090adf0f00b001c7cd11b0b3so71980pjb.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 14:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=IKkzhuZ5ahFSZPoQrQoi/of+l9GIdFv0+csxk8OHQ5g=;
        b=hq6uUsLif370N74LRhh6DI4C0AGm+DOgby0FPaJ156vJSUprPeF1wr3lpaqlNJ+hUM
         0c0/j/8RvUN2SqSl34czMjsyZgkl0Fza3ZjqyslUahnPni77odPclIZH1YBJqkUP7qUZ
         DpQL3kBE9GRhRu2+YHrfGqpUUD6I0GcPibFlbncuiGmDF/IQV29hIpJRAitABtkKt/tF
         tDCz6riBSFok7mV4Z0ydwB3b5MGsz/Y5fjEsVdjhmqVfnz3HCilApzFV+bDA4ppxOe54
         UmYRf70P6v9S4If8qLgs4oO1tRdfwCn8bc/yazxbwz+0BabUia0LE6H/XYJAljZ8uhZQ
         29lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=IKkzhuZ5ahFSZPoQrQoi/of+l9GIdFv0+csxk8OHQ5g=;
        b=jfBxawTzLBcv5lUL5uq1ILoEVnZLOVu5wzRgpb+P5pgo5RMwIKjOOU8h355o7zioe/
         FOXh74Vpa/vhBUaYD+z2ybbDsaxmiuaJQPkkm0ARe4xweI/BPPWC+LQukk8+ropgu4wb
         hi2vS1zvw3eSTyFOrny6BAkech0tyPk9oAo0ba/7idn5Ae8c1pDxoRi8PCbrEU6o3PXE
         Xot+cFJSKc5Vunyfnc4CZbWVwR1ZlB4AT4yot+1PlaLfmQ7LLWDsEugL0oiIzR/pGEt+
         3XO2mKYZeiZh2ok0bWBZZCrrCp+LAI54fALFcueAjdlq6QrVYg7jxD8llIneraVwoKhn
         immQ==
X-Gm-Message-State: AOAM533VDogbEM08AX11qUKI5qBD1mXj59G2dvV+YBaHhZV9wVJhY096
        OoYCZi2d0nTfOT/czbFIOOH9KOIlvYU=
X-Google-Smtp-Source: ABdhPJxEaE4g8HFVIIsZP/5x3ts5HrmJ/rErBXkzJbUxRmE3p7fWTEmV3CW1zeDYuRJplTVljBGEzw==
X-Received: by 2002:a17:90b:33cd:b0:1c6:5db5:5ff9 with SMTP id lk13-20020a17090b33cd00b001c65db55ff9mr1064726pjb.197.1648587975247;
        Tue, 29 Mar 2022 14:06:15 -0700 (PDT)
Received: from [172.17.0.2] ([52.234.31.129])
        by smtp.gmail.com with ESMTPSA id y3-20020a056a00190300b004fa2411bb92sm21327747pfi.93.2022.03.29.14.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 14:06:15 -0700 (PDT)
Message-ID: <624374c7.1c69fb81.ab9df.6d55@mx.google.com>
Date:   Tue, 29 Mar 2022 14:06:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1098488127449280536=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220329201646.2296314-1-luiz.dentz@gmail.com>
References: <20220329201646.2296314-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1098488127449280536==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627309

---Test result---

Test Summary:
CheckPatch                    FAIL      2.56 seconds
GitLint                       PASS      1.51 seconds
SubjectPrefix                 PASS      1.00 seconds
BuildKernel                   PASS      42.17 seconds
BuildKernel32                 PASS      37.86 seconds
Incremental Build with patchesPASS      66.78 seconds
TestRunner: Setup             PASS      637.22 seconds
TestRunner: l2cap-tester      PASS      19.72 seconds
TestRunner: bnep-tester       PASS      8.15 seconds
TestRunner: mgmt-tester       PASS      133.25 seconds
TestRunner: rfcomm-tester     PASS      10.46 seconds
TestRunner: sco-tester        PASS      10.34 seconds
TestRunner: smp-tester        PASS      10.30 seconds
TestRunner: userchan-tester   PASS      8.39 seconds

Details
##############################
Test: CheckPatch - FAIL - 2.56 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v2,2/3] Bluetooth: Print broken quirks\WARNING:SPLIT_STRING: quoted string split across lines
#113: FILE: net/bluetooth/hci_sync.c:3842:
+			 "HCI Delete Stored Link Key command is advertised, "
+			 "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#116: FILE: net/bluetooth/hci_sync.c:3845:
+			 "HCI Read Default Erroneous Data Reporting command is "
+			 "advertised, but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#119: FILE: net/bluetooth/hci_sync.c:3848:
+			 "HCI Read Transmit Power Level command is advertised, "
+			 "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#124: FILE: net/bluetooth/hci_sync.c:3853:
+			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported.")

total: 0 errors, 4 warnings, 0 checks, 78 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12795219.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1098488127449280536==--
