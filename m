Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CF2EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 20 Jun 2023 23:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjFTXfM (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 20 Jun 2023 19:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjFTXfL (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 20 Jun 2023 19:35:11 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39E17170A
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 16:35:10 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6b597fd6bc8so972001a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 20 Jun 2023 16:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687304109; x=1689896109;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yOFjWUdHP9Lx2NW1B1EGyIFveEYaYm/pF4RasIJQMzI=;
        b=V11Ekexdh+CxqmxGcIs1mR1flp1JCwONjeEvIgTSzFqZkHxD44/caeff+3e8SIK4li
         Tl9zwIulQH/6ZnOlMoHH+L4j5xKwHHt6OhcDSdi/mnxZvWDA2iRl5f/4XExgIkMPz5rI
         yOwIMADRSNAa1fUF4czByJ0ED/Rb9DF+TJnzxTnvRYwZZaK1Kshzf8Rrx/Q9V85WJSDm
         UjaFNI5hsh7J/JPlDVQKptFalFClLKn5WqyGBvWStUlNggsPjr182T1i1t8IH3bi4KOI
         uWH8Big+0Oo9C520ZLdjVlsrnP/u62G45A+tnVZHw7yyM4jx/OPvoa3Ew74QTl53yOgQ
         ui1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687304109; x=1689896109;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yOFjWUdHP9Lx2NW1B1EGyIFveEYaYm/pF4RasIJQMzI=;
        b=azhJN1aFlhpEpmt4shvZK712RfXnSprVoJHhgkWken9RP5MaS6kRm7Ia3WVFbuHNe7
         3j6QGm2QW7HdVruVq9elD0bMIXQ7vpnSd7ntjrmTIy1I2FR/2XcXQDyY1bVJcZeJWZwW
         zHYqVP30ytpTy/reVS323JyVR8aw/sVR1eNauhJevRWeoGFLyex+O2A8lcvW6fHeCgrf
         +FyAHMzk4iMP8GlMPoDSWtfEfGdA0G+Sm512Gz0gsMuLb8QHle8rNCCyXYr4Ewrp7E1O
         qQ0EjxMA0yrdLDsV1BiXlkqwxReKhBv4TD1V/lEtNhqh9iBFS2KsT7rTKrT8+kzAOqnl
         +BmQ==
X-Gm-Message-State: AC+VfDwaJh49QV1DRj5n1lqb0GFSfQAbX2YSKQfzvVSCret6PGNe5alT
        eVEe0ZIz5d0H4eVPsMMz9nrMhqJ6/Vc=
X-Google-Smtp-Source: ACHHUZ5pPXb6oR09W7zvV06XWBxwKN1RjKbSEpdQmFx+yAxee7gRLGeUtI2JJrnQdlTtY+QkISpYXQ==
X-Received: by 2002:a05:6830:13cd:b0:6b5:8689:4c78 with SMTP id e13-20020a05683013cd00b006b586894c78mr5866261otq.13.1687304109324;
        Tue, 20 Jun 2023 16:35:09 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.63.17])
        by smtp.gmail.com with ESMTPSA id t25-20020a9d7f99000000b006acfdbdf37csm1413419otp.31.2023.06.20.16.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 16:35:09 -0700 (PDT)
Message-ID: <649237ad.9d0a0220.3199c.750d@mx.google.com>
Date:   Tue, 20 Jun 2023 16:35:09 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4384350151777470278=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_event: Fix parsing of CIS Established Event
In-Reply-To: <20230620224346.729658-1-luiz.dentz@gmail.com>
References: <20230620224346.729658-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4384350151777470278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=758878

---Test result---

Test Summary:
CheckPatch                    PASS      0.72 seconds
GitLint                       PASS      0.33 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      38.03 seconds
CheckAllWarning               PASS      42.85 seconds
CheckSparse                   WARNING   47.74 seconds
CheckSmatch                   WARNING   130.04 seconds
BuildKernel32                 PASS      37.36 seconds
TestRunnerSetup               PASS      533.03 seconds
TestRunner_l2cap-tester       PASS      19.68 seconds
TestRunner_iso-tester         FAIL      28.80 seconds
TestRunner_bnep-tester        PASS      6.94 seconds
TestRunner_mgmt-tester        PASS      147.73 seconds
TestRunner_rfcomm-tester      PASS      10.72 seconds
TestRunner_sco-tester         PASS      9.86 seconds
TestRunner_ioctl-tester       PASS      11.62 seconds
TestRunner_mesh-tester        PASS      8.60 seconds
TestRunner_smp-tester         PASS      9.75 seconds
TestRunner_userchan-tester    PASS      7.17 seconds
IncrementalBuild              PASS      34.54 seconds

Details
##############################
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: CheckSmatch - WARNING
Desc: Run smatch tool with source
Output:
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 80, Passed: 76 (95.0%), Failed: 4, Not Run: 0

Failed Test Cases
ISO Receive - Success                                Failed       0.242 seconds
ISO Receive Timestamped - Success                    Failed       0.236 seconds
ISO Defer Receive - Success                          Failed       0.238 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.229 seconds


---
Regards,
Linux Bluetooth


--===============4384350151777470278==--
