Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] nokia6600 <-> virtual serial port w/Bluez
From: Marcel Holtmann <marcel@holtmann.org>
To: Nikita Tovstoles <nt3@duke.edu>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <408B0C9A.5090409@duke.edu>
References: <408B0C9A.5090409@duke.edu>
Content-Type: text/plain
Message-Id: <1082896875.28880.70.camel@pegasus>
Mime-Version: 1.0
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
Date: Sun, 25 Apr 2004 14:41:15 +0200

Hi Nikita,

> I'm trying to establish a virtual serial port connection between a linux 
> box and nokia 6600. the connection will subsequently be used by a java 
> app. residing on desktop and using javax.comm package. However, though i 
> can create a connection using rfcomm, /dev/rfcomm0 is never recognized 
> as a "serial port".
> 
> Here are the details:
> 
> before bluetooth:
> -javax.comm sees the following ports on linux system:
> /dev/ttyS0
> /dev/lp0
> 
> My understanding is that if two devices advertise same service, they can 
> use it. in this case, sdptool browse <phoneAdr> returns:
> ----
> Service Name: Bluetooth Serial Port
> ...
> Protocol descriptor list:
>     "L2CAP"
>     "RFCOMM"
>           Channel: 2
> 
> That means that Serial Port connection is only available on channel 2, 
> right?
> however, when i try:
> rfcomm connect /dev/rfcomm0 <phoneAddress> 2 
>  
> 
> i see "connected" on linux console, pin prompt on the phone, but as soon 
> as i enter the pin, the host just disconnects. Why is that?

this is may because this is the mRouter serial port. Check with hcidump
if your phone tries to reconnect to you after cutting the connection.

> But, if i do not specify channel number, ie from linux console say:
> rfcomm connect /dev/rfcomm0 <phoneAddress>
> 
> the connection is successfull and persistent. What exactly did i connect 
> to? (ie which service? - sdptool says channel 1 on the phone is "dial-up 
> networking"...)

In most phones the serial port and the dial-up are the same.

>  However, if i use javax.comm package to list desktop's ports, i do not 
> see /dev/rfcomm0 added to the list (see above). and if i specifically 
> try to open that port using javax.comm package, i get NoSuchPort Exception.

You should try using "rfcomm bind ..." and bind a specific /dev/rfcommX
device to your phone. The connection is then established on demand.

> So, how can i create a virtual serial port connection, and how can i 
> verify it in linux (in unlikely case javax.comm is at fault here)?

If you have connected to your phone or bound /dev/rfcommX to it, you can
use minicom and test some AT commands.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
