Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] bluetooth services and profiles
From: Marcel Holtmann <marcel@holtmann.org>
To: Jun Sun <jsun@docomolabs-usa.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7FB17951357F434FA9C14522522BA59B447E65@dcl-ex.dcml.docomolabs-usa.com>
References: 
	 <7FB17951357F434FA9C14522522BA59B447E65@dcl-ex.dcml.docomolabs-usa.com>
Content-Type: text/plain
Message-Id: <1098826604.14036.115.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Tue, 26 Oct 2004 23:36:44 +0200

Hi Jun,

> I saw a lot of web pages about setting up a linux box talking with a
> Bluetooth phone.  Typically you would discover a lot of services offered
> by the phone.
> 
> I am wondering what happens if you hook linux box with a second linux
> box.  In other words what kind of services will you find on the Linux
> box?  What has to be done to support those similar services on bluez? 
> 
> Are they related to the Bluetooth profiles?  I have not seen much about
> Bluetooth profile support in bluez.  Do they exist?

a Bluetooth profile is like an application. If you wanna have support
for a specific profile in BlueZ, you need to write that application.
However for most common Bluetooth profiles these applications exists and
you only have to start them.

If you think that you always need to follow a specific profile for data
exchange between two Bluetooth devices, then you are wrong. BlueZ gives
you the power to do everything you like with Bluetooth.

> The reason I am asking this is because there are now phones powered by
> Linux.  I think they support Bluetooth but I don't know if they are
> using bluez.  I like to get an understanding on how to provide those
> Bluetooth phone services on Linux with bluez.

I don't know either. Maybe yes, maybe no. But as mentioned above a
profile is the same as an application.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
