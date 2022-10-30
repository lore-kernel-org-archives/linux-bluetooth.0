Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60FD0C38A02
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Oct 2022 08:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiJ3IGa (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Oct 2022 04:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiJ3IG2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Oct 2022 04:06:28 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B95B7C2
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 01:06:27 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46-20020a9d0631000000b00666823da25fso5309396otn.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Oct 2022 01:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=M9wLBOmDvEi+kFn6VfwLcmyew7pYwjv2o5fulnz6me8=;
        b=F913CehWxf/F3lJGUxsG2faDohCeuU/y36sgw1bnrYGz88ixtkU7qZkeOHeXxK3C/P
         b+ENbNzoOPAd3s7nknw46Cuna5V9mZLaqhHZrAPlxZhSsb9u41cRIVNSlxGsc306CVWf
         SRkr7dGQ+8TkaciRe03g4IFgogkXCH6hnACJzUp2Jb7HYrALbrqd0XD702srHjSbhCR5
         yKUhCUUXU03/prYH8fSOHHzkVT4Ks1jc1jIkBUg1b85O6vjIHk0G9iKDLaVc+Mmbx7AJ
         Mp99OgUHkwkT380gKViU9XZB46sjwGSvCFoR4AxaeUO8TnC/0W309tzdxFqwIJce/Och
         vkxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9wLBOmDvEi+kFn6VfwLcmyew7pYwjv2o5fulnz6me8=;
        b=5Xhfv07MF9kY4qYUL0duE9DuGYtkMAgl1q+PRycMGNPWBQBwfoouh+XqbX4B+fHkk1
         +nJg0hJ/c3ji/QCWvmFF62B7cutCyEa67yOuSraRrbA+1Te/P/UGpxWRi7M2BORL5CyU
         o1z7kxrP2BryHJ+ZNnx42XZ0Pecda2CYB8OWDmpXjB4vNuRkUkko8Z5nCavpPR1CP+BE
         pxksZnoTJcvVqVIjM0WvW/Rv0m3gHNxQkGkAU5JT2fGFVNa3Dc21ysN/d68eZnUQp2QV
         nVZsWH1GDBGxp0N7rDeWCUStP5BmzjHppBQSNd69iIadm0wuwtS4m7/YdIvXsp4w8rwF
         Dd8A==
X-Gm-Message-State: ACrzQf2DU+ri5Rg7khyTXs5ixZ8qzJyPpls4p2+JeJraPiqLUCAXYTvV
        aXm5dRwzvR5cCImSBDsE6zimjN2nN6s=
X-Google-Smtp-Source: AMsMyM7dF7A6W/iKRfI8PW2Wxn/28+FQdjsx6GwxDFBfDeiw3goLMepEcQGGRiiowrKxYZab/i47hQ==
X-Received: by 2002:a9d:8:0:b0:667:8892:568 with SMTP id 8-20020a9d0008000000b0066788920568mr3718185ota.305.1667117187075;
        Sun, 30 Oct 2022 01:06:27 -0700 (PDT)
Received: from [172.17.0.2] ([20.225.96.25])
        by smtp.gmail.com with ESMTPSA id g13-20020a056870d20d00b0012c21a64a76sm1601883oac.24.2022.10.30.01.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Oct 2022 01:06:26 -0700 (PDT)
Message-ID: <635e3082.050a0220.a2974.44d4@mx.google.com>
Date:   Sun, 30 Oct 2022 01:06:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6754187718783103093=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, christophe.jaillet@wanadoo.fr
Subject: RE: Bluetooth: Fix EALREADY and ELOOP cases in bt_status()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <9a1270540f0c2db13e81a9d69098391f1ad22107.1667113164.git.christophe.jaillet@wanadoo.fr>
References: <9a1270540f0c2db13e81a9d69098391f1ad22107.1667113164.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6754187718783103093==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690214

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.78 seconds
SubjectPrefix                 PASS      0.62 seconds
BuildKernel                   PASS      41.34 seconds
BuildKernel32                 PASS      37.50 seconds
Incremental Build with patchesPASS      53.34 seconds
TestRunner: Setup             PASS      613.53 seconds
TestRunner: l2cap-tester      PASS      19.92 seconds
TestRunner: iso-tester        PASS      19.44 seconds
TestRunner: bnep-tester       PASS      7.62 seconds
TestRunner: mgmt-tester       PASS      122.06 seconds
TestRunner: rfcomm-tester     PASS      14.95 seconds
TestRunner: sco-tester        PASS      11.14 seconds
TestRunner: ioctl-tester      PASS      12.85 seconds
TestRunner: mesh-tester       PASS      9.31 seconds
TestRunner: smp-tester        PASS      11.39 seconds
TestRunner: userchan-tester   PASS      7.99 seconds



---
Regards,
Linux Bluetooth


--===============6754187718783103093==--
