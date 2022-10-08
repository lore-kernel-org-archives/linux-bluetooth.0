Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBEBC433F5
	for <linux-bluetooth@archiver.kernel.org>; Sat,  8 Oct 2022 03:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJHDLe (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 7 Oct 2022 23:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiJHDLc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 7 Oct 2022 23:11:32 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351FB2408B
        for <linux-bluetooth@vger.kernel.org>; Fri,  7 Oct 2022 20:11:31 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id l1-20020a17090a72c100b0020a6949a66aso6233946pjk.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 07 Oct 2022 20:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=iZTzCzdqdXrH6V5Nq2pSyZyurKjOE+ExcRDb4KcyKi4=;
        b=cRcQ4yokfK3oUATLHE/fNIZ7RrtJes/lzbLeMDEqFxuAgUycZysOzATJj+pe7F0LGd
         jOTBTExPRLk8CKYlsfUVZ+jXyM6XfP2TSzRlpLVm7+pHUUd0ejvwj6dbpMblQT6cH1iV
         pSIjG4g+qasRXJa/JxushVmEUM4msjJ9ZAOCtN3CLOcKOQNHg+D54/EbG2cyILC/arK3
         gRSS/d5B5jtlCK3LSsyDFRo16Wti2xm7POVaWhlz8kInoxsk4hHmkKIwDCna43Up0V/u
         Jmwf/XxN+uuIrfsIqa6UdmJiSiazzVsYPpEwzpAnxlIVg0Ak/yZ0oh9MwyOnp82BLvsM
         eGWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZTzCzdqdXrH6V5Nq2pSyZyurKjOE+ExcRDb4KcyKi4=;
        b=N3ffIZH5mxdctsIkXOfCc+SQHpe3bPlokubFyOhp3Vn7zzjO+2XCcN3oXFo5wQLvaO
         EwMrS5dUhX7cKNMvkgY4fDi+xGmjFL9J35Ww8PFxMF/0AxPjpML21BarEYAifzsm25DI
         Re7g6AOExvh8qSPajqlgzxLYgs2kyp/p/eCfNWJXnusOWBIGmKHxL6SNMfrjrkalNED6
         v0RgxA29sy0u9lkZ6xkKegHRsDXpUPbUxJ387wA73pOraWgmXse1CbY1QP1ySC7JaWFi
         11WluRyTGG3dtJnuiuEZEAcQKh0fWoV4br94lKzyPUDlF2GJ5AisI0j4OsNqxcP1k+Xn
         Cweg==
X-Gm-Message-State: ACrzQf2+6Zk3qfLnPytp8ge0xBQ1zFC1nkeqGIaRa43lRIWZZMO+wLuK
        mUUyNS6+9QW5zEbksOIYI9LLZJf001M=
X-Google-Smtp-Source: AMsMyM5evC4iTcO9AQm103fLDfkhZVtWB6St+8XG7o2dsnz8t16kySlRHd1rsFD+XB7MjEbSF5ET0A==
X-Received: by 2002:a17:90b:1b4c:b0:202:c1a3:25ce with SMTP id nv12-20020a17090b1b4c00b00202c1a325cemr19977743pjb.232.1665198690430;
        Fri, 07 Oct 2022 20:11:30 -0700 (PDT)
Received: from [172.17.0.2] ([104.40.10.146])
        by smtp.gmail.com with ESMTPSA id x16-20020aa79a50000000b005403b8f4bacsm2380753pfj.137.2022.10.07.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 20:11:30 -0700 (PDT)
Message-ID: <6340ea62.a70a0220.f4f53.488f@mx.google.com>
Date:   Fri, 07 Oct 2022 20:11:30 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1324513094705632583=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [1/2] Bluetooth: hci_sync: Fix not setting static address
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221008011129.1906898-1-luiz.dentz@gmail.com>
References: <20221008011129.1906898-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1324513094705632583==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=683863

---Test result---

Test Summary:
CheckPatch                    PASS      1.84 seconds
GitLint                       PASS      0.94 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      45.66 seconds
BuildKernel32                 PASS      41.39 seconds
Incremental Build with patchesPASS      66.29 seconds
TestRunner: Setup             PASS      682.30 seconds
TestRunner: l2cap-tester      PASS      21.42 seconds
TestRunner: iso-tester        PASS      22.47 seconds
TestRunner: bnep-tester       PASS      8.46 seconds
TestRunner: mgmt-tester       FAIL      140.62 seconds
TestRunner: rfcomm-tester     PASS      13.03 seconds
TestRunner: sco-tester        PASS      12.36 seconds
TestRunner: ioctl-tester      PASS      14.33 seconds
TestRunner: mesh-tester       PASS      10.32 seconds
TestRunner: smp-tester        PASS      12.12 seconds
TestRunner: userchan-tester   PASS      8.61 seconds

Details
##############################
Test: TestRunner: mgmt-tester - FAIL - 140.62 seconds
Run test-runner with mgmt-tester
Total: 494, Passed: 492 (99.6%), Failed: 2, Not Run: 0

Failed Test Cases
Set Static Address - Success 1                       Timed out    2.396 seconds
Set Static Address - Success 2                       Timed out    2.004 seconds



---
Regards,
Linux Bluetooth


--===============1324513094705632583==--
