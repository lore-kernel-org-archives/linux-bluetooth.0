Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0EBEE0207
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Sep 2023 20:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232525AbjIMUf6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Sep 2023 16:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbjIMUf5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Sep 2023 16:35:57 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DA31BC8
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 13:35:53 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34baf19955cso807335ab.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694637353; x=1695242153; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=t+PCTCEQeqEPNiqvOOfqRy21dLoddWdUn+Af9wQHbKw=;
        b=Hu4aryZ4KX8KExcHONERIZBRHgBECXnRdiNCTVl3/w0P3CS4Y3GTh4uWugfTw0pCUp
         kxa2YOkD4BnhDtdbwq5wbG3vovQEpJOO/ZRbiZP0Z/ARLY+LJpCH7P+ACvb6e1DXBx2W
         3YU08k1enVJ1hayMCaFONA9kcbyz0SFslVNKlXc31Grn0HHaklEdJM878VYBAHI5nBva
         XWN68pJ7YiZDCRQSYyQmcD3KsRVChom+xDcp8PMkAwE2kPTLApL1aSTdFAGI0FGpT9ma
         UgNO5FwFeY+MsXsS5f6yf27uZR1nmmAkiZmVGtbHMnndrgoorhzqXkzz8J2BLo39majP
         ehKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694637353; x=1695242153;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+PCTCEQeqEPNiqvOOfqRy21dLoddWdUn+Af9wQHbKw=;
        b=mLeYxDV/bfKtOTUVV4j1oTupisrDzqQkH7Sc9zWGXqlYWyDpHtghrVb1aG2FHYRL0H
         SdIaXMBcjJ8J4869uTpW6Fqrbjsv/xWQlbFsEdVPAq/OkKMLxGzmrHaD2aiEOFHBSKrP
         +jFrg6MB9YSt1Aqh+Tu7L5y0f8BMDN4ymwAkyrDZgsw/CoTxPLOoLCy86i+mba+bDeSL
         j93FenslJmfq9yIQaasAu6j7f1jsLT43cAPBTNdELilqMLNTcg41vbKxlowSN55t51dJ
         cDSCYlYQrFlTU9BoIlv0mYHoC8msXq4343D2TdHFr059fggdfEKmDAJKe/UcP4CmtQhc
         CbTg==
X-Gm-Message-State: AOJu0YwucBbRbt9Zhuug/x4HgX+Dx16nqF8eEgY7QdUtDdin43UEdlnb
        syoSqjOikUfk/hXNnBvBSi114D/WbEw=
X-Google-Smtp-Source: AGHT+IEQM5v+LwSLnJ4SfE9LPhAYmFvQBwFMxHAncONlcc11LjuZ/JXePnyfAy2qxhJ0JgBLLsBMLA==
X-Received: by 2002:a05:6e02:1c04:b0:34f:2484:64ce with SMTP id l4-20020a056e021c0400b0034f248464cemr4434741ilh.23.1694637352639;
        Wed, 13 Sep 2023 13:35:52 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.5.19])
        by smtp.gmail.com with ESMTPSA id a6-20020a029f86000000b00437a3c128dfsm3716284jam.108.2023.09.13.13.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 13:35:52 -0700 (PDT)
Message-ID: <65021d28.020a0220.6f2d9.5519@mx.google.com>
Date:   Wed, 13 Sep 2023 13:35:52 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1651913900434636212=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix leaking l2cap_conn objects
In-Reply-To: <20230913193839.3029428-1-luiz.dentz@gmail.com>
References: <20230913193839.3029428-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1651913900434636212==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=783902

---Test result---

Test Summary:
CheckPatch                    FAIL      1.28 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.82 seconds
CheckAllWarning               PASS      35.82 seconds
CheckSparse                   PASS      40.91 seconds
CheckSmatch                   PASS      115.39 seconds
BuildKernel32                 PASS      31.58 seconds
TestRunnerSetup               PASS      481.60 seconds
TestRunner_l2cap-tester       PASS      27.15 seconds
TestRunner_iso-tester         PASS      47.77 seconds
TestRunner_bnep-tester        PASS      10.25 seconds
TestRunner_mgmt-tester        PASS      217.08 seconds
TestRunner_rfcomm-tester      PASS      15.95 seconds
TestRunner_sco-tester         PASS      19.14 seconds
TestRunner_ioctl-tester       PASS      17.60 seconds
TestRunner_mesh-tester        PASS      13.02 seconds
TestRunner_smp-tester         PASS      14.12 seconds
TestRunner_userchan-tester    PASS      10.90 seconds
IncrementalBuild              PASS      29.64 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
Bluetooth: L2CAP: Fix leaking l2cap_conn objects
WARNING: Reported-by: should be immediately followed by Closes: with a URL to the report
#88: 
Reported-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

total: 0 errors, 1 warnings, 0 checks, 84 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/src/13383710.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============1651913900434636212==--
