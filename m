Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <10d5dfff9cd.squonimo@virgilio.it>
Date: Wed, 30 Aug 2006 08:34:19 +0100 (GMT+01:00)
From: Alex B <squonimo@virgilio.it>
To: <development@pracucci.com>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
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

Now, I'm trying to cross compile dbus library!
When it will work I'll 
send you a complete log of my job

Bye Alex

----Messaggio 
originale----
Da: development@pracucci.com
Data: 29-ago-2006 20.26
A: 
"Alex B"<squonimo@virgilio.it>, "BlueZ development"<bluez-devel@lists.
sourceforge.net>
Ogg: Re: [Bluez-devel] problem with bluez-utils 3.4 
and dbus

Hi Alex,
> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2/..
/../../../arm-
> linux/bin/ld:
> cannot find -ldbus-glib-1
> collect2: 
ld returned 1 exit 
> status
>   
Have you cross compiled dbus?
If you 
have cross compiled dbus you should add -L<dbus library path> to
LDFLAG, where <dbus library path> is the path to the cross compiled 
dbus
library.

Moreover, if you have cross compiled dbus, can you tell 
us how you have
successfully run the configure script?

Regards,
Marco 
Pracucci





-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
