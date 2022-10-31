Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93CFEFA3744
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 Oct 2022 23:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiJaXK1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 Oct 2022 19:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJaXKX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 Oct 2022 19:10:23 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 967F615808
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:22 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id z9so6990230ilu.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 Oct 2022 16:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=54dZPV8WnJwdMFbPR+7FtVpocZtGBtDYEZcO0zELZoQ=;
        b=AJJND46bkqrPNilKNRVR6MuI2D+vwdgJs9aaC9HFXlQb36qCNioRNLBjeCyhD4VC/K
         KNxi42sO7XG3oDNUF2o4LviP5qATIqa60GeZ4Je0UA18/Hh/PEYw8BQpsIsY6syM8yaE
         2aZxUfW3Dri/MVUgEgrgEjGkplC14S+Bwht0gflp/K9CbksmFwiijLhn5zB6IdIW2jL8
         ghkYvUlCOWgVILec3yxeXyXgWPDvL4bCMHZYzvr3EgetiGWlqZk301WE7QEb9r1tZfm7
         HCYgi1KNU//GZ5gADr9g9QOtpAJMgKuIMjG6GMidXbnR/9Jjs+l/0xFNItN377VDPukb
         9dpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=54dZPV8WnJwdMFbPR+7FtVpocZtGBtDYEZcO0zELZoQ=;
        b=hMOPbeRaaKgEP5a5mYjnPu7e8yTN019b+MzHEPGiZ2kJBF1E1zzH9TnMUttvZGSLzJ
         1e+XHBe3n9CpcE95JO+RswQRsIjMzjweP2mhHsGrB+klHlwUF/5CANnSlUfxSMEuxTNd
         aVRS/YrHEXlpDy08CuGzP41grhjlD/uLNFZ7cxVyju92xkdLcJRl8SMu9lEsuOqZnzJW
         kBTmXGZJsFFNCgKrzBn6SXKtAgK0TYxn7Wn4y0xHwhbvXACCqG5hTcFQzIO3rqFyIwJN
         Tx/YWQWVjZkfvkKzw9jMyT07VI0IEm+4Z0cnNCzZ7UelWDkgRnxXcwlUeoPZo3Rzl+DT
         24Zw==
X-Gm-Message-State: ACrzQf0GkeDz/yK1F0l9Af04BLxxFyEcWx7yq+M58mKeHyV0Ox8llMLy
        mR4X/wPrJxEG4QUCAsTkcdpr/usQfmM=
X-Google-Smtp-Source: AMsMyM57uwZDdaYxj4Wuv0o0EZECXYTf5ZCp7bT0/7S66L9Shm2Zu5b2cDr9A7GLaqPIhrzoPHMorQ==
X-Received: by 2002:a92:c9ce:0:b0:2fc:385f:5ab4 with SMTP id k14-20020a92c9ce000000b002fc385f5ab4mr8587624ilq.78.1667257821858;
        Mon, 31 Oct 2022 16:10:21 -0700 (PDT)
Received: from [172.17.0.2] ([104.43.255.209])
        by smtp.gmail.com with ESMTPSA id q8-20020a0566022f0800b006cab79c4214sm1150414iow.46.2022.10.31.16.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 16:10:21 -0700 (PDT)
Message-ID: <636055dd.050a0220.e9b29.2b6f@mx.google.com>
Date:   Mon, 31 Oct 2022 16:10:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5213637209054951440=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, brian.gix@intel.com
Subject: RE: [RFC] Bluetooth: Convert MSFT filter HCI cmd to hci_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221031220205.91975-1-brian.gix@intel.com>
References: <20221031220205.91975-1-brian.gix@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5213637209054951440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=690652

---Test result---

Test Summary:
CheckPatch                    PASS      1.37 seconds
GitLint                       PASS      0.79 seconds
SubjectPrefix                 PASS      0.73 seconds
BuildKernel                   PASS      36.28 seconds
BuildKernel32                 PASS      32.91 seconds
Incremental Build with patchesPASS      48.56 seconds
TestRunner: Setup             PASS      547.33 seconds
TestRunner: l2cap-tester      PASS      18.57 seconds
TestRunner: iso-tester        PASS      17.49 seconds
TestRunner: bnep-tester       PASS      6.79 seconds
TestRunner: mgmt-tester       PASS      111.09 seconds
TestRunner: rfcomm-tester     PASS      10.77 seconds
TestRunner: sco-tester        PASS      10.26 seconds
TestRunner: ioctl-tester      PASS      11.48 seconds
TestRunner: mesh-tester       PASS      8.26 seconds
TestRunner: smp-tester        PASS      9.99 seconds
TestRunner: userchan-tester   PASS      6.98 seconds



---
Regards,
Linux Bluetooth


--===============5213637209054951440==--
