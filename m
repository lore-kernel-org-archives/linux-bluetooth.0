Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC905C433EF
	for <linux-bluetooth@archiver.kernel.org>; Fri, 25 Mar 2022 21:59:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiCYWBK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 25 Mar 2022 18:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbiCYWBJ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 25 Mar 2022 18:01:09 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C786131969
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 14:59:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id k125so7060344qkf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 25 Mar 2022 14:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Rp6znzBjD3mtroyjgE2mOpjt5LgAXeXZ3v+III2ZCKw=;
        b=S1EW4b6l5DKvGRUId3BRNNIF9RfbUwTr/Nq9eUN6LY3wD4KBaq+n/aUvE57x9tDhW8
         Zpu7KFepV2vcgFTurCr9tUAxpH/uZKcq3sprPD0ewGoF45csvGDCFpBvfPxKcQgAcc/I
         SCZX52zd2Y9dFdJj/o+2LAPkZfVT1BCGLC6Z4ScQMoVf/sZJk3BBvZnQmNQT1qONB5fH
         iyxePAWlYu4MDpgCca9rPCI+y5iO7NeGsIUXqQeXi/o3b+Ms9/hrLkDe15sW7RCz+GdZ
         sGh8g3SkcBZa2qdnphEv53i5ZVGXhuGdE9nZdISqqQybFRA7ueUMmYI15ArIMKRtbF0M
         ig/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Rp6znzBjD3mtroyjgE2mOpjt5LgAXeXZ3v+III2ZCKw=;
        b=mT9lahUqoztlKtXd6feoxOjChHRXx1nwsBs7bz/ZPo/uY66uK2DDCzihSV2XkL5hC/
         jAw0swKHSGJ0nGSWfoVMkGW5Kv1adv70YsFvbRKXPL0Kjtdfu/Gr1Fngv2KRyDP1JCym
         vsdpnpe2I4h363ZZO4cezW2z9vrswybl89+paodkurPttFCKIXey1ymq0Qz1hiR0C0Jm
         C78EcyrCti2Fl283ywymeJhb5n/8hZH6KOyxaVLkkptn6rjzcPfjXYwiIZ+GumaP+5Mk
         GQzD6o0Tf4Z+SLX9vZeAKSHQzOqK52sWYW895dZz9t4EUn6MUy1bQzn5uUaI8CxstSUP
         ccDg==
X-Gm-Message-State: AOAM531zZbIkZETALvm9toA2BwFSTk/uwjs5eX4SyWiDZkc4sSIsqvWo
        dA1JWUQ4G+RWNHogajB6BnXx3QFBLZcYyw==
X-Google-Smtp-Source: ABdhPJwi4wp1P0ZypS7PjOqfy0zebkqpveKtIy8TXciJ4Ae8o4Z+dYX6KNZc1CO3Stf0VXXFaHDCqw==
X-Received: by 2002:ae9:e891:0:b0:47b:a53f:5f00 with SMTP id a139-20020ae9e891000000b0047ba53f5f00mr8412718qkg.693.1648245570085;
        Fri, 25 Mar 2022 14:59:30 -0700 (PDT)
Received: from [172.17.0.2] ([20.119.251.19])
        by smtp.gmail.com with ESMTPSA id y15-20020a05622a004f00b002e1aaa1738dsm6423651qtw.12.2022.03.25.14.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 14:59:29 -0700 (PDT)
Message-ID: <623e3b41.1c69fb81.56ecc.524b@mx.google.com>
Date:   Fri, 25 Mar 2022 14:59:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4970520110673937367=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220325211314.425364-1-luiz.dentz@gmail.com>
References: <20220325211314.425364-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4970520110673937367==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=626431

---Test result---

Test Summary:
CheckPatch                    FAIL      3.90 seconds
GitLint                       PASS      1.92 seconds
SubjectPrefix                 PASS      1.75 seconds
BuildKernel                   PASS      31.26 seconds
BuildKernel32                 PASS      27.90 seconds
Incremental Build with patchesPASS      43.49 seconds
TestRunner: Setup             PASS      493.04 seconds
TestRunner: l2cap-tester      PASS      15.79 seconds
TestRunner: bnep-tester       PASS      6.39 seconds
TestRunner: mgmt-tester       PASS      101.39 seconds
TestRunner: rfcomm-tester     PASS      7.86 seconds
TestRunner: sco-tester        PASS      7.79 seconds
TestRunner: smp-tester        PASS      7.81 seconds
TestRunner: userchan-tester   PASS      6.51 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.90 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[2/2] Bluetooth: Print broken quirks\WARNING:SPLIT_STRING: quoted string split across lines
#113: FILE: net/bluetooth/hci_sync.c:3842:
+		   "HCI Delete Stored Link Key command is advertised, "
+		   "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#116: FILE: net/bluetooth/hci_sync.c:3845:
+		   "HCI Read Default Erroneous Data Reporting command is "
+		   "advertised, but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#119: FILE: net/bluetooth/hci_sync.c:3848:
+		   "HCI Read Transmit Power Level command is advertised, "
+		   "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#124: FILE: net/bluetooth/hci_sync.c:3853:
+		   "HCI Enhanced Setup Synchronous Connection command is "
+		   "advertised, but not supported.")

total: 0 errors, 4 warnings, 0 checks, 56 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12792078.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============4970520110673937367==--
