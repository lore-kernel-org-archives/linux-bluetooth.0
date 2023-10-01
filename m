Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29EF8E748E9
	for <linux-bluetooth@archiver.kernel.org>; Sun,  1 Oct 2023 08:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234472AbjJAIoT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 1 Oct 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJAIoS (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 1 Oct 2023 04:44:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4CEB3
        for <linux-bluetooth@vger.kernel.org>; Sun,  1 Oct 2023 01:44:16 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-79f95cd15dfso509359939f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 01 Oct 2023 01:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696149855; x=1696754655; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3xUbcArxRGTCPciq3Xf5KPvi7pPPk+IVx9YSYYP53x4=;
        b=kbOkUA+nJhxbObZt07UPB0/y4YoKV1T9CA38dln8PIDpxtmt6CaKErfXirpa5eoY9i
         2iXr8YKaEVmsbfzuZGd4GcZwPSfC90eoJI4iSy9WUoSvCrgZ1OrBi6LI/ZaMjK1SHp7r
         E7q2w8EeFjRQKFlrF6aSfgvNDDPgC8S855ON4dHpkCdv27oCNNhdTYLwGiQFjYJlbvcC
         sRLe/mWYMX5GQuBOl3IteCYVv5WVJfC60hic46kAH6LRGyz0QlOZM+63q29IsfKFvUDF
         tQ9iuh0cxigfWtbS9I2ZJLbNDWlbVoO52PGKJr5ohCsAA9Z6N5siSLggekAOyifCRpUK
         kZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696149855; x=1696754655;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3xUbcArxRGTCPciq3Xf5KPvi7pPPk+IVx9YSYYP53x4=;
        b=Aci0HO883bPPUzR4A0RtPtg94Dm12fvxkLJ4Sqxz8SHuw1kZBD1q0QJGsah9GyRfdx
         fnOOi34gSKafDzqrOXpCRkyTeTW7/9b1pz0uf8C5AWmT75SJcpsl1QJDB441xYt2/u36
         Wodfar6zDgLfPHPXZsqc1dtwU5Kaxn7p7IPxnPPJXyMixIaI2647s1vDq+PhvVWVO26z
         Cgj7bQf9rbv0vkmpX6typF+OzLfSMZsZdUHyWtStcyaTLz+IKT/UK1vgbUZLU/k2xjjZ
         W5H5OsED/EPVxPaYr2yZYPzyrzNiEXHmdQseRd1nCWNCs5G+iWHWZMWntKbvqHweeBNJ
         OD5Q==
X-Gm-Message-State: AOJu0Yyx9ERNdYt28F/w3wutv0HkMdwTpHSlYPYw4RVyRoOKe94MOCBk
        TLthK3fsFqznvrWQLcIWE2kTBCzTLC4=
X-Google-Smtp-Source: AGHT+IEbEAuTvz6QezQG1KgRGmOTcQh7kkDnENBZjy9vuWTRoIRl3u/vMUXzlnjX9Vyz1fjkZOjsPw==
X-Received: by 2002:a6b:e901:0:b0:786:f4a0:d37e with SMTP id u1-20020a6be901000000b00786f4a0d37emr8682480iof.4.1696149855274;
        Sun, 01 Oct 2023 01:44:15 -0700 (PDT)
Received: from [172.17.0.2] ([40.77.92.119])
        by smtp.gmail.com with ESMTPSA id s4-20020a02cf24000000b0043194542229sm6135299jar.52.2023.10.01.01.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:44:15 -0700 (PDT)
Message-ID: <6519315f.020a0220.7420d.8ca0@mx.google.com>
Date:   Sun, 01 Oct 2023 01:44:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0287808984223958357=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jlee@suse.com
Subject: RE: [1/2] Bluetooth: hci_event: Ignore NULL link key
In-Reply-To: <20231001080813.GA14514@linux-691t>
References: <20231001080813.GA14514@linux-691t>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0287808984223958357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789096

---Test result---

Test Summary:
CheckPatch                    PASS      0.77 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      43.13 seconds
CheckAllWarning               PASS      46.91 seconds
CheckSparse                   WARNING   53.60 seconds
CheckSmatch                   WARNING   140.37 seconds
BuildKernel32                 PASS      41.66 seconds
TestRunnerSetup               PASS      622.54 seconds
TestRunner_l2cap-tester       PASS      38.78 seconds
TestRunner_iso-tester         PASS      82.16 seconds
TestRunner_bnep-tester        PASS      13.74 seconds
TestRunner_mgmt-tester        FAIL      251.73 seconds
TestRunner_rfcomm-tester      PASS      21.30 seconds
TestRunner_sco-tester         PASS      24.23 seconds
TestRunner_ioctl-tester       PASS      23.16 seconds
TestRunner_mesh-tester        PASS      16.89 seconds
TestRunner_smp-tester         PASS      20.09 seconds
TestRunner_userchan-tester    PASS      15.21 seconds
IncrementalBuild              PASS      40.23 seconds

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
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    2.016 seconds


---
Regards,
Linux Bluetooth


--===============0287808984223958357==--
