Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95619C54EE9
	for <linux-bluetooth@archiver.kernel.org>; Fri, 16 Sep 2022 05:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbiIPFCl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 16 Sep 2022 01:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiIPFCe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 16 Sep 2022 01:02:34 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F2A6396
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 22:02:32 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id b136so30910021yba.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 22:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=8zmQUnLSgMhAmcMNyTSH1FjfiKWd1kLPQ9TrccufX8c=;
        b=bXYC4KXv40xFm5DjYlTkRlaAfQ87P+EsXsP/EfJKijvniHZxGQCM6uwzCEY/fOHX5b
         AflQe0x5EqFVER41XU0FA88OCuLgU7OE9h90DM6/IZSMA6406ER85xir/kup9arbgHSN
         WRPXpEyqupT1h2BwWR/CrKAyKb/ycgBIDsyyPo8LsAe0Dw5Vef4JpcIWVCz/8n83dssn
         TYvn0FqZnRl9Sek+K39iuWPAA7b5h+HhMIYrX3BtKiNFGNliIg1PN6ESfoGrApq7CWNV
         kjARKbbSagxpbvLLmUXyMfSt0Hz1aJxTHFWsbpQN77sesRojpeteOgSQWtVjhhDoFMI+
         WLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=8zmQUnLSgMhAmcMNyTSH1FjfiKWd1kLPQ9TrccufX8c=;
        b=rp2C0bry0ZwR3vHZEQ+Ps+g0CE2lMLKnzLu4w4CFMRfHSHu1w9f0HQ5ceXqu63aOgp
         8PlvhXzmUqjq1mZM+g7lsFuscKv75Cd4bXURUuqUvQDKddWuwJHZv6MssIYvw2HWpLGa
         6+Uwp624/dpVQJjEctYb+FeWIad+n87n/GnL3qxCSvu4gLxLIU5f+2RVBwb5e5DK0KEt
         P9qD+oqrMUnvzg13Gu7qGWYjCP04M8+WENJk6uJEX8oao+OCkgkoapI4XRaGCCPMvO5O
         Xi1AqHGKo8hqQZwHrgALRq6dNCot8qx8kdONL4+/mYQsVOry77ezYX9pY/sWkcTOmZVL
         LA0Q==
X-Gm-Message-State: ACrzQf3dr2/yOZLqSyaYJtiMsjkOSHtsRPs3YNONFCIBQ63RJ5ojCFzC
        GtakKtt/uQIEsu5NVYmM2ML52i4qYQwMDUaRtV98KndU48o=
X-Google-Smtp-Source: AMsMyM40rNdQutPHGpxIrZur2BPRNao4EzmSFgcNGzC6BYOt737tvFDTck1iBinBCfe1KEQCHAnMtiFLcOtRfZ0V6K0=
X-Received: by 2002:a25:ab85:0:b0:6af:faae:55a2 with SMTP id
 v5-20020a25ab85000000b006affaae55a2mr2705757ybi.43.1663304551656; Thu, 15 Sep
 2022 22:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220915095412.462210-1-sathish.narasimman@intel.com>
 <63230e51.050a0220.6c72d.5248@mx.google.com> <CABBYNZJaGkWt4zSZyFhsDTGG-_vBSTmwzzrtnbiP6M_fvJyUXA@mail.gmail.com>
In-Reply-To: <CABBYNZJaGkWt4zSZyFhsDTGG-_vBSTmwzzrtnbiP6M_fvJyUXA@mail.gmail.com>
From:   Sathish Narasimman <nsathish41@gmail.com>
Date:   Fri, 16 Sep 2022 10:32:20 +0530
Message-ID: <CAOVXEJ+Y2Ao6+tHt3eE+y6neJzqUZ07Y3JeOXnn9myUa3Kv7zA@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/4] lib/uuid: Add VCS UUIDs
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz

On Fri, Sep 16, 2022 at 2:37 AM Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
>
> Hi Sathish,
>
> On Thu, Sep 15, 2022 at 4:41 AM <bluez.test.bot@gmail.com> wrote:
> >
> > This is automated email and please do not reply to this email!
> >
> > Dear submitter,
> >
> > Thank you for submitting the patches to the linux bluetooth mailing list.
> > This is a CI test results with your patch series:
> > PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677268
> >
> > ---Test result---
> >
> > Test Summary:
> > CheckPatch                    FAIL      4.02 seconds
> > GitLint                       PASS      1.89 seconds
> > Prep - Setup ELL              PASS      33.60 seconds
> > Build - Prep                  PASS      0.77 seconds
> > Build - Configure             PASS      10.44 seconds
> > Build - Make                  PASS      1169.04 seconds
> > Make Check                    PASS      12.60 seconds
> > Make Check w/Valgrind         PASS      356.41 seconds
> > Make Distcheck                PASS      304.10 seconds
> > Build w/ext ELL - Configure   PASS      11.04 seconds
> > Build w/ext ELL - Make        PASS      108.76 seconds
> > Incremental Build w/ patches  PASS      511.45 seconds
> > Scan Build                    WARNING   1239.48 seconds
> >
> > Details
> > ##############################
> > Test: CheckPatch - FAIL
> > Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> > Output:
> > [BlueZ,v2,2/4] shared/vcp: Add initial code for handling VCP
> > WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> > #1154: FILE: src/shared/vcp.h:16:
> > +#define __packed __attribute__((packed))
> >
> > /github/workspace/src/12977204.patch total: 0 errors, 1 warnings, 1106 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > /github/workspace/src/12977204.patch has style problems, please review.
> >
> > NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
> >
> > NOTE: If any of the errors are false positives, please report
> >       them to the maintainer, see CHECKPATCH in MAINTAINERS.
> >
> > [BlueZ,v2,3/4] profiles: Add initial code for vcp plugin
> > ERROR:INITIALISED_STATIC: do not initialise statics to 0
> > #395: FILE: profiles/audio/vcp.c:288:
> > +static unsigned int vcp_id = 0;
> >
> > /github/workspace/src/12977206.patch total: 1 errors, 0 warnings, 330 lines checked
> >
> > NOTE: For some of the reported defects, checkpatch may be able to
> >       mechanically convert to the typical style using --fix or --fix-inplace.
> >
> > /github/workspace/src/12977206.patch has style problems, please review.
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
> > src/shared/vcp.c:285:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:294:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:318:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:327:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:351:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:360:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:385:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:394:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:419:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:428:29: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (req->change_counter != vstate->counter) {
> >                                    ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:452:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:461:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > src/shared/vcp.c:485:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
> >         if (!vdb && !vdb->vcs)
> >                      ^~~~~~~~
> > src/shared/vcp.c:494:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
> >         if (*change_counter != vstate->counter) {
> >                                ^~~~~~~~~~~~~~~
> > 14 warnings generated.
>
> Lets have these warnings fixed so vstate needs to be checked.
Thanks for the review. Will Update for sure.
Is there a way I can run Checkpatch.pl locally?
>
> >
> >
> >
> > ---
> > Regards,
> > Linux Bluetooth
> >
>
>
> --
> Luiz Augusto von Dentz

Sathish N
