Return-Path: <summetj@cc.gatech.edu>
Date: Wed, 20 Oct 2004 11:35:16 -0400 (EDT)
From: "Jay W. Summet" <summetj@cc.gatech.edu>
To: Marcel Holtmann <marcel@holtmann.org>
cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Socket CF adaptor, limited to 2-3KB/sec RFCOMM
 PPP connection?
In-Reply-To: <1097929292.4911.37.camel@pegasus>
Message-ID: <Pine.GSO.4.58.0410201018500.19016@gaia3.cc.gatech.edu>
References: <Pine.GSO.4.58.0410121425040.24690@gaia3.cc.gatech.edu>
 <1097752969.4640.40.camel@notepaq>  <Pine.GSO.4.58.0410141051300.8280@gaia3.cc.gatech.edu>
 <1097929292.4911.37.camel@pegasus>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <bluez-users.lists.sourceforge.net>

On Sat, 16 Oct 2004, Marcel Holtmann wrote:

> what I assume is that the link manager on the Socket card is not doing a
> good job, because it should select a different packet type automaticly
> to get the best troughput as possible. However this card is very old and
> maybe you should simply ask Socket to get one of there newer cards with
> a CSR chip.

This card should be the latest that Socket makes, I just bought it, and
the "Rev" version is "G". The card is software upgradable, but my
understanding is that the latest firmware is version G.

Do you know of a newer card that they make?



> There are some problems with a 2.6 kernel to get the serial
> part of them working, but maybe these are solved now. I don't have one
> of these newer cards, because I stopped spending money for buying them.

>
> In general it is a bad idea to play with the packet types from the HCI
> level, because the link manager knows best what type to select. In your
> case you may wanna change them with hciconfig and see if it helps.

By default my card shows:
 Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1
 (Seems to be missing only HV2, HV3)

I am able to get a connection if I only turn on DH5, but here at work I'm
unable to get good phone service for testing. When I go home I'll check it
where I get five bars of service to see if forcing the largest packet size
will give me higher speed...

Jay
