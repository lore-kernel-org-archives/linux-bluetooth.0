Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C077EC433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 21:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9B5661107
	for <linux-bluetooth@archiver.kernel.org>; Thu, 23 Sep 2021 21:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243308AbhIWV1l (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 23 Sep 2021 17:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243361AbhIWV1e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 23 Sep 2021 17:27:34 -0400
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4125C061766
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 14:26:01 -0700 (PDT)
Received: by mail-ua1-x932.google.com with SMTP id 42so5172378uak.11
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Sep 2021 14:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=KZI+d8JyAhsOUbVqw8v0ptyo7H86g1xjMrAoRp6n/aE=;
        b=HTheUvXsIRpz//T2sLLjscH/0D5XVSuJ2dzYBobpP1KGzYtpP+MlsvYyWJs8ZjzFIN
         ZbX8Q0WHFhyMufaTEQTYc0N/6z3kaY46O0FRvkh1bCUzicHtGQQsSEDFPvE3P1ytQTSg
         IgPvYOjZaaoXVCdxn3z4NUfhG5hJy+CpnayFiwOvlFRYRTwF2ObZfuIQOAM0rGrLw/+N
         S8SWFBgj+HuQ9V3ODD0ePpvTcSAh3JascntyC7d3ZXUNOuqSYz8FtVRCE1dGEiVhYqz2
         klg0fLvLEBOIcGpYILH4+71ZkcDPox7sLuvIf8xDPmTS4V1+wpjt7IgmV2qfyyBOJ5Qa
         NxZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=KZI+d8JyAhsOUbVqw8v0ptyo7H86g1xjMrAoRp6n/aE=;
        b=WHE+2sPnlCUQLWSf0SsdcMrtXdaUbWJtM88wlSwByyF8pwPOexo3/jhuGpzwu1iBVA
         gE1NtJ0NrieQSXo/LbtTy6mf6EsgDpGIBZrEK3SzEXbKc6iTT7SY4dn80AhXBfmuGwkY
         DEDcMZNLZZx9uFmWPPipAeXefpnJVoBMNFr73q4y3+c7IWYJ0lp9PN3wv9bAlVR2sG/D
         yuyUivrdKB1tSHVQF4i804Y9vmdK7l+wPPHM2b2aJuI6fdmVsC/w9uhLgHnu7DIc+a4X
         9NsacGaJhZyriozKEqmnMCSp5nm2xjwp88h1q+tKDPyS0BDXuJzEDNKjqm/gHLucdpmw
         YYPQ==
X-Gm-Message-State: AOAM533VT4b4uiTXAXUwzNcHUSB5FhVTPEgCnBSplR0f953VE9VftdbZ
        LagZoScPdBuNFmOKri+eYG585mfx+IwQ5NiAa2pfaUcO
X-Google-Smtp-Source: ABdhPJzNjYtrkviHb2VFDazUwN9P0bN/sSt+vUllvTV8rqUi1XMIaluza1TvMCoaem3zvozQX44QTAytw5p05XQmXf8=
X-Received: by 2002:ab0:3b93:: with SMTP id p19mr6942214uaw.72.1632432360787;
 Thu, 23 Sep 2021 14:26:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210922213402.1978215-1-luiz.dentz@gmail.com> <614bafbd.1c69fb81.c4aa.37ba@mx.google.com>
In-Reply-To: <614bafbd.1c69fb81.c4aa.37ba@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 23 Sep 2021 14:25:50 -0700
Message-ID: <CABBYNZL4PCdhfz3ZvUEcH03R8VQUwEizNb32t6X0tp2g_76o9g@mail.gmail.com>
Subject: Re: [BlueZ,1/4] shared/mgmt: Set MTU to UINT16_MAX
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Wed, Sep 22, 2021 at 3:35 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=551265
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    FAIL      5.36 seconds
> GitLint                       PASS      3.57 seconds
> Prep - Setup ELL              PASS      40.85 seconds
> Build - Prep                  PASS      0.48 seconds
> Build - Configure             PASS      7.30 seconds
> Build - Make                  PASS      173.82 seconds
> Make Check                    PASS      8.95 seconds
> Make Distcheck                PASS      204.82 seconds
> Build w/ext ELL - Configure   PASS      7.29 seconds
> Build w/ext ELL - Make        PASS      163.18 seconds
>
> Details
> ##############################
> Test: CheckPatch - FAIL
> Desc: Run checkpatch.pl script with rule in .checkpatch.conf
> Output:
> [BlueZ,4/4] adapter: Truncate number of LTKs loaded if over MGMT MTU
> WARNING:TYPO_SPELLING: 'accomodate' may be misspelled - perhaps 'accommodate'?
> #91:
> If MGMT MTU cannot accomodate all the existing LTKs only send the ones
>                    ^^^^^^^^^^
>
> /github/workspace/src/12511495.patch total: 0 errors, 1 warnings, 64 lines checked
>
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or --fix-inplace.
>
> /github/workspace/src/12511495.patch has style problems, please review.
>
> NOTE: Ignored message types: COMMIT_MESSAGE COMPLEX_MACRO CONST_STRUCT FILE_PATH_CHANGES MISSING_SIGN_OFF PREFER_PACKED SPDX_LICENSE_TAG SPLIT_STRING SSCANF_TO_KSTRTO
>
> NOTE: If any of the errors are false positives, please report
>       them to the maintainer, see CHECKPATCH in MAINTAINERS.
>
>
>
>
> ---
> Regards,
> Linux Bluetooth
>

Pushed.

-- 
Luiz Augusto von Dentz
