Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <408B0C9A.5090409@duke.edu>
From: Nikita Tovstoles <nt3@duke.edu>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] nokia6600 <-> virtual serial port w/Bluez
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
Date: Sat, 24 Apr 2004 17:55:54 -0700

Hi,

I'm trying to establish a virtual serial port connection between a linux 
box and nokia 6600. the connection will subsequently be used by a java 
app. residing on desktop and using javax.comm package. However, though i 
can create a connection using rfcomm, /dev/rfcomm0 is never recognized 
as a "serial port".

Here are the details:

before bluetooth:
-javax.comm sees the following ports on linux system:
/dev/ttyS0
/dev/lp0

My understanding is that if two devices advertise same service, they can 
use it. in this case, sdptool browse <phoneAdr> returns:
----
Service Name: Bluetooth Serial Port
...
Protocol descriptor list:
    "L2CAP"
    "RFCOMM"
          Channel: 2

That means that Serial Port connection is only available on channel 2, 
right?
however, when i try:
rfcomm connect /dev/rfcomm0 <phoneAddress> 2  

i see "connected" on linux console, pin prompt on the phone, but as soon 
as i enter the pin, the host just disconnects. Why is that?

But, if i do not specify channel number, ie from linux console say:
rfcomm connect /dev/rfcomm0 <phoneAddress>

the connection is successfull and persistent. What exactly did i connect 
to? (ie which service? - sdptool says channel 1 on the phone is "dial-up 
networking"...)
 However, if i use javax.comm package to list desktop's ports, i do not 
see /dev/rfcomm0 added to the list (see above). and if i specifically 
try to open that port using javax.comm package, i get NoSuchPort Exception.

So, how can i create a virtual serial port connection, and how can i 
verify it in linux (in unlikely case javax.comm is at fault here)?

thanks a lot

-nikita



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
