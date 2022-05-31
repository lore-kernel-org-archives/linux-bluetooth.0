Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF964C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 31 May 2022 04:30:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243815AbiEaEae (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 31 May 2022 00:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243803AbiEaEad (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 31 May 2022 00:30:33 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A77179830
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 21:30:32 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id 2so13033640iou.5
        for <linux-bluetooth@vger.kernel.org>; Mon, 30 May 2022 21:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=92AYJkWDZNQ135tvWS8vIFVCbDyd0llTocB6Lz09eGc=;
        b=hyCcu48udfSITyKQRJCqpb9FdpLZUvWxRtPm8EZUiuZiBrXfHhByEIUzofMlhBS2LZ
         JZ19x/ZwI03+S1jFvk5W21YteDTkNJY7Lv3ym1tYmkH1Gi8d/tDkaKMfOC3+WlhuAH7n
         GHYZG1UmPMInuUd5Z2H+y2knXlkfl8PZM5QAOCv4ttCQtMmxSi4luX7+2/X3m+A264UG
         2IkJAnMWKuvsiHEo3MFEsHtx/EwUZT0nBhpxrHmAMc92a+PctI0eld7ESDqth8NllBuY
         hySOODXu3pWYHAgAfPSPRMkAkq1ZuWQlsCeUIunQv+ZjxcMpqoMT2qkq/M3LrIJ5qv/v
         Ohbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=92AYJkWDZNQ135tvWS8vIFVCbDyd0llTocB6Lz09eGc=;
        b=NOK/hBhcRlKZAPZm5VtVF56fHEAJqMzzDyqTKf76fH4xfZhuC/XKsFYW1H8Qa3dyGy
         5Addw8GFJESXrDPGpQtNO+VMONRTcZvmdWeMLZal/g1z3iBGVbtJP92QV/4sTj21jkvq
         KGuaWQM3IvtTKahspFh4HItIaeRuLRT0ukm0w/yEEIoZxJjuBrTFmn8ohX5rv/HTz/Ua
         fl7VIXNrwxycPCgMm0iqHdZwNmT7TEfTtixfP89EL76zlG8djPUm1AV9q9osMPnfx5Z1
         eJgpWd5e/PQ4d7tI3D/OE1a0qprmkSCgaxOF5tvrZSYdT9JU0MGg7zh1rFBJVEkFzmFd
         yNBA==
X-Gm-Message-State: AOAM5338uFOvpCMrz0UKAvbslLOhmf5RIElpkt3OJB3KZ2kx98bpSH3o
        6VAwCQN7VwTbtowvyG8tqjf662tu3PE=
X-Google-Smtp-Source: ABdhPJzsnlXbIFi5QR7oQx/CR7Byg+RlfW5HFJH6RsCWJiQkkhUutk0KSsAqNMJgXJP5L5RbN52BUA==
X-Received: by 2002:a05:6638:1392:b0:32e:c7b8:9add with SMTP id w18-20020a056638139200b0032ec7b89addmr20828824jad.12.1653971431507;
        Mon, 30 May 2022 21:30:31 -0700 (PDT)
Received: from [172.17.0.2] ([40.83.18.50])
        by smtp.gmail.com with ESMTPSA id x18-20020a927c12000000b002d149ec2606sm4249667ilc.65.2022.05.30.21.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 21:30:31 -0700 (PDT)
Message-ID: <629599e7.1c69fb81.7d8f0.05fa@mx.google.com>
Date:   Mon, 30 May 2022 21:30:31 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6525182973425454072=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiasheng@iscas.ac.cn
Subject: RE: iBluetooth: hci_intel: Add check for platform_driver_register
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220531033228.1939386-1-jiasheng@iscas.ac.cn>
References: <20220531033228.1939386-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6525182973425454072==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=646117

---Test result---

Test Summary:
CheckPatch                    PASS      1.34 seconds
GitLint                       PASS      0.82 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      31.17 seconds
BuildKernel32                 PASS      28.05 seconds
Incremental Build with patchesPASS      38.45 seconds
TestRunner: Setup             PASS      474.59 seconds
TestRunner: l2cap-tester      PASS      17.13 seconds
TestRunner: bnep-tester       PASS      5.99 seconds
TestRunner: mgmt-tester       PASS      101.65 seconds
TestRunner: rfcomm-tester     PASS      9.53 seconds
TestRunner: sco-tester        PASS      9.37 seconds
TestRunner: smp-tester        PASS      9.39 seconds
TestRunner: userchan-tester   PASS      6.38 seconds



---
Regards,
Linux Bluetooth


--===============6525182973425454072==--
