Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: RE: [Bluez-devel] SCO. Some ideas.
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Message-ID: <A1F0D47583A2D711919F00600819B3A45BDAF5@goofy.vitronics.com>
From: "Williams, Richard" <Richard.Williams@VITRONICS.com>
To: "James Courtier-Dutton" <James@superbug.demon.co.uk>
Cc: "BlueZ Mailing List" <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 1 Mar 2004 14:08:01 -0500

James,

Thanks for the reply. But I am having trouble getting SCO to work on my
platform. Can you point me to any documentation that explains how
to get this to work ? I want to have a Sony-Ericsson BT headset to=20
send/receive audio to/from my Linux box - 2.4.19.=20

I do have BT working: rfcomm, SDP, Obex, but SCO is giving me more=20
trouble.

Thanks very much,

Rich

-----Original Message-----
From: James Courtier-Dutton [mailto:James@superbug.demon.co.uk]
Sent: Monday, March 01, 2004 12:39 PM
To: Williams, Richard
Cc: BlueZ Mailing List
Subject: Re: [Bluez-devel] SCO. Some ideas.


Williams, Richard wrote:
> Hi Guys,
>=20
> Your discussion is very relevant to me, since I'm building a small
> wearable computer system that will have several Bluetooth devices -=20
> among them will be a headset. I was planning to use standard rfcomm
> to send data among the other devices and use SCO for the interface=20
> from my computer to the BT headset.
>=20
> It sounds from your discussion that SCO is really not ready to be =
used.
> In my case, since I'm building an embedded system, I want simple
> and low power. For my system I'd really like a socket interface to =
SCO.
> If I MUST use a large audio package like ALSA, then I'll do that, but
> I really want something small and simple.
>=20
> Is there a bluez SCO that I can use ?=20
> Do you have any idea when a stable SCO package will be available ?
>=20
> I'm currently using linux-2.4.19 on an Intel Xscale processor.
>=20
> thank you very much,
>=20
> Regards,
>=20
> Rich
>=20
> Richard B. Williams
> Vitronics, Inc.
> 3 Corbett Way
> Eatontown, NJ 07724-2262
> 732-389-0244 x29
> Richard.Williams@vitronics.com
>=20

SCO connections currently functions over the socket interface.
You can send sound to the headset, and receive sound from the headset=20
mics. The only problem is in the buffering. That support is there in=20
kernel 2.6.4, or 2.6.3 with patches, and also 2.4.x with other patches.

The problem in the buffering is the current lack of any feedback.
E.g. You output 0.1 second of samples. There is no feedback to tell you=20
that all the samples have been played, or if it is still in the middle=20
of playing.
So, lets take a possible real world setup.
One is playing an internet video stream. One has no way to keep audio in =

sync with video.

Summary: -
The current SCO support if fine, unless you need to keep the playback=20
audio in sync with anything.

Cheers
James


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
