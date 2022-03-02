Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F9DC433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 20:09:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbiCBUKf (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCBUKe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 15:10:34 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFF126DB
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 12:09:51 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id 185so2278217qkh.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 12:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=L0CCz6iwMEDc3ZfuCHNZVzo/kCfq9pil5XFvOL+BKlE=;
        b=GAREL8RBFWvhsvmJu5/z394CT+UIDgYb+QaraKzIYxtyKqLrhMu9VrNA7h6DKDZaau
         OWHFTexcrgEQggRsWn7BkZBigfN54wM6Sp7HMmkrpHigXNLEOaBY5rHuLtzaVw/OTQ4m
         +OpapihY9KJghBvQ9OXCZgOyBw2jelK3CDOxmaLWlZ1ixb+c4g9NCa7WPcdCf1/iaLby
         2P7VmEqv+535o0+5F2N6xWoj4yNtBWUt6oOO25zy5iDnQYJkHFmHWaCUMDSWayVkblIA
         xMQJTYzKK3duKX7jiR1QmXILfZkhjh5aFQaOEEV+gA0brNI9gd+NKE6/Yz8XQA6RddNW
         9qtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=L0CCz6iwMEDc3ZfuCHNZVzo/kCfq9pil5XFvOL+BKlE=;
        b=axdF7c312vMVOhsTFTHQ84uXM+wEfRzfELmS0bGTh1tzEqz8/xWO4oVFCiB6TUMisT
         VBngNdxKt2ZsZS5mDoGCqNcQLdiHxEmAKnNBmuh7MfY9NTZ/US+eK5PXlh5CYSQ808XK
         QdvXai5HVRwkYw/MlF9BKbotvt9b/KMFYNUmxNON9ClzwcvPn5GI1glFf5wUkzTonFyN
         Ef7Dej7rdtA5wIRTus8YSwrZbm8tv+SfJFOxQuen7GdHFKnE/Q2rnscPCcxs7pxy4eiH
         fErHcQ+k6QoaA0I/Cb9ZaTPJTvlLikrpCOcPS2Ga7XadNZTzsFT92yy1/U7kxWC/lQ5P
         DwWA==
X-Gm-Message-State: AOAM533pUcarO1NeF73cUw8cEsCg/SXMcFPsAwKEV30U8zDjzHn2jm1R
        idh6eZZAwEHNRRnxHt1D5WMfphtyso0=
X-Google-Smtp-Source: ABdhPJzNkMOCTX6aaQEv7jX33mgOtbBoOtse57Ta/xIpHhoky7kt8T0/B6RLB/+Um+qTVdN8ex9W+g==
X-Received: by 2002:a37:f719:0:b0:648:cd93:3198 with SMTP id q25-20020a37f719000000b00648cd933198mr17353098qkj.179.1646251790004;
        Wed, 02 Mar 2022 12:09:50 -0800 (PST)
Received: from [172.17.0.2] ([52.177.20.217])
        by smtp.gmail.com with ESMTPSA id r13-20020ac85c8d000000b002de72dbc987sm11950143qta.21.2022.03.02.12.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:09:49 -0800 (PST)
Message-ID: <621fcf0d.1c69fb81.2e3c6.f3f4@mx.google.com>
Date:   Wed, 02 Mar 2022 12:09:49 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4443015620506095445=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220302191100.364431-1-luiz.dentz@gmail.com>
References: <20220302191100.364431-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4443015620506095445==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619678

---Test result---

Test Summary:
CheckPatch                    PASS      1.79 seconds
GitLint                       FAIL      1.13 seconds
SubjectPrefix                 PASS      0.98 seconds
BuildKernel                   PASS      36.27 seconds
BuildKernel32                 PASS      32.69 seconds
Incremental Build with patchesPASS      44.44 seconds
TestRunner: Setup             PASS      574.35 seconds
TestRunner: l2cap-tester      PASS      15.73 seconds
TestRunner: bnep-tester       PASS      7.38 seconds
TestRunner: mgmt-tester       PASS      119.53 seconds
TestRunner: rfcomm-tester     FAIL      9.16 seconds
TestRunner: sco-tester        PASS      9.29 seconds
TestRunner: smp-tester        PASS      9.34 seconds
TestRunner: userchan-tester   PASS      7.72 seconds

Details
##############################
Test: GitLint - FAIL - 1.13 seconds
Run gitlint with rule in .gitlint
Bluetooth: hci_sync: Fix not processing all entries on cmd_sync_work
10: B1 Line exceeds max length (103>80): "Link: https://lore.kernel.org/all/CAJCQCtSeUtHCgsHXLGrSTWKmyjaQDbDNpP4rb0i+RE+L2FTXSA@mail.gmail.com/T/"


##############################
Test: TestRunner: rfcomm-tester - FAIL - 9.16 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.186 seconds



---
Regards,
Linux Bluetooth


--===============4443015620506095445==--
