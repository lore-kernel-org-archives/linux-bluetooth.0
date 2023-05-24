Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E64C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Wed, 24 May 2023 02:35:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjEXCe6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 May 2023 22:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjEXCew (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 May 2023 22:34:52 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB3818C
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 19:34:50 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-253e0edc278so348032a91.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 May 2023 19:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684895689; x=1687487689;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GOq8PQDsdbYz4dJh3GxlqCz7FOqlxQO4TjTBPAroYT0=;
        b=j5mH2WQ2Ofi1pHXYCSbkdG+73+XQSxsUral0kXqKnPS4pA+/2VAJO7jeVXgAM8cbma
         1Wq8r96eIPNn4VRLYg1s9n9pGayiVsDrYsy9keYjM7cWx6jPfTm/3c6clUAqL0xraUhF
         ZXPBHxRZPC1uvrdFotr8MGvI9Fq4MB28R2UKAuIVttz6P4FRwd92NIVCScbJo9r4b8dc
         wwEVXZAMbIDq5nArKyuu9//ISaCL5e5e0j26kAy/jOKZYTIZvoFJYDvEDiSvHOfSuN1i
         a3y/Q6mHPQwplRQEXLa1r0dHqJft2UZJ5aDr8UpMi4yiw7i6ekTq8DqY9vQPe8C3WCZI
         2eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684895689; x=1687487689;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOq8PQDsdbYz4dJh3GxlqCz7FOqlxQO4TjTBPAroYT0=;
        b=UVs7XDDO3hWiosYPbYYHDcpLPKmKNKplA/jzZ/MmNw8Xdl9poWUQDIOTCdOAHk+LSo
         mpzx4x9TIDJ7CvSDjf8wcoWW8XnPeo1AnMrOOghZdAQp5KwfWld+h4aQqj7QQBveyiwn
         +wv6UCnZvOBUll8CeR3+tqExtc1upzTOeHF9YU39Wi68n1teTyTwxAR55w+bXIU/m/2+
         7vVOG4jUrjcviwbsTpmPdkUjAC+PaIEbT86akHk21XpabbN8m1K8nsGIDF+3nClWutFO
         Gh5zdSUDSmiI+MAMTWmLYNCyM1DaIlWipLMXSvqSMKlBjaD0mDK0F03zBbr7GvPFThBL
         CYfQ==
X-Gm-Message-State: AC+VfDxb0Qf5x5TM7eExbOqCM4p1ij7vr06AbqkpGg9MifSDEyuDH46f
        oX+Vhh8QjKJIxQl8mhA9lcYRFWBYUIc=
X-Google-Smtp-Source: ACHHUZ6070YmYjr3d/iSu6jc56uapnBL9sZ8RRrFl+n0gk7GghIVM+eqA2vh0qLLAlBXnYmdJ45ABw==
X-Received: by 2002:a17:90a:e603:b0:253:50d0:a39d with SMTP id j3-20020a17090ae60300b0025350d0a39dmr12946552pjy.48.1684895689474;
        Tue, 23 May 2023 19:34:49 -0700 (PDT)
Received: from [172.17.0.2] ([13.91.161.23])
        by smtp.gmail.com with ESMTPSA id 18-20020a17090a1a1200b00247150f2091sm280739pjk.8.2023.05.23.19.34.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 May 2023 19:34:49 -0700 (PDT)
Message-ID: <646d77c9.170a0220.ce5f1.0b03@mx.google.com>
Date:   Tue, 23 May 2023 19:34:49 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1206722655290671976=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, lm0963hack@gmail.com
Subject: RE: Bluetooth: HCI: fix use-after-free in hci_remove_ltk/hci_remove_irk
In-Reply-To: <20230523115637.14541-1-lm0963hack@gmail.com>
References: <20230523115637.14541-1-lm0963hack@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1206722655290671976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=750457

---Test result---

Test Summary:
CheckPatch                    PASS      0.66 seconds
GitLint                       PASS      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      41.83 seconds
CheckAllWarning               PASS      45.95 seconds
CheckSparse                   PASS      51.32 seconds
CheckSmatch                   PASS      139.19 seconds
BuildKernel32                 PASS      40.19 seconds
TestRunnerSetup               PASS      580.00 seconds
TestRunner_l2cap-tester       PASS      20.75 seconds
TestRunner_iso-tester         PASS      28.64 seconds
TestRunner_bnep-tester        PASS      7.25 seconds
TestRunner_mgmt-tester        PASS      140.80 seconds
TestRunner_rfcomm-tester      PASS      11.32 seconds
TestRunner_sco-tester         PASS      10.43 seconds
TestRunner_ioctl-tester       PASS      12.18 seconds
TestRunner_mesh-tester        PASS      9.19 seconds
TestRunner_smp-tester         PASS      10.39 seconds
TestRunner_userchan-tester    PASS      7.73 seconds
IncrementalBuild              PASS      38.00 seconds



---
Regards,
Linux Bluetooth


--===============1206722655290671976==--
