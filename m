Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33124C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 29 Mar 2022 20:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbiC2UVz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 29 Mar 2022 16:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbiC2UVy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 29 Mar 2022 16:21:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8FDE1255
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:20:10 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id x20so33392903ybi.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 29 Mar 2022 13:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=k2F4+mqWWR0O/doidNDboOaqzlCmX1plu/SZQo971+8=;
        b=KrzusfN6ZPx/aZmABaLThnQz3RmrHUxUi3h10EZ2IfECYNkUCc7VIDlHIGhruXinFT
         qb7QNhbfVV9d38jNXAbOrB+OwXxs+3Zaawaq9MxpPHJIHAb+G3M+S4E43X3ydmTJs2qt
         Bjb2kfCobJ1CQvj7D17YmebaqFAmFT5lk1wm6mUGc4u6p/LptD4mCRE6KdWb4GNrhTSv
         Kdf+35P7WCuRk8YPdJ2924RfPUayatlMLVibPMa9OhX4PEG2acP9+xTdaSMJ+YfumhWH
         QBruCUJdoxEOYNIXA/6IafIsDl6feJYtE4pdRAr5XGlilxkIdRrzmPI0zJ998h1VBzFv
         cV8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=k2F4+mqWWR0O/doidNDboOaqzlCmX1plu/SZQo971+8=;
        b=wTr702MbWCHRME6emVL+18qhsT5qz9cR+fpjP0Rzz91WaqtZUvBc2zRCqbslFmsTBG
         b4UL2DqrQ8CdslBR6sxjn51kct5K3wLBoqq0rqWpEVOaUsN80m5s9tcK0v6vLdTvVR/P
         XlwSHrRpQ+Wskd8xwKKrkllfJayazad7pTWr0TaSQM1Al85gODqZCjzuup9kqgQxUmww
         qw/LS/r0PJjQXrLnW0RF43NpZHBoxbbsuwt4I61DsshyoVSryhUj7eGnJ13aHw8CkRqj
         AegbRCvhJsjGApd53DJW55/rDUxA6cggywsL+Yo49be4S/5eHqL6Rxo/DTGPW8A10/rK
         u1ng==
X-Gm-Message-State: AOAM530Vq/EuFWX5ejYnSUkA+OZTrAk1kYpdkPdjgHMX1joh0+y6RoLh
        +2mtnDmbwNA1TS7abbyg6HUkbyzjlHbpgLaZwC715+Q6
X-Google-Smtp-Source: ABdhPJw6uveNRnUQEevTweb998Of1v4NgRcRFTHvgYe1EusXyKpmTofcIds34dR6M1orBy7XbAMCqeGLn+BtF0TyJaw=
X-Received: by 2002:a25:a467:0:b0:61e:1b4a:7700 with SMTP id
 f94-20020a25a467000000b0061e1b4a7700mr30108820ybi.390.1648585209646; Tue, 29
 Mar 2022 13:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220320183445.BlueZ.1.I21d5ed25e9a0a2427bddbd6d4ec04d80d735fc53@changeid>
 <6237f8da.1c69fb81.51355.519c@mx.google.com>
In-Reply-To: <6237f8da.1c69fb81.51355.519c@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 29 Mar 2022 13:19:58 -0700
Message-ID: <CABBYNZ+H6iMY=vHOEOhGPzbw-L7w3oAdwdKM-KROgx1WzTjWAw@mail.gmail.com>
Subject: Re: [BlueZ,1/9] adv_monitor: Disable RSSIHighTimeout for SW based filtering
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Manish Mandlik <mmandlik@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Manish,

