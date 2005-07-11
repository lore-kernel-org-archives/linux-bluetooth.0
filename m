Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] pand D-Bus service
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <e1effdeb050711115470809e4a@mail.gmail.com>
References: <e1effdeb05070811375af87810@mail.gmail.com>
	 <1120849681.7444.1.camel@notepaq>
	 <e1effdeb050711115470809e4a@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1121110034.5934.24.camel@notepaq>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 11 Jul 2005 21:27:14 +0200

Hi Claudio,

> According with your emails, bluetoothd shall provide 
> methods for settings and send signals.
> I finished the D-Bus services for pand, now we need
> define how organize these services. 
> 
> In my opinion the bluetoothd should be responsible for
> provide all D-Bus services, including pand, hidd, cip, ...
> Create D-Bus services for each daemon will require 
> monitor a lot of dbus connections. It's easier and more
> efficient create "profile objects" for each profile inside
> bluetoothd. Buetoothd can monitor different interfaces and 
> objects.

this is my idea and then you can write a simple Python script and use
all Bluetooth stuff over D-Bus. This way it should be possible to
implement some graphical tools for using Bluetooth.

> Currently, my D-Bus pand implementation is providing:
>   -adapters: show local bluetooth adapters
>   -connect:connect to a bluetooth device
>   -connections: show active connections
>   -disconnect: kill connections
>   -enable-bridge: enable automatic bridge creation on listening
>   -find: search for a service
>   -listen: start/stop listen for bluetooth connections
>   -role: switch the role MASTER|SLAVE
>   -udhcp:enable UDHCP on listen or connect
>   -init: initialize the bluez pan daemon (pand)
>   -kill: kill the pand
> 
> 
> If you see the code of D-Bus hcid, the D-Bus message control functions
> are similar. The best approach is move all to daemon directory.

The bluetoothd should handle every of these things. However the main
focus at the moment is device configuration and the handling of security
related stuff. I am not 100% sure about the interface, but in general I
like to use something similar to Hal.

Adding interfaces for PAN, HID etc. is not so important for me. Once we
have the core stuff running, the should be really easy then.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
