Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 384E2C433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 17:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6D46101A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 17:39:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhJSRlV (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 13:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234643AbhJSRlU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 13:41:20 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88975C06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 10:39:07 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id f4so1491882uad.4
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 10:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FD8CE7z6I8jIc9NDS9TcXQfsd0wBFdVUIiNvjDCqQj8=;
        b=BQF3dNo4F3dg2HGvG/5yb18yPBpgm/SWcyXmoymnVx0Rno0mi9Od8vZJumAlb9BdcG
         mUDOBt25vAZS53ngWUknA4uUCs25monY5CTJFh7kB9jK5PaR+rsO722Y8vihkC9cWl4C
         RwX4rot7Mg0meWGYUkxqJeBXS3y3avqlKjbWgQJK4ls83iGVz17RfNhfqFc8Xipp5KGS
         d1lIQGlK4abMqMl+j1KBypdZUuD5B56lxx2LkhebCVJg4SYSi6Rrw0wNOHFi9vYfRB/J
         U8PrEuesVMQBq5tUtbSRkQmxZSLjDUsbPAQp5mxAkGnxGooqR+K8XqV37aOujlhOQl8+
         HvHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FD8CE7z6I8jIc9NDS9TcXQfsd0wBFdVUIiNvjDCqQj8=;
        b=VsX+NoscsA0PE0DfLmqv78o0GQZ91Sp1rqWNCnpwXu+ePRuiwC60G+PtjIMcs3ZBwU
         tIymJ3A3QkozzDoAFLBQ7rCNQMWdp/ZwVTIp8LX0dpO+y+8oImBc9q3B9ieFWbE59fma
         7UKsJTy7ntrnJMfSnfLEs76WCSTHEVc1rhPlCRWr+C2NQX5vWlSsGIJNj2WJBKV7L2oB
         ongA520JahCp1XG6BpIi3zQmAOnae82EGOObBb7qTCf3RKDAoicN1yhc2S1m8HvQu0na
         VmQCCuCmyYpQs1xPecd/Yh4U2FWPof02LrfkdfTanY1HNPzdgM/NsWl4Hy3rJnEj0B9K
         xw3Q==
X-Gm-Message-State: AOAM531aK0uxMTT4RFpyyzC82fIN+LhhPu0/MdSeiL/7PniFMNbcbCUG
        Si7RtZHD+sJNp6JXxF7eA3AEd60GO608D1FVRtTuJR9EHso=
X-Google-Smtp-Source: ABdhPJwbM1VO7ex6/+MBWIJ5KzOm4w9TwitmgyjkBVoEfP07bYYQYn5Hb1xRiRR70faAQpz2n+AxZyh/vrG31tixIT4=
X-Received: by 2002:ab0:3cac:: with SMTP id a44mr1504939uax.129.1634665146534;
 Tue, 19 Oct 2021 10:39:06 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
In-Reply-To: <20211019091648.120910-1-marijn.suijten@somainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Tue, 19 Oct 2021 10:38:55 -0700
Message-ID: <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com>
Subject: Re: [PATCH BlueZ v2] audio/avrcp: Determine Absolute Volume support
 from feature category 2
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

On Tue, Oct 19, 2021 at 2:17 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> The AVRCP spec (1.6.2) does not mention anything about a version
> requirement for Absolute Volume, despite this feature only existing
> since spec version 1.4.  Android reports a version of 1.3 [1] for its
> "AVRCP remote" (CT) service and mentions in the comment above it itself
> relies on feature bits rather than the exposed version.  As it stands
> BlueZ requires at least version 1.4 making it unable to communicate
> absolute volume levels with even the most recent Android phones running
> Fluoride (have not checked the version on Gabeldorsche).
>
> The spec states that supporting SetAbsoluteVolume and
> EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
> excluded otherwise.  This feature bit is set on Android and, when used
> by this patch, allows for successfully communicating volume back and
> forth despite the version theoretically being too low.
>
> [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761

But I don't think this is valid, if EVENT_VOLUME_CHANGED was
introduced in 1.4 it should have been a reserved value in 1.3 so it
cannot be used. So Android should really report 1.4 on its controller
record, have you tried submitting a patch to Android to change it to
report the version as 1.4? Anyway I'd only adopt such a change if we
could identify the remote end is Android otherwise we risk IOP issues
by reporting a value that is considered reserved with other stacks.

> ---
>
> Changes since v1:
> - Use block comment intead of single-line comment.
>
>  profiles/audio/avrcp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> index d3c9cb795..e530eeab4 100644
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -4175,13 +4175,17 @@ static void target_init(struct avrcp *session)
>                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
>                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
>
> +       /* Remote device supports receiving volume notifications */
> +       if (target->features & AVRCP_FEATURE_CATEGORY_2)
> +               session->supported_events |=
> +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +
>         if (target->version < 0x0104)
>                 return;
>
>         session->supported_events |=
>                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
>
>         /* Only check capabilities if controller is not supported */
>         if (session->controller == NULL)
> --
> 2.33.1
>


-- 
Luiz Augusto von Dentz
