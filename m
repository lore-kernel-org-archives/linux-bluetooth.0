Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2DCC2BB40
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 23:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9C4A22509
	for <linux-bluetooth@archiver.kernel.org>; Mon, 14 Dec 2020 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440519AbgLNXGb (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 14 Dec 2020 18:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407820AbgLNXGW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 14 Dec 2020 18:06:22 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F302C061793
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 15:05:42 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id q205so8437195oig.13
        for <linux-bluetooth@vger.kernel.org>; Mon, 14 Dec 2020 15:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yeaJ7FJ0ZnzDAOK6Ifs+xu4mcPC3j133eyoM5hjB8i4=;
        b=VO+XQiw2TPdfy34Zw1N3k+qPeoPVeJgE5dbg1VoEVqgYtpSgNpvs5kSHIAnK8Rr++h
         zwz2ROVw9MW1JFF+HI6iNsfgtg57sr9ENnfGIuPc4w4IWfBk05OjxW6T/mYq9gQD0oCt
         CtovyYL0pz1Hjk+dWUtD7Pu1UfIpqFPyRCRpC63FknnKfye5tcPzGUx8BPRihN88n34N
         9wSfXcOmjdf43tXVemQKDmNCJhs/X7HA4Yj1QrsSy+obrb4zHsM0I3S/WgtVpBl0DLFa
         WIyrncPoSmYZTpm3DXaYM5UR+t6DSGTowDfyhJwhykxet49WAQ7E/pp+/OqJDFW+Ut8j
         aDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yeaJ7FJ0ZnzDAOK6Ifs+xu4mcPC3j133eyoM5hjB8i4=;
        b=YJEpdOD5xNYq9LqiFahQOV8bLyPWyGE6ADkqf5AbgdlbmLSZCb3wVAv97gnIrEIOb0
         +ELPYM42Ydc2M4hM9VdEFc5ZvqyWrIuNrzV0TTXdVClvwAmgdQ87Luy6lw2Qkmb3Tf1A
         CrWC/IPQCqKoiIHWKtr7MNxdQK0bQlw+8b4L6DrNEldwkagKP8mzaIPz//XFinuvQXvM
         nwvysEn6Cky+kbGvUbZZF+PqxPe0TXXt0CuLeebwd+NLnX1kBQrU8G9FnFx4HCkpvSjb
         MEO6y73jXnToE6weviZq2hLZ2L5h2KAaDEoYE+eHT8CsLmWPkxDnW0rue1RE2OGk12wq
         7lCQ==
X-Gm-Message-State: AOAM532yZluqyYmyzDhnpghQzPadres3C4SwkAWtO+pTZ6AHUJhCQIJh
        N/EBPX94rhTApyuzFYTj9FHbPY2eZMJT9LWus/+V7lEr
X-Google-Smtp-Source: ABdhPJxkQot8YWI1G2LmmMV+QO0UaqQyZZUxtCxTWasCmEoZOofhQnBlmedClvT5ADjt3hWpRfn+1v4xhMQZb5uzvIk=
X-Received: by 2002:aca:efc6:: with SMTP id n189mr10383302oih.161.1607987141243;
 Mon, 14 Dec 2020 15:05:41 -0800 (PST)
MIME-Version: 1.0
References: <20201214221502.392676-1-sonnysasaka@chromium.org> <5fd7e957.1c69fb81.1baac.c831@mx.google.com>
In-Reply-To: <5fd7e957.1c69fb81.1baac.c831@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 14 Dec 2020 15:05:30 -0800
Message-ID: <CABBYNZJ4-+Y1wd=_CAebUDxV0RiGkEX5Z8oMkGfiuXKhXQLUoQ@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/2] Revert "input/hog: Remove HID device after HoG
 device disconnects"
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Sonny Sasaka <sonnysasaka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sonny,

On Mon, Dec 14, 2020 at 2:45 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=401857
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
