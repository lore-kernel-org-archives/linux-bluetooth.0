Return-Path: <office@produktivIT.com>
From: Krisztian Mark Szentes <office@produktivIT.com>
To: Marcel Holtmann <marcel@rvs.uni-bielefeld.de>
Subject: Re: [Bluez-users] bt3c_cs time out - no firmware loaded?
Date: Tue, 13 May 2003 10:47:39 +0200
References: 
	<53B03DA73719D5119E6A0008C71E1D78030EA9A3@svr-mail1.corp.home.nl>
	<200305081542.17759.office@produktivit.com>
	<1052785027.1133.174.camel@pegasus.local>
In-Reply-To: <1052785027.1133.174.camel@pegasus.local>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Message-Id: <200305131047.39294.office@produktivIT.com>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel

On Tuesday 13 May 2003 02:17, Marcel Holtmann wrote:
> > I have trouble with the 3COM Cardbus bluetooth card on a Powerbook
> > Titanium (a powerpc notebook). I patched the 2.4.20 kernel with the
> > mh-6 patch (and the benh patch which does not collide). I haven't
> > found any hint on the list yet.
> >
> > With a USB bluetooth adapter (hci_usb) everything works fine. I have a
> > wonderful RFCOMM communication to a Nokia 6310 and I can get on the
> > internet via GPRS.
>
> is this a SMP enabled kernel? The driver have some problems if you run a
> SMP kernel. Try to disable it.
No, single processor. powerpc.
# CONFIG_SMP is not set

I hope the card itself would work all right; but as far as I can tell the 
firmware does not get loaded. I hope this is not a powerpc arch problem.

Cheers

Mark
-- 
produktivIT   -  Open-Source Solution Provider
Siebenbrunnengasse 55/7
A-1050 Wien
