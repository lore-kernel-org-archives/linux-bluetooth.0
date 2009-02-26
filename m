Return-Path: <cyrus@holtmann.org>
Subject: Re: BlueZ pairing failure and kernel 2.6.24 crash
From: Marcel Holtmann <marcel@holtmann.org>
To: Frederic Danis <frederic.danis@access-company.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <49A6657C.6020109@access-company.com>
References: <49886819.2030401@access-company.com>
	 <1233772466.12562.6.camel@californication>
	 <498B0C6A.6000609@access-company.com> <49A6657C.6020109@access-company.com>
Content-Type: text/plain
Date: Thu, 26 Feb 2009 17:05:19 +0100
Message-Id: <1235664319.27004.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Frederic,

> >>> I am working with BlueZ 3.22, kernel 2.6.24 on ARM and found 2 
> >>> problems :
> >>>
> >>> -  I am not able to pair with some phones (Nokia N70 and 
> >>> sony-ericsson P800). After some investigations, I found that a "L2CAP 
> >>> information request packet" is sent just after the ACL connection. 
> >>> Both phones reply with "command rejected" error, then disconnect the 
> >>> ACL link before BlueZ is able to finish the pairing (see attached 
> >>> traces).
> >>>
> >>> - with some other phones (LG 990 Viewty and sony-ericsson T610), the 
> >>> kernel crashes after pairing initiated by the phone is completed.
> >>>
> >>> For the first problem I removed the send of the "L2CAP information 
> >>> request packet" in the kernel (see attached patch). This fixes both 
> >>> problems.
> >>>
> >>> I did not found any usage of the remote L2CAP information in kernel.
> >>> Is sending "L2CAP information request packet" mandatory for upper 
> >>> layer and/or qualification ?
> >>> Is my fix OK ?
> >>
> >> sending the L2CAP info is just fine. It should not cause any problems. I
> >> think it is the pairing code that does some weird things at the wrong
> >> time. Can you test with bluetooth-testing.git against bluez-4.28 to
> >> verify that this issue still exists.
> > 
> > I try multiple configuration to test these 2 problems :
> > 
> > - pairing out failure with P800 or N70 :
> >   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 3.26 => unable to pair (see 
> > Ubuntu804_Bluez326_traces.txt)
> >   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 4.28 => unable to pair (see 
> > Ubuntu804_Bluez428_traces.txt)
> >   - Ubuntu 8.10 + kernel 2.6.27.11 + BlueZ 4.12 => pairing OK (see 
> > Ubuntu810_Bluez412_traces.txt)
> > 
> >   To perform pairing I use :
> >   BlueZ 3.26 : dbus-send --system --type=method_call --print-reply 
> > --dest=org.bluez /org/bluez/hci1 org.bluez.Adapter.CreateBonding 
> > string:00:0A:D9:14:D0:85
> >   BlueZ 4.xx : bluez-4.xx/test/simple-agent hci0 00:0A:D9:14:D0:85
> > 
> > - kernel crash with LG 990 :
> >   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 3.26 => Ubuntu freeze (kernel 
> > crash)
> >   - Ubuntu 8.04 + kernel 2.6.24.23 + BlueZ 4.28 => Ubuntu freeze (kernel 
> > crash)
> >   - Ubuntu 8.10 + kernel 2.6.27.11 + BlueZ 4.12 => pairing OK
> > 
> > So, for me, it seems to be a problem in the kernel 2.6.24.
> > What is your opinion ?
> > 
> > Unfortunately, I am not able to change kernel version. Do you have any 
> > idea how to fix this, please ? Is my fix OK ?
> > 
> 
> Do you have any idea how to fix this, please ? Is my fix OK ?
> Is there any problem (interoperability, qualification, ...) to remove L2CAP info request ?

you don't have to do the information request, but then you have to make
sure that you do this the right way. Otherwise you mess with the state
machine of L2CAP.

Have you ever looked at the patches from bluetooth-testing.git, because
I did fix a couple of race conditions that came up when implementing the
information request support. They only show when using non-blocking
L2CAP sockets.

Regards

Marcel


