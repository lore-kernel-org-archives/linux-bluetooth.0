Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2CC1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 17:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B662B61002
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 17:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234145AbhJYRvJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 13:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbhJYRvI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 13:51:08 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563B9C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 10:48:46 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id k28so19548135uaa.10
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 10:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30SlFBqWXFPnVS4zQAbxlvgKvk3Uhdyxv8ZSjH4gT/w=;
        b=pfsRi5g1Q85hF2iIkdD9W60zmYsZufmS+w2pu0koawrkwork0FTtunJnUsuDu8KCed
         1dVpZXY+8s1HqR8LuV6fy6nzxwJNFWcLAhAVNM8c18sDE+Rpgnd16IexoxX2+OTNKMR8
         Ws90+0v+yeZTeCvIkVCv1B9N0tachEQiam/hgxkFFGAeQplwU8YyzLOz1aT02mDU5+Bq
         flBwR5sEwz4Vb1KrSDa4R9YPApUcLas/3fHvGD4kabReFidXtPjnQ9wTt5HVfruf3YC6
         4HaW2+IaFQSD3Q/UOD2WRkwJe0LRZqWYTCGjoIwmHNZb53QYO8skatQrC2mKRIjm/KGp
         bqFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30SlFBqWXFPnVS4zQAbxlvgKvk3Uhdyxv8ZSjH4gT/w=;
        b=caPcqiPd7PS6cBD8jKtxvM08PRb8+zdP4p8meBB5FF6SxqWJVGGtveS/fG9NwgPlWp
         ippq+38U8bAANGrCsBmwZ9AssOpzlQ5ZAiwB0DLJpb69QAECI+aO2NM12T47Cz5bgY9S
         oPr/JG+BZELzluaxTSgoL0bmFI9dyGaSCFXQgKse48D7pjNjbqAY/Z4siw7gKl9aT3q7
         VowdzjbUlLmZsIa7wvQsAG+nY9xTgKyJY1eUPLn+R56tNhlgWxYHonb9z+o8GVessdGS
         H4GuPJROY8Zif3E2zU/sgSgYimigWRoRrhtuISmjO+fKecpTHP1hEd62FKqZmeTP2mRf
         5nYg==
X-Gm-Message-State: AOAM531Uk8s5BJxt0KPe2qjPrbo9P/ICzw27cweN54maMrdM+6UjqVSn
        BZnaqAwGvQivprLtKguEyLPqEGuAAiNN3AqLPAQ=
X-Google-Smtp-Source: ABdhPJyIcMic0TzjmqdZEOsZkNm5SYzBegGsRltbzoU1Sx4xdsqWo/4VXZefObscC1lfdJpN1RMr/bQj/BR6Y8czCEM=
X-Received: by 2002:a67:d81a:: with SMTP id e26mr16634305vsj.23.1635184125312;
 Mon, 25 Oct 2021 10:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
 <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com> <20211025134201.v3rh4ro4zkskbfjs@SoMainline.org>
In-Reply-To: <20211025134201.v3rh4ro4zkskbfjs@SoMainline.org>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Mon, 25 Oct 2021 10:48:34 -0700
Message-ID: <CABBYNZ+M_y7JLM777Jwo1y5JQ7EfrmUcWzx6CwSnajnxrJAqVg@mail.gmail.com>
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

