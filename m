Return-Path: <huggie@earth.li>
Date: Thu, 13 May 2004 23:00:10 +0100
From: Simon Huggins <huggie@earth.li>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT 120 B4 + 2.6.6 / 2.6.6-mh1
Message-ID: <20040513220010.GD19473@paranoidfreak.co.uk>
References: <20040513202052.GJ14471@paranoidfreak.co.uk> <1084485054.25099.153.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084485054.25099.153.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Hi Marcel,

On Thu, May 13, 2004 at 11:50:54PM +0200, Marcel Holtmann wrote:
> > I tried running hcidump too and it shows me stuff like:
> > > HCI Event: Inquiry Complete(0x01) plen 1
> > > HCI Event: Command Status(0x0f) plen 4
> > when I run the above scan.
> run it with -x switch to better see the event content.

Ok it shows:
	huggie@thin:~$ hcidump -x
	HCIDump - HCI packet analyzer ver 1.5
	device: hci0 snap_len: 1028 filter: 0xffffffff
	> HCI Event: Command Status(0x0f) plen 4
	  00 01 01 04 
	> HCI Event: Inquiry Complete(0x01) plen 1
	  00 

> >         UP RUNNING PSCAN ISCAN AUTH 
> You should disable auth in hcid.conf, because this will set the dongle
> into security mode 3 and this is not what you want.

I took out the auth line in hcid.conf and it got rid of the AUTH line
but it still doesn't find anything.

I asked someone else who said they hadn't got it working in 2.6.5 but
that it works in 2.4.x.

I'm not sure what to try next to debug this or get it working.

Simon.

-- 
Just another wannabie |  Le doute est le commencement  |  Just another fool
----------------------+         de la sagesse.         +-------------------
This message was brought to you by the letter R and the number 14.
htag.pl 0.0.22 -- http://www.earth.li/projectpurple/progs/htag.html
