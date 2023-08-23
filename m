Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 250EDEE49A0
	for <linux-bluetooth@archiver.kernel.org>; Wed, 23 Aug 2023 04:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjHWEpL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Aug 2023 00:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231565AbjHWEpK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Aug 2023 00:45:10 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D9CF1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 21:45:08 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6b9e478e122so3729221a34.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 22 Aug 2023 21:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692765908; x=1693370708;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AZzdv5G3vCdge4p6g4h4iVsjrJNucOzICG6mQwfWhBA=;
        b=mdoN5jbe3Qhst9n7/lCkeAXxsP24vOv2pNxg5xhvz4hASG4GIXvQNpqQhMrlunjj0U
         cE60odI2mUdiybBl62r1GrOe/4Pc+dZLzH4TXVsmmlf1+GT1o1skTUN3BwowSdIezGy+
         zgF4ygXgEP/6+fNvUx2n6OqcD4Fsc8wbk6VpVLLeUXeGgv6BW+Vvtv5FC+FCufEkekaC
         bSArKZsicRMeKLWteJlqggAg5P7y5L1qERkPz722ktMDjuVJCpTgl5GGWY+meIE+yU+c
         27eohLfs/PdFqDPHg3npz0F4GDv2k0vmHxGjaWkqMnJZ2uCf11USSN/cM2iYonqZHlBU
         bDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692765908; x=1693370708;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AZzdv5G3vCdge4p6g4h4iVsjrJNucOzICG6mQwfWhBA=;
        b=LHgA09FhqFTZIRsjkMD0XdjUzHqWLLIWFkLrZlwdGDoqFKX+fUCL6yc2pOAGPwUJjR
         LAEMYFHctt07CC6P289riw7Mc6K5MbK39qPVZxAVc5GGUnEfeUrBtRs8Cxot2lB/PjnE
         a7V9yTVvi/bi5K207huejNgicj64RhJGfny41Y7nGzpz5KEf6mG4w/Uw2O/DBo2cSpkW
         /rTns97gzdsYr5pjKzYJiBSQfO50YVS2oMQM4aeqIQdbOqGYVi6LI0OvVoZlcrQ1jOO9
         m62zONFMQ8wbTRnOuJIDUdm1zctepr3doC4rnNFigseN621jFopELVy/N5tI3/BlnWmT
         /uNQ==
X-Gm-Message-State: AOJu0YwiUPHdX62PjQ3bZ+X6luqNfItW8IyJfWD4SUzUWSs6bU0rAxcB
        oRmTNSQTz4lPCzxBSltosqMeFMTBYfc=
X-Google-Smtp-Source: AGHT+IHVPhTsX4g/7aMkK3ksqMpckEf0+/u4DpL0VYDXPUTej7BCBXBVAKQHV4T6O2cASkFJiH2ksg==
X-Received: by 2002:a05:6870:332a:b0:1bb:a3a8:c7c1 with SMTP id x42-20020a056870332a00b001bba3a8c7c1mr13413880oae.24.1692765907956;
        Tue, 22 Aug 2023 21:45:07 -0700 (PDT)
Received: from [172.17.0.2] ([157.55.189.31])
        by smtp.gmail.com with ESMTPSA id n10-20020a9d740a000000b006bc8b4a41dfsm5290019otk.3.2023.08.22.21.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 21:45:07 -0700 (PDT)
Message-ID: <64e58ed3.9d0a0220.4522.d7d7@mx.google.com>
Date:   Tue, 22 Aug 2023 21:45:07 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3898939270403852817=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ruanjinjie@huawei.com
Subject: RE: [-next] Bluetooth: btusb: Do not call kfree_skb() under spin_lock_irqsave()
In-Reply-To: <20230823034638.1281539-1-ruanjinjie@huawei.com>
References: <20230823034638.1281539-1-ruanjinjie@huawei.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============3898939270403852817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=778416

---Test result---

Test Summary:
CheckPatch                    PASS      2.85 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      43.27 seconds
CheckAllWarning               PASS      47.99 seconds
CheckSparse                   PASS      54.20 seconds
CheckSmatch                   PASS      148.09 seconds
BuildKernel32                 PASS      43.00 seconds
TestRunnerSetup               PASS      650.12 seconds
TestRunner_l2cap-tester       PASS      37.65 seconds
TestRunner_iso-tester         PASS      86.17 seconds
TestRunner_bnep-tester        PASS      15.61 seconds
TestRunner_mgmt-tester        FAIL      272.34 seconds
TestRunner_rfcomm-tester      PASS      22.86 seconds
TestRunner_sco-tester         PASS      26.37 seconds
TestRunner_ioctl-tester       PASS      25.81 seconds
TestRunner_mesh-tester        PASS      20.55 seconds
TestRunner_smp-tester         PASS      20.60 seconds
TestRunner_userchan-tester    PASS      16.39 seconds
IncrementalBuild              PASS      40.19 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 496 (99.8%), Failed: 1, Not Run: 0

Failed Test Cases
LL Privacy - Unpair 1                                Timed out    2.104 seconds


---
Regards,
Linux Bluetooth


--===============3898939270403852817==--
