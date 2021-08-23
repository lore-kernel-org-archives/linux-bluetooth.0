Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD1DC432BE
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 23:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB6461378
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 23:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbhHWXvy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 19:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233417AbhHWXvl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 19:51:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C861FC061760
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 16:50:57 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id z18so37423618ybg.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 23 Aug 2021 16:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qqy2KRX7ie0ETXEvz8KE/mywNXQQPz8Wcbu9EL3eMdg=;
        b=U4YxH5MDgt0Xj4R6y9OOcIu7UkqTDDbopJo3QB/EScQ6TXUImhIIPvqrVJ1PBwOYlE
         Z+lic3ZUSEFY1ZimZSNZ2mkk+S6f5Vp46nZPT5Jp+0575Hs63u8asb4Enj2qFXpahi6N
         1BZWRICE50Lal/fBQGmhk2eOmceV5Oat2CGNvmaEytpH/84S6L2dzJ6R2dZcwJ/eeYsD
         TQWtTcSMEuPywl/Bo13uoYdYt8LDCa8lD7rIVrVw8ne2MqtsoN70AHjYGp4nWxExldQ8
         3HW+/Yuc2+FLqcTOtWjofFJC5yLgMlvVB3XwTeug/tc1bhZuRnsCj67p935GwwV/Erit
         00UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qqy2KRX7ie0ETXEvz8KE/mywNXQQPz8Wcbu9EL3eMdg=;
        b=J+OMCdcXk5cfYPdAH1mWw+aD/Q5aHenUJJdlUnJ9VkE0zhso3InoSeADIBxDIVfR2k
         VJUSvvzsk3HMr1GlaDr+IY+v4flCpUu9ODsJCEDSBQFRCQQZAjEGZh+R4C3JvdN6ueAY
         j88TrdoNBPqPRBkqJ6H0RciYYYBdiDGAnKGYYcwQZFU1qkBIwFozf98SJyOW8/5zOrAM
         CBxHXVW76oAhlu1i5eLlooahdjYAr6kzrixmbhZlh/DLX668J2lu4ufSgRF8XegPktwW
         RrlRgxYolmVVvdQDbM92P2pDr4+sirsTeGwESfZ6BzWaYLgmbMgVk1C2PDsKwVJ6JKfz
         x22w==
X-Gm-Message-State: AOAM533Rlj3CR9uDy9uNfBh1CCWAZqH2uAK2f/uJFAXg90i2/qZiSA9K
        +wqSs9ulmfi12w8Bp+mP9JrvxfddxqbP/PCVPzlenfMB
X-Google-Smtp-Source: ABdhPJyG1hpFHMjUmu7F4RGhJtGqQolKStk7402/lSdRth2nn4ac63xFIqKaWeBjdYxU8x8BxqkriM7Q5V87lQAQM+8=
X-Received: by 2002:a25:be02:: with SMTP id h2mr48378157ybk.91.1629762656836;
 Mon, 23 Aug 2021 16:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210823215729.87837-1-brian.gix@intel.com> <612429dc.1c69fb81.9ac39.1665@mx.google.com>
In-Reply-To: <612429dc.1c69fb81.9ac39.1665@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 23 Aug 2021 16:50:45 -0700
Message-ID: <CABBYNZLuYq=ySv8YE061VLLnv-zAa0TQ2aa7dAnH9VwoGW2xbQ@mail.gmail.com>
Subject: Re: bluetooth: mgmt: Disallow legacy MGMT_OP_READ_LOCAL_OOB_EXT_DATA
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     "Gix, Brian" <brian.gix@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Brian,

On Mon, Aug 23, 2021 at 4:08 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=536151
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.50 seconds
> GitLint                       PASS      0.10 seconds
> BuildKernel                   PASS      512.80 seconds
> TestRunner: Setup             PASS      338.52 seconds
> TestRunner: l2cap-tester      PASS      2.52 seconds
> TestRunner: bnep-tester       PASS      1.89 seconds
> TestRunner: mgmt-tester       PASS      30.54 seconds
> TestRunner: rfcomm-tester     PASS      2.06 seconds
> TestRunner: sco-tester        PASS      2.02 seconds
> TestRunner: smp-tester        FAIL      2.05 seconds
> TestRunner: userchan-tester   PASS      1.92 seconds
>
> Details
> ##############################
> Test: CheckPatch - PASS - 0.50 seconds
> Run checkpatch.pl script with rule in .checkpatch.conf
>
>
> ##############################
> Test: GitLint - PASS - 0.10 seconds
> Run gitlint with rule in .gitlint
>
>
> ##############################
> Test: BuildKernel - PASS - 512.80 seconds
> Build Kernel with minimal configuration supports Bluetooth
>
>
> ##############################
> Test: TestRunner: Setup - PASS - 338.52 seconds
> Setup environment for running Test Runner
>
>
> ##############################
> Test: TestRunner: l2cap-tester - PASS - 2.52 seconds
> Run test-runner with l2cap-tester
> Total: 40, Passed: 40 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: bnep-tester - PASS - 1.89 seconds
> Run test-runner with bnep-tester
> Total: 1, Passed: 1 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: mgmt-tester - PASS - 30.54 seconds
> Run test-runner with mgmt-tester
> Total: 448, Passed: 445 (99.3%), Failed: 0, Not Run: 3
>
> ##############################
> Test: TestRunner: rfcomm-tester - PASS - 2.06 seconds
> Run test-runner with rfcomm-tester
> Total: 9, Passed: 9 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: sco-tester - PASS - 2.02 seconds
> Run test-runner with sco-tester
> Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0
>
> ##############################
> Test: TestRunner: smp-tester - FAIL - 2.05 seconds
> Run test-runner with smp-tester
> Total: 8, Passed: 7 (87.5%), Failed: 1, Not Run: 0
>
> Failed Test Cases
> SMP Client - SC Request 2                            Failed       0.021 seconds
>
> ##############################
> Test: TestRunner: userchan-tester - PASS - 1.92 seconds
> Run test-runner with userchan-tester
> Total: 3, Passed: 3 (100.0%), Failed: 0, Not Run: 0
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
