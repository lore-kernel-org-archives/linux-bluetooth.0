Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF5C2BA4C
	for <linux-bluetooth@archiver.kernel.org>; Wed, 26 Jan 2022 05:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbiAZFz6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 26 Jan 2022 00:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiAZFz6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 26 Jan 2022 00:55:58 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD1EC06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 21:55:57 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 71so11331424qkf.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 25 Jan 2022 21:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=sRIxSsI96CxxtLvKPzhMBsuM1+28myrOZuA+jtBIwFM=;
        b=hgXYXHpiv7RkOQ+H9FsQ0TfzXVg850EpR4QWg8XSzcybeUTnrZrr3HyuV9cydK5Z0w
         cjmMQOtjvyCyY88mxaIkT8REcF73qTne30M2BmRITZ4YarvIOXsV4mNYV6e6KmAyR1Si
         kUMRqh19hBBbPN/d6X0OSkzg4cVtBkkg7OeZLMmET8b7rGNfFT3VJ/mZIBBU8FwhVm77
         gkpIsnouJCKR/aQGyz5DnXAp+ZA2sH82U+Bp1+A6q3DEYQIE+GvNh4gST7FJ5jTf1qFo
         QkA/QCg2m7IUogDjHqhh3nDBCO6Sp3yY4vJj9wcBODMDr72jn3DrOn2M4UaQIpQGNs+j
         YQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=sRIxSsI96CxxtLvKPzhMBsuM1+28myrOZuA+jtBIwFM=;
        b=GH+GMlPlQmflj5b2L/g3rxEKICCGC8+s9H09exXfWgjikewz5DGwW+s2W1THMtkJ/G
         UAWG4w2xKCZakBbor3J148hurRolaPuQftZCgO6jfuBrSN/cz5cZbcstOersOQtDTXxE
         g+/TgELfpn5olTO/zm24LQmH34+wmFCf9T4jWzFOENB0LrxK8+f//EH1+D3ZZiQ5yjmI
         tPTglalJDcHCc7OkhqaqQOiHj63qxhF4JvWofveilo44mS547wwEKZpIBVo0XTln1C3b
         g2GZXrJH8qbUdAsxmImgmtMXGz7s6+IC8arTtIFdGqmH8rYJf8RLFwe8j+Zu7JTByLkc
         Q6BA==
X-Gm-Message-State: AOAM532y5ufj+5kdYL0svy0Mmh0Ezy2wxScYrr85/fVSqDWtJYV8xqib
        k7ZdfGcz1QujbyHihx7RhTNnQkXnjXU=
X-Google-Smtp-Source: ABdhPJzBrie6CxYMWcwaKpTvRLRj+Im5SQqUTUj5srpraOd64s8GsMWD/GVqBC5Kt0IgchWGVroKVQ==
X-Received: by 2002:a05:620a:2a08:: with SMTP id o8mr17363608qkp.643.1643176556827;
        Tue, 25 Jan 2022 21:55:56 -0800 (PST)
Received: from [172.17.0.2] ([52.254.81.248])
        by smtp.gmail.com with ESMTPSA id g11sm9836521qtg.83.2022.01.25.21.55.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 21:55:56 -0800 (PST)
Message-ID: <61f0e26c.1c69fb81.245e2.9779@mx.google.com>
Date:   Tue, 25 Jan 2022 21:55:56 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5195000948122105466=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, adeep@lexina.in
Subject: RE: Bluetooth: hci_h5: btrtl: Add support for RTL8822CS hci_ver 0x08
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220126053103.3261693-2-adeep@lexina.in>
References: <20220126053103.3261693-2-adeep@lexina.in>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5195000948122105466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=608534

---Test result---

Test Summary:
CheckPatch                    FAIL      3.28 seconds
GitLint                       PASS      1.98 seconds
SubjectPrefix                 PASS      1.74 seconds
BuildKernel                   PASS      29.19 seconds
BuildKernel32                 PASS      26.18 seconds
Incremental Build with patchesPASS      41.66 seconds
TestRunner: Setup             PASS      461.68 seconds
TestRunner: l2cap-tester      PASS      13.20 seconds
TestRunner: bnep-tester       PASS      6.01 seconds
TestRunner: mgmt-tester       PASS      103.37 seconds
TestRunner: rfcomm-tester     PASS      7.32 seconds
TestRunner: sco-tester        PASS      7.60 seconds
TestRunner: smp-tester        PASS      7.54 seconds
TestRunner: userchan-tester   PASS      6.27 seconds

Details
##############################
Test: CheckPatch - FAIL - 3.28 seconds
Run checkpatch.pl script with rule in .checkpatch.conf
[v6,2/2] Bluetooth: hci_h5: Add power reset via gpio in h5_btrtl_open\WARNING:COMMIT_LOG_LONG_LINE: Possible unwrapped commit description (prefer a maximum 75 chars per line)
#60: 
to initialize the adapter in most cases. It has been found experimentally that

total: 0 errors, 1 warnings, 11 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/12724610.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.




---
Regards,
Linux Bluetooth


--===============5195000948122105466==--
