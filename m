Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FB4C77B75
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 20:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbjEOUBz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 16:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbjEOUBv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 16:01:51 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21403A8B
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 13:01:48 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2ac733b813fso140810361fa.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684180906; x=1686772906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UE0eQEYWLc3WHxK2oPaSSAMBHkdScWxTfLuS2Wzggn0=;
        b=sOkDscODqV37n5zoDuUAwuGBId3lWiwfVek1DPWEzTog+LuQ5IT/b/3eeema9Ohf6w
         /TsFhKIzENLgXz1g6rhpE4x3Zi7BKePOlzxz2UFzacVvfeHJMg/2il5qN7fK/KuuKKaH
         advh8Pt+fGjx9gh0o1aPHSik+Opj03eq8VzaydZx60rE402LcDuSvYLRoIYOHl8PC7x9
         fS1GHJPYkDj55nm6IH4pvDW1OoDzDOdQmSoMeJiUluGj7Th+g5AoYAQZDPzVeYmdEEiR
         laqUPvQ0aHmaMYWoFEtQ4iECwni7zV+d/fBERXsiW67iRGuBzueEcRxVZeKKiSjtajOK
         hbwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684180906; x=1686772906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UE0eQEYWLc3WHxK2oPaSSAMBHkdScWxTfLuS2Wzggn0=;
        b=VU4yyPGodAnXnzzN8UMCbN3UalJKR1pkdiFf5yImy56AyW2t/tREIDYXAzKCUiMILC
         B1Uf6HJoK2sqGktgaMSVRGbAuzgcZLG9dj6eyNNhndc5dT0ecf9yy4UFHmdD+wRuLn9X
         L6npZ7pTu99v0e7bwE7Eu+rJpiP9twAlkWUN17XTdUU5dYNmER0XXbSZyxk5eybND3xD
         BUi7YN4+9dm4wY0/NhQ59Bhm9TwL7fC++DCJVUNcOdO8yIdxAcr8C3Z2c2YEt4fd+ki6
         4bN9QNEeONjfwGNDZs0Ks7k+J/NHPZhXHOBTfiBlW1DP0hTFI6YLC5MRY3qK5PODsdR6
         a2Yw==
X-Gm-Message-State: AC+VfDx+ZzStixW8W7F1olYgB7zQWs9Lr8ikL7eYcdLSWRV/y4zDQACh
        GxLXOE+lXkB6r7MGWnL70GVYeE8lpYNxMXaJQ2DWpCmrocE=
X-Google-Smtp-Source: ACHHUZ4WkfD8q4JDZ97U1/WcSEWGlAErYBXgzKjnLBnLfNvgUFX4baBcSzrvNNoSA49N4MM3s/0sxa2yWkD9CgUGL2g=
X-Received: by 2002:a2e:9456:0:b0:2a8:ae7e:b9cb with SMTP id
 o22-20020a2e9456000000b002a8ae7eb9cbmr7518232ljh.42.1684180906086; Mon, 15
 May 2023 13:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
 <645fc6ce.630a0220.1799b.9542@mx.google.com>
In-Reply-To: <645fc6ce.630a0220.1799b.9542@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 15 May 2023 13:01:33 -0700
Message-ID: <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
To:     linux-bluetooth@vger.kernel.org
Cc:     pav@iki.fi
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Sat, May 13, 2023 at 10:41=E2=80=AFAM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=3D747=
273
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      1.14 seconds
> GitLint                       PASS      0.52 seconds
> BuildEll                      PASS      26.21 seconds
> BluezMake                     PASS      745.32 seconds
> MakeCheck                     PASS      11.04 seconds
> MakeDistcheck                 PASS      151.18 seconds
> CheckValgrind                 PASS      243.86 seconds
> CheckSmatch                   PASS      326.99 seconds
> bluezmakeextell               PASS      98.83 seconds
> IncrementalBuild              PASS      1262.88 seconds
> ScanBuild                     WARNING   964.73 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script
> Output:
> [BlueZ,v3,1/2] test-runner: revert udevd and audio support
> WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52efb0751fab396b2b90=
26c9186b10b88', maybe rebased or not pulled?
> #49:
> This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
>
> WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b05c7edb74255c9b0929=
16ac5bb99c97f', maybe rebased or not pulled?
> #50:
> This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f
>
> /github/workspace/src/src/13240258.patch total: 0 errors, 2 warnings, 193=
 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inpl=
ace.
>
> /github/workspace/src/src/13240258.patch has style problems, please revie=
w.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FI=
LE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRIN=
G SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: ScanBuild - WARNING
> Desc: Run Scan Build
> Output:
> tools/test-runner.c:924:2: warning: 2nd function call argument is an unin=
itialized value
>         printf("Running command %s\n", cmdname ? cmdname : argv[0]);
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 1 warning generated.
>
>
>
> ---
> Regards,
> Linux Bluetooth

I tried running on fedora but it looks like something is missing in my setu=
p:

[E][00003.767959] spa.dbus     | [          dbus.c:  329
impl_connection_get()] Failed to connect to session bus: Unable to
autolaun1
[E][00003.769967] mod.portal   | [ module-portal.c:  326
pipewire__module_init()] Failed to connect to session bus:
Input/output error


--=20
Luiz Augusto von Dentz
