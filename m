Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD7BEB64DA
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Jun 2023 23:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjF3XjU (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Jun 2023 19:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjF3XjT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Jun 2023 19:39:19 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60AA01BD4
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 16:39:17 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-98d34f1e54fso265690466b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 16:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1688168355; x=1690760355;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fjgW10LhifPu4PseZV37V4ELGcXEnQIRm+6LdDC5j2s=;
        b=j/siMzj8NQ+siVJMpR86qIXgKE/9pewnrdZNwr3BSB0UiUlM1vaiKpmGiwIcteVbQY
         U31RqGTlrYIoeWxLN25NMxtTUErKCLbqPus8jwJL2LpZxrneE6Dy5py9UbaPTdoNw6+O
         Y3xH2mLBguW0tEBZvWs3Qjqp6JlS3bOA3CHpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688168355; x=1690760355;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fjgW10LhifPu4PseZV37V4ELGcXEnQIRm+6LdDC5j2s=;
        b=P5Ho7jOrsUBBDLifCimJDQTxVLOEBERg3qrGuu0w9yZMKiC9P/ThLNUFD34CaA7K4f
         3w2DxJ3xo0JPE3S58dBbxqDFzxoTj78qp2pR8LATQsmid+Nb1SlJnJZjaq7Kgf9E/8RH
         c7KzwI3pYgqibrZKgdjglYmK2RTJvzEwh+goRtPhpriemKDGjLgrMqDCkeOhOiqw711l
         PZaotFFEz2r7aU4FandJiEqbzOhSef4Gc5fgM3yqhFUg0fgDmxrksk9O5x3iZgUfexfr
         04D2uvZiqHks+s0BSU0oVgDHARpAALPahIiWM8ex7WX63Sbre7r9FdNEQcnZ81wMVYhY
         lPPQ==
X-Gm-Message-State: ABy/qLa7opKwn20VfS2mPzDoXr9Qf3u0Ny6odd7QvE97RSWlTGXotGKL
        x49MQVwp3cXZh7kfucSuci48uG1me4T7b/ME9MDxzg==
X-Google-Smtp-Source: APBJJlEppyiQB9W/3/fg9iwhlaYufv6zG0/cUSQN+yv8UfUv2xPMcod3ZVuPx87uxNydHe4c2ONvGw==
X-Received: by 2002:a17:906:4dc6:b0:988:3ce8:c5bf with SMTP id f6-20020a1709064dc600b009883ce8c5bfmr2536149ejw.33.1688168355390;
        Fri, 30 Jun 2023 16:39:15 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id ot6-20020a170906ccc600b0098df7d0e096sm8274575ejb.54.2023.06.30.16.39.14
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 16:39:15 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-51ddbf83ff9so3656a12.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Jun 2023 16:39:14 -0700 (PDT)
X-Received: by 2002:a50:d544:0:b0:50b:c48c:8a25 with SMTP id
 f4-20020a50d544000000b0050bc48c8a25mr34445edj.6.1688168354646; Fri, 30 Jun
 2023 16:39:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230630153315.v3.1.I3b7c8905728f3124576361ca35ed28e37f12f5d1@changeid>
 <649f5e38.170a0220.6a5f7.574a@mx.google.com>
In-Reply-To: <649f5e38.170a0220.6a5f7.574a@mx.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 30 Jun 2023 16:39:02 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WnF5RAgC2M8xxx9p1KoQDk_iL8Kug2aT6X9S9vSuxAyg@mail.gmail.com>
Message-ID: <CAD=FV=WnF5RAgC2M8xxx9p1KoQDk_iL8Kug2aT6X9S9vSuxAyg@mail.gmail.com>
Subject: Re: [v3,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_adv_monitor()
To:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Fri, Jun 30, 2023 at 3:59=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D761=
691
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.10 seconds
> GitLint                       FAIL      0.77 seconds
> SubjectPrefix                 PASS      0.16 seconds
> BuildKernel                   PASS      32.78 seconds
> CheckAllWarning               PASS      35.74 seconds
> CheckSparse                   PASS      40.37 seconds
> CheckSmatch                   PASS      112.19 seconds
> BuildKernel32                 PASS      31.17 seconds
> TestRunnerSetup               PASS      447.30 seconds
> TestRunner_l2cap-tester       PASS      13.11 seconds
> TestRunner_iso-tester         PASS      23.69 seconds
> TestRunner_bnep-tester        PASS      5.58 seconds
> TestRunner_mgmt-tester        PASS      132.56 seconds
> TestRunner_rfcomm-tester      PASS      9.05 seconds
> TestRunner_sco-tester         PASS      10.42 seconds
> TestRunner_ioctl-tester       PASS      9.73 seconds
> TestRunner_mesh-tester        PASS      7.02 seconds
> TestRunner_smp-tester         PASS      8.21 seconds
> TestRunner_userchan-tester    PASS      5.80 seconds
> IncrementalBuild              PASS      35.20 seconds
>
> Details
> ##############################
> Test: GitLint - FAIL
> Desc: Run gitlint
> Output:
> [v3,1/2] Bluetooth: hci_sync: Avoid use-after-free in dbg for hci_remove_=
adv_monitor()
>
> WARNING: I3 - ignore-body-lines: gitlint will be switching from using Pyt=
hon regex 'match' (match beginning) to 'search' (match anywhere) semantics.=
 Please review your ignore-body-lines.regex option accordingly. To remove t=
his warning, set general.regex-style-search=3DTrue. More details: https://j=
orisroovers.github.io/gitlint/configuration/#regex-style-search
> 1: T1 Title exceeds max length (86>80): "[v3,1/2] Bluetooth: hci_sync: Av=
oid use-after-free in dbg for hci_remove_adv_monitor()"

I'll plan to ignore this one. It looks like it only exceeds 80
characters because of the version prefix "[v3, 1/2] ". If someone
really wants me to re-post with a shorter subject, please yell and I
will do that.

Thanks!

-Doug
