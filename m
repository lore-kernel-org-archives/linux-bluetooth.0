Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3441C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 18 Nov 2022 05:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbiKRFGD (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 18 Nov 2022 00:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbiKRFF5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 18 Nov 2022 00:05:57 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5FE98277
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:05:54 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id l22-20020a17090a3f1600b00212fbbcfb78so7308864pjc.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Nov 2022 21:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RgQWRgNPT7rSwkOvtiA38tjel60tu7LIzV8Mo8Nk840=;
        b=jY9SisRuwdQo7YSaZqKhiWSoN6Zqmx1LJFLhpA3O+lhaTg/NzQHnyupquSEns5y+08
         w1jFbEH7/J5jN+MzeXClLplGzzWMnaX0QkbAu3cd+uGJI52mqdcWD3gZpqm3RC2EJMlp
         pYOv/5Z4w8Ah6V6jQwNisZmpMU9rAUwL/9TzO6rF5J76DuBzvzpMpxDQdg9ekYwLfJvE
         4XM2/o5gbgeRCb1B/nytCAHTjCX6iSrizwC17xmFml6tVrpzR6xhrGsC1mDipunhDJGt
         T+/h9hb5/yk2micqgSC/G8vCG3eCxQ33AGUkZavwNdOgt1NrGH6b3ImoMHL3EsF7QQsr
         mzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RgQWRgNPT7rSwkOvtiA38tjel60tu7LIzV8Mo8Nk840=;
        b=vAxkMVQfUA/Yu09TbEwLG7NhWqWlqfILKtzEME6fbUDHxMFMZxiZgbVFM9j86iHwkK
         0bcxKECIPgzYhcHFQVHGrlXIPRBZe73krlmk0Up0UvecV6q1aSuxItH1F4fsRbGDs7s8
         9RU+10OvISWCShLFY7u2KYPd7p7oFpe/fUdywo21Clu2AthyzUhWRoMd9nuyBoOWCwnR
         lI/tzQyLYr2X5L3Q+SegHip/w2UgOp0HJjWJLB7fhHM1UBgQMCxy4arlDv+5PHhrCrhc
         VknW04jAUlRxJ3qv0FHmRtNtMwEJC/YMgIfQxR7jZtmpGNHn2gb+5BpEmlAfzQwlhMw9
         lNiQ==
X-Gm-Message-State: ANoB5pnNW3kH3eiNCfgSj9IzciWHkK+VTa5SdJzSYb7POcUKUMvYansL
        c0UVxYYDFy+KHVAH5WTslCZq620/X0E=
X-Google-Smtp-Source: AA0mqf55iBOZVZvQ8VM2pQwNUeU+hgdB+HiFgwnShH0/kwfGwywVjYzORDHXq7BPwhLS5eP9SEDaoQ==
X-Received: by 2002:a17:90a:4605:b0:218:7dd7:ad4c with SMTP id w5-20020a17090a460500b002187dd7ad4cmr3089411pjg.224.1668747953711;
        Thu, 17 Nov 2022 21:05:53 -0800 (PST)
Received: from [172.17.0.2] ([168.61.79.13])
        by smtp.gmail.com with ESMTPSA id s65-20020a625e44000000b0056e8ce106d1sm2095068pfb.132.2022.11.17.21.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 21:05:53 -0800 (PST)
Message-ID: <637712b1.620a0220.28145.3c35@mx.google.com>
Date:   Thu, 17 Nov 2022 21:05:53 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1329917280263921662=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, abhay.maheshbhai.maheta@intel.com
Subject: RE: hci_event: handling CIS QoS
In-Reply-To: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
References: <20221116143334.4990-1-abhay.maheshbhai.maheta@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1329917280263921662==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=696036

---Test result---

Test Summary:
CheckPatch                    PASS      0.55 seconds
GitLint                       PASS      0.23 seconds
SubjectPrefix                 FAIL      0.50 seconds
BuildKernel                   PASS      38.42 seconds
BuildKernel32                 PASS      34.97 seconds
TestRunnerSetup               PASS      486.31 seconds
TestRunner_l2cap-tester       PASS      17.60 seconds
TestRunner_iso-tester         FAIL      17.97 seconds
TestRunner_bnep-tester        PASS      6.05 seconds
TestRunner_mgmt-tester        PASS      116.88 seconds
TestRunner_rfcomm-tester      PASS      10.35 seconds
TestRunner_sco-tester         PASS      9.81 seconds
TestRunner_ioctl-tester       PASS      11.29 seconds
TestRunner_mesh-tester        PASS      7.82 seconds
TestRunner_smp-tester         PASS      9.72 seconds
TestRunner_userchan-tester    PASS      6.52 seconds
IncrementalBuild              PASS      36.32 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 55, Passed: 11 (20.0%), Failed: 44, Not Run: 0

Failed Test Cases
ISO QoS 8_1_1 - Success                              Failed       2.011 seconds
ISO QoS 8_2_1 - Success                              Failed       0.181 seconds
ISO QoS 16_1_1 - Success                             Failed       0.177 seconds
ISO QoS 16_2_1 - Success                             Failed       0.174 seconds
ISO QoS 16_2_1 CIG 0x01 - Success                    Failed       0.174 seconds
ISO QoS 16_2_1 CIG 0x01 CIS 0x01 - Success           Failed       0.173 seconds
ISO QoS 24_1_1 - Success                             Failed       0.176 seconds
ISO QoS 24_2_1 - Success                             Failed       0.172 seconds
ISO QoS 32_1_1 - Success                             Failed       0.167 seconds
ISO QoS 32_2_1 - Success                             Failed       0.177 seconds
ISO QoS 44_1_1 - Success                             Failed       0.177 seconds
ISO QoS 44_2_1 - Success                             Failed       0.172 seconds
ISO QoS 48_1_1 - Success                             Failed       0.169 seconds
ISO QoS 48_2_1 - Success                             Failed       0.160 seconds
ISO QoS 48_3_1 - Success                             Failed       0.172 seconds
ISO QoS 48_4_1 - Success                             Failed       0.164 seconds
ISO QoS 48_5_1 - Success                             Failed       0.167 seconds
ISO QoS 48_6_1 - Success                             Failed       0.169 seconds
ISO QoS 8_1_2 - Success                              Failed       0.162 seconds
ISO QoS 8_2_2 - Success                              Failed       0.165 seconds
ISO QoS 16_1_2 - Success                             Failed       0.163 seconds
ISO QoS 16_2_2 - Success                             Failed       0.168 seconds
ISO QoS 24_1_2 - Success                             Failed       0.175 seconds
ISO QoS 24_2_2 - Success                             Failed       0.165 seconds
ISO QoS 32_1_2 - Success                             Failed       0.167 seconds
ISO QoS 32_2_2 - Success                             Failed       0.173 seconds
ISO QoS 44_1_2 - Success                             Failed       0.169 seconds
ISO QoS 44_2_2 - Success                             Failed       0.174 seconds
ISO QoS 48_1_2 - Success                             Failed       0.175 seconds
ISO QoS 48_2_2 - Success                             Failed       0.169 seconds
ISO QoS 48_3_2 - Success                             Failed       0.165 seconds
ISO QoS 48_4_2 - Success                             Failed       0.167 seconds
ISO QoS 48_5_2 - Success                             Failed       0.164 seconds
ISO QoS 48_6_2 - Success                             Failed       0.161 seconds
ISO Connect2 CIG 0x01 - Success                      Failed       0.215 seconds
ISO Send - Success                                   Failed       0.167 seconds
ISO Receive - Success                                Failed       0.167 seconds
ISO Defer Send - Success                             Failed       0.170 seconds
ISO 48_2_1 Defer Send - Success                      Failed       0.168 seconds
ISO Defer Receive - Success                          Failed       0.168 seconds
ISO 48_2_1 Defer Receive - Success                   Failed       0.163 seconds
ISO Send and Receive - Success                       Failed       0.184 seconds
ISO Disconnect - Success                             Failed       0.174 seconds
ISO Reconnect - Success                              Failed       0.168 seconds


---
Regards,
Linux Bluetooth


--===============1329917280263921662==--
