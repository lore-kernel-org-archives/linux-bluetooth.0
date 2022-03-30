Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BEAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 30 Mar 2022 19:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350558AbiC3TNs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 30 Mar 2022 15:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350868AbiC3TMt (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 30 Mar 2022 15:12:49 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A0F31DC9
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 12:10:39 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z19so15744691qtw.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 30 Mar 2022 12:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Aoh1E3vZAEDxHscWie9DEYzNlot8voRPG+uwqyX/IHs=;
        b=Q6lpDBc1GkDGXP/8NK+mxEomZZb3boWRao1/XiFqJIo5DABieURvfG7NHhpwSfCPB4
         AbEi3vuwZ7/HIqd5j0unim7ZE6NORsRlfPGZ4bLLXytGfDcWA9WZAmVz9JT3o99NnFMx
         bcWudYJszDdz0mt+uthtS/xDWaYjnLwTfMrSO93W83RmSIbx7TjUAO5DCZNj8U9TAVJ2
         YcVM2nsVhDQRX8WyspKfUIM9Z6RM50zHG81pBqzlpVXiT/j7Owiz2oa0UfX4OfjSYL+2
         reeDggb7wAJWE0zA2ljd5btD+N1JuRXFpTpl98UQrJ7BMJiqNPSehH2p8Uj4S7zRTeDh
         1xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Aoh1E3vZAEDxHscWie9DEYzNlot8voRPG+uwqyX/IHs=;
        b=4YcfDbk4koxfelveVpsXcyEhaGpX+TCQihTHGiwEwsmCgO73jvFMKC85JCcH5mdGja
         mkhotcxNuZP80g64a8XVsoyX084/MVsCqkXWHmZ1/DgNrHHvLllSCHCG87mPbXGXltW4
         wR4zmRwPFafrCBTGGqXa2LDmsciA5+bzrpSomTs0i5PM/Kq2/x5RHIYEvrEjlmr59NRV
         VR4fyn28BRRafBQ0sVWW+MZ8nH08i/9iT0uL+eHf/SO37KZblgwpgFSL81TS1VzmMBo6
         a4qPSEUjHmNa5j4xnGcoe5S8R6NGXpkYfrRDhoxSQz1xCGfYjK8Dw2zdnAlRIYCQkWqR
         avPA==
X-Gm-Message-State: AOAM530M5k9Corgcc4uqVsG6hOU5Bhuh479S/HVOUB14Gw1TmrGqPND/
        WkQUR2BpHclY2ST9IDctoNY1wBVPeNc=
X-Google-Smtp-Source: ABdhPJz77ilc9NsS0q1Z90mvPeEEwORlmh8TOKpwS+9aBRKiUroj6fv89M67/jUp2UFrdqpIktZ1og==
X-Received: by 2002:a05:622a:1802:b0:2e1:abdb:e522 with SMTP id t2-20020a05622a180200b002e1abdbe522mr1042179qtc.144.1648667438071;
        Wed, 30 Mar 2022 12:10:38 -0700 (PDT)
Received: from [172.17.0.2] ([20.110.86.149])
        by smtp.gmail.com with ESMTPSA id x20-20020ac85f14000000b002e1ee1c56c3sm18446139qta.76.2022.03.30.12.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 12:10:37 -0700 (PDT)
Message-ID: <6244ab2d.1c69fb81.a264e.2415@mx.google.com>
Date:   Wed, 30 Mar 2022 12:10:37 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3625105576494540603=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: HCI: Add HCI_QUIRK_BROKEN_ENHANCED_SETUP_SYNC_CONN quirk
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220330182552.2613523-1-luiz.dentz@gmail.com>
References: <20220330182552.2613523-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3625105576494540603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=627595

---Test result---

Test Summary:
CheckPatch                    FAIL      3.86 seconds
GitLint                       PASS      3.01 seconds
SubjectPrefix                 PASS      2.73 seconds
BuildKernel                   PASS      35.53 seconds
BuildKernel32                 PASS      31.77 seconds
Incremental Build with patchesPASS      57.23 seconds
TestRunner: Setup             PASS      520.37 seconds
TestRunner: l2cap-tester      PASS      16.62 seconds
TestRunner: bnep-tester       PASS      6.67 seconds
TestRunner: mgmt-tester       PASS      107.83 seconds
TestRunner: rfcomm-tester     PASS      8.50 seconds
TestRunner: sco-tester        PASS      8.32 seconds
TestRunner: smp-tester        PASS      8.34 seconds
TestRunner: userchan-tester   PASS      6.95 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.86 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v3,2/3] Bluetooth: Print broken quirks\WARNING:SPLIT_STRING: quoted string split across lines
#109: FILE: net/bluetooth/hci_sync.c:3838:
+			 "HCI Delete Stored Link Key command is advertised, "
+			 "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#112: FILE: net/bluetooth/hci_sync.c:3841:
+			 "HCI Read Default Erroneous Data Reporting command is "
+			 "advertised, but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#115: FILE: net/bluetooth/hci_sync.c:3844:
+			 "HCI Read Transmit Power Level command is advertised, "
+			 "but not supported."),

WARNING:SPLIT_STRING: quoted string split across lines
#120: FILE: net/bluetooth/hci_sync.c:3849:
+			 "HCI Enhanced Setup Synchronous Connection command is "
+			 "advertised, but not supported.")

total: 0 errors, 4 warnings, 0 checks, 65 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12796216.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============3625105576494540603==--
