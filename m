Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1D39C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C948E60232
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 13:42:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbhJYNo2 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbhJYNo0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 09:44:26 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C668C061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 06:42:04 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 7FA4A3F434;
        Mon, 25 Oct 2021 15:42:02 +0200 (CEST)
Date:   Mon, 25 Oct 2021 15:42:01 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: Re: [PATCH BlueZ v2] audio/avrcp: Determine Absolute Volume support
 from feature category 2
Message-ID: <20211025134201.v3rh4ro4zkskbfjs@SoMainline.org>
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
 <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2021-10-19 10:38:55, Luiz Augusto von Dentz wrote:
> Hi Marijn,
> 
> On Tue, Oct 19, 2021 at 2:17 AM Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > The AVRCP spec (1.6.2) does not mention anything about a version
> > requirement for Absolute Volume, despite this feature only existing
> > since spec version 1.4.  Android reports a version of 1.3 [1] for its
> > "AVRCP remote" (CT) service and mentions in the comment above it itself
> > relies on feature bits rather than the exposed version.  As it stands
> > BlueZ requires at least version 1.4 making it unable to communicate
> > absolute volume levels with even the most recent Android phones running
> > Fluoride (have not checked the version on Gabeldorsche).
> >
> > The spec states that supporting SetAbsoluteVolume and
> > EVENT_VOLUME_CHANGED are mandatory when feature level 2 is declared,
> > excluded otherwise.  This feature bit is set on Android and, when used
> > by this patch, allows for successfully communicating volume back and
> > forth despite the version theoretically being too low.
> >
> > [1]: https://android.googlesource.com/platform/system/bt/+/android-11.0.0_r28/bta/av/bta_av_main.cc#761
> 
> But I don't think this is valid, if EVENT_VOLUME_CHANGED was
> introduced in 1.4 it should have been a reserved value in 1.3 so it
> cannot be used. So Android should really report 1.4 on its controller
> record, have you tried submitting a patch to Android to change it to
> report the version as 1.4? Anyway I'd only adopt such a change if we
> could identify the remote end is Android otherwise we risk IOP issues
> by reporting a value that is considered reserved with other stacks.

I think that's a fair concern, and it took some time to validate this on
the phones I have lying around here.  On a Sony Xperia 1 II running
stock software, both the target and controller version follow what is
set in the developer menu, and range from v1.4 to v1.6.  On the
contrary, a similar phone running a fresh AOSP build on Android 12 still
suffers from the target using version 1.3.  Only the controller version
follows what is set in developer settings.

This leaves me curious what other Android vendors do here.  I doubt they
all go in and bump this by hand just to make absolute volume work
without breaking certification.

On a similar note, various Bluetooth headphones in use here (such as the
WH-1000XM3's which must surely be certified) have worked fine with an
AOSP build only signaling version 1.3 with the FEATURE_CATEGORY_2 bit
set.  Either they're detecting Android, or they're just not caring about
the version and only about the feature bits.  I wouldn't be surprised if
the extra validation performed by BlueZ here is more than most firmware.

As far as I'm aware AVRCP 1.3 doesn't define FEATURE_CATEGORY_2 either
(but I don't have that spec available to check) so IOP would only find
this if it combines v1.3 with that feature bit and then tries to check
CAP_EVENTS_SUPPORTED.  But if it does that, it should also find that
we're not even checking for the controller supporting FEATURE_CATEGORY_2
in the first place, nor are disallowing the controller to send
SetAbsoluteVolume.  That's something we should add for sure, even if we
don't go ahead with decreasing the minimum version for category-2
features below 1.4.
I can send a preliminary patch enforcing this if you want.

I've previously submitted changes to Android and they almost always get
lost in the noise - and even if they get through most Android phones
won't see that update anyway.  It seems there already is some move in
this direction [1] but that's on AOSP master and doesn't even reach
Android 12 (yet), besides requiringg a strange "enablenewavrcp"
property.

Finally, on the subject of incorrect behaviour and IOP, I found
179ccb936 ("avrcp: Set volume if volume changed event is registered")
which also seems counter-intuitive besides going completely against the
spec.  It doesn't seem to have gone in through the mailing lists nor
discusses the affected device and any potential misbehaviour as a
result.  If you're concerned with this patch, is that something you'd
like to keep as well?

- Marijn

[1]: https://android-review.googlesource.com/c/platform/system/bt/+/1827796

> > ---
> >
> > Changes since v1:
> > - Use block comment instead of single-line comment.
> >
> >  profiles/audio/avrcp.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
> > index d3c9cb795..e530eeab4 100644
> > --- a/profiles/audio/avrcp.c
> > +++ b/profiles/audio/avrcp.c
> > @@ -4175,13 +4175,17 @@ static void target_init(struct avrcp *session)
> >                                 (1 << AVRCP_EVENT_TRACK_REACHED_END) |
> >                                 (1 << AVRCP_EVENT_SETTINGS_CHANGED);
> >
> > +       /* Remote device supports receiving volume notifications */
> > +       if (target->features & AVRCP_FEATURE_CATEGORY_2)
> > +               session->supported_events |=
> > +                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > +
> >         if (target->version < 0x0104)
> >                 return;
> >
> >         session->supported_events |=
> >                                 (1 << AVRCP_EVENT_ADDRESSED_PLAYER_CHANGED) |
> > -                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED) |
> > -                               (1 << AVRCP_EVENT_VOLUME_CHANGED);
> > +                               (1 << AVRCP_EVENT_AVAILABLE_PLAYERS_CHANGED);
> >
> >         /* Only check capabilities if controller is not supported */
> >         if (session->controller == NULL)
> > --
> > 2.33.1
> >
> 
> 
> -- 
> Luiz Augusto von Dentz
