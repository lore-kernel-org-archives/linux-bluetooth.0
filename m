Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC49C19F28
	for <linux-bluetooth@archiver.kernel.org>; Wed,  3 Aug 2022 11:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231706AbiHCLHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 3 Aug 2022 07:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiHCLHF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 3 Aug 2022 07:07:05 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C71A721A2
        for <linux-bluetooth@vger.kernel.org>; Wed,  3 Aug 2022 04:07:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 17so597914plj.10
        for <linux-bluetooth@vger.kernel.org>; Wed, 03 Aug 2022 04:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc;
        bh=dwz/cL4JGBJfRGPZfHkVvPx2aT0sx0e1UkX6HxoG63w=;
        b=kwj9aPujrbg0xlgzuCsyVfVmsDkg5dz5k+oVgm1dqfyUiBfIPgTSjEDFZDcyEGLtwS
         FQaCn3QvBpPUfzVMW7AdzmoPaV0qrR0aRK0D/I5gOa2lV22EgiKwlmXr57pfNxi5lXCO
         RTwyAINSVLxjHlF4iIRypeLS4kUEYQMUw54XQ8ik0o8Q34N3lj0bbLqQEhBSPyoAGnKS
         /w7evU5jofUqhhNP/nRzrxERJxy2CpgorEF3LiIlwsX9uFvby34rVelkGpdyi4wz2Lum
         hIqYJy+85l7VAvcXOFffM19vvla9rw0517zGA0s3iLSucKVFCG5Ofw4WKWLQJTZ2U0ao
         32Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=dwz/cL4JGBJfRGPZfHkVvPx2aT0sx0e1UkX6HxoG63w=;
        b=2yYoGlHI2coVTdiFER5yXafQ05hL1NFCoPGrmk2NUmCOL4YczSYhvmQMaKgCbXKC78
         usGkiwlxkGuO6uShL4dmO17OymhVBZ5uGwLl8unXXt+FhmWE2IRp3CvOLW5lKO5eACr/
         E0utLRgRKieNhY7Bax7qFpCQlF9tMCZPPNunbKmRQUwJDTjujXW1yB/u+0jhuxYoOqq6
         biCWUbIAc2XMyc6PZW0/qmTiXzs+rmbbtxE3e8EYYhetXh+gboHnN0IYm3JgcRM4oiuj
         7m12SKKsBtJxi94qUdJcXOzoAEJVyfa+iUEynxRAUsq0QxRXx0bT2SbcP3xKv4eQs4IY
         eeqQ==
X-Gm-Message-State: ACgBeo0CFPeLMzs5qkT6B7kUuWnkFoazW0dIDpiZUnJVJZzkYDKtnSSm
        CdwmhFdqXqImphPo40AY9XwES4nlCI8=
X-Google-Smtp-Source: AA6agR6LaeJ2U1g+8t9/VsA0ZsYY+jlZiTg7yoVg6PlKfwPuom0lXC/NIc205uT6DvLmQzA1ro3oPA==
X-Received: by 2002:a17:902:b20d:b0:16d:aefa:8ef6 with SMTP id t13-20020a170902b20d00b0016daefa8ef6mr25913517plr.90.1659524821898;
        Wed, 03 Aug 2022 04:07:01 -0700 (PDT)
Received: from [172.17.0.2] ([20.25.140.33])
        by smtp.gmail.com with ESMTPSA id f11-20020a17090a664b00b001f510175984sm1277837pjm.41.2022.08.03.04.07.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Aug 2022 04:07:01 -0700 (PDT)
Message-ID: <62ea56d5.170a0220.5a780.1e59@mx.google.com>
Date:   Wed, 03 Aug 2022 04:07:01 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8954302548074304302=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, ismael@iodev.co.uk
Subject: RE: [v2] Bluetooth: hci_sync: Fix opcode format in debug message
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220803094933.20984-1-ismael@iodev.co.uk>
References: <20220803094933.20984-1-ismael@iodev.co.uk>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============8954302548074304302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=665046

---Test result---

Test Summary:
CheckPatch                    PASS      1.20 seconds
GitLint                       PASS      0.54 seconds
SubjectPrefix                 PASS      0.42 seconds
BuildKernel                   PASS      34.18 seconds
BuildKernel32                 PASS      28.84 seconds
Incremental Build with patchesPASS      40.61 seconds
TestRunner: Setup             PASS      482.93 seconds
TestRunner: l2cap-tester      PASS      17.02 seconds
TestRunner: bnep-tester       PASS      6.19 seconds
TestRunner: mgmt-tester       PASS      100.22 seconds
TestRunner: rfcomm-tester     PASS      9.49 seconds
TestRunner: sco-tester        PASS      9.26 seconds
TestRunner: smp-tester        PASS      9.30 seconds
TestRunner: userchan-tester   PASS      6.41 seconds



---
Regards,
Linux Bluetooth


--===============8954302548074304302==--
