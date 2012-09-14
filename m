Return-Path: <cyrus@holtmann.org>
From: Philipp Claves <claves@budelmann-elektronik.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Connecting to Bluetooth Low Energy devices
Date: Fri, 14 Sep 2012 10:55:58 +0200
Message-ID: <6387889.teEb9JopTL@arawn>
In-Reply-To: <CAJdJm_MY_TZqay8L0=qOXy3kFkM4RMsXgRKKh1nK7ukokB7WqA@mail.gmail.com>
References: <67399724.T38U7nJAul@arawn> <CAJdJm_MY_TZqay8L0=qOXy3kFkM4RMsXgRKKh1nK7ukokB7WqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson

On Thu, Sep 13, 2012 at 12:54:26, Anderson Lizardo wrote:
> Hi Philipp,
> 
> On Thu, Sep 13, 2012 at 11:34 AM, Philipp Claves
> 
> <claves@budelmann-elektronik.com> wrote:
> > Hello
> > 
> > Trying  to get started with Bluetooth Low Energy devices, i used hcitool
> > and gatttool to enumerate device attributes, but did not get far:
> > 
> > # hcitool lescan
> > LE Scan ...
> > <MAC-Device1> Battery V1.0
> > <MAC-Device1> (unknown)
> > <MAC-Device2> Battery V1.0
> > <MAC-Device2> (unknown)
> > ^C
> > 
> > # gatttool -b <MAC-Device1> -I
> > [   ][<MAC-Device1>][LE]> connect
> > Connecting... connect error: connect error: Connection refused (111)
> > [   ][<MAC-Device1>][LE]>
> > 
> > This is all i get.
> 
> Which kernel version are you running?
Linux 3.5.3
Which is the minimum version required?

> 
> > Am i doing something obviously wrong?
> > Any tips where to get more information about the error (dmesg shows
> > nothing)?
> run "hcidump -X" and check the logs while you run "hcitool lescan".
> Then check the type of advertising those devices are sending. They
> should be connectable advertisings to be able to connect to them. Also
> check the address type, if it is "Random" you need to pass "-t random"
> to gatttool.

Thanks, -t random did the trick.
But it's still strange, the device addresses never changed even once while 
working with them. The bluetooth SIG talk about LE adresses mentioned random 
adresses to change every 15 minutes or so....
I need to investigate this more.

Thanks for your help!


Philipp Claves
-- 
Budelmann Elektronik GmbH
Von-Renesse-Weg 60
48163 Münster
Germany

Tel.  +49 (0)2501 9208440
Fax   +49 (0)2501 5887024
claves@budelmann-elektronik.com
www.budelmann-elektronik.com
