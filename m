Return-Path: <SRS0=qbbT=IE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_05,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F37C433E0
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 01:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC05665092
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Mar 2021 01:18:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhCFBSA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 5 Mar 2021 20:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbhCFBRn (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 5 Mar 2021 20:17:43 -0500
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3E95C06175F
        for <linux-bluetooth@vger.kernel.org>; Fri,  5 Mar 2021 17:17:42 -0800 (PST)
Received: by mail-oo1-xc2c.google.com with SMTP id g46so875754ooi.9
        for <linux-bluetooth@vger.kernel.org>; Fri, 05 Mar 2021 17:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=z07f/Co8NsOBERAppjRHos+jB1QvTqR1uak/lEZKoWk=;
        b=qrg5Hd1OOM5T55czQ0od/G8geg2ZgxElK7pjXU1EVy4GhtLJRDH/7sYma8BYUrpzUl
         DHt6v3q7PiS7mU4wz3BLmg4IKUsAgNL5km6d7LCnUnL1quHwTTmng6yWBdne8KrxcwGP
         4znPJT4Bip9dDCmjQUJ1FcYjATzanH1vTcBxD/nFiHACcJ5TIUevWNWigub+8J8faWuS
         sM7CoBSdqP/sWyLlQm4OyUeHhBWcQFZRN3WFV78viOanH4bwFxDeKgz8Rr8pyzxPdLwW
         JdsLYY3cQm21Rt7jK84AscR1pXqYgxsQWdvgrZbEEPJnN+CnhOIoxBq4YJrsg5M/hYg5
         ZXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=z07f/Co8NsOBERAppjRHos+jB1QvTqR1uak/lEZKoWk=;
        b=QgO5H4d+rNXgu7qUZ57vy5mi7yuXtKTtSqAhIbj/Sw51CeOByG5z+I3xdecR+C6thX
         NLAYKvFY+u0j9aAoeGE9xkVYVdhgbzRug+9Wfcm74ApxkHU6y69xqVo1iuaTgMQvX5uB
         AMt4ez2dJ7az3SfFQeBGMUd9siqnPhiMdMJH6kVQZnye5b2wSy3nSg71ByVO2ufGFrhc
         dt2iSEaqAvhwrNfumcH76d+6vlbOQKALwJf+prPsEw+G+SEapZRQ5Tjp29zXAJdcd2Au
         WoueXWLG67hS2Q8RlJGtD24fMR05121XAQN5pXFEHvGmDmxgk7AD6YUyyg/bXC5bzdBt
         KGIQ==
X-Gm-Message-State: AOAM533nlG3MWQG0f7boBhDQMkR/l+bGMDBJ9a8/rcHsSDAHSPLI+vnb
        WPTkgqvLUwd6RB04QzILrQFWawIuEggImUUG4WVE33UB7ZE=
X-Google-Smtp-Source: ABdhPJy+lERv3coE9IN1tj3g7zWe0pmVtQGxxayIwXnTUEzaWJPbnutDaHla040PdP8x0N6WyZm1MHuAWp90DeUHcgc=
X-Received: by 2002:a4a:c316:: with SMTP id c22mr9992054ooq.65.1614993461788;
 Fri, 05 Mar 2021 17:17:41 -0800 (PST)
MIME-Version: 1.0
References: <20210304222448.3769100-1-luiz.dentz@gmail.com> <6041615f.1c69fb81.ffcdc.51a4@mx.google.com>
In-Reply-To: <6041615f.1c69fb81.ffcdc.51a4@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 5 Mar 2021 17:17:30 -0800
Message-ID: <CABBYNZL8wBc8OQvrRMXuqP=tB4ug2AAU0Ov3uCMvCcJUAz_Kiw@mail.gmail.com>
Subject: Re: [BlueZ,1/2] adapter: Fix not using the correct setting
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

On Thu, Mar 4, 2021 at 2:38 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=442263
>
> ---Test result---
>
> ##############################
> Test: CheckPatch - PASS
>
> ##############################
> Test: CheckGitLint - PASS
>
> ##############################
> Test: CheckBuild - PASS
>
> ##############################
> Test: MakeCheck - PASS
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied.

-- 
Luiz Augusto von Dentz
