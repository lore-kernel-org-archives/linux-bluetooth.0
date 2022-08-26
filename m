Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 105BDECAAD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 09:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245606AbiHZJZm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343736AbiHZJZG (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 05:25:06 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23696ADCFA
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 02:25:04 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id B3FD0C000B;
        Fri, 26 Aug 2022 09:25:02 +0000 (UTC)
Message-ID: <1a7f6a809b74444ce64150fc6ad6e6506dd10d9b.camel@hadess.net>
Subject: Re: [PATCH] adapter: Implement PowerState property
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 26 Aug 2022 11:25:02 +0200
In-Reply-To: <CABBYNZ+TKBSHr67Avm+g-_ce8bKE17OSp9xMayJk_y--MsAuDQ@mail.gmail.com>
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
         <6422b1f3f94e959917f919af20a2aa43b4c13a89.camel@hadess.net>
         <CABBYNZ+TKBSHr67Avm+g-_ce8bKE17OSp9xMayJk_y--MsAuDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-08-25 at 16:06 -0700, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, Aug 25, 2022 at 8:32 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > On Thu, 2022-08-25 at 15:26 +0200, Bastien Nocera wrote:
> > > This property should allow any program to show the transitional
> > > state,
> > > not just the one that requested the change, and will also show
> > > transitional states that were the results of other system
> > > changes,
> > > like
> > > rfkill changes.
> > 
> > Looks like the bot doesn't like where I put those comments.
> > 
> > If anyone can comment on the API I used, and I'll iterate the
> > actual
> > implementation. I'd like the API to be settled by the time GNOME 43
> > ships, so we can rely on it there.
> 
> I wonder what are you actually after with these changes, in most
> cases
> I'd say the changes shall just be queued, anyway perhaps the problem
> was something related to:
> 
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=ede7b915980fbc80eff80aa189c35ca016956c61
> 

That helps with one of the problems I ran into (resetting the
transitional state on failure), thanks.

What I'm after is a transitional state when the Bluetooth adapter is
being powered on, as it can take more than "an instant" (aka 200msec)
to turn on, and sometimes much longer.

Users in that transition period can wonder why the adapter is already
on but not usable, or still off. This is even worse if the enablement
doesn't work, as it could show that the device was on/available for a
time before stopping being available, depending on which option the UI
developer took, which is obviously not true.

I updated the patch for the latest git and completed the commit
message, let me know if that helps.
