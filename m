Return-Path: <huggie@earth.li>
Date: Fri, 14 May 2004 09:59:51 +0100
From: Simon Huggins <huggie@earth.li>
To: Marcel Holtmann <marcel@holtmann.org>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] D-Link DBT 120 B4 - works in 2.4.26-mh1 not 2.6.6
Message-ID: <20040514085951.GL19473@paranoidfreak.co.uk>
References: <20040513202052.GJ14471@paranoidfreak.co.uk> <1084485054.25099.153.camel@pegasus> <20040513220010.GD19473@paranoidfreak.co.uk> <1084486715.25099.164.camel@pegasus> <20040513222606.GE19473@paranoidfreak.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040513222606.GE19473@paranoidfreak.co.uk>
List-ID: <bluez-users.lists.sourceforge.net>

On Thu, May 13, 2004 at 11:26:06PM +0100, Simon Huggins wrote:
> On Fri, May 14, 2004 at 12:18:35AM +0200, Marcel Holtmann wrote:
> > I miss the inquiry command. Do you ran hcidump as root? You must see
> > something like this:
> > 	< HCI Command: Inquiry(0x01|0x0001) plen 5
> > 	  33 8B 9E 08 64 
> > 	> HCI Event: Command Status(0x0f) plen 4
> > 	  00 01 01 04 
> Ah right no I didn't since it didn't moan when I ran it as a user.

> If I do I get:
> 	HCIDump - HCI packet analyzer ver 1.5
> 	device: hci0 snap_len: 1028 filter: 0xffffffff
> 	< HCI Command: Inquiry(0x01|0x0001) plen 5
> 	  33 8B 9E 08 64 
> 	> HCI Event: Command Status(0x0f) plen 4
> 	  00 01 01 04 
> 	> HCI Event: Inquiry Complete(0x01) plen 1
> 	  00 

> for a scan and the same for an inq.

In 2.4.26-mh1 I can see the phone I get:
	huggie@thin:~$ sudo hcidump -x
	HCIDump - HCI packet analyzer ver 1.5
	device: hci0 snap_len: 1028 filter: 0xffffffff
	< HCI Command: Inquiry(0x01|0x0001) plen 5
	  33 8B 9E 08 64 
	> HCI Event: Command Status(0x0f) plen 4
	  00 01 01 04 
	> HCI Event: Inquiry Result(0x02) plen 15
	  01 29 F4 36 6D 0E 00 01 00 00 04 02 52 46 6B 
	> HCI Event: Inquiry Complete(0x01) plen 1
	  00 
	< HCI Command: Remote Name Request(0x01|0x0019) plen 10
	  29 F4 36 6D 0E 00 02 00 00 00 
	> HCI Event: Command Status(0x0f) plen 4
	  00 01 19 04 
	> HCI Event: Remote Name Req Complete(0x07) plen 255
	  00 29 F4 36 6D 0E 00 53 68 69 6E 79 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
	  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 

And the scan does see the device with the name I gave it.


Simon.

-- 
"Be wewy wewy careful. There be dragons here." -- Linus Torvalds
