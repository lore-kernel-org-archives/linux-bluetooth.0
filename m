Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CDCEE020D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Sep 2023 20:44:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIMUoY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Sep 2023 16:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjIMUoX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Sep 2023 16:44:23 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7E1BCA
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 13:44:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b962c226ceso3496661fa.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Sep 2023 13:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694637857; x=1695242657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H5wfGspt98vW32O2xut3uMlrNjwVCauAhcHD9R4JsKs=;
        b=oiYBouJUU+LLZdsPFooCNgNjHPXj3Gkv9e60oGGoAvou/P4UmhjKwf57jD4ES6VhJd
         wZsHkwt6nJdmYpxebxFb1EuRpp+0jSi26tEEMee5ZPWpDDDI4PSTEhSz9dwaQDcCdcVn
         zCPydTlVzo1LCmuAfBeM5KDt/N0mgD6cOfWj/0dPt6tNVrvkFh+QXadO6qntl6HHbohg
         +/HTyjkgs1vsryeN+/uaovQQfAeN7N3veOAPWzmvK/gKWVs5CDZh2ajQWvtFF3qOjhq7
         KEIq8hmrTwMI0+SY6ipfWh0V9zhJdsHTshb6GRDocqu/EG1s+oydD8GjpiPTMETQxvwJ
         nOYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694637857; x=1695242657;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H5wfGspt98vW32O2xut3uMlrNjwVCauAhcHD9R4JsKs=;
        b=D68JgxI+YEOI2eW7WgAsvdYlmPsnItmkjn9BCP8ubuTe5uZNZLv4RWgWrRXfxEHNNa
         ywBZz2g9FVaOqpX73qd+P3aEQTRKG4QAfB2CIBenOuuA0dXIHlk3LomdaWnMK/+5dgII
         /S9WbS+aKUs7Net7XHFkq/Io6n4nm++TaDw4QYeWIpbQkMjsmtXaDZP/MG59qwWnd9vl
         +cFfOEzEs/wFq7YG/o2yMbsx9l0KllqiQYvCMe6qB7D0elFQufMsKeUDyUl49gFnRHki
         4GaEUlHE3KfkFXwur2VL8dt8hxmAcr21zvZxMVSZDdUrSt+Xa/Sj9kZuRlIJQEVlFb/2
         sH6g==
X-Gm-Message-State: AOJu0YxCPZrdNmBC/uHGNqZO7z5us3LgcEPxG5g5er9kIp0uS1Cqi/PY
        lcejjBOdsON+yd+GHAzzHcvcH7ccKI23lFBbuCWY+v4n
X-Google-Smtp-Source: AGHT+IFmCpMWWdN26vpnOvlZFvMRTp5P8aNqisKfLezfaw73ZO1zG2H1pwX1/jRJoZsBuFDPG0a0U4SHe+O0PpVH5so=
X-Received: by 2002:a2e:9817:0:b0:2b9:b693:c906 with SMTP id
 a23-20020a2e9817000000b002b9b693c906mr3093821ljj.27.1694637856499; Wed, 13
 Sep 2023 13:44:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230913193839.3029428-1-luiz.dentz@gmail.com> <65021d28.020a0220.6f2d9.5519@mx.google.com>
In-Reply-To: <65021d28.020a0220.6f2d9.5519@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 13 Sep 2023 13:44:04 -0700
Message-ID: <CABBYNZLSsyh96AphQBOckn+Y3SUX2MuXL8UiqMwMh7pZqX8mzg@mail.gmail.com>
Subject: Re: Bluetooth: L2CAP: Fix leaking l2cap_conn objects
To:     linux-bluetooth@vger.kernel.org
Cc:     "Olivier L'Heureux" <olivier.lheureux@mind.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Olivier,

On Wed, Sep 13, 2023 at 1:35=E2=80=AFPM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D783=
902
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.28 seconds
> GitLint                       PASS      0.33 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      32.82 seconds
> CheckAllWarning               PASS      35.82 seconds
> CheckSparse                   PASS      40.91 seconds
> CheckSmatch                   PASS      115.39 seconds
> BuildKernel32                 PASS      31.58 seconds
> TestRunnerSetup               PASS      481.60 seconds
> TestRunner_l2cap-tester       PASS      27.15 seconds
> TestRunner_iso-tester         PASS      47.77 seconds
> TestRunner_bnep-tester        PASS      10.25 seconds
> TestRunner_mgmt-tester        PASS      217.08 seconds
> TestRunner_rfcomm-tester      PASS      15.95 seconds
> TestRunner_sco-tester         PASS      19.14 seconds
> TestRunner_ioctl-tester       PASS      17.60 seconds
> TestRunner_mesh-tester        PASS      13.02 seconds
> TestRunner_smp-tester         PASS      14.12 seconds
> TestRunner_userchan-tester    PASS      10.90 seconds
> IncrementalBuild              PASS      29.64 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> Bluetooth: L2CAP: Fix leaking l2cap_conn objects
> WARNING: Reported-by: should be immediately followed by Closes: with a UR=
L to the report
> #88:
> Reported-by: Olivier L'Heureux <olivier.lheureux@fortrobotics.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> total: 0 errors, 1 warnings, 0 checks, 84 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /github/workspace/src/src/13383710.patch has style problems, please revie=
w.
>
> NOTE: Ignored message types: UNKNOWN_COMMIT_ID
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>

Would you be able to check if this would fix the problem for you? I
will be working on a way to reproduce it with the timeout as well,
just want a quick validation before doing it.

--=20
Luiz Augusto von Dentz
