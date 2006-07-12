Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060711193859.GA3569@srcf.ucam.org>
References: <20060711193859.GA3569@srcf.ucam.org>
Date: Thu, 13 Jul 2006 01:32:18 +0200
Message-Id: <1152747138.17416.10.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] [Patch] Add dbus method for obtaining
	RFCOMM	channels
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

Hi Matthew,

> So, firstly, this is something that scratches an itch I have for hal 
> integration. I'm entirely open to doing it in an entirely different way 
> if people would prefer that.
> 
> This patch adds a GetRFCOMMChannel dbus method, allowing channels to be 
> added to hal objects. An example use case would be a phone manager - 
> having the channel means that it can simply call a few dbus methods and 
> then have a serial device.

I would actually prefer not to hand the channel around. We have seen
devices where the channel changes every time they reboot and so it might
not be a good idea. I would prefer using a unique ID to identify the
service.

One of the bigger goals is a working SDP cache for these kind of task
and the knowledge when to refresh the SDP records for a specific
service. At the moment it is not fully clear how this can be achieved
and we might simply have to play with certain ways and see what works
best in the end.

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
