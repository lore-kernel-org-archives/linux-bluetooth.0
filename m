Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4B5F29E2.2010906@gmx.net>
References: <4B5C554D.4030702@gmx.de> <1264343316.11653.0.camel@violet>
	 <4B5C6062.4030705@gmx.de> <1264346020.11653.1.camel@violet>
	 <2d5a2c101001241309u6e292a12hfc5c67011d6b77ba@mail.gmail.com>
	 <4B5EA94B.1000204@gmx.de>
	 <2d5a2c101001260236v506b53dcl9d948722f7926329@mail.gmail.com>
	 <4B5F29E2.2010906@gmx.net>
Date: Wed, 27 Jan 2010 00:01:15 +0200
Message-ID: <2d5a2c101001261401l5424c174qaaee6351c4435a03@mail.gmail.com>
Subject: Re: [PATCH 1/1] add configurable support for bridge forward delay
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Thomas Egerer <thomas.washeim@gmx.net>
Cc: Marcel Holtmann <marcel@holtmann.org>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Thomas,

On Tue, Jan 26, 2010 at 7:44 PM, Thomas Egerer <thomas.washeim@gmx.net> wro=
te:
>
> Luiz,
>
> I disagree. On page 31 the specification states that a NAP/GN performs
> the following (in regard to packet forwarding operations):
> 'Automatically learn and maintain the information required to make
> frame-filtering decisions as described in [3] section 7.1 and specified
> in [3] sections 7.8 and 7.9, for the support of Basic Filtering Services.=
'
> and even if it says in the next paragraph:
> 'The NAP/GN is not required to perform any of the following aspects of
> the 802.1D standard.'
> footnote 4 mentions:
> 'Sophisticated Bluetooth NAP devices may choose to implement some or all
> of the 802.1D features.'
> In my eyes this supports my point of view since the forward delay as
> part of the learning process should be a subject of configuration.
> Could I convince you?

You almost convince me, but after some googling it seems
http://www.linuxfoundation.org/collaborate/workgroups/networking/bridge#Spa=
nning_Tree_Protocol
contradicts what you are saying:

"The Spanning Tree Protocol has no authentication; all participants
are assumed to be trustworthy and correct. This assumption is not true
if bridging between a hostile environment like the Internet and a
private network. For this reason, STP is turned off by default on the
recent versions of Linux."

And even the spec itself seem to support my argument:

"2004 =97 Revised version (802.1D-2004), incorporating the extensions
802.11c, 802.1t and 802.1w, which were separately published in 2001,
and removing the original Spanning tree protocol, instead
incorporating the Rapid Spanning Tree Protocol (RSTP) from 802.1w."

Naturally someone else also notice that this arbitrary delay during
the learning phase is a bad idea after all and invented the RSTP and I
guess PAN spec was released after 2004 so that would explain why we
don't see anything about how to handle forwarding delay.


--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o
