Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E48CFE7AD73
	for <linux-bluetooth@archiver.kernel.org>; Tue,  3 Oct 2023 15:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbjJCPi0 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 3 Oct 2023 11:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbjJCPiZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 3 Oct 2023 11:38:25 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808EDA6
        for <linux-bluetooth@vger.kernel.org>; Tue,  3 Oct 2023 08:38:21 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-57bab8676f9so615448eaf.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 03 Oct 2023 08:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696347500; x=1696952300; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=tn3/Rpp+UKKHiKZ4Q3EDzhEYvj8a+iOnZJwgroICyic=;
        b=jvvf/O0lff7cNxJvCDBd2n1ii/e+lcctei94FbJundSX7CgorKd7ykuxPaEb7KQCE0
         7Xg3oxrF5+yYxPQYMMQtRPAXT3CCKaQtzGQBy+pyLhfBK0A4V51LhhCJUk1D5xMtmfcz
         leC12oZ9uN/fQx1KQAgyapn4jXRIHqAKgdLs4vn2W8LpNtWlHzGkdWvkFdLI2VHZS5Sf
         tP3xa6deq44sBgkc5dVXQ8h4OqvPZncgPdRGOT4n1VMg7iNAollqMo1wuRotHiLh/0lR
         E49YKkaz3iZDlHynyYgmjHz1uY6EnoaZYsrGCJffKQmy6lsRyuWmflnTyRwhE8dibmJM
         11nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696347500; x=1696952300;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tn3/Rpp+UKKHiKZ4Q3EDzhEYvj8a+iOnZJwgroICyic=;
        b=QpGkouv6JGD4rRylQv3qBLy9xrxiIgzwVlOHgsB2DVP7tyGmkwqiUMDzqNv/x5MBB0
         dmUKLnChQxqoG4AR1n55kDrEAqnZFzTyVd6BJTOCGgFJjNV+bexySP+LBzLHcv+fBNUC
         uneQBxDIZrdF0mMf2Xx393DONbJrxEMaLYliNMQNvKddd4MFX9kLM+UspWesk7YeMQyh
         b0EEWc+yoOyZXGCilsAOlVSesd2fqnTrXwwapbf0Vig6/KBevLGe5PFHXNndRKFZ/an+
         nATTSTtaylLuYiaw41kDHk6moEZCHKt2kOjfUKRBnrZetSNLvrXpUQoJyYDp4h935o24
         a42w==
X-Gm-Message-State: AOJu0YwZ3qpKH8eMSSfGyir+PBUuynj40IoN9NLog4xDeAg3edSrzAB4
        Xh32iX/Z5IBssRSxnXmqb7OmC/6Favk=
X-Google-Smtp-Source: AGHT+IFe7MFfydCOQ7k6DMhOPcYiZRSm/ozzJ2h4tFhnSmrZjVYV2pO0He1EzpytI6yIoem2wMH1uA==
X-Received: by 2002:a4a:9d14:0:b0:57b:8c6b:c99b with SMTP id w20-20020a4a9d14000000b0057b8c6bc99bmr13118366ooj.9.1696347500572;
        Tue, 03 Oct 2023 08:38:20 -0700 (PDT)
Received: from [172.17.0.2] ([13.66.79.88])
        by smtp.gmail.com with ESMTPSA id w5-20020a4aa985000000b0057377b1c1c8sm236935oom.24.2023.10.03.08.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 08:38:20 -0700 (PDT)
Message-ID: <651c356c.4a0a0220.87f7c.2e20@mx.google.com>
Date:   Tue, 03 Oct 2023 08:38:20 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1358379364194485613=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, iulia.tanasescu@nxp.com
Subject: RE: Bluetooth: ISO: Allow binding a bcast listener to 0 bises
In-Reply-To: <20231003144933.3462-2-iulia.tanasescu@nxp.com>
References: <20231003144933.3462-2-iulia.tanasescu@nxp.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1358379364194485613==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=789631

---Test result---

Test Summary:
CheckPatch                    PASS      0.81 seconds
GitLint                       PASS      0.30 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      34.70 seconds
CheckAllWarning               PASS      38.04 seconds
CheckSparse                   PASS      44.49 seconds
CheckSmatch                   PASS      116.78 seconds
BuildKernel32                 PASS      33.12 seconds
TestRunnerSetup               PASS      510.61 seconds
TestRunner_l2cap-tester       PASS      31.12 seconds
TestRunner_iso-tester         PASS      54.18 seconds
TestRunner_bnep-tester        PASS      10.63 seconds
TestRunner_mgmt-tester        FAIL      229.78 seconds
TestRunner_rfcomm-tester      PASS      16.20 seconds
TestRunner_sco-tester         PASS      19.63 seconds
TestRunner_ioctl-tester       PASS      18.64 seconds
TestRunner_mesh-tester        PASS      13.54 seconds
TestRunner_smp-tester         PASS      14.64 seconds
TestRunner_userchan-tester    PASS      12.42 seconds
IncrementalBuild              PASS      32.09 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Add Device 5 (2 Devices to RL)          Failed       0.424 seconds


---
Regards,
Linux Bluetooth


--===============1358379364194485613==--
