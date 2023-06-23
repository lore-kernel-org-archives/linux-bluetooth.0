Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F8EB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 22:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjFWWBY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 18:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjFWWBX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 18:01:23 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6B26AD
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 15:01:22 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-3ff24a193dbso10899551cf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 15:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687557681; x=1690149681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cXuMrN7W5+KF/JJXaeh7pay/mx8/rrapAtJfwPuKMYc=;
        b=XirGxTnu0sihutdq3+9lb0DUMWVq4E3+lkYa/3MYsDkiP1o1tM003t1ejlHz0rUFDN
         T0LmYLP+NvEx5OTfxtP6j5+265RhJOcT9Ihm6hhHf4u3nM+G3b1Cu5gaE9or/HVRro3k
         12zk44W3uE2Vpdl31qGDkLeLLzRxcj9G7wLYFbAx+cxoBH9uIs7SKeHLtX5SbMmG6lIS
         hiv/cr66x1tGE9YebX1aBsTfCnBNrzgftGyqLvD2xJhg+x1+9C3VbKY+U6HbjDShzFV3
         CSJXmoOWXfZYwO4uZeQlv0LJ6wSQqoUHdgx19ryo1X4up3ZF8elS5Hq1/74dc5qhUBO0
         dOfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687557681; x=1690149681;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXuMrN7W5+KF/JJXaeh7pay/mx8/rrapAtJfwPuKMYc=;
        b=Ttu/UxhSuiVyqpvKZFMgTpldrJ/Sj7TwY131HBcuOHO8dXRIwmzbKsjX8DEOGN/H63
         eigeiWAkY70h1/Bdg1N1Z8Rk2YMcD08GdQq5ZYtd8js8lSGmMT9EOuPYj3I31v0YuYXw
         d7slhEENj4nbcg6LFHuD6HmLy14U04hHYfCeYrDUe6MjHmVI7VBpGKJVQvV6ZZsXW30j
         vAJAYWBs4GMVdc7EqY1CvcCNPA3sWRE12vx1er1ZvMsCy1xAVgqsA+iSFzhO5EFt4dhF
         lOe2Mjiww/UfsiYvWB2ODYcJbZp7owo/hZsRI9Mhk3ji54b4/bYbwXBXecpveTCV4Fs/
         ntEA==
X-Gm-Message-State: AC+VfDxgx+rzuGIdM6TyiO3nBSOpRJ5gTQbSQY1UQp1Y1EqqcJar7isi
        K3KJCI88QPIQOJXXwbpT6segfEr5PmyC5w==
X-Google-Smtp-Source: ACHHUZ4Eqk8vn8EKO/922gkydua7EAmQDcIVHzdTEm+1mReCO2g+JiOIyQVvmPTZgGWmKWHEGzpArw==
X-Received: by 2002:a05:622a:1745:b0:3f6:af78:de13 with SMTP id l5-20020a05622a174500b003f6af78de13mr8029505qtk.18.1687557681607;
        Fri, 23 Jun 2023 15:01:21 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.16.209])
        by smtp.gmail.com with ESMTPSA id bt9-20020ac86909000000b003f6f83de87esm5261700qtb.92.2023.06.23.15.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 15:01:21 -0700 (PDT)
Message-ID: <64961631.c80a0220.2a030.13ed@mx.google.com>
Date:   Fri, 23 Jun 2023 15:01:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6119204602948191193=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v5] Bluetooth: hci_event: Fix parsing of CIS Established Event
In-Reply-To: <20230623212439.1702413-1-luiz.dentz@gmail.com>
References: <20230623212439.1702413-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6119204602948191193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=759915

---Test result---

Test Summary:
CheckPatch                    PASS      0.91 seconds
GitLint                       PASS      0.40 seconds
SubjectPrefix                 PASS      0.14 seconds
BuildKernel                   PASS      45.47 seconds
CheckAllWarning               PASS      48.19 seconds
CheckSparse                   WARNING   55.80 seconds
CheckSmatch                   WARNING   135.44 seconds
BuildKernel32                 PASS      41.15 seconds
TestRunnerSetup               PASS      532.88 seconds
TestRunner_l2cap-tester       PASS      20.47 seconds
TestRunner_iso-tester         FAIL      29.96 seconds
TestRunner_bnep-tester        PASS      7.28 seconds
TestRunner_mgmt-tester        PASS      154.03 seconds
TestRunner_rfcomm-tester      PASS      11.33 seconds
TestRunner_sco-tester         PASS      10.17 seconds
TestRunner_ioctl-tester       PASS      12.01 seconds
TestRunner_mesh-tester        PASS      9.08 seconds
TestRunner_smp-tester         PASS      10.73 seconds
TestRunner_userchan-tester    PASS      8.11 seconds
IncrementalBuild              PASS      39.36 seconds

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
Total: 80, Passed: 54 (67.5%), Failed: 26, Not Run: 0

Failed Test Cases
ISO QoS 44_1_1 - Success                             Failed       0.268 seconds
ISO QoS 44_2_1 - Success                             Failed       0.272 seconds
ISO QoS 48_1_1 - Success                             Failed       0.268 seconds
ISO QoS 48_2_1 - Success                             Failed       0.256 seconds
ISO QoS 48_3_1 - Success                             Failed       0.276 seconds
ISO QoS 48_4_1 - Success                             Failed       0.264 seconds
ISO QoS 48_5_1 - Success                             Failed       0.264 seconds
ISO QoS 48_6_1 - Success                             Failed       0.272 seconds
ISO QoS 8_1_2 - Success                              Failed       0.260 seconds
ISO QoS 8_2_2 - Success                              Failed       0.280 seconds
ISO QoS 16_1_2 - Success                             Failed       0.256 seconds
ISO QoS 16_2_2 - Success                             Failed       0.252 seconds
ISO QoS 24_1_2 - Success                             Failed       0.256 seconds
ISO QoS 24_2_2 - Success                             Failed       0.260 seconds
ISO QoS 32_1_2 - Success                             Failed       0.256 seconds
ISO QoS 32_2_2 - Success                             Failed       0.260 seconds
ISO QoS 44_1_2 - Success                             Failed       0.256 seconds
ISO QoS 44_2_2 - Success                             Failed       0.268 seconds
ISO QoS 48_1_2 - Success                             Failed       0.252 seconds
ISO QoS 48_2_2 - Success                             Failed       0.276 seconds
ISO QoS 48_3_2 - Success                             Failed       0.268 seconds
ISO QoS 48_4_2 - Success                             Failed       0.252 seconds
ISO QoS 48_5_2 - Success                             Failed       0.256 seconds
ISO QoS 48_6_2 - Success                             Failed       0.268 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.268 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.216 seconds


---
Regards,
Linux Bluetooth


--===============6119204602948191193==--
