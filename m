Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBEEAC433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed, 27 Apr 2022 21:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiD0VKq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 27 Apr 2022 17:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237467AbiD0VKA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 27 Apr 2022 17:10:00 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F378F18C
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 14:06:00 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id b17so1930041qvf.12
        for <linux-bluetooth@vger.kernel.org>; Wed, 27 Apr 2022 14:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=D/FBiUTa5BW0feiphcuVsnkjXQEOOp44IIxOW8Oe5EU=;
        b=PVPZOMVV1WyNUWTN176JKIWOKBX52DZzMuD97ZDakiIhLNtZOFxzCqPa23j7ZtXdhu
         eEQlJGpRLQ4guQeamzGS0Q85VsOo37ew1i4k31Rg61cxEY5q+5KTkCFJlgCRTM6oF8eK
         rjy1cAMfenv1WhGvTIM7GhODh/K9GXcwEFxeal9zMqED4UFDdj/dPLXXWDvAlPGSCLfm
         E6KdZZsXWRUEVkP5zquDethVQTm1iBxKCx8Dr49M/WWfK7Rk04R0J93uFqtfvVfZ7l2B
         g3AZoESkP5hJcFwZEQvRYlRP2+HPe3c/VnelCZNMdYQrKbu6+FvFVfNGwFB73drwq3kz
         jggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=D/FBiUTa5BW0feiphcuVsnkjXQEOOp44IIxOW8Oe5EU=;
        b=HTmpnukPe8NBFe9l9wT/9O700Q3QylhG8WGAi8b4iX2wXshMMH3pKXabRq2zV5tq12
         7Yi3S5Lq3oCSWpWHRd04S0EwVZNq9choX6UB/prXRj43b3nC5wvGf+5K9Gqjw0/k/RB6
         1FR1EjOZ0U0VSftI4I6s5h+KSsd8tA2YZZVzBEQYqO/oQPUBBslv+5Mtn/LdfhkQBRgk
         1e0jtK1md5jtNIi6/t84xMarX0UBvqeLJEXWLlw9jJUJc7JzqSH9cxxbKnnVZeYvaZv3
         sQ/a5uWJQrbBU2fpDKc85tVa8HyiVL3dLLKSweaveTt1EIQTjfa/cywVu+nZwYUWZpA7
         8kag==
X-Gm-Message-State: AOAM530WEuwIQTuv1aPKvMJ4Z4l+8AQUPdFDDK+8uhLH6uwshS3o+o8V
        L/PLSs/WZJVCfdhRHQDhBq9qWoB4/SMgqg==
X-Google-Smtp-Source: ABdhPJzI1zrvI4G8r2tBaHj8lY21pR33K5t+1XZtWevOV5m+NYLcgU7hBz3EV7g1Lc0WwUpkV5/DeA==
X-Received: by 2002:a05:6214:c26:b0:446:63cb:35eb with SMTP id a6-20020a0562140c2600b0044663cb35ebmr21335057qvd.63.1651093559637;
        Wed, 27 Apr 2022 14:05:59 -0700 (PDT)
Received: from [172.17.0.2] ([40.84.43.74])
        by smtp.gmail.com with ESMTPSA id s4-20020ae9de04000000b0069c3a577b0asm8523016qkf.51.2022.04.27.14.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 14:05:59 -0700 (PDT)
Message-ID: <6269b037.1c69fb81.fee4.0f76@mx.google.com>
Date:   Wed, 27 Apr 2022 14:05:59 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1742108024668501957=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lnx.erin@gmail.com
Subject: RE: [net-next,v3] net: SO_RCVMARK socket option for SO_MARK with recvmsg()
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20220427200259.2564-1-lnx.erin@gmail.com>
References: <20220427200259.2564-1-lnx.erin@gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1742108024668501957==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=636346

---Test result---

Test Summary:
CheckPatch                    PASS      5.22 seconds
GitLint                       PASS      1.07 seconds
SubjectPrefix                 FAIL      0.90 seconds
BuildKernel                   PASS      31.48 seconds
BuildKernel32                 PASS      27.89 seconds
Incremental Build with patchesPASS      38.28 seconds
TestRunner: Setup             PASS      470.72 seconds
TestRunner: l2cap-tester      PASS      17.48 seconds
TestRunner: bnep-tester       PASS      6.24 seconds
TestRunner: mgmt-tester       PASS      101.20 seconds
TestRunner: rfcomm-tester     PASS      9.74 seconds
TestRunner: sco-tester        PASS      9.47 seconds
TestRunner: smp-tester        PASS      9.56 seconds
TestRunner: userchan-tester   PASS      6.38 seconds

Details
##############################
Test: SubjectPrefix - FAIL - 0.90 seconds
Check subject contains "Bluetooth" prefix
"Bluetooth: " is not specified in the subject



---
Regards,
Linux Bluetooth


--===============1742108024668501957==--
