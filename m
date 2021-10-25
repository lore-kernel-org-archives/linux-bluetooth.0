Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7160BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 18:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F68560FDC
	for <linux-bluetooth@archiver.kernel.org>; Mon, 25 Oct 2021 18:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhJYSkP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 25 Oct 2021 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232699AbhJYSkK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 25 Oct 2021 14:40:10 -0400
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390FC061745
        for <linux-bluetooth@vger.kernel.org>; Mon, 25 Oct 2021 11:37:48 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r1.th.seeweb.it (Postfix) with ESMTPSA id 706D21F4B4;
        Mon, 25 Oct 2021 20:37:43 +0200 (CEST)
Date:   Mon, 25 Oct 2021 20:37:42 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Pauli Virtanen <pav@iki.fi>,
        Marek Czerski <ma.czerski@gmail.com>
Subject: Re: [PATCH BlueZ v2] audio/avrcp: Determine Absolute Volume support
 from feature category 2
Message-ID: <20211025183742.jx3h77ko3rbapisv@SoMainline.org>
References: <20211019091648.120910-1-marijn.suijten@somainline.org>
 <CABBYNZKvicPfaqoun8nomNw=_qxT8k4n0+TiHxALfQOV+Ns2+A@mail.gmail.com>
 <20211025134201.v3rh4ro4zkskbfjs@SoMainline.org>
 <CABBYNZ+M_y7JLM777Jwo1y5JQ7EfrmUcWzx6CwSnajnxrJAqVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABBYNZ+M_y7JLM777Jwo1y5JQ7EfrmUcWzx6CwSnajnxrJAqVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Luiz,

On 2021-10-25 10:48:34, Luiz Augusto von Dentz wrote:
> Hi Marijn,
> 
> On Mon, Oct 25, 2021 at 6:42 AM Marijn Suijten
> <marijn.suijten@somainline.org> wrote:
> >
> > Hi Luiz,
> > [..]
> > As far as I'm aware AVRCP 1.3 doesn't define FEATURE_CATEGORY_2 either
> > (but I don't have that spec available to check) so IOP would only find
> > this if it combines v1.3 with that feature bit and then tries to check
> > CAP_EVENTS_SUPPORTED.  But if it does that, it should also find that
> > we're not even checking for the controller supporting FEATURE_CATEGORY_2
> > in the first place, nor are disallowing the controller to send
> > SetAbsoluteVolume.  That's something we should add for sure, even if we
> > don't go ahead with decreasing the minimum version for category-2
> > features below 1.4.
> > I can send a preliminary patch enforcing this if you want.
> 
> So you are saying FEATURE_CATEGORY_2 is not defined in AVRCP 1.3
> either? If the is the case we should probably make it clear on the
> code with a code comment that we will be going to verify it only
> because of Android using it with AVRCP 1.3, but I wonder if there is
> anything in the records that you give us the information that it is
> indeed Android and we should be fine doing such check since AOSP has
> been doing this for a while.

I'm not sure since I don't have access to the 1.3 spec and haven't found
it online in a quick search.  This however makes the most sense since
feature category 2 seems to _only_ concern itself with volume-related
functionality, which are merely SetAbsoluteVolume and
EVENT_VOLUME_CHANGED and introduced only since 1.4.

I wonder if there's anything specific besides the class indicating a
phone factor and the appearance of an avrcp controller with v1.3 but
this feature bit set.

I'll send a followup in two stages: one that introduces a
FEATURE_CATEGORY_2 check around all volume handling, and another that
bumps the requirement for the peer-controller down to v1.3 with clear
comments about AOSP - unless you have better ideas to detect it :)

> > [..]
> >
> > Finally, on the subject of incorrect behaviour and IOP, I found
> > 179ccb936 ("avrcp: Set volume if volume changed event is registered")
> > which also seems counter-intuitive besides going completely against the
> > spec.  It doesn't seem to have gone in through the mailing lists nor
> > discusses the affected device and any potential misbehaviour as a
> > result.  If you're concerned with this patch, is that something you'd
> > like to keep as well?

Anything on this commit?  I'd like to improve the FEATURE_CATEGORY_2
checks and this is quite alarming and conflicting with that.

- Marijn
