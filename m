Return-Path: <cyrus@holtmann.org>
From: <Lukasz.Rymanowski@tieto.com>
To: <mika.linnanoja@nokia.com>, <linux-bluetooth@vger.kernel.org>
CC: <ville.tervo@nokia.com>, <antti.julku@nokia.com>, <marcel@holtmann.org>,
	<linus.walleij@stericsson.com>, <par-gunnar.p.hjalmdahl@stericsson.com>,
	<padovan@profusion.mobi>
Date: Wed, 4 May 2011 10:53:17 +0300
Subject: RE: [PATCH] bluetooth: Fix for security block issue.
Message-ID: <7D7F2FD3846CF6429ACEBDFB5A2DD86F07F33ED77A@EXMB01.eu.tieto.com>
References: <1295965639-16683-1-git-send-email-lukasz.rymanowski@tieto.com>
 <1295971990.1520.53.camel@aeonflux> <4DB935D9.5080302@nokia.com>
 <20110428095139.GJ18898@null> <4DBA6D97.7050207@nokia.com>
In-Reply-To: <4DBA6D97.7050207@nokia.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Apr 28, 2011 at 12:39:37PM +0300, Antti Julku wrote:
> It's easy to reproduce at least with these dongles:
>=20
> Alink BLUEUSB21 (BCM)
> Belkin BT2.1 F8T017 (BCM)
> DeLock 2.1 (CSR)
> PTS 2.1 (CSR)
>=20
> So most of our BT 2.1 dongles seem to be buggy. It would be nice to=20
> have a workaround since it happens with so many dongles.

If there is so many buggy devices I think Gustavo and Marcel could consider=
 to take this patch.

On 04/28/2011 12:51 PM, ext Ville Tervo wrote:
> Could the actual reason be some change in usb stack? Could it have=20
> lower priority for event pipe than for data pipe? In that case event=20
> for security change might arrive to bt stack too late.
>
> At lest I haven't seen this kind of behaviour with serial attached=20
> chips. So I think this is something USB specific.

I found the problem on serial attached chip.
Before I received fix in the chip I used that patch for couple months witho=
ut the problems.

Br
Lukasz
