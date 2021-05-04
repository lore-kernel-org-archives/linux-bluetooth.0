Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3328C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 18:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC367613C7
	for <linux-bluetooth@archiver.kernel.org>; Tue,  4 May 2021 18:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEDS7q (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 4 May 2021 14:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhEDS7n (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 4 May 2021 14:59:43 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22076C061574
        for <linux-bluetooth@vger.kernel.org>; Tue,  4 May 2021 11:58:47 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id y2so13538028ybq.13
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 May 2021 11:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5w2Je0XCMedGvAp8cl8VHBTgt2OvL8+CKqQ1DKlnFjg=;
        b=pRX8ayBlqP9Bt1PhfiosM5koRxMUE+JMrAasI4AoWiNKNjHotezLRGUg5No7g0kO7s
         gC70kICBCHP081eqWosHIJjQD3+4MB7vi7Ycl3Hk4yXl+sPzBJXgYC/92/an2e8sRQe8
         OI/1TG4YBgI2H6s7wpN3QFQYjaxtLauztP4EWoKaX4sigeGMFRF4VukFzOcYYu6cRsnw
         vZa0hIID7h8r5HDxNrL4bpTMohdqK+R9Bv208R03/LhpmHoEtLKhr315UN85F54Ys2Zt
         e+ocAPfp8yvW574dvh9kITMH4WajlmWh5q0zECZjKCVAdYCaYTvtgsbmLUGmAHzESjE/
         LOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5w2Je0XCMedGvAp8cl8VHBTgt2OvL8+CKqQ1DKlnFjg=;
        b=fs0dHKcQUbcX2kxFeBdY7Ch7IQK1KmmXmtGp/1PRvStDOfG8v9pb+pmOQqVqCg6K53
         o3domTd87l6lsCJ8FCfCS96/O2h0HmiNyt/dkzLNmFHiv0mhTnLBL5LUrYOLQa23Uz4K
         L2UdadocGkWKlqSmIoMAuH7buvzZNNopyOhD0apnUSSEWY8umXtJ2B9i8RUbhqa7BtGB
         vUbxaVRF27sQaAbJy7u78XSG40iurpy9Qr7AkcQvsdy/wgR30qCTcVzZMPpMtNJThuxj
         OK4scuksMDlxvlX0t8aoF4zCwQK/dK33UriCSzz9kZfY9dJIC4hHxOF1ggdUNugSOQ8T
         dQHw==
X-Gm-Message-State: AOAM5321MPkYanzDuD8Sdrjjx3dAvD86MS/iijFfB3sHtFsXqt3cD5X4
        H+Cb6P76GBjCiMoheMop9Rv8MB/OYDyVNYirLTAJ+SH7
X-Google-Smtp-Source: ABdhPJxTtREfSdyrkuIr3C3Jw3vLe5a6fB7YF2772/pO+vCtkhvkQZVxPRLcs/i2ypCp6fMq2Tgbpzz+4NZ3Y/8aVow=
X-Received: by 2002:a25:a466:: with SMTP id f93mr6991320ybi.264.1620154726270;
 Tue, 04 May 2021 11:58:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210504050207.841261-2-hj.tedd.an@gmail.com> <60910961.1c69fb81.d76ca.db48@mx.google.com>
 <4e7e5ab6161ab4852efc26a3bcd01f2d84b16749.camel@gmail.com>
In-Reply-To: <4e7e5ab6161ab4852efc26a3bcd01f2d84b16749.camel@gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 4 May 2021 11:58:35 -0700
Message-ID: <CABBYNZJdnBXSEczXOP_y5vNrzSTU5hBC0U-PZE42x8aW4ZSO8w@mail.gmail.com>
Subject: Re: Convert manpages to rst format
To:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, May 4, 2021 at 11:25 AM Tedd Ho-Jeong An <hj.tedd.an@gmail.com> wrote:
>
> Hi
>
> On Tue, 2021-05-04 at 01:44 -0700, bluez.test.bot@gmail.com wrote:
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=476657
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      1.09 seconds
> > GitLint                       PASS      0.49 seconds
> > Prep - Setup ELL              PASS      48.06 seconds
> > Build - Prep                  PASS      0.11 seconds
> > Build - Configure             PASS      8.27 seconds
> > Build - Make                  PASS      205.97 seconds
> > Make Check                    PASS      9.56 seconds
> > Make Dist                     PASS      13.28 seconds
> > Make Dist - Configure         PASS      5.14 seconds
> > Make Dist - Make              PASS      82.48 seconds
> > Build w/ext ELL - Configure   PASS      8.44 seconds
> > Build w/ext ELL - Make        PASS      191.12 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > Output:
> > monitor: Convert manpage to rst format
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #125: FILE: monitor/btmon.rst:1:
> > +=====
> >
> > - total: 0 errors, 1 warnings, 224 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > "[PATCH] monitor: Convert manpage to rst format" has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > tools: Convert manpages to rst format
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #111: FILE: tools/bdaddr.rst:1:
> > +======
> >
> These errors can be ignored since no SPDX header is needed in the manpage file. Also
> even if the SPDX license header is added, the checkpatch cannot parse .rst file and
> still shows a warning.

Isn't there a way to make checkpatch ignore those then? I can apply
them either way but going forward it would be great to avoid having
these errors.

> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #252: FILE: tools/btattach.rst:1:
> > +========
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #411: FILE: tools/ciptool.rst:1:
> > +========
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #652: FILE: tools/hciattach.rst:1:
> > +=========
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #1102: FILE: tools/hciconfig.rst:1:
> > +=========
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #1503: FILE: tools/hcidump.rst:1:
> > +=======
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #1889: FILE: tools/hcitool.rst:1:
> > +=======
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #2160: FILE: tools/hid2hci.rst:1:
> > +========
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #2298: FILE: tools/l2ping.rst:1:
> > +======
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #2469: FILE: tools/rctest.rst:1:
> > +======
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #2675: FILE: tools/rfcomm.rst:1:
> > +======
> >
> > WARNING:SPDX_LICENSE_TAG: Missing or malformed SPDX-License-Identifier tag in line 1
> > #2919: FILE: tools/sdptool.rst:1:
> > +=======
> >
> > - total: 0 errors, 12 warnings, 1414 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > "[PATCH] tools: Convert manpages to rst format" has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> >
> > ##############################
> > Test: GitLint - PASS
> > Desc: Run gitlint with rule in .gitlint
> >
> > ##############################
> > Test: Prep - Setup ELL - PASS
> > Desc: Clone, build, and install ELL
> >
> > ##############################
> > Test: Build - Prep - PASS
> > Desc: Prepare environment for build
> >
> > ##############################
> > Test: Build - Configure - PASS
> > Desc: Configure the BlueZ source tree
> >
> > ##############################
> > Test: Build - Make - PASS
> > Desc: Build the BlueZ source tree
> >
> > ##############################
> > Test: Make Check - PASS
> > Desc: Run 'make check'
> >
> > ##############################
> > Test: Make Dist - PASS
> > Desc: Run 'make dist' and build the distribution tarball
> >
> > ##############################
> > Test: Make Dist - Configure - PASS
> > Desc: Configure the source from distribution tarball
> >
> > ##############################
> > Test: Make Dist - Make - PASS
> > Desc: Build the source from distribution tarball
> >
> > ##############################
> > Test: Build w/ext ELL - Configure - PASS
> > Desc: Configure BlueZ source with '--enable-external-ell' configuration
> >
> > ##############################
> > Test: Build w/ext ELL - Make - PASS
> > Desc: Build BlueZ source with '--enable-external-ell' configuration
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
> Regards,
> Tedd
>


-- 
Luiz Augusto von Dentz
