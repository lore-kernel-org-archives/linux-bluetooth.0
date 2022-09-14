Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4C2ECAAD3
	for <linux-bluetooth@archiver.kernel.org>; Wed, 14 Sep 2022 21:04:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbiINVEs (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 14 Sep 2022 17:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiINVEo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 14 Sep 2022 17:04:44 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E177813D49
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 14:04:41 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 9so18876560ljr.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 14 Sep 2022 14:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=gbm1KyFa7fz0eZaRli9QsGM9n9nS9UEydnER8kTQrkU=;
        b=Cw9ww9DKzjQVIxxJgKk6BZwKRtVZ6pR80aghT/JP+6CMOnNMWtbqBJg3BT8EUstVUH
         jNypvgwJ+3deVOFZzfCG4GI38ejEI/x84y3P7plNp5jprn37XvoLxo//9JkfNUzozoHj
         B1r4nav2lJ6WRB7Lk7K9+Cq7el2fkyTtstiP9WNkNIlMeHDmA0Mt3BqYn9P/2+KwU4Hf
         jIr1LnKKZWbEwQJXP76mD4K/O2CTIaKq0iHy5NBspYhTvwC+etG4h6Yaqp8CmVKCzuRq
         3n8xuundvdb7PRWZkJP8cNX1suInsCCK+ugNwGb/7Co0nNU0/kepHwu6ViMLmPJBZShi
         /mMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=gbm1KyFa7fz0eZaRli9QsGM9n9nS9UEydnER8kTQrkU=;
        b=yFHVvKH94n5p4SvON6RJQ35tOKyw8qbY1nvIkuXYhbmxCqDgjd9jY8wGL/opW0wC8k
         ERoIAukO1Fk2QXro5oP6hRtnsKpBTML1BTqLzrYFVCPAaD5CGmt7+aMYrf9WiuW7+frZ
         l0RhDhr/MqcqFxPtAYKZYRRp89CgJEUbiyFK38W9AcS9JZfeEGkNzaPlyq1GuE+csOzA
         ov/77DNqp7yscpoAbQkXe1TcgA6cJK9T6McmJHwL/x+yxzB+pltW7oRHnjpaRqbu5jDp
         H8lKYrx8jd1BJftOLDxtmU2xUzjHUhgDvI+tPmzcayXjcesKDy/yVmTLT6pf83je4WNT
         QY9Q==
X-Gm-Message-State: ACgBeo23/oNrg2wTmWfRKkkiZjJ2QROuyb9EY/zz9DpYEYCsnr24KCwB
        3010OiwHRWS2M6o7snfoakGBrJ2OZBAyI5n8ilPLaByP73o=
X-Google-Smtp-Source: AA6agR5JsvcSiIYk7tDqtUdsC7FUVMtsgl2/T+tc/3tg5+1FIKclYfrdpxpmBIVI3ZndwFQ02Qq9LMKfU3N6ENE2KxY=
X-Received: by 2002:a2e:804a:0:b0:26b:66d3:4d51 with SMTP id
 p10-20020a2e804a000000b0026b66d34d51mr10531624ljg.293.1663189479644; Wed, 14
 Sep 2022 14:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220912124657.404551-2-sathish.narasimman@intel.com> <631f3c5c.050a0220.3a4e9.d86a@mx.google.com>
In-Reply-To: <631f3c5c.050a0220.3a4e9.d86a@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 14 Sep 2022 14:04:28 -0700
Message-ID: <CABBYNZKbMvToE1S4JAJz80SLpW8a9jFzw+u3KQMTdmC0wtrK+g@mail.gmail.com>
Subject: Re: Volume Control Profile
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Mon, Sep 12, 2022 at 7:08 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=676220
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      5.79 seconds
> GitLint                       PASS      3.00 seconds
> Prep - Setup ELL              PASS      31.92 seconds
> Build - Prep                  PASS      0.90 seconds
> Build - Configure             PASS      9.87 seconds
> Build - Make                  PASS      1165.82 seconds
> Make Check                    PASS      12.98 seconds
> Make Check w/Valgrind         PASS      355.07 seconds
> Make Distcheck                PASS      306.75 seconds
> Build w/ext ELL - Configure   PASS      10.50 seconds
> Build w/ext ELL - Make        PASS      107.90 seconds
> Incremental Build w/ patches  PASS      510.36 seconds
> Scan Build                    WARNING   1238.26 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,2/4] shared/vcp: Add initial code for handling VCP
> WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> #393: FILE: src/shared/vcp.c:302:
> +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
>
> WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> #425: FILE: src/shared/vcp.c:334:
> +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
>
> WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> #458: FILE: src/shared/vcp.c:367:
> +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
>
> WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> #491: FILE: src/shared/vcp.c:400:
> +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
>
> WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> #523: FILE: src/shared/vcp.c:432:
> +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
>
> WARNING:LONG_LINE: line length of 88 exceeds 80 columns
> #555: FILE: src/shared/vcp.c:464:
> +       gatt_db_attribute_notify(vdb->vcs->vs, (void *)vstate, sizeof(struct vol_state),
>
> WARNING:LONG_LINE: line length of 82 exceeds 80 columns
> #1051: FILE: src/shared/vcp.c:960:
> +                                               value_handle, vcp_vstate_register,
>
> WARNING:LONG_LINE: line length of 81 exceeds 80 columns
> #1080: FILE: src/shared/vcp.c:989:
> +                                               value_handle, vcp_vflag_register,
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #1146: FILE: src/shared/vcp.h:16:
> +#define __packed __attribute__((packed))
>
> /github/workspace/src/12973630.patch total: 0 errors, 9 warnings, 1098 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12973630.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [BlueZ,3/4] profiles: Add initial code for vcp plugin
> ERROR:INITIALISED_STATIC: do not initialise statics to 0
> #395: FILE: profiles/audio/vcp.c:288:
> +static unsigned int vcp_id = 0;
>
> /github/workspace/src/12973633.patch total: 1 errors, 0 warnings, 330 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12973633.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: Scan Build - WARNING
> Desc: Run Scan Build with patches
> Output:
> *****************************************************************************
> The bugs reported by the scan-build may or may not be caused by your patches.
> Please check the list and fix the bugs if they are caused by your patch.
> *****************************************************************************
> src/shared/vcp.c:288:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:294:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:320:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:326:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:352:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:358:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:385:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:391:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:418:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:424:29: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (req->change_counter != vstate->counter) {
>                                    ^~~~~~~~~~~~~~~
> src/shared/vcp.c:450:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:456:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:482:11: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         vstate = vdb->vcs->vstate;
>                  ^~~~~~~~
> src/shared/vcp.c:488:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> 14 warnings generated.

Would you please fix the above problems, also Id reorder the patches
so the monitor changes can be applied before the others.

-- 
Luiz Augusto von Dentz
