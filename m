Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C95ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 09:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiIOJ6M (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 05:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiIOJ5h (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 05:57:37 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038579C228
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 02:53:24 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id p69so20136923yba.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 02:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=dWKFLfMRTgfQu9bSpTr/rzHVqKoEmBUXIEoSuOHE3Ak=;
        b=RcEK4m87RefXG575cYTY/p7pvh+1P1mhoLuFljIhjSB8Si5HnS1eIyeXCSBoPMHauD
         +jBTXZUS9aALk1A2SWsRAP5dtRWOBERt78/SOrS8RHB108nkmjOeMduknBFUk1IudZJy
         NrC78jhhjA2+c8jeplBSi8CsrlQcjQjYukccL/Y3IOeHqn4TaEm77hg5dWzgvLuBvn8U
         CDAAt08m6thAjNco07pA2fpvVJnMghB68VbM29i4qaSj1cRVRoT6Vg3qVGQJRwohx/tf
         pEzVEBBEJgCqfF0UFPcOo4IUr4U2hU8hseAU/7zPeevjZezQmeOFObHGnjl1M0FbAaHX
         yqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=dWKFLfMRTgfQu9bSpTr/rzHVqKoEmBUXIEoSuOHE3Ak=;
        b=eu7P0P0z+dWHRoit53eWIt9HjYHrdRmUyvxMJv7rFon9GxA1R85qsa9Es4Og2sOcdA
         DsINNDBdgoh0NzQpvhMO8W+rb1TiactcuQuegOn7faiwY4AAKETvq6Qcxw6OZQMuvGFC
         a4w62UIOj14xGSTl+ICqAx4mEP8HoM/skCm243F8nMx4UJadtdf15W9sjVls/IyJpbJ1
         b/I/G+V97eTMSpNN1ENyVtkq/0vmIIk1ZsBwpQ627ZHXyjhfUa/1dqg1iBe+45ewbncM
         soD5UUV5dKCBD76DQ3ZUqmtW3FlwD7ABKFrU0QTuCnTW4wZxAkhE0WGoLfucDyWyCk9t
         uXAg==
X-Gm-Message-State: ACgBeo0giDchih+VVVdFvISoq6YWUqGLEQGFfzSaBQVbiXTbTdQk7miI
        ORyfp5yCwBNOcDLXCSimiaw8yEPwpKAgoFdokAB9QthZJfY=
X-Google-Smtp-Source: AA6agR5uCKkUeoTfoVpjPuEcgAhLhu8An2GLwd64jIwTMbQBSqY2WcZNCnE/E2URyjhJIUXiRS33MBsG/IKnTO/gePA=
X-Received: by 2002:a05:6902:1245:b0:6ae:325e:166a with SMTP id
 t5-20020a056902124500b006ae325e166amr30401206ybu.206.1663235603795; Thu, 15
 Sep 2022 02:53:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220912124657.404551-2-sathish.narasimman@intel.com>
 <631f3c5c.050a0220.3a4e9.d86a@mx.google.com> <CABBYNZKbMvToE1S4JAJz80SLpW8a9jFzw+u3KQMTdmC0wtrK+g@mail.gmail.com>
In-Reply-To: <CABBYNZKbMvToE1S4JAJz80SLpW8a9jFzw+u3KQMTdmC0wtrK+g@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Thu, 15 Sep 2022 15:23:12 +0530
Message-ID: <CAOVXEJKL5d04tm3Yi=4vCyDjUmri-9Unne+aW7YVk967Fe_fjw@mail.gmail.com>
Subject: Re: Volume Control Profile
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

Updated v2 of the patch.
Please review

On Thu, Sep 15, 2022 at 3:18 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
> On Mon, Sep 12, 2022 at 7:08 AM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676220
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      5.79 seconds
> > GitLint                       PASS      3.00 seconds
> > Prep - Setup ELL              PASS      31.92 seconds
> > Build - Prep                  PASS      0.90 seconds
> > Build - Configure             PASS      9.87 seconds
> > Build - Make                  PASS      1165.82 seconds
> > Make Check                    PASS      12.98 seconds
> > Make Check w/Valgrind         PASS      355.07 seconds
> > Make Distcheck                PASS      306.75 seconds
> > Build w/ext ELL - Configure   PASS      10.50 seconds
> > Build w/ext ELL - Make        PASS      107.90 seconds
> > Incremental Build w/ patches  PASS      510.36 seconds
> > Scan Build                    WARNING   1238.26 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > Output:
> > [BlueZ,2/4] shared/vcp: Add initial code for handling VCP
> > WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> > #393: FILE: src/shared/vcp.c:302:
> > +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
> >
> > WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> > #425: FILE: src/shared/vcp.c:334:
> > +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
> >
> > WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> > #458: FILE: src/shared/vcp.c:367:
> > +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
> >
> > WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> > #491: FILE: src/shared/vcp.c:400:
> > +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
> >
> > WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> > #523: FILE: src/shared/vcp.c:432:
> > +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
> >
> > WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> > #555: FILE: src/shared/vcp.c:464:
> > +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
> >
> > WARNING:LONG_LINE: line length of 82 exceeds 80 columns
> > #1051: FILE: src/shared/vcp.c:960:
> > +                                               value_handle, vcp_vstate_register,
> >
> > WARNING:LONG_LINE: line length of 81 exceeds 80 columns
> > #1080: FILE: src/shared/vcp.c:989:
> > +                                               value_handle, vcp_vflag_register,
> >
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> > #1146: FILE: src/shared/vcp.h:16:
> > +#define __packed __attribute__((packed))
> >
> > /github/workspace/src/12973630.patch total: 0 errors, 9 warnings, 1098 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > /github/workspace/src/12973630.patch has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > [BlueZ,3/4] profiles: Add initial code for vcp plugin
> > ERROR:INITIALISED_STATIC: do not initialise statics to 0
> > #395: FILE: profiles/audio/vcp.c:288:
> > +static unsigned int vcp_id = 0;
> >
> > /github/workspace/src/12973633.patch total: 1 errors, 0 warnings, 330 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > /github/workspace/src/12973633.patch has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> >
> > ##############################
> > Test: Scan Build - WARNING
> > Desc: Run Scan Build with patches
> > Output:
> > *****************************************************************************
> > The bugs reported by the scan-build may or may not be caused by your patches.
> > Please check the list and fix the bugs if they are caused by your patch.
> > *****************************************************************************
> > src/shared/vcp.c:288:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:294:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:320:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:326:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:352:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:358:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:385:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:391:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:418:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:424:29: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (req->change_counter != vstate->counter) {
> >                                    ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:450:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:456:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:482:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         vstate = vdb->vcs->vstate;
> >                  ^~~~~~~~
> > src/shared/vcp.c:488:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > 14 warnings generated.
>
> Would you please fix the above problems, also Id reorder the patches
> so the monitor changes can be applied before the others.
>
> --
> Luiz Augusto von Dentz
