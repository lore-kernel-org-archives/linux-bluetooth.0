Return-Path: <cyrus@holtmann.org>
Date: Mon, 8 Oct 2012 12:15:36 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Sietse Achterop <s.achterop@rug.nl>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Unreliable communication with multiple bluetooth devices and
 some delay
Message-ID: <20121008091535.GG2456@aemeltch-MOBL1>
References: <506AEDFC.9060300@rug.nl>
 <507298AA.2020704@rug.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <507298AA.2020704@rug.nl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Oct 08, 2012 at 11:11:06AM +0200, Sietse Achterop wrote:
> On 02-10-12 15:37, Sietse Achterop wrote:
> 
> > I have 7 bluetooth devices (epucks, educational robots:  http://www.e-puck.org/).
> > They use the lmx9838 device for bluetooth and are seen as rfcomm-devices on linux.
> > The lmx-device is used in transparent mode.
> > This is on various linuxes, with kernels 2.6.32, 3.0.0 and 3.2, e.g. as in the latest ubuntu 12.04.1.
> > 
> > The test program is a simple loop that continuously sends each epuck a small message,
> > a string of say 6 characters.
> > I use stdio's fprintf to send chars to the /dev/rfcomm devices.
> > In pseudo code:
> >   open_devices();
> >   while true do
> >     for i = 1 to 7 do
> >        fprintf(fp[i], "l,1,2\n");
> >     od
> >     delay( 0.5 seconds);
> >   od
> > 
> > This works perfectly if the delay statement is REMOVED.
> > Then each 2 milliseconds a message is send to the next epuck.
> > But if the delay is ADDED again it gets very UNRELIABLE.
> > After 1 to 30 seconds a communication is failing and after a
> > 20 second delay the connection of a epuck is dropped.
> > After a longer time all connections are dropped.
> 
>    Dear list,
> 
> to react on my on question, I just installed kernel 3.6.1, but the problem does
> not go away:(.
> It is random which of the epuck fails.
> I would be grateful with some pointer. Could it be hardware in one of the BT devices?
> I used a number of different dongles on the linux site. If it is a hardware problem,
> it must be a structural problem in the hardware.
> If it is no hardware problem, it has to be software on the linux site, because the lmx9838 is
> used in transparent mode and the software is not much more than an echo and is software that
> has been working for more than a year.
> Am I using bluetooth in an unusual way?

Get capture with hcidump like "hcidump -tX -i hciX". It will tell you why
connection is closed. Also dmesg might give some warnings.

Best regards 
Andrei Emeltchenko 

