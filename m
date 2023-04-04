Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E0BFC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 Apr 2023 21:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjDDVec (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 Apr 2023 17:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235705AbjDDVeb (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 Apr 2023 17:34:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D83530C1
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 Apr 2023 14:34:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so37547331pjp.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Apr 2023 14:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680644069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4wJuw9pxzC92GYgo8I2hxvInPBsO21ek6MWQhSnraN0=;
        b=Ia17amrlYf6RU6lP+3HXeaL5KXTUq6GSqG7SHPlmyDnjGdlj4NkwYHPMmjsKXaEH21
         +oidkcGuxsbo259900wofKpkPMbo7izgVxWosN0bDU2li9p7HThWeqZwxlPMFQp7YISJ
         T1vgxuf7cj8pH3Kwrpff9nY81V7hmCqoHBOOq51j2px5tT/3oWG52WhSbIW3yiusvC5G
         KilcGTqwx57GQ1dRZH+ip/pc9mYvdix9sga5SGmAnr/LKI94i5i/CEmFfQgw19UZZ1FO
         W6W9Ky6lJu0BIDiLfyk2P8qKzekdtmsrLp1S4FzAKEumYOY+oSu/0XY2FBuFz2GBHdxG
         wjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644069;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4wJuw9pxzC92GYgo8I2hxvInPBsO21ek6MWQhSnraN0=;
        b=SxlSj/WaEO9/eYVhsxLoKKTFaYrG8HZ+y1CFOW+P889tz7znB7mF2uqe+fdiB9g9fV
         MzHwML3OxDm9Katj0p3VkRZnsjL6kn0lK/k9Rk5cWrz7R3VcssCwI1bcUVTF86Ddv2jZ
         d+0jSTrI4UpCXEFZDHOduscos4m5kAleVVK2OMcbdcKaKSR1V7N6YzhJTcl2+A+y6v/J
         MKUK894MWkqVF3wgdC/TotvG3rdchAPQyFbsyn9R03xH50lBGENCw/2yCxRbUey6U+qS
         5mYEvnIkaFINi5A4fz3Ghnv+7RzQttA7tBB4E2tz4BXAfufiEAG4ns04oN11Qp8fz6QL
         jIAA==
X-Gm-Message-State: AAQBX9f5VUw95eq1pLxRhNASesv+QUPIETnUmS7Ke6gLHNvZqu7jaJi4
        8mlR+ojF0JbH/tHIEgi1eVaARQ1SL6g=
X-Google-Smtp-Source: AKy350Y2VjB3dYkkowvbMmONeShxOg0vWLMY7Khv6hbcdwUDzzzfIEZ3dzXW17wkrVozqydQqS6ARA==
X-Received: by 2002:a17:90a:9601:b0:240:5c46:e9b0 with SMTP id v1-20020a17090a960100b002405c46e9b0mr482196pjo.2.1680644069379;
        Tue, 04 Apr 2023 14:34:29 -0700 (PDT)
Received: from [172.17.0.2] ([13.64.13.84])
        by smtp.gmail.com with ESMTPSA id u12-20020a17090abb0c00b0023c8a23005asm14490pjr.49.2023.04.04.14.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 14:34:29 -0700 (PDT)
Message-ID: <642c97e5.170a0220.ec523.00c9@mx.google.com>
Date:   Tue, 04 Apr 2023 14:34:29 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2792231361872890956=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [RESEND] Bluetooth: Enable all supported LE PHY by default
In-Reply-To: <20230404210537.2329660-1-luiz.dentz@gmail.com>
References: <20230404210537.2329660-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2792231361872890956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=736984

---Test result---

Test Summary:
CheckPatch                    PASS      1.01 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      37.19 seconds
CheckAllWarning               PASS      41.17 seconds
CheckSparse                   PASS      47.12 seconds
CheckSmatch                   PASS      126.56 seconds
BuildKernel32                 PASS      36.64 seconds
TestRunnerSetup               PASS      521.74 seconds
TestRunner_l2cap-tester       PASS      18.08 seconds
TestRunner_iso-tester         PASS      18.58 seconds
TestRunner_bnep-tester        PASS      6.07 seconds
TestRunner_mgmt-tester        FAIL      124.09 seconds
TestRunner_rfcomm-tester      PASS      9.72 seconds
TestRunner_sco-tester         PASS      8.93 seconds
TestRunner_ioctl-tester       PASS      10.46 seconds
TestRunner_mesh-tester        PASS      7.74 seconds
TestRunner_smp-tester         PASS      8.80 seconds
TestRunner_userchan-tester    PASS      6.45 seconds
IncrementalBuild              PASS      34.23 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 497, Passed: 494 (99.4%), Failed: 3, Not Run: 0

Failed Test Cases
Get PHY Success                                      Failed       0.144 seconds
Set PHY 1m 2m coded Succcess                         Timed out    2.465 seconds
Start Discovery LE - (Ext Scan Param)                Failed       0.154 seconds


---
Regards,
Linux Bluetooth


--===============2792231361872890956==--
