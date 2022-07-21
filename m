Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB58BC43334
	for <linux-bluetooth@archiver.kernel.org>; Thu, 21 Jul 2022 00:09:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbiGUAJ1 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 20 Jul 2022 20:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbiGUAJ1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 20 Jul 2022 20:09:27 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C1C74E0E
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 17:09:26 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id k25-20020a056830169900b0061c6f68f451so11580otr.9
        for <linux-bluetooth@vger.kernel.org>; Wed, 20 Jul 2022 17:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=Q23TsMNUauDXsUNFUCBC5sl2WEZhIXa1eCgkeEVUPzU=;
        b=MRGfboke6mCm0dP1ZgAEAVtm407DG9ekky6SLEXLaYJiGAb4JJ0zvG559umiKNDNEV
         R64Bm2QX+E1JozB2UZNA6Jc2RK3QSFRIw5alRl8H/+HWEcq/Owvk+BD5ig7stGaCkcZ3
         0OoT6FCmF2QU6MtRkJr8hpCSfykDUKEKhNYAP3t3ov269zigYBvJFXWklYSBxurw0prh
         73AEhFRPSvDzJzxNfuq+iiGYIyYCTBOQETkii/oMMUzYVoAYUVRjaaTHb3ahQB2MF6rW
         WO3zMNTTauS6V9BlAL8QZgpOZcKV4WQyGA6deQVk/Ra+x6IGulwGdPy13emg2Uzm+9vb
         W/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=Q23TsMNUauDXsUNFUCBC5sl2WEZhIXa1eCgkeEVUPzU=;
        b=fpOZDcT9FQNxJT+WOir7bHSo0uwp+z4bbFDzSF50x4htmFM1Dg4Vh+VI00fp6IIHL/
         QOH9rSPgFLH8abjiukYqyDvafBVjFTmcYt9Q2lEO7rSG+8NzYwd9k3kW6HMb2zXN0JOW
         IAVbwqhGBjovHYTnPGvEIx1EPCU/pqZS4dIZIqBwbJkN/ekgW03iD/LJcF/1MLskrmsy
         vvt4T8F82EUbU1OYauZHwSmazXMfmPGMB/te4ALTZPaqXfGFpWg7LvJk7kD4iAdK7h6x
         ykJcrgHRMu4tYcNi7RPJ4eAEQ1af9v9RyJWgaxigW0zID0kiqCbwudIfsmM/t97Brhrt
         8bgw==
X-Gm-Message-State: AJIora9IeF0Fk2CY1DzdGr+HB2MhM1dUeETDQWBrLaEOjjPuRw1bXf6q
        ZjnimetAABv9bOPM2irCHqZFFOejHuw=
X-Google-Smtp-Source: AGRyM1u2fO+rLhLKcdwcUyULS8LOwzUZf4EYT8GJ7eLcIcDAI4QwcSAHBpeUA4NI6pBKv7BXfFU69A==
X-Received: by 2002:a9d:6e84:0:b0:61c:8fdc:de7c with SMTP id a4-20020a9d6e84000000b0061c8fdcde7cmr10454127otr.334.1658362165449;
        Wed, 20 Jul 2022 17:09:25 -0700 (PDT)
Received: from [172.17.0.2] ([52.171.221.38])
        by smtp.gmail.com with ESMTPSA id n10-20020acabd0a000000b0033a80567b7asm58861oif.46.2022.07.20.17.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 17:09:25 -0700 (PDT)
Message-ID: <62d89935.1c69fb81.fb8c1.037a@mx.google.com>
Date:   Wed, 20 Jul 2022 17:09:25 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9096080418897784158=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, mmandlik@google.com
Subject: RE: [v2,1/2] Bluetooth: hci_sync: Refactor add Adv Monitor
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220720162102.v2.1.If745ed1d05d98c002fc84ba60cef99eb786b7caa@changeid>
References: <20220720162102.v2.1.If745ed1d05d98c002fc84ba60cef99eb786b7caa@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============9096080418897784158==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=661630

---Test result---

Test Summary:
CheckPatch                    PASS      4.71 seconds
GitLint                       PASS      1.64 seconds
SubjectPrefix                 PASS      1.55 seconds
BuildKernel                   PASS      44.64 seconds
BuildKernel32                 PASS      39.90 seconds
Incremental Build with patchesPASS      92.10 seconds
TestRunner: Setup             PASS      669.01 seconds
TestRunner: l2cap-tester      PASS      21.49 seconds
TestRunner: bnep-tester       PASS      7.88 seconds
TestRunner: mgmt-tester       PASS      125.69 seconds
TestRunner: rfcomm-tester     PASS      11.54 seconds
TestRunner: sco-tester        PASS      12.25 seconds
TestRunner: smp-tester        PASS      11.31 seconds
TestRunner: userchan-tester   PASS      7.82 seconds



---
Regards,
Linux Bluetooth


--===============9096080418897784158==--
