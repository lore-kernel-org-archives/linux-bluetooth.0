Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46EF6F66.70705@tfh-berlin.de>
References: <46EF6F66.70705@tfh-berlin.de>
Date: Tue, 18 Sep 2007 10:25:48 +0200
Message-Id: <1190103949.5525.126.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] bluez-utils on arm
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi David,

> i try to compile bluez-utils (latest version) for ARM. I compiled 
> dbus1.0.2 before and of courese bluez-libs. I don't know how to tell 
> configure where to find dbus-libs. I tried a lot of things, everytime 
> with same result:
> 
> ...
> checking for GLIB... no
> checking for DBUS... no
> configure: error: dbus > 0.35 is required
> 
> config.log says the following:
> 
> ...
> configure:10494: $PKG_CONFIG --exists --print-errors "dbus-1 > 0.35"
> Package dbus-1 was not found in the pkg-config search path.
> Perhaps you should add the directory containing `dbus-1.pc'
> to the PKG_CONFIG_PATH environment variable
> No package 'dbus-1' found
> configure:10497: $? = 1
> No package 'dbus-1' found
> 
> I don't know what the "pkg-config search path" is. "configure -h" shows 
> options DBUS_LIBS and DBUS_CFLAGS, but i can not use these in the right 
> way. Shall i use "-L" option (or so?) or do i only have to put the right 
> path to the directory containing `dbus-1.pc'???

the pkg-config search path needs to contain the dbus-1.pc. Actually you
must make sure that the D-Bus devel package is present or compile it by
yourself.

> Is it possible to compile bluez-utils without dbus?

Not with the 3.x version. The D-Bus support is mandatory.

Regards

Marcel



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
