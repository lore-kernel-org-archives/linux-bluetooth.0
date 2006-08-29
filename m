Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: Alex B <squonimo@virgilio.it>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <10d5a94bb15.squonimo@virgilio.it>
References: <10d5a94bb15.squonimo@virgilio.it>
Date: Tue, 29 Aug 2006 19:52:59 +0200
Message-Id: <1156873979.4026.14.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] problem with bluez-utils 3.4 and dbus
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
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

Hi Alex,

> I'm trying to croos compile bluez-utils for XScale.
> 
> when I write make 
> Install the error is:
> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2
> /../../../../arm-linux/bin/ld:
> skipping incompatible 
> /opt/gnome/lib/libdbus-glib-1.so when searching
> for -ldbus-glib-1
> /usr/local/arm-linux/lib/gcc-lib/arm-linux/3.3.2/../../../../arm-
> linux/bin/ld:
> cannot find -ldbus-glib-1
> collect2: ld returned 1 exit 
> status
> 
> 
> /opt/gnome/lib/libdbus-glib-1.so it's a simlink to 
> /usr/lib/libdbus-glib-1.so
> 
> I read all old topics about this problem, 
> but I never found a solution.
> 
> the configure string is:
> ./configure --
> host=arm-linux --prefix=/mydir --whit-bluez=/mydir

I don't have a solution for this, because I don't do that much cross
compiling by myself. However since we use pkg-config, it should be
really easy to tell it which libraries to use.

Regards

Marcel



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
