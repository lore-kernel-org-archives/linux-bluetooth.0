Return-Path: <marosg@yahoo.com>
Message-ID: <20040423081254.81987.qmail@web20421.mail.yahoo.com>
Date: Fri, 23 Apr 2004 01:12:54 -0700 (PDT)
From: Marian Gasparovic <marosg@yahoo.com>
Subject: Re: [Bluez-users] bluetooth/gprs problem
To: Marcel Holtmann <marcel@holtmann.org>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <1082626222.1845.17.camel@merlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-users.lists.sourceforge.net>

forwarded to mailing list without attachments.

Marcel,
--- Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Marian,
> 
> > I have i-Tec USB Dongle with Broadcom chip
> connected
> > to my notebook with Debian Woody. I am able to
> > establish bluetooth connection to my Siemens S55
> > mobile. After I start pppd for GPRS access to
> Internet
> > I get connected. I can ping any server for as long
> as
> > I want. But when I open any web page under
> Konqueror
> > or try ping -f, after couple of seconds (10-20) I
> > loose connection. First I see bluetooth going away
> on
> > mobil display, then gprs disconnect and after a
> minute
> > pppd finds it out too. Any suggestions where to
> look ?
> > I tried it with several notebooks, usb bluetooth
> > devices and mobiles and only this i-Tec USB Dongle
> > makes troubles. Under Windows XP it works without
> a
> > problem.
> 
> this can be a dongle problem, because the dongle
> contains a Broadcom
> chip and we already know that under some weird
> circumstances this is
> buggy. But actually I think that your PPP setting
> are not correct for a
> GPRS dialin. Check the some GPRS+PPP HOWTO's.
> 
> If you really want to be sure that this is no
> Bluetooth problem you must
> run "hcidump -w <file>" as root and send us the
> resulting dump file.
> 
now it is very strange waht I see. First I tried some
experiments with uhci, uhci(je) and ohci, nothing
helped. Then I tried hcidump -w and I was able to surf
half an hour without a problem !!! Then I restarted a
computer, surfing worked, but I was aborted after
several minutes. Now I have hcidump output I hope you
will find something there. And another thing - when I
restart my notebook, I have to restart bluez-utils and
bluez-sdp before I can connect, otherwise pppd doesn't
connect with /dev/rfcomm0:connection refused. I even
attach my ppp chatscript and peer config files.
Any help ?
Thank you



	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
