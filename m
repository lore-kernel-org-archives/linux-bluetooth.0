Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880E2C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A51C610A3
	for <linux-bluetooth@archiver.kernel.org>; Tue,  7 Sep 2021 22:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346840AbhIGWJB (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Sep 2021 18:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhIGWJA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Sep 2021 18:09:00 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0AC061575
        for <linux-bluetooth@vger.kernel.org>; Tue,  7 Sep 2021 15:07:53 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a15so527493iot.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Sep 2021 15:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PZA+xvanC7A3HMagvoleXRmk6Q05IjiZFkTm8d3pv4A=;
        b=fRC5b9IkBR2bf4+kDGttpObj84Kxkt7jMZOr2MDGzNdkXTRgIceeBXLxMzSmCKYdIY
         eOIrIdb0zFHMK9cCqFEZkA7EaO5O3pN/JHlKmHZ/4aa7ApBYbIEBrq7OR5KFdVWLMtIO
         cEdavt0GOGKQFyKu+TJlpcZXlhKgi4bDXk+t+KXPeSYktyQ8B+j9WNNkGFLC4aMYu0MU
         jv7iGEiBNxkNHW6QzNll72BVEEyEUOPNX8OFIPpHEOYfYuiE/4fpbWjwuIbd1m9P8qzw
         lmr7GtWfsoEFlmalnsKfKrk6QBktPiiPCCuL+FQNKJqAszTZpCC9cEw7fMNo41BhSOnd
         iSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PZA+xvanC7A3HMagvoleXRmk6Q05IjiZFkTm8d3pv4A=;
        b=TIBMRIOwFnX8kf2VXY66MOqXgK8Ae/frdHJstcRN1Ks3v59RIBvuqMVLvbVdssP7UZ
         41G55W72j/5Y/aM4d3PgxEzXZeDrsjxfaIKswa3lY1jfM8tE4YvCHfn6Fp8/MC0ukCf/
         UIqs/98gOZA6YjNx230tcUUPIQpTLEMTjZoj9HFntNw+caOO+PpWNpJQEJhK0luXjLZR
         sIfJZ6vF2m47T/y9hAuiXeBNejUTaFFvfXgpnDVtgUTZmCqbRnWKR69pePxqm9R2CH9g
         rrBh6zUv01myEO31tqkP4VBLQp1XbtHNzHHWN7rzSZX9peTlisfHEOW9ddLQMOiqSZhw
         6XSg==
X-Gm-Message-State: AOAM530vubiP4/SQ3llHnSEMKKK87MR+xzQ/UuFDszeBFcoWFb43NFzB
        mLkeTskSPqRecd0hZbMszuQy0afBuz8FiD6o4IVBTp1q
X-Google-Smtp-Source: ABdhPJx9K/Pg066uXyegxYrcgq/OoAY9QD1sgynxVB2mHPiDEPS7ocr7xz9YAgkgECEsHIdKDqxkuHDvbHD1kL5zAm4=
X-Received: by 2002:a5e:990e:: with SMTP id t14mr339404ioj.75.1631052473186;
 Tue, 07 Sep 2021 15:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210907112556.11848-1-kiran.k@intel.com> <613752d2.1c69fb81.c33e2.0212@mx.google.com>
In-Reply-To: <613752d2.1c69fb81.c33e2.0212@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 7 Sep 2021 15:07:42 -0700
Message-ID: <CABBYNZJXgqBJe5QF-KTF0s2uY2FttbwjrJRpJQ561Oubi+9M5A@mail.gmail.com>
Subject: Re: [v2,1/3] tools/sco-tester: add test cases to get offload codecs
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Kiran K <kiran.k@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Kiran,

On Tue, Sep 7, 2021 at 4:58 AM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=543085
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      0.72 seconds
> GitLint                       PASS      0.31 seconds
> Prep - Setup ELL              PASS      41.19 seconds
> Build - Prep                  PASS      0.09 seconds
> Build - Configure             PASS      7.12 seconds
> Build - Make                  PASS      178.50 seconds
> Make Check                    PASS      8.98 seconds
> Make Distcheck                PASS      219.84 seconds
> Build w/ext ELL - Configure   PASS      7.29 seconds
> Build w/ext ELL - Make        PASS      166.16 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> tools/sco-tester: add test cases to get offload codecs
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #27: FILE: lib/bluetooth.h:154:
> +} __attribute__((packed));
>
> WARNING:PREFER_DEFINED_ATTRIBUTE_MACRO: Prefer __packed over __attribute__((packed))
> #32: FILE: lib/bluetooth.h:159:
> +} __attribute__((packed));
>
> - total: 0 errors, 2 warnings, 149 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> "[PATCH] tools/sco-tester: add test cases to get offload codecs" has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
> ##############################
> Test: GitLint - PASS
> Desc: Run gitlint with rule in .gitlint
>
> ##############################
> Test: Prep - Setup ELL - PASS
> Desc: Clone, build, and install ELL
>
> ##############################
> Test: Build - Prep - PASS
> Desc: Prepare environment for build
>
> ##############################
> Test: Build - Configure - PASS
> Desc: Configure the BlueZ source tree
>
> ##############################
> Test: Build - Make - PASS
> Desc: Build the BlueZ source tree
>
> ##############################
> Test: Make Check - PASS
> Desc: Run 'make check'
>
> ##############################
> Test: Make Distcheck - PASS
> Desc: Run distcheck to check the distribution
>
> ##############################
> Test: Build w/ext ELL - Configure - PASS
> Desc: Configure BlueZ source with '--enable-external-ell' configuration
>
> ##############################
> Test: Build w/ext ELL - Make - PASS
> Desc: Build BlueZ source with '--enable-external-ell' configuration
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
