Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DE1CDB465
	for <linux-bluetooth@archiver.kernel.org>; Wed, 11 Oct 2023 23:37:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjJKXht (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 11 Oct 2023 19:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJKXht (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 11 Oct 2023 19:37:49 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6FB9E
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 16:37:48 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id d75a77b69052e-4194d89a6dfso2649781cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 11 Oct 2023 16:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697067467; x=1697672267; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bnioqDl2PtsuLxZMq+ePUb++a7Cbmz5QjPBr0MVuETs=;
        b=c9vt3JAxNi86V2o6kp6RKbxFYw02+D9RqhEn+KKpXTxA81d+lyrjoyzFaYszmk/PAF
         icLE/GLx+SQpwbFicf84W0hdYAsJgmBWDxGdpXDyr+bdxC9DSkaaK8hwDSqEGhVtWjF9
         LGXzNpAOxX8JoLBE/2uMsUw8jm9CLEKFpMZsfkkFTBnyCYA4nGMWwmGvZiE87O3GlhYS
         GPgRlPjwMkmsqfuUaxXqdlwhZ5CY6j/6H7DPzWpLiV/BrITYpYTDVw0ZsTjV5Yv5MREy
         TriwBdKys5uQcpZb0RyLRZHpDIxT+Y09WwfsYUNTVzeLBG6W18Ix6QFRaTnFI9Kws9oa
         YQpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697067467; x=1697672267;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnioqDl2PtsuLxZMq+ePUb++a7Cbmz5QjPBr0MVuETs=;
        b=h4oGfP6VuixCSVbcsvxPbD9p81PHHtJhG6gNeFceiG59CVvVyw1Q8RztMeRt7/IdFe
         vOzOhKEr6WKm9V7PRZe+KeVNQYeW8dOitEzy9KYLr5rl6ZJr9q/CR720+Ee3mlDB3zpD
         pxzWXLHszRZwNb+mCDa1LJOJ2IJSf12StjhW//K1QwAfVG0qcXJhLBFFIHF0LqHjXhZC
         0NyYWXdJ+Wrm4Je1a31C0RBZaqM8YV8AjesdATCaO0bBGF+Je0NZPawObFvXNs4KRGdJ
         zRgHs1L4B9h+TSY7l6qdQIjusDHKzCVM4bPzqPctm1CuYuqshTQ1m1cfSZgpnc637ClJ
         rB+A==
X-Gm-Message-State: AOJu0YxcnTFrnPXzwA1Qpf9zQkKA0Spf8JqebsJrjQmM3Xx2CGRZ7QpM
        96wZ3mPXdFCvAyP8gzLUodjjj8gBU+A=
X-Google-Smtp-Source: AGHT+IFPFb/llYXRWalHD31ccg8D2q+dXzP3rStM67eYomTyJTyKE/8MboUHJSsaoZM3VumYKzrieg==
X-Received: by 2002:ac8:5d8f:0:b0:410:60a4:ffbc with SMTP id d15-20020ac85d8f000000b0041060a4ffbcmr26785763qtx.66.1697067467074;
        Wed, 11 Oct 2023 16:37:47 -0700 (PDT)
Received: from [172.17.0.2] ([104.45.204.150])
        by smtp.gmail.com with ESMTPSA id m3-20020ac84443000000b0041520676966sm5710064qtn.47.2023.10.11.16.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 16:37:46 -0700 (PDT)
Message-ID: <652731ca.c80a0220.30226.9e60@mx.google.com>
Date:   Wed, 11 Oct 2023 16:37:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2009548895305618411=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, jiangzp@google.com
Subject: RE: [kernel,v2] Bluetooth: btmtksdio: enable bluetooth wakeup in system suspend
In-Reply-To: <20231011153928.kernel.v2.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
References: <20231011153928.kernel.v2.1.I6dbfc1fedddf0633b55ce7e7a10ef7f3929a9bdc@changeid>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============2009548895305618411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=792370

---Test result---

Test Summary:
CheckPatch                    PASS      0.75 seconds
GitLint                       PASS      0.35 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      34.96 seconds
CheckAllWarning               PASS      38.36 seconds
CheckSparse                   PASS      44.17 seconds
CheckSmatch                   PASS      119.51 seconds
BuildKernel32                 PASS      33.90 seconds
TestRunnerSetup               PASS      524.90 seconds
TestRunner_l2cap-tester       PASS      31.18 seconds
TestRunner_iso-tester         PASS      55.05 seconds
TestRunner_bnep-tester        PASS      10.58 seconds
TestRunner_mgmt-tester        PASS      224.21 seconds
TestRunner_rfcomm-tester      PASS      16.44 seconds
TestRunner_sco-tester         PASS      19.55 seconds
TestRunner_ioctl-tester       PASS      18.44 seconds
TestRunner_mesh-tester        PASS      13.42 seconds
TestRunner_smp-tester         PASS      14.64 seconds
TestRunner_userchan-tester    PASS      11.67 seconds
IncrementalBuild              PASS      33.12 seconds



---
Regards,
Linux Bluetooth


--===============2009548895305618411==--
