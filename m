Return-Path: <cyrus@holtmann.org>
Date: Tue, 21 Oct 2008 05:00:56 -0200
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: David Sainty <David.Sainty@dtsp.co.nz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-bluetooth@vger.kernel.org, bugme-daemon@bugzilla.kernel.org
Subject: Re: [Bugme-new] [Bug 11779] New: No way to disable bluetooth
Message-ID: <20081021070056.GA15748@ime.usp.br>
References: <bug-11779-10286@http.bugzilla.kernel.org/> <20081020172426.4e28ba79.akpm@linux-foundation.org> <48FD397F.2020101@dtsp.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <48FD397F.2020101@dtsp.co.nz>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi, Andrew, David and others.

On Oct 21 2008, David Sainty wrote:
> Andrew Morton wrote:
> >>http://bugzilla.kernel.org/show_bug.cgi?id=11779
> >>
> >>According to the manual, under Windows Vista (which is what came with
> >>the box, but which I never used), this button is supposed to cycle
> >>between 4 states:
> >>
> >>* both disabled;
> >>* bluetooth enabled & wifi enabled;
> >>* bluetooth disabled & wifi enabled;
> >>* bluetooth enabled & wifi disabled.
> >>
> >>Unfortunately, under Linux (tested with Ubuntu's 8.10 pre-releases,
> >>which includes a kernel based on 2.6.27-rc*, if I understand it
> >>correctly), it is all or nothing: both disabled or both enabled.
> >>
> >>If I launch powertop, it recommends to disable bluetooth with
> >>"hciconfig hci down; rmmod hci_usb", but the led of bluetooth is still
> >>lit and I fear that the device is still drawing power from the battery.
> >>(Actually, it seems that the modules for bluetooth go renamed also).
> >>
> >>    
> If the LED is on, it's obviously drawing at least enough power to light 
> the LED :)

Indeed. :-)

> >>Is there any way to get it to disable completely the device?
>
> This is a guess, but probably turning it on and off has nothing to do 
> with the bluetooth support, it's probably intended to be powered on and 
> off through ACPI or something - it's probably very specific to that 
> particular laptop.

How can we chase this issue? I am willing to cooperate as much as possible,
with as much data that I can to get things straight. It's got an Intel ICH8
chipset here, with a Realtek rt8169-driven wired network. It's battery is
quite short under Linux. :-(

(And it seems that the gnome power indicator is confused when reading data
about the battery, since it sometimes shows the battery as completely
drained when it is actually charged and plugged on the AC outlet).

I really, really don't want to install Windows Vista for use, but I may
install it for debugging/reverse engineering/simulating the behaviour.

> However, "hciconfig hci down" should at least minimise any drain the 
> device is causing.

I may test it latter, but I'm scared. And this is what is preventing me
from using this notebook (as well as bug
http://bugzilla.kernel.org/show_bug.cgi?id=11717).

For this latter one I even provided a *video* of me pressing the power
button and the machine not waking up from suspend. :-( I can't think of
anything else that I can provice, but I'm willing to help here.


Thanks for any help,

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
