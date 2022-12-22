Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A207FC4332F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 22 Dec 2022 05:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230428AbiLVF7Z (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 22 Dec 2022 00:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLVF7Y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 22 Dec 2022 00:59:24 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BB42A2
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 21:59:22 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id e205so1036156oif.11
        for <linux-bluetooth@vger.kernel.org>; Wed, 21 Dec 2022 21:59:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=hiExCZaPo3J/+jc7V0f+6r0WUVdFU8A2WHBvh6MbSoU=;
        b=PobTyDyJz5r2yKFm+XklIfqxnlPkc8bAEwBDMoZruIsyf6p9F/mwW4Sgfqdjn4uUPL
         tQD8zW6WuJ27MJfLmGpigZsXzJIgKvyrMm2Dgv5pUCbeQWCsx5yM4kPNewRuqKREZWoS
         It+kKeeXAwBBMMgw5K5U/s7QxISazINrWGPWi5hsxq9h6WMhgcfE39YRWEakJC/EBhBq
         PNaXuAoipKVJJ0jrVUSDUW/AdYKuoXr4oWVi3Zkij5V69KL4dL7WY851qqPUbXZG2/iL
         vHZXxnO9+UM/eA0Dwet8Q+Elbyl+mQabwIGPSn3HqKBT4Hg6tPuM3Pci5JN1rLVWon55
         ov9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hiExCZaPo3J/+jc7V0f+6r0WUVdFU8A2WHBvh6MbSoU=;
        b=t+B/CwzOL3JUrwQHGmlzm+yV42JyhucoJosjpe/3kKB2fpxfxrENUolySup9+yBz8i
         xVhupyQ1/00ulJtj5dm7ksOO9XARxn0GsEqy6mZyzVZneqbB2ykDWUp4dB9GEhxIxi3A
         AK/8KbVjZ8GMqKoJ5xhj27kR+d+2AxfEDA8J7zMRyR2a9241TVxYtc8DrzDMYGxivKer
         E5lQLsfwPz57EWv3mkEwqdvRCB0S1JFWx2SY9rEMWaoNJjL5b5nliY+cLoaPVffhGn2r
         qFsV7UacV4C5i4atkC8fqUNDNacrcsdq5rRP/VYuEzokpaARaOm6/u/mA2FKr8XZ2P+o
         ZXhg==
X-Gm-Message-State: AFqh2kqB3zENsvFgyEV74vX1C7kz3bjDPvhHiCRAz+CPQ1Qtb6Zey2Ks
        0BZZ1VNgGYsjcsHkA1anKfB/C+SvFMM=
X-Google-Smtp-Source: AMrXdXvkaUWihUUZjhdTUVHRsvikxoMczUZetajDGDkYt2kUyfNiKWSlY9shiZQ5yFkCg+CG76gEiQ==
X-Received: by 2002:aca:1c19:0:b0:355:1de8:de4b with SMTP id c25-20020aca1c19000000b003551de8de4bmr1983423oic.36.1671688761444;
        Wed, 21 Dec 2022 21:59:21 -0800 (PST)
Received: from [172.17.0.2] ([40.84.170.16])
        by smtp.gmail.com with ESMTPSA id q82-20020acaf255000000b00360f68d509csm4684453oih.49.2022.12.21.21.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 21:59:21 -0800 (PST)
Message-ID: <63a3f239.ca0a0220.3874e.2e54@mx.google.com>
Date:   Wed, 21 Dec 2022 21:59:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0632780512117669423=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, linux@weissschuh.net
Subject: RE: HID: remove some unneeded exported symbols from hid.h
In-Reply-To: <20221222-hid-v1-1-f4a6c35487a5@weissschuh.net>
References: <20221222-hid-v1-1-f4a6c35487a5@weissschuh.net>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0632780512117669423==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=706392

---Test result---

Test Summary:
CheckPatch                    PASS      6.97 seconds
GitLint                       PASS      2.49 seconds
SubjectPrefix                 FAIL      0.98 seconds
BuildKernel                   PASS      38.63 seconds
CheckAllWarning               PASS      41.68 seconds
CheckSparse                   PASS      47.37 seconds
BuildKernel32                 PASS      37.00 seconds
TestRunnerSetup               PASS      522.93 seconds
TestRunner_l2cap-tester       PASS      18.46 seconds
TestRunner_iso-tester         PASS      20.10 seconds
TestRunner_bnep-tester        PASS      6.85 seconds
TestRunner_mgmt-tester        PASS      125.54 seconds
TestRunner_rfcomm-tester      PASS      10.65 seconds
TestRunner_sco-tester         PASS      9.85 seconds
TestRunner_ioctl-tester       PASS      11.63 seconds
TestRunner_mesh-tester        PASS      8.59 seconds
TestRunner_smp-tester         PASS      9.65 seconds
TestRunner_userchan-tester    PASS      7.27 seconds
IncrementalBuild              PASS      76.47 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


---
Regards,
Linux Bluetooth


--===============0632780512117669423==--
