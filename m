Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C684ECAAA1
	for <linux-bluetooth@archiver.kernel.org>; Thu, 15 Sep 2022 21:01:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiIOVBI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 15 Sep 2022 17:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIOVBG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 15 Sep 2022 17:01:06 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81E7286C09
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 14:01:05 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a8so32268201lff.13
        for <linux-bluetooth@vger.kernel.org>; Thu, 15 Sep 2022 14:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Ih9VnReyVB91ezgvsBBnQWwR0hW/niL41I/2likpQbg=;
        b=RGUj6lhn62gd/HkVpAcLEvIxz0vWGyafbGqDvILqboSeCDpOWpYpZ07olj8GPryYLD
         bIuGiNYXQ76qztT1B5XZ6Axc5ClJGITNq4K52oguwUQcyXo8PUliZW1PcaB1SEw1h6ky
         7Ji4FfoefolV3TlRA7Bv4njUeXgY4aTkFwWg08qMgiCoU6biBuGJ8iPyL1ZeN7IK+bJE
         ehBz3coWMb3QoTo2Y9unQUEA1D2HcqsRPISSNj4TSF7YjtWPhpTAVdxOm7W2i664nA/5
         9GY9QkqzOF9dL+I//0K3RtYeLf8YbTd/9Z6Jr5oPsTfpBL1GPJRfSqt9W/NFSomKfJt4
         k6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Ih9VnReyVB91ezgvsBBnQWwR0hW/niL41I/2likpQbg=;
        b=a6xea8R2cvv+567l9J/8KJWatHvBkvnJtGCggSTnqEY7sRYGG+Di/VtVU3vj3lkHCG
         McBDS1GkR6b6Bzoq3s+WoG+m3nD7WYjGJlCQTcSle5RflmOG5DDOOEx4uFiVVoDUBQxl
         ThgxBkQP0z3b6xK5u4g+KEux/IXIR1YsZtxIw9ql1WANK48lkdt1P9RpSiiFhR/pjDLd
         eoNMugK1XUIDrmjarbNCqGzXVoFlgX0GQdbaVG0nxIlkz12fevIll3Q0aL/4SN6yATAG
         6AvX+Yv8OcL0lgMvaNgcNNSPsNhM/C31LotgjjHFA44R0PuzaEuyFt93wHoC3JUFfIEN
         v0pQ==
X-Gm-Message-State: ACrzQf0KUYj2luHjtwNTySkbTsSXmyL4yx0iFdPeKKOv1DOI1LTvSzoe
        k1gb0iSK4tSS8Z12+mqG8ltFzdwy8EKyUXkosKmI6J2gtH0=
X-Google-Smtp-Source: AMsMyM48rx5tr4GyzqdaxaDxUDKv1Lat8bVaJi2GBiFiaW8bga0Eb9ejmggijbwVUJ634HLDLu6qdY4sQhs8xe4/bVM=
X-Received: by 2002:a05:6512:b97:b0:497:5c43:2d61 with SMTP id
 b23-20020a0565120b9700b004975c432d61mr539144lfv.251.1663275663240; Thu, 15
 Sep 2022 14:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220915095412.462210-1-sathish.narasimman@intel.com> <63230e51.050a0220.6c72d.5248@mx.google.com>
In-Reply-To: <63230e51.050a0220.6c72d.5248@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 15 Sep 2022 14:00:51 -0700
Message-ID: <CABBYNZJaGkWt4zSZyFhsDTGG-_vBSTmwzzrtnbiP6M_fvJyUXA@mail.gmail.com>
Subject: Re: [BlueZ,v2,1/4] lib/uuid: Add VCS UUIDs
To:     linux-bluetooth@vger.kernel.org
Cc:     sathish.narasimman@intel.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Sathish,

On Thu, Sep 15, 2022 at 4:41 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=677268
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      4.02 seconds
> GitLint                       PASS      1.89 seconds
> Prep - Setup ELL              PASS      33.60 seconds
> Build - Prep                  PASS      0.77 seconds
> Build - Configure             PASS      10.44 seconds
> Build - Make                  PASS      1169.04 seconds
> Make Check                    PASS      12.60 seconds
> Make Check w/Valgrind         PASS      356.41 seconds
> Make Distcheck                PASS      304.10 seconds
> Build w/ext ELL - Configure   PASS      11.04 seconds
> Build w/ext ELL - Make        PASS      108.76 seconds
> Incremental Build w/ patches  PASS      511.45 seconds
> Scan Build                    WARNING   1239.48 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,v2,2/4] shared/vcp: Add initial code for handling VCP
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #1154: FILE: src/shared/vcp.h:16:
> +#define __packed __attribute__((packed))
>
> /github/workspace/src/12977204.patch total: 0 errors, 1 warnings, 1106 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12977204.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
> [BlueZ,v2,3/4] profiles: Add initial code for vcp plugin
> ERROR:INITIALISED_STATIC: do not initialise statics to 0
> #395: FILE: profiles/audio/vcp.c:288:
> +static unsigned int vcp_id = 0;
>
> /github/workspace/src/12977206.patch total: 1 errors, 0 warnings, 330 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12977206.patch has style problems, please review.
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
> src/shared/vcp.c:285:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:294:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:318:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:327:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:351:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:360:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:385:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:394:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:419:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:428:29: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (req->change_counter != vstate->counter) {
>                                    ^~~~~~~~~~~~~~~
> src/shared/vcp.c:452:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:461:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> src/shared/vcp.c:485:15: warning: Access to field 'vcs' results in a dereference of a null pointer (loaded from variable 'vdb')
>         if (!vdb && !vdb->vcs)
>                      ^~~~~~~~
> src/shared/vcp.c:494:25: warning: Access to field 'counter' results in a dereference of a null pointer (loaded from variable 'vstate')
>         if (*change_counter != vstate->counter) {
>                                ^~~~~~~~~~~~~~~
> 14 warnings generated.

Lets have these warnings fixed so vstate needs to be checked.

>
>
>
> ---
> Regards,
> Linux Bluetooth
>


-- 
Luiz Augusto von Dentz