On Mon, Oct 25, 2021 at 6:42 AM Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> Hi Luiz,
>
> On 2021-10-19 10:38:55, Luiz Augusto von Dentz wrote:
> > Hi Marijn,
> >
> > On Tue, Oct 19, 2021 at 2:17 AM Marijn Suijten
> > <marijn.suijten@somainline.org> wrote:
> > >
> > > The AVRCP spec (1.6.2) does not mention anything about a version
> > > requirement for Absolute Volume, despite this feature only existing
> > > since spec version 1.4.  Android reports a version of 1.3 [1] for its
> > > "AVRCP remote" (CT) service and mentions in the comment above it itself
> > > relies on feature bits rather than the exposed version.  As it stands
> > > BlueZ requires at least version 1.4 making it unable to communicate
> > > absolute volume levels with even the most recent Android phones running
> > > Fluoride (have not checked the version on Gabeldorsche).
> > >
> > > The spec states that supporting SetAbsoluteVolume and
> > > EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
> > > excluded otherwise.  This feature bit is set on Android and, when used
> > > by this patch, allows for successfully communicating volume back and
> > > forth despite the version theoretically being too low.
> > >
> > > [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761
> >
> > But I don't think this is valid, if EVENT_VOLUME_CHANGED was
> > introduced in 1.4 it should have been a reserved value in 1.3 so it
> > cannot be used. So Android should really report 1.4 on its controller
> > record, have you tried submitting a patch to Android to change it to
> > report the version as 1.4? Anyway I'd only adopt such a change if we
> > could identify the remote end is Android otherwise we risk IOP issues
> > by reporting a value that is considered reserved with other stacks.
>
> I think that's a fair concern, and it took some time to validate this on
> the phones I have lying around here.  On a Sony Xperia 1 II running
> stock software, both the target and controller version follow what is
> set in the developer menu, and range from v1.4 to v1.6.  On the
> contrary, a similar phone running a fresh AOSP build on Android 12 still
> suffers from the target using version 1.3.  Only the controller version
> follows what is set in developer settings.
>
> This leaves me curious what other Android vendors do here.  I doubt they
> all go in and bump this by hand just to make absolute volume work
> without breaking certification.
>
> On a similar note, various Bluetooth headphones in use here (such as the
> WH-1000XM3's which must surely be certified) have worked fine with an
> AOSP build only signaling version 1.3 with the FEATURE_CATEGORY_2 bit
> set.  Either they're detecting Android, or they're just not caring about
> the version and only about the feature bits.  I wouldn't be surprised if
> the extra validation performed by BlueZ here is more than most firmware.
>
> As far as I'm aware AVRCP 1.3 doesn't define FEATURE_CATEGORY_2 either
> (but I don't have that spec available to check) so IOP would only find
> this if it combines v1.3 with that feature bit and then tries to check
> CAP_EVENTS_SUPPORTED.  But if it does that, it should also find that
> we're not even checking for the controller supporting FEATURE_CATEGORY_2
> in the first place, nor are disallowing the controller to send
> SetAbsoluteVolume.  That's something we should add for sure, even if we
> don't go ahead with decreasing the minimum version for category-2
> features below 1.4.
> I can send a preliminary patch enforcing this if you want.

So you are saying FEATURE_CATEGORY_2 is not defined in AVRCP 1.3
either? If the is the case we should probably make it clear on the
code with a code comment that we will be going to verify it only
because of Android using it with AVRCP 1.3, but I wonder if there is
anything in the records that you give us the information that it is
indeed Android and we should be fine doing such check since AOSP has
been doing this for a while.

> I've previously submitted changes to Android and they almost always get
> lost in the noise - and even if they get through most Android phones
> won't see that update anyway.  It seems there already is some move in
> this direction [1] but that's on AOSP master and doesn't even reach
> Android 12 (yet), besides requiringg a strange "enablenewavrcp"
> property.
>
> Finally, on the subject of incorrect behaviour and IOP, I found
> 179ccb936 ("avrcp: Set volume if volume changed event is registered")
> which also seems counter-intuitive besides going completely against the
> spec.  It doesn't seem to have gone in through the mailing lists nor
> discusses the affected device and any potential misbehaviour as a
> result.  If you're concerned with this patch, is that something you'd
> like to keep as well?
>
> - Marijn
>
> [1]: https://android-review.googlesource.com/c/platform/system/bt/+/1827796
>
> > > ---
> > >
> > > Changes since v1:
> > > - Use block comment instead of single-line comment.
> > >
> > >  profiles/audio/avrcp.c | 8 ++++++--
> > >  1 file changed, 6 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > > index d3c9cb795..e530eeab4 100644
> > > --- a/profiles/audio/avrcp.c
> > > +++ b/profiles/audio/avrcp.c
> > > @@ -4175,13 +4175,17 @@ static void target_init(struct avrcp *session)
> > >                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> > >                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
> > >
> > > +       /* Remote device supports receiving volume notifications */
> > > +       if (target->features & AVRCP_FEATURE_CATEGORY_2)
> > > +               session->supported_events |=
> > > +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > > +
> > >         if (target->version < 0x0104)
> > >                 return;
> > >
> > >         session->supported_events |=
> > >                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> > > -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> > > -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > > +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> > >
> > >         /* Only check capabilities if controller is not supported */
> > >         if (session->controller == NULL)
> > > --
> > > 2.33.1
> > >
> >
> >
> > --
> > Luiz Augusto von Dentz



-- 
Luiz Augusto von Dentz
