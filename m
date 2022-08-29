Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E37ECAAD5
	for <linux-bluetooth@archiver.kernel.org>; Mon, 29 Aug 2022 09:47:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiH2Jrr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 29 Aug 2022 05:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiH2Jrp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 29 Aug 2022 05:47:45 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87EB5E31F
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Aug 2022 02:47:38 -0700 (PDT)
Received: (Authenticated sender: hadess@hadess.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 2D4E6E0004;
        Mon, 29 Aug 2022 09:47:35 +0000 (UTC)
Message-ID: <039331637535e9cb0c1f9df777cd18d5e34cfe27.camel@hadess.net>
Subject: Re: [PATCH] adapter: Implement PowerState property
From:   Bastien Nocera <hadess@hadess.net>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date:   Mon, 29 Aug 2022 11:47:35 +0200
In-Reply-To: <CABBYNZL+NZ_NR8bx+CaayZis4oRywGvqYN8umqaCYEpp3uOwMw@mail.gmail.com>
References: <db39101f70c945026e76d7b49ee358d9a2330358.camel@hadess.net>
         <CABBYNZL+NZ_NR8bx+CaayZis4oRywGvqYN8umqaCYEpp3uOwMw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-1.fc36) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Fri, 2022-08-26 at 11:50 -0700, Luiz Augusto von Dentz wrote:
> Hi Bastien,
> 
> On Thu, Aug 25, 2022 at 6:40 AM Bastien Nocera <hadess@hadess.net>
> wrote:
> > 
> > This property should allow any program to show the transitional
> > state,
> > not just the one that requested the change, and will also show
> > transitional states that were the results of other system changes,
> > like
> > rfkill changes.
> > ---
> > 
> > Downstream bug in gnome-bluetooth:
> > https://gitlab.gnome.org/GNOME/gnome-bluetooth/-/issues/121
> > 
> > Note that this probably doesn't handle multiple, conflicting
> > requests
> > for power on, or power off. Is there a good way to protect against
> > that?
> > 
> >  client/main.c       |  1 +
> >  doc/adapter-api.txt | 14 ++++++++++
> >  src/adapter.c       | 66
> > +++++++++++++++++++++++++++++++++++++++++++++
> >  3 files changed, 81 insertions(+)
> > 
> > diff --git a/client/main.c b/client/main.c
> > index 19139d15b..ddd97c23c 100644
> > --- a/client/main.c
> > +++ b/client/main.c
> > @@ -981,6 +981,7 @@ static void cmd_show(int argc, char *argv[])
> >         print_property(adapter->proxy, "Alias");
> >         print_property(adapter->proxy, "Class");
> >         print_property(adapter->proxy, "Powered");
> > +       print_property(adapter->proxy, "PowerState");
> >         print_property(adapter->proxy, "Discoverable");
> >         print_property(adapter->proxy, "DiscoverableTimeout");
> >         print_property(adapter->proxy, "Pairable");
> > diff --git a/doc/adapter-api.txt b/doc/adapter-api.txt
> > index 48466ab75..5bdb9c34e 100644
> > --- a/doc/adapter-api.txt
> > +++ b/doc/adapter-api.txt
> > @@ -269,6 +269,20 @@ Properties string Address [readonly]
> >                         restart or unplugging of the adapter it
> > will reset
> >                         back to false.
> > 
> > +               string PowerState [readonly]
> > +
> > +                       The power state of an adapter.
> > +
> > +                       The power state will show whether the
> > adapter is
> > +                       turning off, or turning on, as well as
> > being on
> > +                       or off.
> > +
> > +                       Possible values:
> > +                               "on" - powered on
> > +                               "off" - powered off
> > +                               "turning-on" - transitioning from
> > "off" to "on"
> > +                               "turning-off" - transitioning from
> > "on" to "off"
> 
> This changes need to be split in its own patch,

You want the docs changes to be a separate patch? I can do that, but I
thought that having documentation changes be added along with the
property itself would have been desirable.

>  also not long ago I
> was discussing with Marcel about MGMT power states vs rfkill, they
> don't seem to be inline with each other, while rfkill does reflect on
> the MGMT interface powered states doesn't which means the driver are
> not aware of it since afaik the MGMT states are not communicated back
> to the driver, so perhaps we should reflect this distinction on
> PowerState with a dedicated state for rfkill or we start using rfkill
> ourselves directly via daemon using a dedicated property.

The rfkill calls made by GNOME are usually sent to all the rfkill
devices, rather than targeted at blocking a single adapter. So the
adapter state isn't super interesting in this case, as all the devices
will be either blocked (computer with no platform rfkill), or gone from
the USB bus (computer with a platform rfkill).


The good thing about using a string property here is that we can extend
it. One thing we can do though, to make extensibility easier, is take a
leaf out of the icon naming specification, and use prefixes to encode
the expected state in case the software isn't new enough to know about
a property.

For example:
- "on"
- "off"
- "on-disabling" (transitioning from on to off)
- "off-enabling" (transitioning from off to on)

So we could easily add:
- "off-rfkill" (off and blocked)

Let me know what you think.

Cheers
