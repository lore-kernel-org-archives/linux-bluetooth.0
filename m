Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <20060817124514.GA27427@localhost.localdomain>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<1155819360.4075.123.camel@aeonflux.holtmann.net>
	<20060817113538.GB5118@srcf.ucam.org>
	<1155823499.4075.157.camel@aeonflux.holtmann.net>
	<20060817122559.GA6422@srcf.ucam.org>
	<20060817124514.GA27427@localhost.localdomain>
Date: Thu, 17 Aug 2006 14:03:33 +0100
Message-Id: <1155819813.18545.36.camel@cookie.hadess.net>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] DBus interface -
	determining	whether	a	device	exists
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

On Thu, 2006-08-17 at 15:45 +0300, Johan Hedberg wrote:
> Hi Matthew,
> 
> On Thu, Aug 17, 2006, Matthew Garrett wrote:
<snip>
> > I guess that since we don't have any guarantees that the device exists 
> > at any given point in time anyway, this makes less difference and we 
> > should just populate HAL regardless. I suppose I'm open to that.
> 
> Maybe you could simply use the list of bonded devices to populate HAL?
> You could use the ListBondings method and BondingCreated/BondingRemoved 
> signals for that.

This is how MacOS X populates its selection lists. They have the list of
paired devices, as well as "Favourite" devices.

-- 
Bastien Nocera <hadess@hadess.net> 


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
