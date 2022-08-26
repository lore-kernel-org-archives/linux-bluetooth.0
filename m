Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8EB8ECAAD2
	for <linux-bluetooth@archiver.kernel.org>; Fri, 26 Aug 2022 09:27:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343818AbiHZJ1e convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 26 Aug 2022 05:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343831AbiHZJ0s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 26 Aug 2022 05:26:48 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905ABD87C8
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Aug 2022 02:26:27 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id C558EFF805;
        Fri, 26 Aug 2022 09:26:22 +0000 (UTC)
Message-ID: <470f881968afbfb35fcb96cf8842882075e6447c.camel@hadess.net>
Subject: Re: [PATCH] adapter: Implement PowerState property
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Archie Pusaka <apusaka@google.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Fri, 26 Aug 2022 11:26:22 +0200
In-Reply-To: <CABBYNZKpB2p5mh8q6he21MM1m3qapwYccsEgUa9q5OrbjRnZzQ@mail.gmail.com>
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
         <6422b1f3f94e959917f919af20a2aa43b4c13a89.camel@hadess.net>
         <CABBYNZ+TKBSHr67Avm+g-_ce8bKE17OSp9xMayJk_y--MsAuDQ@mail.gmail.com>
         <CABBYNZKpB2p5mh8q6he21MM1m3qapwYccsEgUa9q5OrbjRnZzQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 2022-08-25 at 16:10 -0700, Luiz Augusto von Dentz wrote:
> Hi Archie and Bastien,
> 
> On Thu, Aug 25, 2022 at 4:06 PM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > 
> > Hi Bastien,
> > 
> > On Thu, Aug 25, 2022 at 8:32 AM Bastien Nocera <hadess@hadess.net>
> > wrote:
> > > 
> > > On Thu, 2022-08-25 at 15:26 +0200, Bastien Nocera wrote:
> > > > This property should allow any program to show the transitional
> > > > state,
> > > > not just the one that requested the change, and will also show
> > > > transitional states that were the results of other system
> > > > changes,
> > > > like
> > > > rfkill changes.
> > > 
> > > Looks like the bot doesn't like where I put those comments.
> > > 
> > > If anyone can comment on the API I used, and I'll iterate the
> > > actual
> > > implementation. I'd like the API to be settled by the time GNOME
> > > 43
> > > ships, so we can rely on it there.
> > 
> > I wonder what are you actually after with these changes, in most
> > cases
> > I'd say the changes shall just be queued, anyway perhaps the
> > problem
> > was something related to:
> > 
> > https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=ede7b915980fbc80eff80aa189c35ca016956c61
> 
> Btw, I think this shows that perhaps it would be best practice to
> create a github issue when there are bugs for Gnome/Chrome OS so we
> can properly use the Fixes: tag to close them which makes it easier
> for downstream to find out if a similar issue was fixed and attempt
> to
> reuse the same fix.

That's not the fix we need in this particular case, but I'm fine with
filing GitHub bugs if you prefer.
