Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] starting sdpd, default local service
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <4229B4C7.4070503@gmx.ch>
References: <4229B4C7.4070503@gmx.ch>
Content-Type: text/plain
Message-Id: <1110030258.8168.12.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 05 Mar 2005 14:44:18 +0100

Hi Marco,

> I noticed, that when I start sdpd, there's this service:
> Service Name: Public Browse Group Root
> Service Description: Root of public browse hierarchy
> Service Provider: BlueZ
> Service RecHandle: 0x10000
> Service Class ID List:
>    "Browse Group Descriptor" (0x1001)
> Language Base Attr List:
>    code_ISO639: 0x656e
>    encoding:    0x6a
>    base_offset: 0x100
> 
> What is it is for?

it is the root of the public browse group.

> I think I don't need it. How can I prevent it from starting? Is only 
> [sdptool del 0x10000] an option?

Yesterday I checked in a patch that doesn't make it public anymore. If
you use the sdpd from CVS, you will get a clean public browse group
until you start it with the -p or --public parameter.

> what are the -n and -m switches for in sdpd? -n is documented in the 
> manpage but sdpd detaches anyway if i use -n...

The -n means no detach and thus the sdpd is blocking your terminal until
you terminate it. Basically this mode is for debugging and testing only.

The -m will force a role switch for a connecting device. In general it
is not a good idea to use it, but in some corner cases you may wanna be
able to do so.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
