Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] multiple devices clarification?
From: Marcel Holtmann <marcel@holtmann.org>
To: Anthony Yulo <strikewing16th@hotmail.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <LAW11-F70hbG9UwhcYb0001b888@hotmail.com>
References: <LAW11-F70hbG9UwhcYb0001b888@hotmail.com>
Content-Type: text/plain
Message-Id: <1077730129.2919.123.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 25 Feb 2004 18:28:49 +0100

Hi Anthony,

> I just want to clarify about bluez  supporting multiple devices in on 
> computer...

you can attach up to 16 Bluetooth adapters to your PC.

> and then lookd into one of marcel's pages and it said:
> 
> "HCI 16.x Any combination of seven slaves and two masters (but not more than 
> seven devices at one time)  "..
> 
> So what does this mean? so i can't have more than two masters in one 
> computer? is that correct?

This is CSR specific and these are per device limitations.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
