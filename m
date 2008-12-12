Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <BD8ED0C257AAA247BB6C9A92879522C10D9C0DEE@CNSCNEVS01.ap.sony.com>
References: <BD8ED0C257AAA247BB6C9A92879522C10D9C0DEE@CNSCNEVS01.ap.sony.com>
Date: Fri, 12 Dec 2008 02:54:03 +0100
Message-Id: <1229046843.22285.29.camel@violet.holtmann.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] StartDiscovery doesn't exist
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
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

> 	I am appreciating for your answer my question about "What's the
> API different between inadapter-api.txt and dbus-api.txt in
> bluez-utils-3.36.tar.gz".
> 	
> 	Now I develop application with Bluez 4.x. But something happens
> abnormally. 
> When I call function StartDiscovery over python-dbus, the system raise a
> error:
> 
> File "/usr/lib/python2.5/site-packages/dbus/connection.py", line 607, in
> call_blocking message, timeout)
> dbus.exceptions.DBusException: org.freedesktop.DBus.Error.UnknownMethod:
> Method "StartDiscovery" with signature "" on interface
> "org.bluez.Adapter" doesn't exist
> 
> But the SetProperty, GetProperty are all right(These functions all come
> from bluez4.x/doc/adapter-api.txt ).
> 
> 	So I think maybe there are some librarys or other things version
> too old.
> 	
> 	OS version:	Suse linux 11, 2.6.25.5-1.1-pae
> 	Daemon name: 	hcid
> 	
> 	So what's the problem? (Need I change the daemon hcid to
> bluetoothd? If I need, how to do)

if you develop against bluez-4.x, then please re-read the *-api.txt
documents since some method names changed for the final 4.x releases.

Regards

Marcel



------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
