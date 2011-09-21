Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] bluetooth: Fix for security block issue.
From: Marcel Holtmann <marcel@holtmann.org>
To: Antti Julku <antti.julku@nokia.com>
Cc: Lukasz.Rymanowski@tieto.com, mika.linnanoja@nokia.com,
	linux-bluetooth@vger.kernel.org, ville.tervo@nokia.com,
	linus.walleij@stericsson.com,
	par-gunnar.p.hjalmdahl@stericsson.com, padovan@profusion.mobi
Date: Wed, 21 Sep 2011 10:01:56 +0200
In-Reply-To: <4E7990A9.2070709@nokia.com>
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
	 <1295971990.1520.53.camel@aeonflux> <4DB935D9.5080302@nokia.com>
	 <20110428095139.GJ18898@null> <4DBA6D97.7050207@nokia.com>
	 <7D7F2FD3846CF6429ACEBDFB5A2DD86F07F33ED77A@EXMB01.eu.tieto.com>
	 <20110505190948.GD2098@joana> <4E7990A9.2070709@nokia.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1316592118.1937.114.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Antti,

> >>> It's easy to reproduce at least with these dongles:
> >>>
> >>> Alink BLUEUSB21 (BCM)
> >>> Belkin BT2.1 F8T017 (BCM)
> >>> DeLock 2.1 (CSR)
> >>> PTS 2.1 (CSR)
> >>>
> >>> So most of our BT 2.1 dongles seem to be buggy. It would be nice to
> >>> have a workaround since it happens with so many dongles.
> >>
> >> If there is so many buggy devices I think Gustavo and Marcel could consider to take this patch.
> >
> > The patch is too hackish, I don't wanna have such workaround in the tree.
> > It is a good idea check the USB stack for possible causes for this bug.
> >
> 
> We checked this with USB sniffer. Data comes from USB in the same order 
> as shown in hcidump, so USB seems to work correctly.

and this means that the Bluetooth controller is screwing this up.

If you take a real Bluetooth air sniffer then you see that the packet is
most likely encrypted. Problem is just that we do not know for sure. And
the Bluetooth specification is pretty clear on what to do in these
cases. There is even a special qualification test case for this.

The real problem is that the HCI event packets and HCI data packets are
on a different endpoint when you do this over USB. And there is no real
guarantee of ordering in USB when you go over different endpoints.

This is essentially the same problem when some controllers send the
first data packet before we received the Connect Complete event with the
connection handle.

Fact is that the chip manufactures need to start testing for this. And
BlueZ is faster with its event processing than other stacks. That is
something they have to deal with.

Regards

Marcel


