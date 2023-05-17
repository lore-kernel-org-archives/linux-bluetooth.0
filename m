Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9B3AC77B75
	for <linux-bluetooth@archiver.kernel.org>; Wed, 17 May 2023 19:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjEQTe2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 17 May 2023 15:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjEQTe1 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 17 May 2023 15:34:27 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CFE197
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 12:34:26 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2acb6571922so11800751fa.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 May 2023 12:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684352064; x=1686944064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4Vi9hi2LsSoitxx/ERLJ9nfHz9JDKCq39f8XWxLBVI=;
        b=HPI9EXnCPurM7x8Kk5Faf0dBy1a1RdQH6xjYzIhnYMiEnUpaENQfoxjZn0h0URFid2
         o8hZVixcpb2L9hIAZHEE/k2AqKJAbBtaqo0EIal383fP+9bT6l9lrYWbHWKbGCqqxXB0
         yFn3q1lvjHexZ4d9xM5FSJvWFK7QQvvN6bRmBod/mKk6eLqGPIO0Ayi8JBOxCZ6gSJZd
         MXdZVkY4568nFHKJo9+cmd+acYjWgn4nXobQf8ej/YqtGFdyqR+E+azZ7X9ogq0Gu+R3
         1ltg1R0KOJaYFuTXkVwW5O4Dx6bbrAdV6bQIlKpoHknvnM48lSKTGn+u1RSPDGbum3Jm
         LmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684352064; x=1686944064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B4Vi9hi2LsSoitxx/ERLJ9nfHz9JDKCq39f8XWxLBVI=;
        b=R/q3IN6mChGgx+pSARQ/dx0La9nJVkh462l4YB0sNRs1w59f3mvjzw/2C/EBNnIT3D
         kPziWe8Kr+P94bUYkbKV7N0l2FMofrdV2OC+mPj5OVd2GxpDAH9RtU8oKskpiccAUih5
         xVI/Fv/fLjiQDlhK2qo7JZxj99L2Dr+ERcn5yrybLI6liF0mbJjrMe4fWlAD7898VHmA
         GiQmwG1WEpnhntuolMc1uMW2s8XbpSy6guxpuM4IURq9ONiFz4loZQcqci6XEEIGT6tR
         82xmZTuQih1lKuxGsEjsQOnlNmM1Eo/poEGjqFuhNcPR44ii/thEx9oOW/FdKliGpAks
         o+LQ==
X-Gm-Message-State: AC+VfDwWEnZKqcQRE9Hs660iMrqkHYau64DW/uJmdZ0MNLwz+cH5Sb5Q
        BSf9KLAiQ/KoxXZ92LGgb9F/Gf/pV4CqhmaWC+eTd4I4amE=
X-Google-Smtp-Source: ACHHUZ6OYxDqGvbT9RmwWShGs8RNqUXA99lirWCsoc1p4d52t8DAzF5fwDjMCztuAQVuXPc3l5YsI2qJ4W/mJDa4/d8=
X-Received: by 2002:a2e:7403:0:b0:2a9:b6fe:18c5 with SMTP id
 p3-20020a2e7403000000b002a9b6fe18c5mr10079099ljc.52.1684352063853; Wed, 17
 May 2023 12:34:23 -0700 (PDT)
MIME-Version: 1.0
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
 <645fc6ce.630a0220.1799b.9542@mx.google.com> <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
 <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi>
In-Reply-To: <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 17 May 2023 12:34:11 -0700
Message-ID: <CABBYNZKu7pPE0EddZyzv1mbEW0nePOzf_dawkDJ-e6+ReJvS-A@mail.gmail.com>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On Mon, May 15, 2023 at 1:30=E2=80=AFPM Pauli Virtanen <pav@iki.fi> wrote:
>
> Hi Luiz,
>
> ma, 2023-05-15 kello 13:01 -0700, Luiz Augusto von Dentz kirjoitti:
> > Hi Pauli,
> >
> > On Sat, May 13, 2023 at 10:41=E2=80=AFAM <bluez.test.bot@gmail.com> wro=
te:
> > >
> > > This is automated email and please do not reply to this email!
> > >
> > > Dear submitter,
> > >
> > > Thank you for submitting the patches to the linux bluetooth mailing l=
ist.
> > > This is a CI test results with your patch series:
> > > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=
=3D747273
> > >
> > > ---Test result---
> > >
> > > Test Summary:
> > > CheckPatch                    FAIL      1.14 seconds
> > > GitLint                       PASS      0.52 seconds
> > > BuildEll                      PASS      26.21 seconds
> > > BluezMake                     PASS      745.32 seconds
> > > MakeCheck                     PASS      11.04 seconds
> > > MakeDistcheck                 PASS      151.18 seconds
> > > CheckValgrind                 PASS      243.86 seconds
> > > CheckSmatch                   PASS      326.99 seconds
> > > bluezmakeextell               PASS      98.83 seconds
> > > IncrementalBuild              PASS      1262.88 seconds
> > > ScanBuild                     WARNING   964.73 seconds
> > >
> > > Details
> > > ##############################
> > > Test: CheckPatch - FAIL
> > > Desc: Run checkpatch.pl script
> > > Output:
> > > [BlueZ,v3,1/2] test-runner: revert udevd and audio support
> > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52efb0751fab396b=
2b9026c9186b10b88', maybe rebased or not pulled?
> > > #49:
> > > This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
> > >
> > > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b05c7edb74255c9b=
092916ac5bb99c97f', maybe rebased or not pulled?
> > > #50:
> > > This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f
> > >
> > > /github/workspace/src/src/13240258.patch total: 0 errors, 2 warnings,=
 193 lines checked
> > >
> > > NOTE: For some of the reported defects, checkpatch may be able to
> > >       mechanically convert to the typical style using --fix or --fix-=
inplace.
> > >
> > > /github/workspace/src/src/13240258.patch has style problems, please r=
eview.
> > >
> > > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUC=
T FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_S=
TRING SSCANF_TO_KSTRTO
> > >
> > > NOTE: If any of the errors are false positives, please report
> > >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > >
> > >
> > > ##############################
> > > Test: ScanBuild - WARNING
> > > Desc: Run Scan Build
> > > Output:
> > > tools/test-runner.c:924:2: warning: 2nd function call argument is an =
uninitialized value
> > >         printf("Running command %s\n", cmdname ? cmdname : argv[0]);
> > >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > 1 warning generated.
> > >
> > >
> > >
> > > ---
> > > Regards,
> > > Linux Bluetooth
> >
> > I tried running on fedora but it looks like something is missing in my =
setup:
> >
> > [E][00003.767959] spa.dbus     | [          dbus.c:  329
> > impl_connection_get()] Failed to connect to session bus: Unable to
> > autolaun1
> > [E][00003.769967] mod.portal   | [ module-portal.c:  326
> > pipewire__module_init()] Failed to connect to session bus:
> > Input/output error
>
> I have those two "errors" too, they should be harmless as the xdg-
> desktop-portal module is optional. With `test-runner -d -l -A` you
> should get the Bluetooth endpoints to appear.
>
> Removing the mod.portal from the configuration can't be done with drop-
> in config files currently, and I didn't want to include a full config
> file here as it has some tens of lines of mandatory boilerplate.

Ok, looks like it configuring the endpoints:

https://gist.github.com/Vudentz/0d8851e719affd9f2dc1f4081ce32fb7

That said I probably need to compile pipewire from source in order to
have the LE Audio endpoints registered, btw do you have any
instructions on how to build it, do I need to build wireplumber as
well?

>
> --
> Pauli Virtanen



--=20
Luiz Augusto von Dentz
