Return-Path: <jon@valvatne.com>
Subject: Re: [Bluez-users] hidd --server only finding one device
From: Jon Valvatne <jon@valvatne.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1087513312.4309.100.camel@pegasus>
References: <1087496559.3103.11.camel@localhost.localdomain>
	 <1087504160.4309.78.camel@pegasus>
	 <1087507199.3103.27.camel@localhost.localdomain>
	 <1087510775.4309.86.camel@pegasus>
	 <1087511321.3103.32.camel@localhost.localdomain>
	 <1087511911.4309.94.camel@pegasus>
	 <1087512926.3103.51.camel@localhost.localdomain>
	 <1087513312.4309.100.camel@pegasus>
Content-Type: text/plain
Message-Id: <1087520970.3103.87.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 18 Jun 2004 03:09:31 +0200
List-ID: <bluez-users.lists.sourceforge.net>

On Fri, 2004-06-18 at 01:01, Marcel Holtmann wrote:
<snip>
> 
> I think the problem here is your Bluetooth card. The Nokia card is
> working fine, but it seems that it has problems when you try to get
> another device into that piconet in which it is already master. I only
> own the DTL-1 and so I can't test this, but with a newer card or USB
> dongle everything should work, because I tested already this case with
> seven HID devices and it was working perfect.
> 

Ok, thank you very much for your help. I was actually happy when I
received a Socket card of revision F instead of G, because then I
wouldn't have to worry about the G card not working with the 2.6 kernel.
But I guess there's a reason they never supported HID in their windows
drivers for the previous revisions.

I've just ordered their special upgrade offer, so hopefully in a week or
two I'll have both the F and the G revision to play with. Maybe I can
even somehow make the newer card work with 2.6, so I can have both a new
kernel and working HID. Wish me luck :)

Jon
