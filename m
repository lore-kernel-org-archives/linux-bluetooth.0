Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856F2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 09:04:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbiBXJFX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiBXJFX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 24 Feb 2022 04:05:23 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F641A617E
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 01:04:53 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id n185so1245560qke.5
        for <linux-bluetooth@vger.kernel.org>; Thu, 24 Feb 2022 01:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=lRQRGddvzGu/DT2ux3P4wbJ6OTQ/qMvpmDenLa/xXaU=;
        b=lweCX9Dng9mDyXlX7Uai3gy24kMfaNaydpMGgEea5NrDk3iZuwV9bgJ5lGB9hgtvMU
         AQErw2WEK/AbIrSKcVObTz12bZ2GSYEg5hkHaXSgqZdMj7N3f/mpqeBFo0UZ8iMH9a/+
         VT2FLVNz7cn5zoblmFWabTW6eEiihmu5qmO+W4+3Di+rdl+PSz5oLOSpXyatfgiSfWe4
         SPT5RXPiAEThDpGlit/hfIB8s8n+JA0xX9lKP2u1ULFKQO8QfCM8U4BzO/wjpTB33kYh
         bCRUbl8YvdV4ryR2kw/Wttz5nRP6oeAz0QuYUaqPGYbZg1i2m/A8YaV7OnkMaR7snS6/
         S1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=lRQRGddvzGu/DT2ux3P4wbJ6OTQ/qMvpmDenLa/xXaU=;
        b=0Bb+jDhc8Tjtcl21Upl/FMbGqaZryG/mFlV65RHtFTbRB9tu2NYkQ5uuXOJJxIJcTV
         5YD6WZeF7BVuGhmfzGyHuGGBPXxz4nwhiEXMIKVhNysJ2HpttACJzj/6x2+j9ajYl+IZ
         o3mSfWF9Ql4bZmPxyDuWq7HlBOwb3gOTph/WoqOR1tPGZebFM9MN8JBHAWshgKra8XsX
         tiMKBNjYLEfMdinfj67Fg0EgcbOsIdKkl4M3/a8DGTAwamrVho7sFV8KE25A/SaUnEel
         IUticyCIiOaYR6Lkw6UkOM0PIkpCqVjG2MwBGM79yC8MlEUB2MyW0FoNCVRE+QjJCBla
         NQEQ==
X-Gm-Message-State: AOAM533JUD5ns6JDjfFlqkgmjxsEa5SbKO+VOg+buw62tclTR9a+er4N
        fhHBixJrmvAEM8SGRJZOf2mzyYZEQ6DCgQ==
X-Google-Smtp-Source: ABdhPJycuhWl20IDNUQTn8r2e3n7HcmFjdZ6IwuV8iVRpRYnq44uVBp7gsyb3ALdEhH1iPxeu5+R4g==
X-Received: by 2002:a37:386:0:b0:649:aa0:cf08 with SMTP id 128-20020a370386000000b006490aa0cf08mr952126qkd.381.1645693492749;
        Thu, 24 Feb 2022 01:04:52 -0800 (PST)
Received: from [172.17.0.2] ([20.57.115.70])
        by smtp.gmail.com with ESMTPSA id q12sm1084093qkl.78.2022.02.24.01.04.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:04:52 -0800 (PST)
Message-ID: <62174a34.1c69fb81.50633.6bb9@mx.google.com>
Date:   Thu, 24 Feb 2022 01:04:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0462205618538615717=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: Bluetooth: hci_sync: Fix hci_update_accept_list_sync
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220224080219.38653-1-luiz.dentz@gmail.com>
References: <20220224080219.38653-1-luiz.dentz@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0462205618538615717==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=617449

---Test result---

Test Summary:
CheckPatch                    PASS      1.64 seconds
GitLint                       PASS      0.95 seconds
SubjectPrefix                 PASS      0.87 seconds
BuildKernel                   PASS      32.63 seconds
BuildKernel32                 PASS      27.62 seconds
Incremental Build with patchesPASS      37.65 seconds
TestRunner: Setup             PASS      511.88 seconds
TestRunner: l2cap-tester      PASS      14.90 seconds
TestRunner: bnep-tester       PASS      7.02 seconds
TestRunner: mgmt-tester       PASS      116.05 seconds
TestRunner: rfcomm-tester     PASS      8.99 seconds
TestRunner: sco-tester        PASS      9.00 seconds
TestRunner: smp-tester        PASS      8.50 seconds
TestRunner: userchan-tester   PASS      7.13 seconds



---
Regards,
Linux Bluetooth


--===============0462205618538615717==--
