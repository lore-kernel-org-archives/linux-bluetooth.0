Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B45C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Tue, 13 Sep 2022 23:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiIMXMC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 13 Sep 2022 19:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbiIMXMC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 13 Sep 2022 19:12:02 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A4070E47
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:12:00 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso12737750pjm.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Sep 2022 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=EBs6c/rDd5/uOSpMoD+z4WbttoOQcO+F/g20BgLpb24=;
        b=av8j3vxKC5uEhwNfQkyBWvQT3ugVMw3rDhBw1VsgtmtyHkE7GCtTdc2uI0i/1Z6ky7
         BVAUZwEKpta4AnPV3hOTzgbrc0psECt14aG1Z9KKvcTdWmAej02dBLJJcpgwL5XlVCtk
         rL+bEzyaZmD+HTKb69vrUCV4QFfcVZOyKPm9bVWAFWytYDcfDfrkZUDrf//QKBpsXkhM
         TTJzxLRZrSK3XsykoUDDRm4Qg+JujNSJvGK8O4jtwqMLgqHb5hzmh2MTyJTJO0nRQQfb
         wxnkVOke30LbWKB6tVBjNUwwT8uPzcaZ1ZzBqKmpKjnKrxBNgWIcTTuvtc/hlG+H6iic
         IYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=EBs6c/rDd5/uOSpMoD+z4WbttoOQcO+F/g20BgLpb24=;
        b=4a9D0BIeDB04VBHRcHLB0XxvOiWbiY6QOl1xb8WTmKt57Xf7ZK4uijsKu7r/jd5evH
         M565zf9UEdyLofLwcyPbAcmaXN+lenRfvj5t703K4wAkKVUexRGBY2Y5yzVJ0Npj0FlF
         G8Fos6BYEbq6JmGaakP8cgQRmz4D0peSwbqdmhkLM4fHeL74qPwpmyn4xBAb4b56n7d1
         ekdQOLFc7TQ0tkoLIVixm2rc80TPcQ1eqfCVQjtL4SCUh7s4aqcUYh/K9jy7a3l0veNv
         oHrGnPxdWlu0Mh8oVQR041AqiJ0zWuz0dyd2b6HivSyywCxGxiqlDmLCFSxzIMeID971
         d1jg==
X-Gm-Message-State: ACrzQf36IkT9pFoPh2Jk6WjE0NVqFAo/xnHsfrvGrFgquPC2RkpDvcBQ
        LYFJpRgVJyOBYc2styAheGBWPGSQ17g=
X-Google-Smtp-Source: AMsMyM5gDD7vPfHyx/tZY8nmKEWNT6zPyRkk59/BZV9OLQY4NehRl7obQdSsr0G8FfnbMwM5zkzpPQ==
X-Received: by 2002:a17:90a:318f:b0:1fa:a374:f565 with SMTP id j15-20020a17090a318f00b001faa374f565mr1596352pjb.146.1663110719688;
        Tue, 13 Sep 2022 16:11:59 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.80.126])
        by smtp.gmail.com with ESMTPSA id f11-20020a170902684b00b0016f057b88c9sm9007822pln.26.2022.09.13.16.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 16:11:59 -0700 (PDT)
Message-ID: <63210e3f.170a0220.7dfaf.038b@mx.google.com>
Date:   Tue, 13 Sep 2022 16:11:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3819566134973533406=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: Bluetooth: hci_sync: allow advertising during active scan without privacy
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220913150420.kernel.v1.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
References: <20220913150420.kernel.v1.1.I54824fdfb8de716a1d7d9eccecbbfb6e45b116a8@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3819566134973533406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676705

---Test result---

Test Summary:
CheckPatch                    PASS      0.94 seconds
GitLint                       FAIL      0.47 seconds
SubjectPrefix                 PASS      0.31 seconds
BuildKernel                   PASS      40.55 seconds
BuildKernel32                 PASS      35.44 seconds
Incremental Build with patchesPASS      52.30 seconds
TestRunner: Setup             PASS      604.47 seconds
TestRunner: l2cap-tester      PASS      19.00 seconds
TestRunner: iso-tester        PASS      18.39 seconds
TestRunner: bnep-tester       PASS      7.23 seconds
TestRunner: mgmt-tester       PASS      115.07 seconds
TestRunner: rfcomm-tester     PASS      11.59 seconds
TestRunner: sco-tester        PASS      10.92 seconds
TestRunner: smp-tester        PASS      10.75 seconds
TestRunner: userchan-tester   PASS      7.73 seconds

Details
##############################
Test: GitLint - FAIL - 0.47 seconds
Run gitlint with rule in .gitlint
[kernel,v1,1/1] Bluetooth: hci_sync: allow advertising during active scan without privacy
1: T1 Title exceeds max length (89>80): "[kernel,v1,1/1] Bluetooth: hci_sync: allow advertising during active scan without privacy"




---
Regards,
Linux Bluetooth


--===============3819566134973533406==--
