Return-Path: <kmohangda@gmail.com>
Message-ID: <7aa80ced0502212319181c8835@mail.gmail.com>
Date: Tue, 22 Feb 2005 12:49:14 +0530
From: Mohan K <kmohangda@gmail.com>
Reply-To: Mohan K <kmohangda@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] trying to send data at HCI level
Cc: marcel@holtmann.org
In-Reply-To: <1109055931.8506.0.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
References: <7aa80ced0502212224cce2126@mail.gmail.com>
	 <1109055931.8506.0.camel@pegasus>
List-ID: <bluez-users.lists.sourceforge.net>

Hi marcel,
              Thank you for your response. I need some clarifications. 
How to set the device device in RAW mode? In my program I opened the
socket in RAW mode. Is it sufficient?

Regards
Mohan

On Tue, 22 Feb 2005 08:05:31 +0100, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Mohan,
> 
> >        I am using two USB dongles on two different PCs. I want to send
> > and receive data on the either side at HCI level. I wrote one program
> > to send and receive the data, which is not working. I don't know how
> > to send and recevie the data at the HCI level. Previously I wrote
> > program for L2CAP level, which is working.
> 
> it is a bad idea to send data directly at HCI level. However it is
> possible with BlueZ and in this case you must set the device into RAW
> mode, because otherwise L2CAP will handle incoming data.
> 
> Regards
> 
> Marcel
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>
