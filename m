Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB25EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Wed, 28 Jun 2023 20:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbjF1UAE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 28 Jun 2023 16:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjF1UAD (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 28 Jun 2023 16:00:03 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 849891FE7
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 13:00:01 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-7658430eb5dso11296585a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 28 Jun 2023 13:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687982400; x=1690574400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nVgUFzoXcyP+dIh2SaZpiejs1Ryo/GN1elkER95ftUc=;
        b=l8nBRhjkRkGToFuafQZirBPp29+O56JZkjmYzoPbKasxUk5IqDJfGU5XxHcyOe/lYb
         BG6/k3QXfposZOeaaRFJt5bv4U8QQsWRuaDTdOmQG897+menjcxyz0CDX8AFI6l2qdRT
         /urOyjey4LZkOaH+6p1V+K+MJ24mXFfWIjUAWd2dKI3mqLz7ecgPVSkiNwQFESEIYUg2
         UkkbE1ydin97bdaOFppaCTR3X3UeEGZ6clvD4We3grDnHrZDaXld+77cqRH/TMm3TJcR
         lnRWYo61oC16cAduGq/4wARMUOZAQHtU3AadQnlZ4UnOkeO1/6jiWUGmnJ8CxaSL4BoU
         /8OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687982400; x=1690574400;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nVgUFzoXcyP+dIh2SaZpiejs1Ryo/GN1elkER95ftUc=;
        b=XrsrrQ46woDWlFTo3Ip8dQbm4Wubjrlu3mZZXqezp8zoDyKNfEr4dZCdjiRWU9bENF
         iHTDD2RT/UWsK/i0rpafNFsLkUj9epOp0pmQi50UPAtBQFeXYdGeTQshz7W81+VnTUWk
         zYgvvxSi+2Wb+BC1wKFHdC1CHyjlEZi50/uD1Nu/g4nwt7CVr4RWlYrWI8IQNXKznKJZ
         bYYQnqzLZ0jLCaaEhyVO9z/64NL2j8CqwKk4nbPFz80V0Ti7QQ5ZV/sz+MOVgLsak1Vj
         xSt2uZaU0uB6iDWmYIb6XuvUaKrcKSGzwHSp9hRDyn0rl2IxF23iFfApfIeVeF3Qy9ng
         65FA==
X-Gm-Message-State: AC+VfDw8whK8LEP7FREsiOKm5x/eMx2kse+fncBPcIqyEmISWqRa+iy8
        voVh/cMfgOjNXHJkPW9wpneI0IkFA1s=
X-Google-Smtp-Source: ACHHUZ5Zqo3dxLMVq7Skqsd3DcNR6dB6Bnvi/ind7GmxkhkgMPoeFNfSeLA48JyWNRIomCH2Hs1jjA==
X-Received: by 2002:a05:620a:424d:b0:75b:23a1:3606 with SMTP id w13-20020a05620a424d00b0075b23a13606mr32900588qko.23.1687982400440;
        Wed, 28 Jun 2023 13:00:00 -0700 (PDT)
Received: from [172.17.0.2] ([172.177.213.83])
        by smtp.gmail.com with ESMTPSA id d11-20020a37c40b000000b007625382f4ccsm5390424qki.69.2023.06.28.13.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 13:00:00 -0700 (PDT)
Message-ID: <649c9140.370a0220.1482a.ca3f@mx.google.com>
Date:   Wed, 28 Jun 2023 13:00:00 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1993619023383546177=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v3,1/3] Bluetooth: hci_conn: Consolidate code for aborting connections
In-Reply-To: <20230628192114.2773581-1-luiz.dentz@gmail.com>
References: <20230628192114.2773581-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1993619023383546177==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=761033

---Test result---

Test Summary:
CheckPatch                    PASS      3.28 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 PASS      0.39 seconds
BuildKernel                   PASS      33.55 seconds
CheckAllWarning               PASS      36.54 seconds
CheckSparse                   WARNING   43.18 seconds
CheckSmatch                   WARNING   113.11 seconds
BuildKernel32                 PASS      32.16 seconds
TestRunnerSetup               PASS      456.30 seconds
TestRunner_l2cap-tester       PASS      17.45 seconds
TestRunner_iso-tester         PASS      24.69 seconds
TestRunner_bnep-tester        PASS      5.82 seconds
TestRunner_mgmt-tester        PASS      133.82 seconds
TestRunner_rfcomm-tester      PASS      9.19 seconds
TestRunner_sco-tester         PASS      10.55 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        PASS      7.39 seconds
TestRunner_smp-tester         PASS      8.44 seconds
TestRunner_userchan-tester    PASS      6.04 seconds
IncrementalBuild              PASS      63.76 seconds

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


---
Regards,
Linux Bluetooth


--===============1993619023383546177==--
