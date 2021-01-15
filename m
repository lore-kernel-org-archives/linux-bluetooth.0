Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637A3C433E0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29F3523884
	for <linux-bluetooth@archiver.kernel.org>; Fri, 15 Jan 2021 12:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731958AbhAOMX3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 15 Jan 2021 07:23:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731851AbhAOMX1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 15 Jan 2021 07:23:27 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCEEC061795
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 04:22:34 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id f26so11417489qka.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 Jan 2021 04:22:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:date:mime-version:from:to:subject:reply-to:in-reply-to
         :references;
        bh=/Wnyfazuc1teDd80qHAtnEdJQN3rfWicRh4+ASnC3M0=;
        b=vY2HojeUKDonmPKPYZEdrDLu06TOfWz59iuu1gPXHAMzXT1zZ3TVj0dGym1gReCKT1
         RuIj6KDrN/SlA+uK/t4Rc7HDTVkSZQkKi59xRzSY14K6Pp4o43a6oUBGUBpuNV468UOB
         pG99sVJgkvzTgk5O6MFAAEuo1qCH4WdWNvZ7MknwJxlXMjd1N6lrG0M82GIyGAhzl8jr
         Lq49B2By6MRfR1tVhpfmJoaXvX2amP+ePf+NFpmDBVGbjcZdg21TJIwoBGIEXd/hDQcC
         J7+E1mSB2mahfvtmgCeQCzZyA6RotNfwz6JaOnwSmj1zkrV6CzvtHpX3dplaHO9kihQB
         jImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:from:to:subject
         :reply-to:in-reply-to:references;
        bh=/Wnyfazuc1teDd80qHAtnEdJQN3rfWicRh4+ASnC3M0=;
        b=eHPsc7PH20Mn+99T87wCQMDRVrijEychA4pFVo7ireNULzA8Nr0uX9MgUrkH6j0Exu
         6cZK36Y5R7cryolw9aS+ikbKKfx+4rIKMdhoTNFbB1FxvMrUnHb1T+es/l6fSRZMNbfE
         u8t4Fdv/BMSbCg7pwMUsIReLakKF7UaZH1jR5tCclrgRhKqoVGLqJdr2r2sMurcjCn8h
         eIoey64OMA8rxNE/Wk8heYZLj52znNrQEcSDSgW6JnMGkLoXymq8mOj0GbEdPwq1eaUc
         ulP9rQk6u/i54YvWJQCPz4i2WO3p1NFF4FpLgqkkpdwUz+ITpRyLXwaAyjWZkQ86Oe2j
         nGTA==
X-Gm-Message-State: AOAM530tG8G1AgYVIwPuiSXtIiOdLSit4DJL4r6G8AAXmbIEiY3Qtalw
        LBx2+V6nYna+XV4ji5RW0njjXbWfqPtC2w==
X-Google-Smtp-Source: ABdhPJyfFmKS7+RkxfD/TM4PECjd9SHs9RJgXvtW+7YUkq8K4nriycj/fukU6dI/8cBUXl4BeKfIug==
X-Received: by 2002:a37:6245:: with SMTP id w66mr11880052qkb.422.1610713353800;
        Fri, 15 Jan 2021 04:22:33 -0800 (PST)
Received: from [172.17.0.2] ([52.254.7.212])
        by smtp.gmail.com with ESMTPSA id a9sm4873759qkk.39.2021.01.15.04.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 04:22:33 -0800 (PST)
Message-ID: <60018909.1c69fb81.52ada.fa70@mx.google.com>
Date:   Fri, 15 Jan 2021 04:22:33 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============1103421102432459560=="
MIME-Version: 1.0
From:   bluez.test.bot@gmail.com
To:     linux-bluetooth@vger.kernel.org, apusaka@google.com
Subject: RE: Support advertising monitor add pattern with RSSI opcode
Reply-To: linux-bluetooth@vger.kernel.org
In-Reply-To: <20210115194853.Bluez.v4.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
References: <20210115194853.Bluez.v4.1.I90bb4b25451e7f726fc2c8771cfe642b16312ce3@changeid>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--===============1103421102432459560==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=415375

---Test result---

##############################
Test: CheckPatch - PASS

##############################
Test: CheckGitLint - PASS

##############################
Test: CheckBuild - PASS

##############################
Test: MakeCheck - PASS



---
Regards,
Linux Bluetooth


--===============1103421102432459560==--
