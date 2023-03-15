Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 600BAC6FD1D
	for <linux-bluetooth@archiver.kernel.org>; Wed, 15 Mar 2023 19:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjCOTVq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 15 Mar 2023 15:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbjCOTVp (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 15 Mar 2023 15:21:45 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21C75AB71
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 12:21:43 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 12849240620
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Mar 2023 20:21:42 +0100 (CET)
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4PcKyF3Wjhz6tnp;
        Wed, 15 Mar 2023 20:21:41 +0100 (CET)
Message-ID: <aaf3202815de303e1b52419133d1c54cea177fb4.camel@iki.fi>
Subject: Re: [PATCH BlueZ 2/2] doc: update ISO Transport properties to match
 implementation
From:   Pauli Virtanen <pav@iki.fi>
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org
Date:   Wed, 15 Mar 2023 19:21:40 +0000
In-Reply-To: <CABBYNZKDfGozd=Ud1_GSN821t2=dqtNYTiQ5Z89TfNQ2aF9N3Q@mail.gmail.com>
References: <e856ad3174024bb61113217cb889005a0bf0ad1c.1678902782.git.pav@iki.fi>
         <d33ba431a0b89d8dc80b0da984316d9936be54f4.1678902782.git.pav@iki.fi>
         <CABBYNZKDfGozd=Ud1_GSN821t2=dqtNYTiQ5Z89TfNQ2aF9N3Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi,

ke, 2023-03-15 kello 11:32 -0700, Luiz Augusto von Dentz kirjoitti:
> On Wed, Mar 15, 2023 at 10:54 AM Pauli Virtanen <pav@iki.fi> wrote:
> > 
> > Document the transport QoS properties. Fix documentation of Delay, it's
> > microseconds for ISO.
> > ---
> >  doc/media-api.txt | 44 ++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 42 insertions(+), 2 deletions(-)
> > 
> > diff --git a/doc/media-api.txt b/doc/media-api.txt
> > index 281f72c1e..eac7f081c 100644
> > --- a/doc/media-api.txt
> > +++ b/doc/media-api.txt
> > @@ -773,12 +773,17 @@ Properties        object Device [readonly]
> >                                 "pending": streaming but not acquired
> >                                 "active": streaming and acquired
> > 
> > -               uint16 Delay [readwrite]
> > +               uint16 Delay [A2DP only, readwrite, optional]
> > 
> > -                       Optional. Transport delay in 1/10 of millisecond, this
> > +                       For A2DP: transport delay in 1/10 of millisecond. This
> >                         property is only writeable when the transport was
> >                         acquired by the sender.
> > 
> > +               uint32 Delay [ISO only, optional]
> > +
> > +                       For ISO, presentation delay in microseconds.
> > +                       Note the value type is different for ISO and A2DP.
> > +
> 
> I don't think D-Bus introspection allows polymorphism of properties,
> so either we just use uint16 and limit the maximum delay to 65K or we
> have say it is in milliseconds given that in most cases the presets
> have the Presentation Delay as a round number.

How about renaming the property to PresentationDelay in ISO transports?
I think it would clearest to keep it as it is in BAP.

For A2DP changing away from the 1/10 ms unit breaks things.

> >                 uint16 Volume [readwrite]
> > 
> >                         Optional. Indicates volume level of the transport,
> > @@ -804,3 +809,38 @@ Properties object Device [readonly]
> > 
> >                         Linked transport objects which the transport is
> >                         associated with.
> > +
> > +               byte CIG [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS CIG.
> > +                       Only present when QoS is configured.
> > +
> > +               byte CIS [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS CIS.
> > +                       Only present when QoS is configured.
> > +
> > +               byte Interval [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS interval.
> > +                       Only present when QoS is configured.
> 
> This should be uint32

Indeed...

> 
> > +               byte Framing [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS framing.
> > +                       Only present when QoS is configured.
> > +
> > +               byte PHY [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS PHY.
> > +                       Only present when QoS is configured.
> > +
> > +               uint32 Retransmissions [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS retransmissions.
> > +                       Only present when QoS is configured.
> 
> And this should be byte
> 
> > +               uint32 Latency [ISO only, optional, experimental]
> > +
> > +                       Indicates configured QoS latency.
> > +                       Only present when QoS is configured.
> 
> uint16
> 
> > --
> > 2.39.2
> > 
> 
> 

-- 
Pauli Virtanen
