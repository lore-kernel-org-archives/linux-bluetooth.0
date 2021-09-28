Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2E5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:44:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5775561360
	for <linux-bluetooth@archiver.kernel.org>; Tue, 28 Sep 2021 21:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242973AbhI1Vp6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 28 Sep 2021 17:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241482AbhI1Vp5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 28 Sep 2021 17:45:57 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F87C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:44:18 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id l19so586148vst.7
        for <linux-bluetooth@vger.kernel.org>; Tue, 28 Sep 2021 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4YPXYsEKPLuipyQlgbQ/ue6WJa1FQ79DhOG7a4XNBQ=;
        b=j32tqHvMzwgBJTzY41qu1AHODV5AvMmAwNebFUIro7C2aFaL4KpbTLs2hkYZd8CyJT
         k6h/myGHe9iBQpSgtaBH9zRIJuHsBjSA2CRx+hgL4mJjUPh73ed6OSWGK87O+a9EeWxU
         rLY5KYoW3lC0Z4dcFjMr1t9JpmwTx1my0fta4l2+cmXJCXyA+stHgJbzf0djviTFarPL
         z0aiMyLG07JkUAbqSf4lYk10G4w8ZjLpLmcuijpUoBo3pla+PUUi6jPx/LYRA3iD6BlZ
         PwhLFUk0pC391LzR0Eat+XxSuIMzILWqZucMiaJ5PkpIx7ZWy6aYurh8uHlKcLwtrwfn
         9wVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4YPXYsEKPLuipyQlgbQ/ue6WJa1FQ79DhOG7a4XNBQ=;
        b=5Vb/R4otoAzHTVWsuTs+W+0mIYSZGjtGXuqx3FIF5dNZLJhOswNS6jzVeFmT+N4A1N
         i05eL/pv2d6vxuV9/31ZAudJcag+QTKosmi1XPVr6T4CX8uDr9eFq+GJInZgeYkk1+2k
         m9FeD3qdzBG9IUy1PFakUxXJNPU3YtcEMI5zHUEWuk0uWlIN8xgHO59rWkLXQ8YXaU63
         VrLD2A16zbPKKgdNxW07x66axGaQ+58XS+CNrVBt3qEf2nnwLsOj8NQPwCUpVbwsYOuA
         euOFW53bUIaFWI9nTj1D6ZHOG8Y+U29Cd6eACURg58oDduF8cqjufBLGfOpA98KjYpJ7
         T5WQ==
X-Gm-Message-State: AOAM531ACVSAR9tyDy1b2X+ZvCYZ1QoINDMxHbBVyOXlMGYAOPMa2ecA
        h/zx1/ulH4sQQY8/0YzMzMTagOciPrU5qDCYEzBbXjqQ
X-Google-Smtp-Source: ABdhPJzJtvKAtJaJhKJ7XFAxhkSN5WNtgtMX5r11S+6Z2fnMWM4rpHA1+3Yd6BX+OfwSpd9vC+5mD3citr3XZMqvv7Q=
X-Received: by 2002:a05:6102:318d:: with SMTP id c13mr7938207vsh.10.1632865457015;
 Tue, 28 Sep 2021 14:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20210928181050.47565-1-marcel@holtmann.org> <61536889.1c69fb81.2e0ef.112b@mx.google.com>
In-Reply-To: <61536889.1c69fb81.2e0ef.112b@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 28 Sep 2021 14:44:06 -0700
Message-ID: <CABBYNZKVYgsdYLCPsxxxoAxwjbx9ToDWYt1L=qjjus3P1-0OGQ@mail.gmail.com>
Subject: Re: Bluetooth: btrtl: Set VsMsftOpCode based on device table
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Marcel Holtmann <marcel@holtmann.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marcel,

On Tue, Sep 28, 2021 at 12:11 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=554407
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.55 seconds
> GitLint                       PASS      0.91 seconds
> BuildKernel                   PASS      544.18 seconds
> TestRunner: Setup             PASS      398.95 seconds
> TestRunner: l2cap-tester      PASS      8.93 seconds
> TestRunner: bnep-tester       PASS      4.83 seconds
> TestRunner: mgmt-tester       PASS      75.98 seconds
> TestRunner: rfcomm-tester     PASS      5.93 seconds
> TestRunner: sco-tester        PASS      6.15 seconds
> TestRunner: smp-tester        PASS      6.00 seconds
> TestRunner: userchan-tester   PASS      5.10 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Applied, thanks.

-- 
Luiz Augusto von Dentz
