Return-Path: <rfoster@mountainvisions.com.au>
Subject: Re: [Bluez-users] bluez-utils 2.7 and bthid
From: Robert Foster <rfoster@mountainvisions.com.au>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1084181881.9269.149.camel@pegasus>
References: <1084160685.3287.2.camel@rover.mountainvisions.com.au>
	 <1084177906.9269.129.camel@pegasus>
	 <1084180461.3145.8.camel@rover.mountainvisions.com.au>
	 <1084181881.9269.149.camel@pegasus>
Content-Type: text/plain
Message-Id: <1084184033.3139.3.camel@rover.mountainvisions.com.au>
Mime-Version: 1.0
Date: Mon, 10 May 2004 20:13:53 +1000
List-ID: <bluez-users.lists.sourceforge.net>

Okay, cool:) everything working now:)
On Mon, 2004-05-10 at 19:38, Marcel Holtmann wrote:
> as I said, don't enable auth and encrypt in hcid.conf, because this is
> security mode 3. Make also sure that only one hcid is running.
> 
disabled these - for some reason I was under the impression that I
needed them to connect to my Nokia 6600..  But I guess I was wrong :) 
this was an overhang from the old laptop.
> > I have also set up a rather simple script - /etc/init.d/bluetooth-hid to
> > automatically connect to the mouse at startup, which gets it's options
> > from a config file in /etc/bluetooth/hid.conf
> 
> Why do you need that? The mouse and keyboard reconnects after you've
> pressed a key. The only thing you have to start is bthid in daemon mode.
> 
Ok, so I don't have to re-connect everytime I boot up?  Cool :)
> Regards
> 
> Marcel
Thanks Marcel.
