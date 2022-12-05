Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4164C47089
	for <linux-bluetooth@archiver.kernel.org>; Mon,  5 Dec 2022 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbiLETdk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 5 Dec 2022 14:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiLETdV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 5 Dec 2022 14:33:21 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55C52D1E1
        for <linux-bluetooth@vger.kernel.org>; Mon,  5 Dec 2022 11:28:18 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q13so5545744ild.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 05 Dec 2022 11:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uvE+Epev0kcmQ2j8T1Me/ZqS7MIeVb1PS05hrmBaA1Y=;
        b=QawSJQdbxWO5kMPFVC5zjX7DmNEPuj0ABFu2D9arCXy+zpg9VkyKz/YwrTC34dUCg3
         BMIzCowZhcxtCzYqATpiFOMoE5EQC63zwlAjNj3u1X98PUM22t6inkoRumc9jkOMEh9M
         h9/IY8ei+58EkVs/MiQ0H5k/5DL7PR+Sdd1Vh/wM9kp7JK2h1VYA5s68rru24OpoKRDm
         edDnl0FG46qrGtuhx/TBNbSTTWYxUwnMt1BNICsO4a7+MJI4rH7rmRTYZiaH1PxGs1+/
         NDSKqqQSu3KgMAkPAB3VR+0DiqpD6OaHgpLssZuqe0Rt9ZCAnouFpL/k+to3dwzoMsL0
         vgEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uvE+Epev0kcmQ2j8T1Me/ZqS7MIeVb1PS05hrmBaA1Y=;
        b=SuEYHH7S4+ZGnFNBqUS/+5vkE33k5Lt/7rj0V/xBJHX66EtGE57F1JljOjfJZQU6qM
         Frfv0mBG0ThqZ/rfo3OnVApoB5plAk5llo3aIisO3AO4nTwGOSJlPi4iC6H4Fs6cCxZg
         98ONFf6PEvtPv2R2QJMsHwiUqsKh+vGPOMFgILIHxqZCgD9bPdoZAQKjGXZjeOOuql5K
         DZMkQbYHLh2jlMrpOyQ56USByGDcnR5m5jIWQhqbAVb74YdSL6xst9h/e8lHDLPg6rCe
         Z3m2prwLcpd2jChJvl6etjE9ioEFuqb7/2LebEdk4Rk5oH3mSemhB13SZjmTNXSffUWn
         Q8+A==
X-Gm-Message-State: ANoB5pmOvgnvUD3DP/WA22VVMmMr9atl/Fyk6ODR6YjmlL+7CSNyzhy9
        B1OtE0j/romvlqjQUj9NUKPP9jSyYuM=
X-Google-Smtp-Source: AA0mqf5LJSp81AiR+7qoTZkiq7dDIolWL8E7JevuQFJlbuyhCG+TWqPKhSm+cxCzZ1GkeqcYGgGrWQ==
X-Received: by 2002:a92:d0d:0:b0:303:c87:7177 with SMTP id 13-20020a920d0d000000b003030c877177mr18106529iln.308.1670268498110;
        Mon, 05 Dec 2022 11:28:18 -0800 (PST)
Received: from [172.17.0.2] ([20.12.227.79])
        by smtp.gmail.com with ESMTPSA id v16-20020a02b090000000b0038a3cc44e36sm2291655jah.14.2022.12.05.11.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 11:28:17 -0800 (PST)
Message-ID: <638e4651.020a0220.b6b34.3511@mx.google.com>
Date:   Mon, 05 Dec 2022 11:28:17 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1182728368000299085=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2,1/3] Bluetooth: btusb: Fix new sparce warnings
In-Reply-To: <20221205183236.3460924-1-luiz.dentz@gmail.com>
References: <20221205183236.3460924-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1182728368000299085==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=701910

---Test result---

Test Summary:
CheckPatch                    PASS      1.72 seconds
GitLint                       PASS      0.85 seconds
SubjectPrefix                 PASS      0.29 seconds
BuildKernel                   PASS      34.88 seconds
BuildKernel32                 PASS      30.81 seconds
TestRunnerSetup               PASS      428.62 seconds
TestRunner_l2cap-tester       PASS      15.67 seconds
TestRunner_iso-tester         PASS      15.59 seconds
TestRunner_bnep-tester        PASS      5.42 seconds
TestRunner_mgmt-tester        PASS      104.21 seconds
TestRunner_rfcomm-tester      PASS      9.23 seconds
TestRunner_sco-tester         PASS      8.66 seconds
TestRunner_ioctl-tester       PASS      9.82 seconds
TestRunner_mesh-tester        PASS      6.64 seconds
TestRunner_smp-tester         PASS      8.36 seconds
TestRunner_userchan-tester    PASS      5.55 seconds
IncrementalBuild              PASS      42.68 seconds



---
Regards,
Linux Bluetooth


--===============1182728368000299085==--
