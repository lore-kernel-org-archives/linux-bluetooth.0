Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74EB5C433EF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E10D610E6
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 Oct 2021 17:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbhJFSA6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 Oct 2021 14:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhJFSA6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 Oct 2021 14:00:58 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9ABC061746
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 Oct 2021 10:59:05 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id i13so2390174uat.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 06 Oct 2021 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eklmAy7xisif8D/v3krYLBj/A8IEdkJrL3/ZIC2y7UE=;
        b=DAg+8hiC3VRUlj76lLZRdZm1vwyFrykLqS0lNbVxplwvtcNyRAzCkyCYXjhz4Rs2Mn
         Ys31rl+0K73Z88QyKEoXeAufmpbUwVYBdvjZQywI6CEIIzfepyuNDbwTLzhOANnxqmd4
         67uQylVs5bpMRioVuTMa3lQfFwVQ5GT1ueMK84KMHyephoX7mNKqofqDhENqqpvCynK5
         y3jhNwfRDusy2jXO/a+ieyHkiPyJnMcRqTDM0GFdfoEyfy73r4yd1vD59ZGZXeypo/RX
         k2Y1DlzK4M09ihFYi9QwFvTJq4WJRh7SP5NUBF4OEeKjbvcW/iGlgxJRPGODqMHHSWXU
         3SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eklmAy7xisif8D/v3krYLBj/A8IEdkJrL3/ZIC2y7UE=;
        b=dThc2bvFbN8HZZsqsr167w7gTrEJurdajgA9WXqmQfNu2P+jFn8SWLpgQ2VyIO4wlj
         EPdG2/mmjI0IbCguJ3X4RCeQ0/3/fC52PGv3vvwwEfygNLmWr9TIEtaYHBeVcKUcMclp
         +V/o6Ht7UXhc0Nk1j17LrBTJ4rCj96US7iQ3RPKHfZp66l5z4+XhMGB1wqWaGXW3fmPx
         8x4Ji/kDfxfVwaC9QADsN9XIzf913xTnXQbDMf7tA/zgoRhoZ5utQDGCMaBN3Oq0ySYL
         AP5Rs48IBUS6yaVxflEQyVEIRWaGk3vnxlAEA2kjsF6vGuLB/dpPjBY4E7dEw1RHyEht
         F2qA==
X-Gm-Message-State: AOAM5327axR8f28mgd6C31dZM2pA5rWVnDQu1bsMtVTZVBzi58LNokYW
        uJ/FWM5VBpjOxg60jgBk9blpGdJ3IdcnlzmlLKIkEALE
X-Google-Smtp-Source: ABdhPJxKiLTgWTMeaHb1jKvhCGn9tyz9L9Vg5GrVKQ8Pni7lGDhZhxaHX3z0E4d85bKuZPBtKYW+erAMDRb02fluzlc=
X-Received: by 2002:ab0:5b89:: with SMTP id y9mr19504621uae.47.1633543144897;
 Wed, 06 Oct 2021 10:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20211006024022.111584-1-hj.tedd.an@gmail.com> <615d11b0.1c69fb81.689fa.1bd2@mx.google.com>
In-Reply-To: <615d11b0.1c69fb81.689fa.1bd2@mx.google.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 6 Oct 2021 10:58:54 -0700
Message-ID: <CABBYNZLT_ByiTdRKYsgxmBJ5sxMy4zNpy3BhJUA_r7p9JcSh9Q@mail.gmail.com>
Subject: Re: [BlueZ] tools/mgmt-tester: Update the correct suspend reason for disconnect
To:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc:     Tedd Ho-Jeong An <hj.tedd.an@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Tedd,

On Tue, Oct 5, 2021 at 8:05 PM <bluez.test.bot@gmail.com> wrote:
>
> This is automated email and please do not reply to this email!
>
> Dear submitter,
>
> Thank you for submitting the patches to the linux bluetooth mailing list.
> This is a CI test results with your patch series:
> PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=558253
>
> ---Test result---
>
> Test Summary:
> CheckPatch                    PASS      1.42 seconds
> GitLint                       PASS      0.92 seconds
> Prep - Setup ELL              PASS      47.11 seconds
> Build - Prep                  PASS      0.50 seconds
> Build - Configure             PASS      9.03 seconds
> Build - Make                  PASS      201.78 seconds
> Make Check                    PASS      9.71 seconds
> Make Distcheck                PASS      238.39 seconds
> Build w/ext ELL - Configure   PASS      8.76 seconds
> Build w/ext ELL - Make        PASS      190.52 seconds
>
>
>
> ---
> Regards,
> Linux Bluetooth

Applied, thanks.

-- 
Luiz Augusto von Dentz
