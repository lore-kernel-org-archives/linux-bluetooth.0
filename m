Return-Path: <huggie@earth.li>
Date: Thu, 13 May 2004 23:26:06 +0100
From: Simon Huggins <huggie@earth.li>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT 120 B4 + 2.6.6 / 2.6.6-mh1
Message-ID: <20040513222606.GE19473@paranoidfreak.co.uk>
References: <20040513202052.GJ14471@paranoidfreak.co.uk> <1084485054.25099.153.camel@pegasus> <20040513220010.GD19473@paranoidfreak.co.uk> <1084486715.25099.164.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1084486715.25099.164.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Salut Marcel!

On Fri, May 14, 2004 at 12:18:35AM +0200, Marcel Holtmann wrote:
> Hi Simon,
> > Ok it shows:
> > 	huggie@thin:~$ hcidump -x
> > 	HCIDump - HCI packet analyzer ver 1.5
> > 	device: hci0 snap_len: 1028 filter: 0xffffffff
> > 	> HCI Event: Command Status(0x0f) plen 4
> > 	  00 01 01 04 
> > 	> HCI Event: Inquiry Complete(0x01) plen 1
> > 	  00 
> I miss the inquiry command. Do you ran hcidump as root? You must see
> something like this:
> 	< HCI Command: Inquiry(0x01|0x0001) plen 5
> 	  33 8B 9E 08 64 
> 	> HCI Event: Command Status(0x0f) plen 4
> 	  00 01 01 04 

Ah right no I didn't since it didn't moan when I ran it as a user.

If I do I get:
	HCIDump - HCI packet analyzer ver 1.5
	device: hci0 snap_len: 1028 filter: 0xffffffff
	< HCI Command: Inquiry(0x01|0x0001) plen 5
	  33 8B 9E 08 64 
	> HCI Event: Command Status(0x0f) plen 4
	  00 01 01 04 
	> HCI Event: Inquiry Complete(0x01) plen 1
	  00 

for a scan and the same for an inq.

Does that mean it should all be working then?

-- 
----------(  I only play with my computer on days that end   )----------
----------(                     in "y".                      )----------
Simon ----(                                                  )---- Nomis
                             Htag.pl 0.0.22
