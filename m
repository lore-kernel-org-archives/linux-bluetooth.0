Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E34C4332F
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Dec 2022 20:56:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiLPU4Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Dec 2022 15:56:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiLPU4X (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Dec 2022 15:56:23 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A1FEE22
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 12:56:22 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id v82so3008294oib.4
        for <linux-bluetooth@vger.kernel.org>; Fri, 16 Dec 2022 12:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8lY9pQeRjPIgtybElbMj2L34rhigtUsyVzLsNhzIQqg=;
        b=LcczkdWlGC6/BNhq9jk5XFpy7KnCs0cRsWmhAcgNvH+6W7XmpDxtKjaWZv7q1tBFlv
         fWOFHdMEqXkyfqu+p+hWBbIe5qdqT+WniZeKSmY461V/FzlbYIsbo4BQFKuXwGv6Tbqh
         7SeOwkK04Ucjm58xlr30qZOkntKc6r4DZSRKpAJx3CLXfqDg0HQLe1MNSMl7vDYXAL0K
         0gk+/cO3Anqt/i3Vop+fMcqHPsopDA5r71N0FR7e3FCMab3trEvzPqw5UxoMBp7tsgce
         BqYEzTRjR9yJKTMtrZg6lc009d2y45qQWaQ3HtEiEa7esOiVBNiBwxwv+krX9Da7XKmy
         RV+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8lY9pQeRjPIgtybElbMj2L34rhigtUsyVzLsNhzIQqg=;
        b=OxJN9uNxek1kSdSB5ptBMDuWxz/Ie6Y3Vuj8+21ttlGESGRex+K8ol/hHgN4wdiU1A
         MQeUyTGccsSCr2RAOi5IWoWRsxRVxZdsXlvhG7HZsBqAmBa//bRbe5CvTLdAYdLWTPuC
         GbnjNod09tq3NzV7vQ5VvR4sZK1mYdY+4IhZbrPNJiMHm8NjItNCkF/xf4ZLtWVwU/D4
         3X6vdhYH+WIDLuBbho+em2XKTt6hDBzP0bUnM6frJU9kALYORUNGHbEbqOtd8cVHECze
         z/ANaTfdn4SgJnxQPVryy3fhbBDuQc62lrwA42twxHcVJCqxHHNbmuwTw9wBonJPyGCJ
         3PpQ==
X-Gm-Message-State: AFqh2kpm0v1rQXIHIhDgJfB81TS/XjP/inFcugUt4G/Z5M2e/mcQ9VDD
        0RgP4HQaQRI5p6aB4I68nxHHG+xnQEg=
X-Google-Smtp-Source: AMrXdXti/F4qyehPsDKNSq9BgepOvrbxe+/HqD5e1MTvQ7fdTSM6OfWgK7x1P01Q/1Pohcz7hJWjDQ==
X-Received: by 2002:a05:6808:bd6:b0:35f:a2b9:1773 with SMTP id o22-20020a0568080bd600b0035fa2b91773mr3721200oik.22.1671224181671;
        Fri, 16 Dec 2022 12:56:21 -0800 (PST)
Received: from [172.17.0.2] ([104.210.132.177])
        by smtp.gmail.com with ESMTPSA id c13-20020a056830000d00b0066ebe432518sm1322203otp.38.2022.12.16.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 12:56:21 -0800 (PST)
Message-ID: <639cdb75.050a0220.d0b08.6058@mx.google.com>
Date:   Fri, 16 Dec 2022 12:56:21 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0199843520218017503=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Subject: RE: Bluetooth: Fix issue with Actions Semi ATS2851 based devices
In-Reply-To: <20221216201247.297210-1-marcel@holtmann.org>
References: <20221216201247.297210-1-marcel@holtmann.org>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============0199843520218017503==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=705205

---Test result---

Test Summary:
CheckPatch                    PASS      0.85 seconds
GitLint                       PASS      0.29 seconds
SubjectPrefix                 PASS      0.10 seconds
BuildKernel                   PASS      32.85 seconds
CheckAllWarning               PASS      36.24 seconds
CheckSparse                   PASS      41.65 seconds
BuildKernel32                 PASS      32.38 seconds
TestRunnerSetup               PASS      461.30 seconds
TestRunner_l2cap-tester       PASS      17.08 seconds
TestRunner_iso-tester         PASS      17.46 seconds
TestRunner_bnep-tester        PASS      5.89 seconds
TestRunner_mgmt-tester        PASS      112.86 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         PASS      8.49 seconds
TestRunner_ioctl-tester       PASS      9.92 seconds
TestRunner_mesh-tester        PASS      7.46 seconds
TestRunner_smp-tester         PASS      8.51 seconds
TestRunner_userchan-tester    PASS      6.18 seconds
IncrementalBuild              PASS      30.57 seconds



---
Regards,
Linux Bluetooth


--===============0199843520218017503==--
