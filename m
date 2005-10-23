Return-Path: <pavel@ucw.cz>
Date: Sun, 23 Oct 2005 10:35:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Ed Tomlinson <tomlins@cam.org>
Cc: marcel@holtmann.org, maxk@qualcomm.com, bluez-devel@lists.sourceforge.net,
   kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Billionton bluetooth CF card: performance is 10KB/sec
Message-ID: <20051023083535.GA1975@elf.ucw.cz>
References: <20051022173152.GA2573@elf.ucw.cz> <200510221801.49314.tomlins@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200510221801.49314.tomlins@cam.org>
List-ID: <bluez-devel.lists.sourceforge.net>

Hi!

> > I use this to set up billionton:
> > 
> > setserial /dev/ttyBT baud_base 921600
> > hciattach -s 921600 /dev/ttyBT bcsp
> > 
> > root@amd:~# tcpspray -n 1 -b 1000000 10.1.0.3
> > 
> > Transmitted 1000000 bytes in 163.256781 seconds (5.982 kbytes/s)
> > 
> > (okay, this was little slower, I was far from other side). Most tests
> > look like this:
> > 
> > root@amd:~# tcpspray -n 1 -b 1000000 10.1.0.3
> > 
> > Transmitted 1000000 bytes in 103.183640 seconds (9.464 kbytes/s)
> 
> Pavel,
> 
> I see about the same with a bluetooth usb adapter.  Suspect that is about what
> you should see with bluetooth - its not designed for speed.  It would be really 
> nice to be wrong though...

No, it is designed to do more. It should do around ~100 kbytes/sec
according to spec, and MSI dongle *does* do 25 kbytes/sec easily
against nokia 6230.
							Pavel
-- 
Thanks, Sharp!
