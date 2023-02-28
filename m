Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44BD6C64EC7
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Feb 2023 06:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjB1Ggq (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Feb 2023 01:36:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjB1Ggp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Feb 2023 01:36:45 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83EF46A0
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 22:36:44 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id u6so5730099ilk.12
        for <linux-bluetooth@vger.kernel.org>; Mon, 27 Feb 2023 22:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677566204;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3ciqAQwNrKdY+AmuWnhWrTMf+EI1aWE7uchzyUhAQrY=;
        b=nyAS350hSJ/bexBUFOunbFgHgN1FpGxVSYHuIlQJz9CSCsYs+BJ6EuByEmtPJeEjRN
         F/QVKKKuxYHZnsccje0xXkXO0fUprY8+HL0eaNZwJl83YMNSz7mAb1N9Lg7AafqwalnS
         J7Brg8qsjUmpqcCKb0DzCfI3C93eSjvCEcJjrJ3H50aEBjuw5SRKViGrqz4oTt1D8iqJ
         f3t/vy4HaK3Yd/N28bfNYy8JsMEFL6c2yYxnMWMMCXIOeYv7ngZMwGzdoiQ0zt7q4f1r
         wy0i78j0aCx6eaLL9PKVuA8PNgV3q7y7thJ+pXN2CzLf0FR/qIG3IQRN2n6NqWB8MyXp
         ZtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677566204;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ciqAQwNrKdY+AmuWnhWrTMf+EI1aWE7uchzyUhAQrY=;
        b=aePfno60zoIBW+F/zwEiZ5r1Z+SpjkcoUnk5X/Xr95XywUDEPOQ8LZmw1ej906bYtR
         aMBcb0h5RY96gasxUunYLIyGOGCyoKdaa7lohz+SmLRTE32T7c+im+VeH5l587C1Enq7
         CnvotkeJOJD3/1AG3kAneMe+Quiu/GvmVh8DvzEfFwPpaiHIHq6d8BAbjfw/qm+AUKDr
         p03DzCemG/K33X83xQp7f7KGIlsY6xw9scRvM9mno0fL6BgbtLmX0C9dNqjRqWsDrRaR
         bYG/lEl4CeNTJIVeQfVsMxqQ3m+N2kRH6tv7NRaRL42hYNQNA9o6hihURIOcy0vdCKDO
         Eu8g==
X-Gm-Message-State: AO0yUKVrL4Qde2hjsxwawXz66n2aNSnLoTpMykVSNorcsg2Y2pCiK5zC
        kVE+GptvGt6k0tCJ3OpsVXorlsgKxuY=
X-Google-Smtp-Source: AK7set+XKvM3NTZi2U+yW9wm6RIvw44MvutaDN2PgNTgOPCj7FFRUJB/kEFPAd0DHtnGdIVPPitXaw==
X-Received: by 2002:a05:6e02:1a2d:b0:314:f7f:a369 with SMTP id g13-20020a056e021a2d00b003140f7fa369mr2287072ile.11.1677566203965;
        Mon, 27 Feb 2023 22:36:43 -0800 (PST)
Received: from [172.17.0.2] ([40.77.93.33])
        by smtp.gmail.com with ESMTPSA id m11-20020a056638224b00b003c4e3ecb02dsm2760130jas.24.2023.02.27.22.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 22:36:43 -0800 (PST)
Message-ID: <63fda0fb.050a0220.c0afe.5162@mx.google.com>
Date:   Mon, 27 Feb 2023 22:36:43 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5465622039012173995=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, tangmeng@uniontech.com
Subject: RE: [v2] Bluetooth: btusb: Add new PID/VID 04ca:3801 for MT7663
In-Reply-To: <20230228055517.17348-1-tangmeng@uniontech.com>
References: <20230228055517.17348-1-tangmeng@uniontech.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============5465622039012173995==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=725396

---Test result---

Test Summary:
CheckPatch                    PASS      0.57 seconds
GitLint                       PASS      0.27 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      31.38 seconds
CheckAllWarning               PASS      34.51 seconds
CheckSparse                   PASS      38.71 seconds
CheckSmatch                   PASS      108.17 seconds
BuildKernel32                 PASS      31.09 seconds
TestRunnerSetup               PASS      436.51 seconds
TestRunner_l2cap-tester       PASS      15.84 seconds
TestRunner_iso-tester         PASS      16.64 seconds
TestRunner_bnep-tester        PASS      5.33 seconds
TestRunner_mgmt-tester        PASS      108.09 seconds
TestRunner_rfcomm-tester      PASS      8.58 seconds
TestRunner_sco-tester         PASS      7.98 seconds
TestRunner_ioctl-tester       PASS      9.16 seconds
TestRunner_mesh-tester        PASS      6.72 seconds
TestRunner_smp-tester         PASS      7.81 seconds
TestRunner_userchan-tester    PASS      5.58 seconds
IncrementalBuild              PASS      28.41 seconds



---
Regards,
Linux Bluetooth


--===============5465622039012173995==--
