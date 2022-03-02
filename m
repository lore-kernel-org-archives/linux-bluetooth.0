Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53313C433F5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  2 Mar 2022 14:10:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242779AbiCBOKw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Mar 2022 09:10:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCBOKu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Mar 2022 09:10:50 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80B89C2481
        for <linux-bluetooth@vger.kernel.org>; Wed,  2 Mar 2022 06:09:51 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id f4so1178694qvd.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Mar 2022 06:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=zrUawacDijnh4O5vC6iZGfb6nFIfCw8xS6BZUXH3lyg=;
        b=TIf2Gbxtpz37yk66NfJi6yuKHr6BBzFPYtOxepSa0eDFhoSw1EwE8+Dud1d3OBFlHG
         gj/Kg/xvC75o4lu6adT8v4nHUf9hqlGboU6z26cPC6figB26zjRrzMbiud2mwOGQPWnH
         QO0utzsBM2wrTN3OYdsrN8fpjvW7KU2532ru0ibPk+MKdMT9INin57bzAQcxVQiWnLQA
         pWD+SA18rieKZKY2HKRDv/4cnsMpTR3r1DQKyyIBgbvwl70UpwLFfFZ/63kW4Iu91t1P
         qOFF1sbjfzbIABxaR0GeZ7rjAmnu1MV35DvucCTJKBf2dsn8iSroYOBOp491MMm4hawQ
         61CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=zrUawacDijnh4O5vC6iZGfb6nFIfCw8xS6BZUXH3lyg=;
        b=iDs47uXZqlZQB1V5k/km9JQYYurJiK8AX8rwnkq/np3RBllnqxoNZTtITjfAQUn6ER
         Wn674taoTMjcqHbAnmSyJ/3cM3PP906D0PT3eqBPrt7UURxcjWLAs9vdT8fygnfDX/aW
         IsBrq/7y4hqDV7QqWPrnAJ2USr1lPULXYVVpkXzaVPie4xDoUyJTqfNdUyQEmDQXPyvy
         MsWni5XgKpxMWxjs5cFXILVBUIdI85VccKRY0Uzk3Snmt+WL8OrJzG0bCGHE09iWGu5H
         PuxgqJV32qi53JEshcSA9+00XGeFAa9ThghrfCcTw5h9NnOFdcqyQ/skd0/Jm6gCYOD8
         aucw==
X-Gm-Message-State: AOAM531wsCw8CoEYhdNb1Xh1V4him9sH25z0OpHkL9owDumAT+iADzrD
        C2+U6tk198KJa3cWjN+iK6bd1+sJKvo=
X-Google-Smtp-Source: ABdhPJwjt8Tkv8kb9rge556vZAY3mlL+j+DcPBT5kIB4t95DgbwfNmlxmfwyVMwkATZ7hy78Ve1i8w==
X-Received: by 2002:a05:6214:27e4:b0:42e:a257:b77c with SMTP id jt4-20020a05621427e400b0042ea257b77cmr21042103qvb.62.1646230190289;
        Wed, 02 Mar 2022 06:09:50 -0800 (PST)
Received: from [172.17.0.2] ([13.82.126.25])
        by smtp.gmail.com with ESMTPSA id s19-20020ac85cd3000000b002de4e165ae0sm11290349qta.75.2022.03.02.06.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 06:09:50 -0800 (PST)
Message-ID: <621f7aae.1c69fb81.1e0a4.91fc@mx.google.com>
Date:   Wed, 02 Mar 2022 06:09:50 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============4429384641586876618=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, hdegoede@redhat.com
Subject: RE: Bluetooth: hci_core: Fix unbalanced unlock in set_device_flags()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220302134439.515377-1-hdegoede@redhat.com>
References: <20220302134439.515377-1-hdegoede@redhat.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4429384641586876618==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=619579

---Test result---

Test Summary:
CheckPatch                    PASS      1.68 seconds
GitLint                       PASS      0.97 seconds
SubjectPrefix                 PASS      0.85 seconds
BuildKernel                   PASS      36.20 seconds
BuildKernel32                 PASS      31.72 seconds
Incremental Build with patchesPASS      43.70 seconds
TestRunner: Setup             PASS      564.00 seconds
TestRunner: l2cap-tester      PASS      15.37 seconds
TestRunner: bnep-tester       PASS      7.22 seconds
TestRunner: mgmt-tester       PASS      117.53 seconds
TestRunner: rfcomm-tester     FAIL      9.09 seconds
TestRunner: sco-tester        PASS      8.99 seconds
TestRunner: smp-tester        PASS      8.92 seconds
TestRunner: userchan-tester   PASS      7.47 seconds

Details
##############################
Test: TestRunner: rfcomm-tester - FAIL - 9.09 seconds
Run test-runner with rfcomm-tester
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Basic RFCOMM Socket Client - Write 32k Success       Failed       0.188 seconds



---
Regards,
Linux Bluetooth


--===============4429384641586876618==--
