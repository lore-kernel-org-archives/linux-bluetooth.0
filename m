Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4A3C6FD18
	for <linux-bluetooth@archiver.kernel.org>; Fri, 31 Mar 2023 07:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjCaHgn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 31 Mar 2023 03:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjCaHgl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 31 Mar 2023 03:36:41 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4561A768B
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 00:36:40 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id p2so15830427qtw.13
        for <linux-bluetooth@vger.kernel.org>; Fri, 31 Mar 2023 00:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680248199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qmkKASLrqScv9wBxvin0Z5CUPNBoCKNZmCZZkwrJxZE=;
        b=KKfhf6W9JGEbcORqQUHh42zwrA/C8dnj75PrUZ3lFF8jC2fx0N4EPk9fQ3d7gzRzo1
         TCwSlj7braRLQ8uUWTVgVLnASofCZWiB8Av9Tx1akVaORRRY4XQ2baH6C5aBqO3k7m8h
         3+P+oWQC6h1JAKq7dqr8d+0nFnd8ZBranWbe8tSPJTwfTXaPPaSitF5DuJuhmDx5NJfz
         a+FJ+yyFoFZXX2uWm9zgdC6QXvlUSvMRqa77vwSihtK8gbMEVXhoQzFw/ZXh2Xi1DoFG
         1GFPunSotgO8CvRgBTDaXlfNbOx7PgRNOf7F68rpRqnmtJfDcX5XGz3st/OhoV7oBTFH
         N5dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680248199;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qmkKASLrqScv9wBxvin0Z5CUPNBoCKNZmCZZkwrJxZE=;
        b=oyy8SbP9Qv21WOShfVSXSZBKSckQ3XU+lKODDe9HQ6kw71ZUAkbmAvtskAOzdHCgud
         VAOCuoO0qejU7mqPuU1V4Z1imqEzmsIVNb8Qcy1sorSomzNHxl8S66pqlyaDmdVRfIwU
         GVcX0mBp/EOcCw5q+F6DR/kTwHApyEOYJkUr2Loxk5okBPUr6qtYN9lggJllrz0sEt4L
         hQXq6yQjGH9iC2N+zGfUes6rjD6ErzfLkSbfNg5Cvv5bmpBoQp6/LfJQVEHKi9wMmMaB
         T4L3HXXwk5oZ/BD0+2zR6virobi/TcjKLIlMnDNBqCC7+nJetCC+Dj0zhSYqTF3zSwfN
         w2CA==
X-Gm-Message-State: AAQBX9erzlGpM8v0lWtMtMG9L7gtf6L63hiuI1Qql+1C94RBv67hsz3N
        0Krl2IsyFhGVo2bwVjdWUtDwk2yxjMI=
X-Google-Smtp-Source: AKy350Zb9NNVGBMQWttbX3FaoqrMB7E2HlOo7wIXUm1U8lTw0vstRdxWznr+p7Cdey31xox8UCBg9Q==
X-Received: by 2002:ac8:7d0c:0:b0:3e4:e94a:5082 with SMTP id g12-20020ac87d0c000000b003e4e94a5082mr28835867qtb.5.1680248199362;
        Fri, 31 Mar 2023 00:36:39 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.201.65])
        by smtp.gmail.com with ESMTPSA id y3-20020a37f603000000b007468733cd1fsm470593qkj.58.2023.03.31.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 00:36:39 -0700 (PDT)
Message-ID: <64268d87.370a0220.7d922.2655@mx.google.com>
Date:   Fri, 31 Mar 2023 00:36:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0986430023905570492=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, michenyuan@huawei.com
Subject: RE: cmtp: fix argument error
In-Reply-To: <20230331064520.1320749-1-michenyuan@huawei.com>
References: <20230331064520.1320749-1-michenyuan@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0986430023905570492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=735678

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.36 seconds
SubjectPrefix                 FAIL      0.41 seconds
BuildKernel                   PASS      39.31 seconds
CheckAllWarning               PASS      43.12 seconds
CheckSparse                   PASS      48.21 seconds
CheckSmatch                   PASS      129.98 seconds
BuildKernel32                 PASS      38.30 seconds
TestRunnerSetup               PASS      534.77 seconds
TestRunner_l2cap-tester       PASS      18.44 seconds
TestRunner_iso-tester         PASS      18.96 seconds
TestRunner_bnep-tester        PASS      6.32 seconds
TestRunner_mgmt-tester        PASS      123.65 seconds
TestRunner_rfcomm-tester      PASS      10.02 seconds
TestRunner_sco-tester         PASS      8.95 seconds
TestRunner_ioctl-tester       PASS      10.65 seconds
TestRunner_mesh-tester        PASS      8.16 seconds
TestRunner_smp-tester         PASS      9.17 seconds
TestRunner_userchan-tester    PASS      6.59 seconds
IncrementalBuild              PASS      35.97 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0986430023905570492==--
