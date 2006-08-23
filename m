Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Wed, 23 Aug 2006 23:13:53 +0300
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060823201353.GA29549@localhost.localdomain>
References: <1155819858.4075.134.camel@aeonflux.holtmann.net>
	<20060817114116.GC5118@srcf.ucam.org>
	<20060817115912.GA24906@localhost.localdomain>
	<20060819143608.GA31812@srcf.ucam.org>
	<1156037973.3989.14.camel@aeonflux.holtmann.net>
	<20060819235330.GA16375@srcf.ucam.org>
	<1156040029.3989.22.camel@aeonflux.holtmann.net>
	<20060820003154.GA17093@srcf.ucam.org>
	<1156043737.3989.32.camel@aeonflux.holtmann.net>
	<20060820175957.GA2750@srcf.ucam.org>
MIME-Version: 1.0
In-Reply-To: <20060820175957.GA2750@srcf.ucam.org>
Subject: Re: [Bluez-devel] [PATCH] implement RFCOMM Connect and Disconnect
	methods
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

On Sun, Aug 20, 2006, Matthew Garrett wrote:
> Ok, how's this? Again not heavily tested, but just to make sure that the 
> style is right.

The patch is now commited to the CVS along with some coding style 
changes and a few other fixes. It's a good start, but one major thing 
missing is that the Connect method should initiate an SDP query to the 
remote device if necessary (if the record isn't found in the local 
cache) to find out the correct channel to connect to.

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
