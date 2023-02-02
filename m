Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85EA8C05027
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Feb 2023 22:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjBBWEE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Feb 2023 17:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbjBBWDu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Feb 2023 17:03:50 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1633CC1B
        for <linux-bluetooth@vger.kernel.org>; Thu,  2 Feb 2023 14:03:27 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id x29so3449149ljq.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 02 Feb 2023 14:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+7HIgKSzGY6hN/gxH2GZLyCwiAJwn8d8Lo20rXEtTLg=;
        b=p/HIc7RsAvkHmpBMwgF4b4ymcxWU/1cH5JZjNp8jw3FPwPuutY8f5l7RyiYt14Dbqm
         BhwWpmG+jWx/7bYxzpmm1Nn6EgAxBYWc+umswz+cCD/Us8J7MqcPrlqWHNUVS8HssGLA
         X1gV41uOgzJK8qYrsYF3xkwaFdPzPz+UYqpr4Lb208iHLE7wfivu5EAY2adx9fAvqBwm
         /LT/h23NmDzdn0zV1sAmTRUQxbvgolLXqa7i6KV6xDDusI6RlgW3tIp6t+mBYQ8bdKrR
         2BzDsqakP5AgCRwIT3yPxwEGSPFQcns+4bbjxjVbL5eTD2kdEG8w9jqv5XXoLT6qDt1h
         G9jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+7HIgKSzGY6hN/gxH2GZLyCwiAJwn8d8Lo20rXEtTLg=;
        b=vI+00b24NZSXScEiGrIz24nNhpp/kx9GkmuLyStLt6woVqq6eVI2+tIirIugrFW8FX
         8SRdk4WDI8DhMzkqYJdh8Xh88A+GA5pFBTZ3LsW4aWjv60YrZsS08Zi1MxAhKPGwirgb
         qFH0W14M9WMazcxyiEbqIREWHlpX/I44aCqzjmILmHMiSaSSaQ+RwS8LFN6+Z06p13WR
         KzDzV0iFb1nFLDEF8Oek7GQc1i9WVwmSAHc+IG6LKIXdVG6EvMHj1v4hhW8Fa5sSZUou
         JbS3s7SY5SDeEUtWbz/IKUnpz9fjpcU3O2e6uAi4gkgTeZBp8TPpDNwrK87y7ECmrhrL
         +Pdw==
X-Gm-Message-State: AO0yUKVf4KdhBKxRI83OMTK49SVuLH8/SbgASdkT98/N+2hIxvoNGPEH
        5ajgr0SDZteM71h4jrzhjYRN6Lda3zouDQ9Skyz2e2aXwYs=
X-Google-Smtp-Source: AK7set+InkVOLjUvxcuz6PUCwZIUKeE0tHBYfy0kUgNPBP07NM1PwnVQVYCuT0EuFpHSuhNeD8/d5uh1ubGQfxX+C2c=
X-Received: by 2002:a2e:a4c8:0:b0:28b:78f0:e658 with SMTP id
 p8-20020a2ea4c8000000b0028b78f0e658mr1095316ljm.9.1675375405217; Thu, 02 Feb
 2023 14:03:25 -0800 (PST)
MIME-Version: 1.0
References: <20230202114614.53907-1-max.chou@realtek.com> <63dbaf9b.c80a0220.30d2e.7d9c@mx.google.com>
In-Reply-To: <63dbaf9b.c80a0220.30d2e.7d9c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 2 Feb 2023 14:03:13 -0800
Message-ID: <CABBYNZLf6NhA9TGASAh0NH0LMU0DSPGb-UCSU0oBdN3N6=k7LA@mail.gmail.com>
Subject: Re: [v2] Bluetooth: btrtl: Firmware format v2 support
To:     linux-bluetooth@vger.kernel.org
Cc:     max.chou@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Max,

On Thu, Feb 2, 2023 at 4:44 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D718=
117
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.47 seconds
> GitLint                       FAIL      0.59 seconds
> SubjectPrefix                 PASS      0.12 seconds
> BuildKernel                   PASS      32.41 seconds
> CheckAllWarning               PASS      34.42 seconds
> CheckSparse                   WARNING   39.28 seconds
> CheckSmatch                   WARNING   107.00 seconds
> BuildKernel32                 PASS      30.51 seconds
> TestRunnerSetup               PASS      438.93 seconds
> TestRunner_l2cap-tester       PASS      16.68 seconds
> TestRunner_iso-tester         PASS      17.51 seconds
> TestRunner_bnep-tester        PASS      5.83 seconds
> TestRunner_mgmt-tester        PASS      113.14 seconds
> TestRunner_rfcomm-tester      PASS      9.24 seconds
> TestRunner_sco-tester         PASS      8.45 seconds
> TestRunner_ioctl-tester       PASS      9.90 seconds
> TestRunner_mesh-tester        PASS      7.34 seconds
> TestRunner_smp-tester         PASS      8.30 seconds
> TestRunner_userchan-tester    PASS      6.11 seconds
> IncrementalBuild              PASS      28.50 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [v2] Bluetooth: btrtl: Firmware format v2 support
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 24: B1 Line exceeds max length (83>80): "> I rather use an skb for parsin=
g the data instead of parsing via pointer directly,"
> ##############################
> Test: CheckSparse - WARNING
> Desc: Run sparse tool with linux kernel
> Output:
> drivers/bluetooth/btrtl.c:882:22: warning: cast to restricted __le16drive=
rs/bluetooth/btrtl.c:888:27: warning: cast to restricted __le16drivers/blue=
tooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl.h:47:45: warn=
ing: array of flexible structures
> ##############################
> Test: CheckSmatch - WARNING
> Desc: Run smatch tool with source
> Output:
> drivers/bluetooth/btrtl.c: note: in included file:drivers/bluetooth/btrtl=
.h:47:45: warning: array of flexible structures
>
>
> ---
> Regards,
> Linux Bluetooth

Id give a look at:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/tree/Documentation/driver-api/firmware/fw_upload.rst

There are not so many drivers since it was introduced last year but
from the looks of it it has a nice abstraction for handling firmware
uploads.


--=20
Luiz Augusto von Dentz
