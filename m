Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2676C77B7D
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 May 2023 20:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbjEOUbA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 May 2023 16:31:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245388AbjEOUa6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 May 2023 16:30:58 -0400
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271FA100C0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 13:30:56 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 8C225240038
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 May 2023 22:30:55 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4QKrbz03vBz9rxN;
        Mon, 15 May 2023 22:30:54 +0200 (CEST)
Message-ID: <87eda7c7bdb8479f6233b6709e5c21de0535fdfc.camel@iki.fi>
Subject: Re: [BlueZ,v3,1/2] test-runner: revert udevd and audio support
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org
Date:   Mon, 15 May 2023 20:30:54 +0000
In-Reply-To: <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
References: <fcd0cc37474487489e2567f3de7d90f1b62d9613.1683994090.git.pav@iki.fi>
         <645fc6ce.630a0220.1799b.9542@mx.google.com>
         <CABBYNZLUQOQ-gTdCAeUNknEkgQenmVQhahrog+8CL4y87PZKBg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

ma, 2023-05-15 kello 13:01 -0700, Luiz Augusto von Dentz kirjoitti:
> Hi Pauli,
> 
> On Sat, May 13, 2023 at 10:41 AM <bluez.test.bot@gmail.com> wrote:
> > 
> > This is automated email and please do not reply to this email!
> > 
> > Dear submitter,
> > 
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=747273
> > 
> > ---Test result---
> > 
> > Test Summary:
> > CheckPatch                    FAIL      1.14 seconds
> > GitLint                       PASS      0.52 seconds
> > BuildEll                      PASS      26.21 seconds
> > BluezMake                     PASS      745.32 seconds
> > MakeCheck                     PASS      11.04 seconds
> > MakeDistcheck                 PASS      151.18 seconds
> > CheckValgrind                 PASS      243.86 seconds
> > CheckSmatch                   PASS      326.99 seconds
> > bluezmakeextell               PASS      98.83 seconds
> > IncrementalBuild              PASS      1262.88 seconds
> > ScanBuild                     WARNING   964.73 seconds
> > 
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script
> > Output:
> > [BlueZ,v3,1/2] test-runner: revert udevd and audio support
> > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id '91a48af52efb0751fab396b2b9026c9186b10b88', maybe rebased or not pulled?
> > #49:
> > This reverts commit 91a48af52efb0751fab396b2b9026c9186b10b88
> > 
> > WARNING:UNKNOWN_COMMIT_ID: Unknown commit id 'e20e7e0b05c7edb74255c9b092916ac5bb99c97f', maybe rebased or not pulled?
> > #50:
> > This reverts commit e20e7e0b05c7edb74255c9b092916ac5bb99c97f
> > 
> > /github/workspace/src/src/13240258.patch total: 0 errors, 2 warnings, 193 lines checked
> > 
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> > 
> > /github/workspace/src/src/13240258.patch has style problems, please review.
> > 
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> > 
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> > 
> > 
> > ##############################
> > Test: ScanBuild - WARNING
> > Desc: Run Scan Build
> > Output:
> > tools/test-runner.c:924:2: warning: 2nd function call argument is an uninitialized value
> >         printf("Running command %s\n", cmdname ? cmdname : argv[0]);
> >         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 warning generated.
> > 
> > 
> > 
> > ---
> > Regards,
> > Linux Bluetooth
> 
> I tried running on fedora but it looks like something is missing in my setup:
> 
> [E][00003.767959] spa.dbus     | [          dbus.c:  329
> impl_connection_get()] Failed to connect to session bus: Unable to
> autolaun1
> [E][00003.769967] mod.portal   | [ module-portal.c:  326
> pipewire__module_init()] Failed to connect to session bus:
> Input/output error

I have those two "errors" too, they should be harmless as the xdg-
desktop-portal module is optional. With `test-runner -d -l -A` you
should get the Bluetooth endpoints to appear.

Removing the mod.portal from the configuration can't be done with drop-
in config files currently, and I didn't want to include a full config
file here as it has some tens of lines of mandatory boilerplate.

-- 
Pauli Virtanen