On Mon, Mar 21, 2022 at 4:53 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D624=
998
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      13.09 seconds
> GitLint                       PASS      8.89 seconds
> Prep - Setup ELL              PASS      46.69 seconds
> Build - Prep                  PASS      0.76 seconds
> Build - Configure             PASS      9.23 seconds
> Build - Make                  FAIL      1504.46 seconds
> Make Check                    FAIL      2.42 seconds
> Make Check w/Valgrind         FAIL      324.61 seconds
> Make Distcheck                FAIL      173.77 seconds
> Build w/ext ELL - Configure   PASS      9.30 seconds
> Build w/ext ELL - Make        FAIL      1466.64 seconds
> Incremental Build with patchesFAIL      4186.16 seconds
>
> Details
> ##############################
> Test: Build - Make - FAIL
> Desc: Build the BlueZ source tree
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avdtp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avdtp.c:766:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   766 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avrcp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avrcp.c:989:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   989 | int main(int argc, char *argv[])
>       |     ^~~~
> src/adv_monitor.c: In function =E2=80=98btd_adv_monitor_resume=E2=80=99:
> src/adv_monitor.c:2402:7: error: implicit declaration of function =E2=80=
=98btd_adv_monitor_offload_supported=E2=80=99; did you mean =E2=80=98btd_ad=
v_monitor_offload_enabled=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
>  2402 |  if (!btd_adv_monitor_offload_supported(manager))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       btd_adv_monitor_offload_enabled
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:10284: src/bluetoothd-adv_monitor.o] Error 1
> make: *** [Makefile:4307: all] Error 2
>
>
> ##############################
> Test: Make Check - FAIL
> Desc: Run 'make check'
> Output:
> src/adv_monitor.c: In function =E2=80=98btd_adv_monitor_resume=E2=80=99:
> src/adv_monitor.c:2402:7: error: implicit declaration of function =E2=80=
=98btd_adv_monitor_offload_supported=E2=80=99; did you mean =E2=80=98btd_ad=
v_monitor_offload_enabled=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
>  2402 |  if (!btd_adv_monitor_offload_supported(manager))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       btd_adv_monitor_offload_enabled
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:10284: src/bluetoothd-adv_monitor.o] Error 1
> make: *** [Makefile:11277: check] Error 2
>
>
> ##############################
> Test: Make Check w/Valgrind - FAIL
> Desc: Run 'make check' with Valgrind
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> src/adv_monitor.c: In function =E2=80=98btd_adv_monitor_resume=E2=80=99:
> src/adv_monitor.c:2402:7: error: implicit declaration of function =E2=80=
=98btd_adv_monitor_offload_supported=E2=80=99; did you mean =E2=80=98btd_ad=
v_monitor_offload_enabled=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
>  2402 |  if (!btd_adv_monitor_offload_supported(manager))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       btd_adv_monitor_offload_enabled
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:10284: src/bluetoothd-adv_monitor.o] Error 1
> make: *** [Makefile:4307: all] Error 2
>
>
> ##############################
> Test: Make Distcheck - FAIL
> Desc: Run distcheck to check the distribution
> Output:
> ../../src/adv_monitor.c: In function =E2=80=98btd_adv_monitor_resume=E2=
=80=99:
> ../../src/adv_monitor.c:2402:7: warning: implicit declaration of function=
 =E2=80=98btd_adv_monitor_offload_supported=E2=80=99; did you mean =E2=80=
=98btd_adv_monitor_offload_enabled=E2=80=99? [-Wimplicit-function-declarati=
on]
>  2402 |  if (!btd_adv_monitor_offload_supported(manager))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       btd_adv_monitor_offload_enabled
> /usr/bin/ld: src/bluetoothd-adv_monitor.o: in function `btd_adv_monitor_r=
esume':
> /github/workspace/src/bluez-5.63/_build/sub/../../src/adv_monitor.c:2402:=
 undefined reference to `btd_adv_monitor_offload_supported'
> collect2: error: ld returned 1 exit status
> make[2]: *** [Makefile:5878: src/bluetoothd] Error 1
> make[1]: *** [Makefile:4307: all] Error 2
> make: *** [Makefile:11198: distcheck] Error 1
>
>
> ##############################
> Test: Build w/ext ELL - Make - FAIL
> Desc: Build BlueZ source with '--enable-external-ell' configuration
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avdtp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avdtp.c:766:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   766 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avrcp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avrcp.c:989:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   989 | int main(int argc, char *argv[])
>       |     ^~~~
> src/adv_monitor.c: In function =E2=80=98btd_adv_monitor_resume=E2=80=99:
> src/adv_monitor.c:2402:7: error: implicit declaration of function =E2=80=
=98btd_adv_monitor_offload_supported=E2=80=99; did you mean =E2=80=98btd_ad=
v_monitor_offload_enabled=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
>  2402 |  if (!btd_adv_monitor_offload_supported(manager))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       btd_adv_monitor_offload_enabled
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:10284: src/bluetoothd-adv_monitor.o] Error 1
> make: *** [Makefile:4307: all] Error 2
>
>
> ##############################
> Test: Incremental Build with patches - FAIL
> Desc: Incremental build per patch in the series
> Output:
> tools/mgmt-tester.c: In function =E2=80=98main=E2=80=99:
> tools/mgmt-tester.c:12364:5: note: variable tracking size limit exceeded =
with =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
> 12364 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avdtp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avdtp.c:766:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   766 | int main(int argc, char *argv[])
>       |     ^~~~
> unit/test-avrcp.c: In function =E2=80=98main=E2=80=99:
> unit/test-avrcp.c:989:5: note: variable tracking size limit exceeded with=
 =E2=80=98-fvar-tracking-assignments=E2=80=99, retrying without
>   989 | int main(int argc, char *argv[])
>       |     ^~~~
> src/adv_monitor.c: In function =E2=80=98btd_adv_monitor_resume=E2=80=99:
> src/adv_monitor.c:2308:7: error: implicit declaration of function =E2=80=
=98btd_adv_monitor_offload_supported=E2=80=99; did you mean =E2=80=98btd_ad=
v_monitor_offload_enabled=E2=80=99? [-Werror=3Dimplicit-function-declaratio=
n]
>  2308 |  if (!btd_adv_monitor_offload_supported(manager))
>       |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |       btd_adv_monitor_offload_enabled
> cc1: all warnings being treated as errors
> make[1]: *** [Makefile:10284: src/bluetoothd-adv_monitor.o] Error 1
> make: *** [Makefile:4307: all] Error 2

Will you be fixing the errors above?

--=20
Luiz Augusto von Dentz
