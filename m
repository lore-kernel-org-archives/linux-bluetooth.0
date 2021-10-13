Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70682C433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 15:27:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC6560FDA
	for <linux-bluetooth@archiver.kernel.org>; Wed, 13 Oct 2021 15:27:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhJMP3C (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 13 Oct 2021 11:29:02 -0400
Received: from mout01.posteo.de ([185.67.36.141]:34023 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhJMP3C (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 13 Oct 2021 11:29:02 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 32578240026
        for <linux-bluetooth@vger.kernel.org>; Wed, 13 Oct 2021 17:26:56 +0200 (CEST)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HTxGR1NbTz6tmF;
        Wed, 13 Oct 2021 17:26:55 +0200 (CEST)
Message-ID: <2a183e606205246ae64422c274275eb1caa2ada5.camel@iki.fi>
Subject: Re: [PATCH BlueZ] avrcp: keep track of last volume, and use as
 transport init_volume
From:   Pauli Virtanen <pav@iki.fi>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 13 Oct 2021 15:26:54 +0000
In-Reply-To: <20211012215115.ypzc55dd5enwscis@SoMainline.org>
References: <097b7a889f73ea9cee42b9a0c99683a1d7ee8069.camel () iki ! fi>
         <20211012215115.ypzc55dd5enwscis@SoMainline.org>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Marijn,

ti, 2021-10-12 kello 23:51 +0200, Marijn Suijten kirjoitti:
> 
> On 2021-10-12 20:35:17, Pauli Virtanen wrote:
> > [..]
> > There's also something confusing in the code in current master
> > branch: why are avrcp_handle_set_volume and avrcp_volume_changed
> > setting the volume on local target->player, which I thought is a BlueZ
> > as TG thing? 
> 
> If I remember correctly you can also have a player with BlueZ as CT
> which is basically a passthrough representing the "actual player" on the
> other end of the connection?

In these routines (which are called on RegisterNotification response,
and SetAbsoluteVolume response, so BlueZ as CT), the player is
from target_get_player, so it's one of the RegisterPlayer() players for
Bluez as TG.

There's indeed a separate set of "proxy" players in 
session->controller->players, but their avrcp_player_cb is NULL and
don't have set_volume defined or appear as TG players.

> > I see that df7d3fa50023 ("audio/avrcp: Always update transport volume
> > regardless of player") moved most of what player->set_volume does to
> > the callbacks, and the player volumes seem to be currently used only to
> > provide initial volume for transports. The volume probably should be
> > stored elsewhere than in local players?
> 
> Going off of memory without looking at the codebase, it probably makes
> sense to move volume out of the players and into the device entirely as
> a single source-of-truth representing the currently known volume value
> of the peer.  That might solve these issues (ie. no player available in
> the linked commit) and get rid of a bunch of edgecases?  That's probably
> overlooking some major dependencies though, but it'd be great if you
> could look into that direction.
> 
> In addition I don't know if AVRCP volume is "local" to an entire device
> or just a single transport "within" that device.

From my current reading of the spec, there's no correspondence to audio
transports. One might understand it so that volume is specific to a
certain player on TG, but as TG is supposedly sink, it's sounds like it
intended to be a single device volume.

> > [..]
> > Caching in struct avrcp session doesn't have these problems, but
> > df7d3fa50023 mentions there's some issue with avrcp session appearing
> > late. I'll need to think a bit how to fix this.
> 
> I don't remember there being no avrcp session yet, but you're probably
> referring to 4b6153b0501c ("audio/transport: supply volume on transport
> init") instead?

Sorry, yes, I meant 4b6153b0501c.

Best,
Pauli


