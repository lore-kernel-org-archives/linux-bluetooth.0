Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 16:01:42 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060817130142.GA28489@localhost.localdomain>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<1155819360.4075.123.camel@aeonflux.holtmann.net>
	<20060817113538.GB5118@srcf.ucam.org>
	<1155823499.4075.157.camel@aeonflux.holtmann.net>
	<20060817122559.GA6422@srcf.ucam.org>
	<20060817124514.GA27427@localhost.localdomain>
	<20060817125212.GA7171@srcf.ucam.org>
MIME-Version: 1.0
In-Reply-To: <20060817125212.GA7171@srcf.ucam.org>
Subject: Re: [Bluez-devel] DBus interface - determining
	whether	a	device	exists
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

On Thu, Aug 17, 2006, Matthew Garrett wrote:
> On Thu, Aug 17, 2006 at 03:45:14PM +0300, Johan Hedberg wrote:
> 
> > Maybe you could simply use the list of bonded devices to populate HAL?
> > You could use the ListBondings method and BondingCreated/BondingRemoved 
> > signals for that.
> 
> Is that persistant over restarts of the daemon?

Yes.

Johan

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
