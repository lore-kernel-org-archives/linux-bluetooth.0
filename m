Return-Path: <tomlins@cam.org>
From: Ed Tomlinson <tomlins@cam.org>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Date: Sun, 23 Oct 2005 08:53:13 -0400
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
   kernel list <linux-kernel@vger.kernel.org>
References: <20051022173152.GA2573@elf.ucw.cz> <200510221801.49314.tomlins@cam.org> <20051023083535.GA1975@elf.ucw.cz>
In-Reply-To: <20051023083535.GA1975@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510230853.14484.tomlins@cam.org>
List-ID: <bluez-devel.lists.sourceforge.net>

On Sunday 23 October 2005 04:35, Pavel Machek wrote:
> > > Transmitted 1000000 bytes in 103.183640 seconds (9.464 kbytes/s)
> >=20
> > I see about the same with a bluetooth usb adapter. =A0Suspect that is a=
bout what
> > you should see with bluetooth - its not designed for speed. =A0It would=
 be really=20
> > nice to be wrong though...
>=20
> No, it is designed to do more. It should do around ~100 kbytes/sec
> according to spec, and MSI dongle *does* do 25 kbytes/sec easily
> against nokia 6230.

Pavel,

Then the interesting test is to see if the delay is kernel or phone.   Are =
you talking
to the same phone with both adapters?  If so please copy me on any test pat=
ches as
I too have the same issue when talking to a pilot T3 using rfcomm using a "=
0a12:0001=20
Cambridge Silicon Radio, Ltd Bluetooth Dongle (HCI mode)" usb dongle.

I would _love_ to get 25K/s

Thanks,

Ed Tomlinson
