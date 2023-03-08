Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F382C678D5
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Mar 2023 19:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCHTD2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 8 Mar 2023 14:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbjCHTDN (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 8 Mar 2023 14:03:13 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53144CF0CA
        for <linux-bluetooth@vger.kernel.org>; Wed,  8 Mar 2023 11:02:38 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53852143afcso322397887b3.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 08 Mar 2023 11:02:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678302157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xVPUPDQFuTV2AuCmtAK54KiYxrfWGITpRzNdvCFO74A=;
        b=WsKgPy+1Ky79uE3hMjuVIPiXxc6H6VB4CVVAkhxvB1OeV30mFhcglerIlKQPns5fhd
         cHDqE4b5DpVq5Qy7xFQf6gU44esTb1hSmbpTgIdZX2rvproET4RmMiyPV3V7vfS6GaUe
         o7d3+5cMwZ3gHxb5ueTHCT8IIvMIlP47GoowtgQEcP2PyjWKRNuXfJMS22Nv9xCo2zrb
         DbrYB5eQxkLIKNzZK+uQGkCFBSXEUyKgS5OY85BPsCav6f7gXvMc0E2UKaeMnhr1SFnV
         l0GEPLP/ztqoABDA1ui/+l+8PYqqQpL1/j6j1TwT0XPq8SrKQzw34YqQ6rA3OhdJOhBM
         Bf2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678302157;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xVPUPDQFuTV2AuCmtAK54KiYxrfWGITpRzNdvCFO74A=;
        b=XT6BXu7ET0iOQ9QZj3tZIcz1g+6QM0ws6wfaTXNip4esduAihXct2wfzUZ9Ru6JND5
         KI5jvrlieZrjc/fLeYwdt+5mD38RG6Ra0X45hiRjt3pdD9EZaMf9P2sA8JOs4jB7/e4o
         cETRZ+zCmSQ+gqXthBh6kkv54b6aYMLngfoyhBBPcDmnCaO//IA7ijYmzLLmkRbLbUa/
         PRkM2d3rwL6rXSWgHyNZQRu3EEl3il+DOxNLBXJDjHpta5yRxXUKE1i26MGpxJcqCPFz
         yxUmadKp2IfK0uZyciw1wuUvnATLxbsYq2e0ogFnK9wrFPAVE6VuJf3427E6JEDMXeJw
         IZrg==
X-Gm-Message-State: AO0yUKUqgiM8vug4f7xDsaCzQ8qbtpOll5tK00cvTvcNCQMODJxs+UKC
        +mWVtJup1SjOySz5UOuKm2SGfl8IBDc=
X-Google-Smtp-Source: AK7set+ZaizB46IZrtqg2cW6uO9DJiEpm8pX37YxfHen2GCxaruXd6CYjMiDRg7XvTRjgTMgyhiR2Q==
X-Received: by 2002:a05:7500:3e12:b0:f8:6227:a07f with SMTP id lh18-20020a0575003e1200b000f86227a07fmr92009gab.17.1678302157186;
        Wed, 08 Mar 2023 11:02:37 -0800 (PST)
Received: from [172.17.0.2] ([172.177.120.58])
        by smtp.gmail.com with ESMTPSA id q25-20020a37f719000000b007343fceee5fsm11855181qkj.8.2023.03.08.11.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 11:02:37 -0800 (PST)
Message-ID: <6408dbcd.370a0220.f6f83.745b@mx.google.com>
Date:   Wed, 08 Mar 2023 11:02:37 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1900658033876422884=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, inga.stotland@intel.com
Subject: RE: Bluetooth: hci_sync: Remove duplicate statement
In-Reply-To: <20230308183235.326109-1-inga.stotland@intel.com>
References: <20230308183235.326109-1-inga.stotland@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1900658033876422884==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=727987

---Test result---

Test Summary:
CheckPatch                    PASS      0.65 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      30.68 seconds
CheckAllWarning               PASS      34.13 seconds
CheckSparse                   PASS      38.16 seconds
CheckSmatch                   PASS      106.76 seconds
BuildKernel32                 PASS      29.85 seconds
TestRunnerSetup               PASS      430.35 seconds
TestRunner_l2cap-tester       PASS      16.14 seconds
TestRunner_iso-tester         PASS      16.51 seconds
TestRunner_bnep-tester        PASS      5.42 seconds
TestRunner_mgmt-tester        PASS      107.26 seconds
TestRunner_rfcomm-tester      PASS      8.62 seconds
TestRunner_sco-tester         PASS      8.01 seconds
TestRunner_ioctl-tester       PASS      9.19 seconds
TestRunner_mesh-tester        PASS      6.77 seconds
TestRunner_smp-tester         PASS      7.77 seconds
TestRunner_userchan-tester    PASS      5.67 seconds
IncrementalBuild              PASS      27.80 seconds



---
Regards,
Linux Bluetooth


--===============1900658033876422884==--
