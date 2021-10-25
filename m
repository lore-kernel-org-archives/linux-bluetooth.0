Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB23C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 21:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5739603E7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 21:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhJYVEc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 17:04:32 -0400
Received: from relay04.th.seeweb.it ([5.144.164.165]:60553 "EHLO
        relay04.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbhJYVEc (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 17:04:32 -0400
X-Greylist: delayed 8664 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Oct 2021 17:04:31 EDT
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 8D9611F5FA;
        Mon, 25 Oct 2021 23:02:07 +0200 (CEST)
Date:   Mon, 25 Oct 2021 23:02:06 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>,
        Yu Liu <yudiliu@google.com>
Subject: Re: [PATCH BlueZ v2] audio/avrcp: Determine Absolute Volume support
 from feature category 2
Message-ID: <20211025210206.bkt5wovzmkmt6teg@SoMainline.org>
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
 <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com>
 <20211025134201.v3rh4ro4zkskbfjs@SoMainline.org>
 <CABBYNZ+M_y7JLM777Jwo1y5JQ7EfrmUcWzx6CwSnajnxrJAqVg@mail.gmail.com>
 <20211025183742.jx3h77ko3rbapisv@SoMainline.org>
 <CABBYNZJcx9tC6vNw38X-9d09k-Pe5-=DARY7qPz=dNpaYJqz1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZJcx9tC6vNw38X-9d09k-Pe5-=DARY7qPz=dNpaYJqz1g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2021-10-25 13:32:50, Luiz Augusto von Dentz wrote:
> Hi Marijn,
> 
> On Mon, Oct 25, 2021 at 11:37 AM Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Hi Luiz,
> >
> > On 2021-10-25 10:48:34, Luiz Augusto von Dentz wrote:
> > > Hi Marijn,
> > >
> > > On Mon, Oct 25, 2021 at 6:42 AM Marijn Suijten
> > > <marijn.suijten@somainline.org> wrote:
> > > >
> > > > Hi Luiz,
> > > > [..]
> > > > As far as I'm aware AVRCP 1.3 doesn't define FEATURE_CATEGORY_2 either
> > > > (but I don't have that spec available to check) so IOP would only find
> > > > this if it combines v1.3 with that feature bit and then tries to check
> > > > CAP_EVENTS_SUPPORTED.  But if it does that, it should also find that
> > > > we're not even checking for the controller supporting FEATURE_CATEGORY_2
> > > > in the first place, nor are disallowing the controller to send
> > > > SetAbsoluteVolume.  That's something we should add for sure, even if we
> > > > don't go ahead with decreasing the minimum version for category-2
> > > > features below 1.4.
> > > > I can send a preliminary patch enforcing this if you want.
> > >
> > > So you are saying FEATURE_CATEGORY_2 is not defined in AVRCP 1.3
> > > either? If the is the case we should probably make it clear on the
> > > code with a code comment that we will be going to verify it only
> > > because of Android using it with AVRCP 1.3, but I wonder if there is
> > > anything in the records that you give us the information that it is
> > > indeed Android and we should be fine doing such check since AOSP has
> > > been doing this for a while.
> >
> > I'm not sure since I don't have access to the 1.3 spec and haven't found
> > it online in a quick search.  This however makes the most sense since
> > feature category 2 seems to _only_ concern itself with volume-related
> > functionality, which are merely SetAbsoluteVolume and
> > EVENT_VOLUME_CHANGED and introduced only since 1.4.
> >
> > I wonder if there's anything specific besides the class indicating a
> > phone factor and the appearance of an avrcp controller with v1.3 but
> > this feature bit set.
> >
> > I'll send a followup in two stages: one that introduces a
> > FEATURE_CATEGORY_2 check around all volume handling, and another that
> > bumps the requirement for the peer-controller down to v1.3 with clear
> > comments about AOSP - unless you have better ideas to detect it :)
> >
> > > > [..]
> > > >
> > > > Finally, on the subject of incorrect behaviour and IOP, I found
> > > > 179ccb936 ("avrcp: Set volume if volume changed event is registered")
> > > > which also seems counter-intuitive besides going completely against the
> > > > spec.  It doesn't seem to have gone in through the mailing lists nor
> > > > discusses the affected device and any potential misbehaviour as a
> > > > result.  If you're concerned with this patch, is that something you'd
> > > > like to keep as well?
> >
> > Anything on this commit?  I'd like to improve the FEATURE_CATEGORY_2
> > checks and this is quite alarming and conflicting with that.
> 
> So you want to change that check to check for FEATURE_CATEGORY_2
> instead of checking if AVRCP_EVENT_VOLUME_CHANGED has been registered?
> Note that the reason why this was done like that is because there is
> no record to check the version so I assume there are no features to
> check either, I wonder how these devices are even qualified like that.

Yeah I'd check for the TG version (done before that patch) and
FEATURE_CATEGORY_2 here, but the patch clearly mentions that there's no
target to begin with.  This seems counter-intuitive and more like a
fluke (maybe the SDP cache got of date, or the device dynamically
"un"-publishes this record) and without knowing what device this was
happening on it's very hard to validate if/whether this is still valid.

> Anyway we probably need more code comments when we are doing something
> like that, and perhaps we could have some entry on main.conf, under
> AVRCPO, to make these checks less strict so the system can allow
> things like 1.3 with FEATURE_CATEGORY_2 and target without record.

I totally agree that all these edge-cases should use extra comments to
detail what's going on, and I like the idea of hiding them behind config
flags.  That way we can pass validation without worries and at the same
time give distros and individuals the ability to be less strict, though
we'll have to think about the default value for for example this AOSP
workaround.

Based on your suggestion I'll also move absolute volume control without
target SDP record behind a similar flag, and add Yu Liu to the CC here
to see if we can get some more clarification. Yu, can you detail what
device this was happening on, and if this is still the case?  Thanks!

- Marijn
