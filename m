Return-Path: <cyrus@holtmann.org>
Message-ID: <507298AA.2020704@rug.nl>
Date: Mon, 08 Oct 2012 11:11:06 +0200
From: Sietse Achterop <s.achterop@rug.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Unreliable communication with multiple bluetooth devices and
 some delay
References: <506AEDFC.9060300@rug.nl>
In-Reply-To: <506AEDFC.9060300@rug.nl>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 02-10-12 15:37, Sietse Achterop wrote:

> I have 7 bluetooth devices (epucks, educational robots:  http://www.e-puck.org/).
> They use the lmx9838 device for bluetooth and are seen as rfcomm-devices on linux.
> The lmx-device is used in transparent mode.
> This is on various linuxes, with kernels 2.6.32, 3.0.0 and 3.2, e.g. as in the latest ubuntu 12.04.1.
> 
> The test program is a simple loop that continuously sends each epuck a small message,
> a string of say 6 characters.
> I use stdio's fprintf to send chars to the /dev/rfcomm devices.
> In pseudo code:
>   open_devices();
>   while true do
>     for i = 1 to 7 do
>        fprintf(fp[i], "l,1,2\n");
>     od
>     delay( 0.5 seconds);
>   od
> 
> This works perfectly if the delay statement is REMOVED.
> Then each 2 milliseconds a message is send to the next epuck.
> But if the delay is ADDED again it gets very UNRELIABLE.
> After 1 to 30 seconds a communication is failing and after a
> 20 second delay the connection of a epuck is dropped.
> After a longer time all connections are dropped.

   Dear list,

to react on my on question, I just installed kernel 3.6.1, but the problem does
not go away:(.
It is random which of the epuck fails.
I would be grateful with some pointer. Could it be hardware in one of the BT devices?
I used a number of different dongles on the linux site. If it is a hardware problem,
it must be a structural problem in the hardware.
If it is no hardware problem, it has to be software on the linux site, because the lmx9838 is
used in transparent mode and the software is not much more than an echo and is software that
has been working for more than a year.
Am I using bluetooth in an unusual way?

  Regards,
    Sietse

