Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA02AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 17 Jul 2022 14:04:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233102AbiGQOE2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 17 Jul 2022 10:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233098AbiGQOE1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 17 Jul 2022 10:04:27 -0400
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7066A13E2F
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Jul 2022 07:04:26 -0700 (PDT)
Received: by mail-il1-x134.google.com with SMTP id r4so649847ilb.10
        for <linux-bluetooth@vger.kernel.org>; Sun, 17 Jul 2022 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=9eNsrk0dKkLmfftdJt5rrWXDWUpVCPR2pReXymCbUCQ=;
        b=gzJlnbScD0yE9c65ihhobOmEkwBkBlerIk4vkbqN7PhBpbDvp4awviobQHz7nWc9t8
         ntoYvsP0Deu3gxp4WStw6LG4rBJKalM1zM0HNUgfFdjdkVDxyljjQbbvIOW/KRvwdmhb
         pvwdx3My7tYG4LH1qLBFWTW0JaWrUkRrtQlZTvoB8JZN36a2XODvkXgfvHutP5yPe0E4
         Xbm9zSqvWOaLwSXRM5Tvcump9ENrWBOXZ0DX7ZE7P1TD5swihSExtJrzAQo5u/cduvl+
         rw7PrveEj/dhmTHNUoodMMO3JjFjalWummpKoG6WcZrLUHdvAEIweLhYXs3QvP9sNXsb
         Dsqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=9eNsrk0dKkLmfftdJt5rrWXDWUpVCPR2pReXymCbUCQ=;
        b=8Pl98Q9hNsCJV8jgC0vX8pqysTh3c/Dzn4+olyXuWPIgbkh3QIa8IeqdwqZgUbM5Wd
         s1ZiMzzx64tOc5hNdEvWfK4BEsZGxd5ttAhsELMaZUGrzMMUs849yVBw+ft4DA6zvIdo
         uT8U9/mJ7ZqNmHzRu8xiawhJdnnhmzZFAn0E8xHx1Pzn+CLZxl4xVBUqeD8XVMC74g7/
         9xaDZUJSpysd2nri9ViV9HWBj8VSBQmTSF6Fi5Qx2aVbsK0aW9ucx9FNghHrj6dtrYy6
         8sNb3Le3d3fjK4iNYp5aCT2a/SmJFduNM76f+gr46lWILTgInvayOy5JYnfD1bOcImaI
         A0xA==
X-Gm-Message-State: AJIora8sPsDX6yo3HfzYT3mofJR2xu/gfWvQ6G5aDi+naiMYQMnAAp+T
        vm6lLADFt/IdA/x4vfCiu5eb9oDOmT0=
X-Google-Smtp-Source: AGRyM1tQpnFvNzBr2vsb6siXWd9IrfP0VIZ0VZ36vIFEEXEFa9Xyc4W7LUuiBXActXdn3quDIJPT9g==
X-Received: by 2002:a92:6603:0:b0:2da:82b6:34a3 with SMTP id a3-20020a926603000000b002da82b634a3mr11514404ilc.250.1658066665482;
        Sun, 17 Jul 2022 07:04:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.173.131.15])
        by smtp.gmail.com with ESMTPSA id t1-20020a056e02060100b002dc251040besm3789337ils.46.2022.07.17.07.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Jul 2022 07:04:25 -0700 (PDT)
Message-ID: <62d416e9.1c69fb81.b292d.39c4@mx.google.com>
Date:   Sun, 17 Jul 2022 07:04:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6323641962129503077=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, khalid.masum.92@gmail.com
Subject: RE: Bluetooth: hci_core: Use ERR_PTR instead of NULL
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220717133759.8479-1-khalid.masum.92@gmail.com>
References: <20220717133759.8479-1-khalid.masum.92@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============6323641962129503077==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=660435

---Test result---

Test Summary:
CheckPatch                    PASS      1.44 seconds
GitLint                       PASS      0.84 seconds
SubjectPrefix                 PASS      0.65 seconds
BuildKernel                   PASS      31.55 seconds
BuildKernel32                 PASS      27.58 seconds
Incremental Build with patchesPASS      37.85 seconds
TestRunner: Setup             PASS      468.67 seconds
TestRunner: l2cap-tester      PASS      16.39 seconds
TestRunner: bnep-tester       PASS      5.54 seconds
TestRunner: mgmt-tester       PASS      94.94 seconds
TestRunner: rfcomm-tester     PASS      8.95 seconds
TestRunner: sco-tester        PASS      8.67 seconds
TestRunner: smp-tester        PASS      8.79 seconds
TestRunner: userchan-tester   PASS      5.78 seconds



---
Regards,
Linux Bluetooth


--===============6323641962129503077==--
