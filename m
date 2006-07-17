Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Mon, 17 Jul 2006 18:49:32 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060717174932.GA27126@srcf.ucam.org>
References: <20060711193859.GA3569@srcf.ucam.org>
	<1152747138.17416.10.camel@localhost>
Mime-Version: 1.0
In-Reply-To: <1152747138.17416.10.camel@localhost>
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

On Thu, Jul 13, 2006 at 01:32:18AM +0200, Marcel Holtmann wrote:

> I would actually prefer not to hand the channel around. We have seen
> devices where the channel changes every time they reboot and so it might
> not be a good idea. I would prefer using a unique ID to identify the
> service.

Hm. dbus-api.txt currently documents that Connect should take a string 
describing the service. Would a serviceid not be more appropriate?

-- 
Matthew Garrett | mjg59@srcf.ucam.org


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
