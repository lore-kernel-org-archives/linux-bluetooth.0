Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24796C43334
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jul 2022 05:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiGOFOm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jul 2022 01:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiGOFOl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jul 2022 01:14:41 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7727878200
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 22:14:40 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id x21so2293660plb.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 14 Jul 2022 22:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=tt3ccKxW5zJXLjOO11qHe+9Xey+8qlSHtVjK0PWIXrg=;
        b=WY/FZsEXTXRdTS3W80UXlglKyCASmo9JK4IGJQeZNBkJLh6wjqLhmHl9pTTHCRvd2T
         GNzkm9GL/heXvHAEPh5HVZuhks34pxrTJ4MMuyK2jIIXDBuO+ABWiktv2aTaSRnH8+WU
         0A+72hHegShSzgHKlmUg0V+tBEdkV7K2BvFT5LW2YIsn5YVqPq0Xnz4Mscv/AbXu3zFq
         5VyzwCCrhmtAjI/pp6CP8OtcUfN4GpQiu5zabXpGU6/uJvR349aKhFA+G1Dte3wxaODp
         o4j5x4NBn6koVmq1VMWsGoHfyu4qRbrMPy8hdJ10RTyRe/phn10jLCR7uh3eJtCpELiI
         r1Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=tt3ccKxW5zJXLjOO11qHe+9Xey+8qlSHtVjK0PWIXrg=;
        b=jq9kqJve5kux6vrl9SzZxJ7x2xEEESi9M5+1RTCGaqYRlk34vj4GxxBwRjIZuEG8T0
         QF1/gFOC71O0KsBLgSX1XCjj5YNEHwe1PX9PejiX7xzb3ZUO19n40ldoYdPQn29tX/ZU
         0mWSiBa8ga+BkP3EEHFZNhPzVLgZBcXjTPFRCJVDSFgxpMGY4AiDlLQdslqW4ybdMBcZ
         a0w3QGFdOLug67Vnhcvy3Alvzlj8N52emcgBYVaRU6SlRID/B8lwyu8Ifq0NSUfXdUUB
         +R84rORwFBAO3cnrKoRRod/6HFSnmfdQJjZjfVsCgJE9D71Hzxur5u1PBY4wTSoE/Qhc
         ccFA==
X-Gm-Message-State: AJIora9H+cwqvASrs9A6lW2/LUgbt1R0FSVrhMuEQxo6YvracdW8mvwY
        /jRwKqdG2mZ0/R9hgL8cOYkYmCwLxUA=
X-Google-Smtp-Source: AGRyM1tOSyUyYHdF1mvTjfwMBJPsaHmFv67z4ETd5oB2XJyCLUwjclg0TyerJ99klGzjsdZ6mZtgvg==
X-Received: by 2002:a17:90b:1b0c:b0:1f0:1c:1f8a with SMTP id nu12-20020a17090b1b0c00b001f0001c1f8amr13613964pjb.77.1657862079663;
        Thu, 14 Jul 2022 22:14:39 -0700 (PDT)
Received: from [172.17.0.2] ([20.253.250.114])
        by smtp.gmail.com with ESMTPSA id lp2-20020a17090b4a8200b001e87bd6f6c2sm4602535pjb.50.2022.07.14.22.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 22:14:39 -0700 (PDT)
Message-ID: <62d0f7bf.1c69fb81.f2090.7a44@mx.google.com>
Date:   Thu, 14 Jul 2022 22:14:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8244276805485629407=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, quic_zijuhu@quicinc.com
Subject: RE: [v2] Bluetooth: hci_sync: Remove redundant func definition
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <1657858487-29052-1-git-send-email-quic_zijuhu@quicinc.com>
References: <1657858487-29052-1-git-send-email-quic_zijuhu@quicinc.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8244276805485629407==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=659926

---Test result---

Test Summary:
CheckPatch                    PASS      1.35 seconds
GitLint                       FAIL      0.44 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      42.89 seconds
BuildKernel32                 PASS      37.83 seconds
Incremental Build with patchesPASS      51.07 seconds
TestRunner: Setup             PASS      626.68 seconds
TestRunner: l2cap-tester      PASS      20.21 seconds
TestRunner: bnep-tester       PASS      7.33 seconds
TestRunner: mgmt-tester       PASS      121.69 seconds
TestRunner: rfcomm-tester     PASS      11.54 seconds
TestRunner: sco-tester        PASS      11.26 seconds
TestRunner: smp-tester        PASS      11.09 seconds
TestRunner: userchan-tester   PASS      7.69 seconds

Details
##############################
Test: GitLint - FAIL - 0.44 seconds
Run gitlint with rule in .gitlint
[v2] Bluetooth: hci_sync: Remove redundant func definition
10: B3 Line contains hard tab characters (\t): "	-remove the func copy within hci_request.c instead of hci_sync.c"




---
Regards,
Linux Bluetooth


--===============8244276805485629407==--
