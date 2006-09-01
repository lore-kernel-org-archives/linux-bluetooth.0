Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <10d6949dedb.squonimo@virgilio.it>
Date: Fri, 1 Sep 2006 13:10:51 +0100 (GMT+01:00)
From: Alex B <squonimo@virgilio.it>
To: <bluez-devel@lists.sourceforge.net>
Mime-Version: 1.0
Subject: [Bluez-devel] R: Re:  problem with bluez-utils 3.4 and dbus
Reply-To: Alex B <squonimo@virgilio.it>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi all,
I solved my problems...
I have a toolchain without:
1) libz
2) 
libxml
3) libdbus

I cross compiled all this library, with the help of 
many hotow, and then i cross compiled the bluez-utils...

now I have to 
try to use this utils...

I tried to learn by myself how to regestir a 
device in my pc using hcitool and sdptool, but it doesn't work... can 
someone help and send me the correct sequence of commands to register, 
pair , etc... a divece as a Headset or a mobile phone????

thanks
Alex 
B

----Messaggio originale----
Da: chris.brand@qwikker.com
Data: 30-ago-
2006 19.33
A: "BlueZ development"<bluez-devel@lists.sourceforge.net>
Ogg: Re: [Bluez-devel] problem with bluez-utils 3.4 and dbus

> please 
report this back to the D-Bus mailing list. They need 
> to know that 
they have problems in cross-compiling cases. 
> Otherwise this will 
never get fixed.

I've created dbus bug 8071 at freedesktop.org.
https:
//bugs.freedesktop.org/show_bug.cgi?id=8071

Chris 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, 
security?
Get stuff done quickly with pre-integrated technology to make 
your job easier
Download IBM WebSphere Application Server v.1.0.1 based 
on Apache Geronimo
http://sel.as-us.falkag.net/sel?
cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing 
list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.
net/lists/listinfo/bluez-devel




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
