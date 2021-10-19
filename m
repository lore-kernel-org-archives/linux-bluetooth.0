Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D42F4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 08:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B356115A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 19 Oct 2021 08:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbhJSIup (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 19 Oct 2021 04:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhJSIuo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 19 Oct 2021 04:50:44 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3742BC06161C
        for <linux-bluetooth@vger.kernel.org>; Tue, 19 Oct 2021 01:48:31 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 002B13EBC3;
        Tue, 19 Oct 2021 10:48:27 +0200 (CEST)
Date:   Tue, 19 Oct 2021 10:48:26 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org, Yu Liu <yudiliu@google.com>,
        Sonny Sasaka <sonnysasaka@chromium.org>
Subject: Re: [PATCH BlueZ] avrcp: keep track of last volume, and use as
 transport init_volume
Message-ID: <20211019084826.gerpvckkjz2wxslj@SoMainline.org>
References: <097b7a889f73ea9cee42b9a0c99683a1d7ee8069.camel () iki ! fi>
 <20211012215115.ypzc55dd5enwscis@SoMainline.org>
 <2a183e606205246ae64422c274275eb1caa2ada5.camel@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a183e606205246ae64422c274275eb1caa2ada5.camel@iki.fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

+cc'ing a bunch of editors who have previously touched Absolute Volume.

Hi Pauli,

Thanks for your patience - I wasn't available to reply last week.  Also
apologies for having the wrong In-reply-to in my mail, marc.info
substitutes @/. in email ddressses with () and ! and I missed it while
importing.  Will import directly from lore.kernel.org next time around.

On 2021-10-13 15:26:54, Pauli Virtanen wrote:
> Hi Marijn,
> 
> ti, 2021-10-12 kello 23:51 +0200, Marijn Suijten kirjoitti:
> > 
> > On 2021-10-12 20:35:17, Pauli Virtanen wrote:
> > > [..]
> > > There's also something confusing in the code in current master
> > > branch: why are avrcp_handle_set_volume and avrcp_volume_changed
> > > setting the volume on local target->player, which I thought is a BlueZ
> > > as TG thing? 
> > 
> > If I remember correctly you can also have a player with BlueZ as CT
> > which is basically a passthrough representing the "actual player" on the
> > other end of the connection?
> 
> In these routines (which are called on RegisterNotification response,
> and SetAbsoluteVolume response, so BlueZ as CT), the player is
> from target_get_player, so it's one of the RegisterPlayer() players for
> Bluez as TG.

It indeed seems like the target player is wrongly used in certain cases,
for example also when handling notifications (which should be sent from
TG->CT).  Surprisingly the last commit touching these is a crash-fix
that checks session->target for NULL, and mentions a crash exactly
because both roles might not always be supported (by the remote device,
hence the counterpart is not initialized in BlueZ).

Following your SetAbsoluteVolume response example, it also becomes clear
from avrcp_set_volume that the target should only be used in the notify
scenario - the remainder of this function uses the controller before
eventually sending the command and subsequently (seemingly wrongly)
updating the target player in the avrcp_handle_set_volume
response-handler.

However, according to 179ccb936 ("avrcp: Set volume if volume changed
event is registered") the peer doesn't need to have a target profile at
all (hence the ->controller on the BlueZ side) to control volume.
This patch seems suspicious to me and I don't even see it on the mailing
list nor GitHub to figure out if there has been any conversation prior
to merging.
Most notably registered_events should be checked when sending a
VolumeChanged notification, not when sending the SetAbsoluteVolume
command.

Perhaps the author was hit by the same versioning issue on Android where
the target profile is definitely available but advertises a version of
the spec that did not document Absolute Volume (both notification and
Set functionality).  The device however appropriately declares
FEATURE_CATEGORY_2 which mandates support for absolute volume.
I have sent a patch to support this case previously [1] but it has not
yet been looked at, Luiz should I resend this?

All in all, perhaps we should also introduce a bunch of null-checks
against ->target and ->controller respectively to ensure certain
functions are only handled for the right role?

> There's indeed a separate set of "proxy" players in 
> session->controller->players, but their avrcp_player_cb is NULL and
> don't have set_volume defined or appear as TG players.
> 
> > > I see that df7d3fa50023 ("audio/avrcp: Always update transport volume
> > > regardless of player") moved most of what player->set_volume does to
> > > the callbacks, and the player volumes seem to be currently used only to
> > > provide initial volume for transports. The volume probably should be
> > > stored elsewhere than in local players?
> > 
> > Going off of memory without looking at the codebase, it probably makes
> > sense to move volume out of the players and into the device entirely as
> > a single source-of-truth representing the currently known volume value
> > of the peer.  That might solve these issues (ie. no player available in
> > the linked commit) and get rid of a bunch of edgecases?  That's probably
> > overlooking some major dependencies though, but it'd be great if you
> > could look into that direction.
> > 
> > In addition I don't know if AVRCP volume is "local" to an entire device
> > or just a single transport "within" that device.
> 
> From my current reading of the spec, there's no correspondence to audio
> transports. One might understand it so that volume is specific to a
> certain player on TG, but as TG is supposedly sink, it's sounds like it
> intended to be a single device volume.

In that case shall we move it all outside of the players and into the
device (after maintainers acknowledge this, too)?

> > > [..]
> > > Caching in struct avrcp session doesn't have these problems, but
> > > df7d3fa50023 mentions there's some issue with avrcp session appearing
> > > late. I'll need to think a bit how to fix this.
> > 
> > I don't remember there being no avrcp session yet, but you're probably
> > referring to 4b6153b0501c ("audio/transport: supply volume on transport
> > init") instead?
> 
> Sorry, yes, I meant 4b6153b0501c.
> 
> Best,
> Pauli

- Marijn

[1]: https://marc.info/?l=linux-bluetooth&m=161911940309461&w=2
