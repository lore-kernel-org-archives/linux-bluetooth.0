Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20050221185035.98722.qmail@web53003.mail.yahoo.com>
From: Alfredo Meraz <alfredo_meraz@yahoo.com.mx>
Subject: Re: [Bluez-users] Re: USB Bluetooth works manually, but won't hotplug with the SAME script
To: bluez-users@lists.sourceforge.net
In-Reply-To: <cvael0$d6q$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
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
Date: Mon, 21 Feb 2005 12:50:35 -0600 (CST)

Hi Sebastian :)
Thanks for your prompt help.
I've tried the script... unfortunately, again, it
works manually, but doesn't work with hotplug :( ... I
had to remove the "modprobe bluetooth", because it
didn't find the module, but AFAIK, the functionality
is implemented in hci_usb... I might be wrong on this
:(
What the last 2 lines do, is what other people are
suggesting to do with an rfcomm-kernel patch :)...
basically, the second to last line:
sdptool add --channel=3 SP
adds the Serial Port service to sdpd, and the last
line, fires up a pppd connection everytime a
connection request comes from channel 3, establishing
a connection to the palm :)
Is there a chance that the problem is caused by the
environment the kernel uses to execute the script is
more restricted than when I do it manually? If so, how
do I determine the difference? :S
Best regards.
Alfredo

 --- Sebastian Roth <sebiroth@web.de> escribió: 
> Hi Alfredo,
> 
> I can't say what exactly the problem is but IMHO the
> script
> is not structured very wise. Maybe the script is
> executed before
> the needed modules are loaded when used for
> hotplugging.
> Here is my suggestion for a script:
> 
> #!/bin/sh
> # get the bluetooth things ready
> PATH=/bin:/sbin:/usr/bin:/usr/sbin
> 
> # load all modules
> modprobe bluetooth
> modprobe hci_usb
> modprobe l2cap
> modprobe rfcomm
> 
> # start the deamons
> # AFAIK the configfile paths are default
> # so there is no need to specify these
> hcid
> sdpd
> rfcomm bind all
> 
> # this is done by hcid!
> # hciconfig hci0 up
> 
> # don't really know what these
> # commands do but seems ok to me
> sdptool add --channel=3 SP
> dund --listen --channel 3 --msdun noauth
:192.168.1.240 crtscts 115200 ms-dns 192.168.1.1
> lock
> 
> 
> I have not tested this script but it _should_ work.
> 
> Best regards,
> Sebastian
> 
> 
> 
>
-------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT
> Products from real users.
> Discover which products truly live up to the hype.
> Start reading now.
>
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
>
https://lists.sourceforge.net/lists/listinfo/bluez-users
>  

_________________________________________________________
Do You Yahoo!?
La mejor conexión a internet y 25MB extra a tu correo por $100 al mes. http://net.yahoo.com.mx


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
