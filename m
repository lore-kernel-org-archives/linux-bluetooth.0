Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09B95C7EE23
	for <linux-bluetooth@archiver.kernel.org>; Thu, 18 May 2023 16:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjERQME (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 18 May 2023 12:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjERQMC (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 18 May 2023 12:12:02 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF38171F
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 09:11:39 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2ac82912a59so23809751fa.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 May 2023 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684426297; x=1687018297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHK6swPbDWvg+CW1q3KaIR0ejawULIIDzMC+OAfhIqg=;
        b=c04W789Cyi+A6GVKk13qmYubqdOsbP7VTOavyjLpdZa0gpOxi6eXFTCOufyxhvHObj
         4fv0eHk9LrJrKBamN5Z2u3XPrCoJGFatnoLkVbsbLn4owDwKWRKDxfwmw5gf+qNqCGNu
         Xqdgx1gXQj8Ky3Z9gARB46U4mx5Sx6fDfuWae+uwfGWQo8YPbmvzOCJBBEc3iWxjysw4
         Yu8tc3qPByMxHm9lqNuTHfHotruEawxoPAwsKGXx++qM+iNrR3mBEZWv11L8H+PWH9fM
         VDRm5xV1DWi+wPjWxcfLHPKk5h5KZBEoanOL/A7CEWn+Af80UZOf7qD/CPJtdYraMhi7
         t0qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684426297; x=1687018297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AHK6swPbDWvg+CW1q3KaIR0ejawULIIDzMC+OAfhIqg=;
        b=D8hVYZyuatC63ACc2vaHaXG3t2ics1Fp7VUjXepNS8/0Iks99BZhBqDny1kYhlwLSs
         I6oawZ3x8bPgxLQQjNQKQTmSvxk32EFm5EFLc0qtjDP9+xVYH+f7cbPJHsEY5iIe2YEO
         7+2WiEudFyjKYt1KAMU3QbWJBFA9LWpf7anInD418LiECdMHKkFrSL5uB6mOBB64bj+r
         ejunkRgulUSG3Zjz7BRaYaDhoHiqdfAa3yxTrISP5fgbyyj/qiHTkWEE1r/Y2LNK2Rj8
         3ayCDQH1e977rCQJEECf0gK2VRyJyZrtGhKKAnX+8i8JfwP+7w+nwkqsCDCzq4mVV/MJ
         ocBw==
X-Gm-Message-State: AC+VfDxPB4slhY9f3IqE8riyv0DhLnblwsoekNox98xuJPqh35IUPyU+
        1vd+AzoWXtxYD0e9udxwJD1UYfLmNKPXCrgUjIdIUkCpo3c=
X-Google-Smtp-Source: ACHHUZ5A1MxmPkTAEHuwZUpnfHKayHWs4TAOlT4XzgQ2yGTMcYgQziY4NlBD2MpyU4Z5F98GwncmYf5I2iTzZi/mN2c=
X-Received: by 2002:a2e:8696:0:b0:2ac:8bc1:9cb1 with SMTP id
 l22-20020a2e8696000000b002ac8bc19cb1mr9648457lji.42.1684426296788; Thu, 18
 May 2023 09:11:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230518073540.2473673-1-neeraj.sanjaykale@nxp.com> <6465e45d.ca0a0220.6b14e.1682@mx.google.com>
In-Reply-To: <6465e45d.ca0a0220.6b14e.1682@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 18 May 2023 09:11:24 -0700
Message-ID: <CABBYNZJcw5EjL9nxdpQ+GzprimUd4dwM_m_M5zec_Suo0JuNWA@mail.gmail.com>
Subject: Re: [v2] Bluetooth: btnxpuart: Fix compiler warnings
To:     linux-bluetooth@vger.kernel.org
Cc:     neeraj.sanjaykale@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Neeraj,

On Thu, May 18, 2023 at 1:42=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D748=
779
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      0.72 seconds
> GitLint                       PASS      0.34 seconds
> SubjectPrefix                 PASS      0.10 seconds
> BuildKernel                   PASS      41.18 seconds
> CheckAllWarning               PASS      46.64 seconds
> CheckSparse                   PASS      51.56 seconds
> CheckSmatch                   PASS      139.75 seconds
> BuildKernel32                 PASS      41.00 seconds
> TestRunnerSetup               PASS      584.91 seconds
> TestRunner_l2cap-tester       PASS      20.78 seconds
> TestRunner_iso-tester         PASS      27.55 seconds
> TestRunner_bnep-tester        PASS      7.55 seconds
> TestRunner_mgmt-tester        PASS      143.95 seconds
> TestRunner_rfcomm-tester      PASS      11.24 seconds
> TestRunner_sco-tester         PASS      10.66 seconds
> TestRunner_ioctl-tester       PASS      12.65 seconds
> TestRunner_mesh-tester        PASS      9.53 seconds
> TestRunner_smp-tester         PASS      10.31 seconds
> TestRunner_userchan-tester    PASS      7.54 seconds
> IncrementalBuild              PASS      39.90 seconds

Perhaps we should use __maybe_unused like in the following change:

https://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.gi=
t/commit/?id=3D0811ff480978a2122f0465cb8682d9f7a2f6a169

>
>
> ---
> Regards,
> Linux Bluetooth
>


--=20
Luiz Augusto von Dentz
