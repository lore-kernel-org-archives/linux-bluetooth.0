Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <4106C88A.6020009@ntlworld.com>
From: Oli Ellis <oliver.ellis@ntlworld.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] Will this work?
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 27 Jul 2004 22:26:34 +0100

I am looking into feasability of building a bluetooth-based item that 
could be controlled easily from any pc (mostly with linux) for the 
purposes of home automation, and I have come upon several bluetooth 
dongles with serial ports on them (for example this one: 
http://www.socketcom.com/product/CS0400-479.asp), claiming to support 
General Access Profile, Service Discovery Profile and Serial Port**** 
profiles, as well as driverless operation with any serial device 
(configuration can be done via AT commands).

Obviously no-one will know the specifics of this particular device, but 
in principle, with the tools that are available under linux at the 
moment, would it be possible to establish a connection to the device and 
then send data to it just like an attached serial device? I understand 
that serial emulation is available under the bluez package, but how far 
does it go? Can one control individual pins, or is it just as a stream 
of bytes? My primary idea is to use it inside something like a lamp so 
that, for example,  the brightness can be controlled, or a coffee 
machine, or anything.

And if it is possible, is it also sensible to do it in this way? I 
understand that bluetooth chips are down to ~$5 (US), but this item is 
going for ~$170 (US). It there a more cost-effective way of talking to a 
number of bluetooth devices?

Sorry for the long post, and many thanks for any thoughts you might have

-Oli **


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
