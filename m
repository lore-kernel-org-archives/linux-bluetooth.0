Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE1AC433EF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8A56103D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 12 Oct 2021 21:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbhJLVxY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 12 Oct 2021 17:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbhJLVxY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 12 Oct 2021 17:53:24 -0400
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16B00C061570
        for <linux-bluetooth@vger.kernel.org>; Tue, 12 Oct 2021 14:51:21 -0700 (PDT)
Received: from SoMainline.org (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 950093F357;
        Tue, 12 Oct 2021 23:51:16 +0200 (CEST)
Date:   Tue, 12 Oct 2021 23:51:15 +0200
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     Pauli Virtanen <pav@iki.fi>
Cc:     linux-bluetooth@vger.kernel.org,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: [PATCH BlueZ] avrcp: keep track of last volume, and use as
 transport init_volume
Message-ID: <20211012215115.ypzc55dd5enwscis@SoMainline.org>
References: <097b7a889f73ea9cee42b9a0c99683a1d7ee8069.camel () iki ! fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <097b7a889f73ea9cee42b9a0c99683a1d7ee8069.camel () iki ! fi>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Pauli,

On 2021-10-12 20:35:17, Pauli Virtanen wrote:
> [..]
> There's also something confusing in the code in current master
> branch: why are avrcp_handle_set_volume and avrcp_volume_changed
> setting the volume on local target->player, which I thought is a BlueZ
> as TG thing? 

If I remember correctly you can also have a player with BlueZ as CT
which is basically a passthrough representing the "actual player" on the
other end of the connection?

> I see that df7d3fa50023 ("audio/avrcp: Always update transport volume
> regardless of player") moved most of what player->set_volume does to
> the callbacks, and the player volumes seem to be currently used only to
> provide initial volume for transports. The volume probably should be
> stored elsewhere than in local players?

Going off of memory without looking at the codebase, it probably makes
sense to move volume out of the players and into the device entirely as
a single source-of-truth representing the currently known volume value
of the peer.  That might solve these issues (ie. no player available in
the linked commit) and get rid of a bunch of edgecases?  That's probably
overlooking some major dependencies though, but it'd be great if you
could look into that direction.

In addition I don't know if AVRCP volume is "local" to an entire device
or just a single transport "within" that device.

> [..]
> Caching in struct avrcp session doesn't have these problems, but
> df7d3fa50023 mentions there's some issue with avrcp session appearing
> late. I'll need to think a bit how to fix this.

I don't remember there being no avrcp session yet, but you're probably
referring to 4b6153b0501c ("audio/transport: supply volume on transport
init") instead?

- Marijn
