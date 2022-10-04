Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D25C433F5
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Oct 2022 09:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJDJ3h (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Oct 2022 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJDJ1q (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Oct 2022 05:27:46 -0400
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7741538D
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Oct 2022 02:26:19 -0700 (PDT)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-132b8f6f1b2so285038fac.11
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Oct 2022 02:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date;
        bh=zfwlBO2yhfQ9oRWHj/mtRt5hCUmLvb/1aqIOGset/M4=;
        b=fcZvj2TV7vnRF/IKCYr9E8xt88GEg9rxkypGJ0mvohc8/jAtri6WuE6CEMltZFZVzW
         B/EyI8kQ5AaxIHItfID5Qo3mXeDWJrDdo47nD/ZesKEjOoZLbD4lVbu0KbNgtfwRX0ds
         F/s0/9qxjglobHF4c0bI/Bt8rpcMI7VREutM312AJ8da4Y2f8+QbulBiBZqoMMXE2svo
         LLfDUZI2LmYO8siINQp0QmGqcsANKvyw0GJPbHfHK4FcSz0+aFiAfE4rFjPeW4bCNID2
         8sLMMdPhRGxCXrrcXuJXWszO1YTIEWNRPVtC73As5H1c/nvPW/aSCP1kws/M5nbdU1VK
         8RWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=zfwlBO2yhfQ9oRWHj/mtRt5hCUmLvb/1aqIOGset/M4=;
        b=xVqQfYS5zwUlfIYF3Ez4aIW14soRdR72iopex/Z3FfKUOUWsgqlzX/m6OpnMHJnk30
         /s6CguPGflaNt6yw9NJ+5WGf3PYtyLUdsG5TJmS1daqzwlQkBhDqRufn+tLUTeK5AAFA
         aTG94GoDVH338NZ0Ol54tQRfLM8LPc4ATJNRFRpM3iy4skNOMLanq2qiCEuOAOHqWmZB
         c67N7+JOxRJgEUOhJWo5Sbmh6LJqd/rRosLIvvIuLz9a6nxJWkl0GTsfGbDnzvt7cI1m
         rLgaO4UFZn/hfztEbr2o9MdbIBZYQ3r9uj6X9gPuhlkHTAlcC7ccSVY5zfjvNQ/gBCEk
         J11w==
X-Gm-Message-State: ACrzQf3uwDUhe8oaGA9SJoMdpQJ4zgpTO6VLnyTwmm581fT2/lobfhnx
        G4TvNE1dD69o0DkEju51TeRYt+sxKHA=
X-Google-Smtp-Source: AMsMyM640XOXBDtxw2FesTdnatEqeLYNQvG1j+b+kjnBN3RDtznUAahn93nLmSYLFtvt/hiBnHfqTQ==
X-Received: by 2002:a05:6870:e308:b0:131:74e0:d6a7 with SMTP id z8-20020a056870e30800b0013174e0d6a7mr7953387oad.77.1664875578561;
        Tue, 04 Oct 2022 02:26:18 -0700 (PDT)
Received: from [172.17.0.2] ([13.65.170.132])
        by smtp.gmail.com with ESMTPSA id m9-20020a056870a10900b0012c52bd4369sm2903079oae.19.2022.10.04.02.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 02:26:18 -0700 (PDT)
Message-ID: <633bfc3a.050a0220.f1a41.8651@mx.google.com>
Date:   Tue, 04 Oct 2022 02:26:18 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4748548329657680672=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Bluetooth: btusb: Introduce generic USB reset
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
References: <20221004163224.1.I46e98b47be875d0b9abff2d19417c612077d1909@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============4748548329657680672==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=682932

---Test result---

Test Summary:
CheckPatch                    PASS      1.62 seconds
GitLint                       PASS      0.74 seconds
SubjectPrefix                 PASS      0.63 seconds
BuildKernel                   PASS      42.93 seconds
BuildKernel32                 PASS      39.54 seconds
Incremental Build with patchesPASS      55.77 seconds
TestRunner: Setup             PASS      643.76 seconds
TestRunner: l2cap-tester      PASS      19.50 seconds
TestRunner: iso-tester        PASS      19.73 seconds
TestRunner: bnep-tester       PASS      7.72 seconds
TestRunner: mgmt-tester       PASS      124.90 seconds
TestRunner: rfcomm-tester     PASS      12.48 seconds
TestRunner: sco-tester        PASS      11.55 seconds
TestRunner: ioctl-tester      PASS      13.47 seconds
TestRunner: smp-tester        PASS      11.79 seconds
TestRunner: userchan-tester   PASS      8.33 seconds



---
Regards,
Linux Bluetooth


--===============4748548329657680672==--
