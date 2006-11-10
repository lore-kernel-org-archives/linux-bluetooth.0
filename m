Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 10 Nov 2006 21:04:37 +0200
From: Johan Hedberg <johan.hedberg@nokia.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20061110190437.GA8446@localhost.localdomain>
References: <1155839761.4075.165.camel@aeonflux.holtmann.net>
	<44E5B2A5.1070002@palmsource.com>
	<1155924372.4075.191.camel@aeonflux.holtmann.net>
	<45362E18.1040909@palmsource.com>
	<20061018140352.GA11008@localhost.localdomain>
	<45390275.1010607@palmsource.com> <4550C24B.9080703@palmsource.com>
	<20061110081232.GA27901@localhost.localdomain>
	<1163176812.4944.1.camel@aeonflux.holtmann.net>
	<4554AB39.1070104@palmsource.com>
MIME-Version: 1.0
In-Reply-To: <4554AB39.1070104@palmsource.com>
Subject: Re: [Bluez-devel]
	DBus	interface	-	determining	whether	a	device	exists
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

Hi Fred,

On Fri, Nov 10, 2006, Frederic Danis wrote:
> Here is a new version of the patch updated. apitest is updated.
> Hope it is OK.

It's in the CVS now. There were a few more white space issues I fixed as 
well as some wording in dbus-api.txt (we use "adapter" to mean a local 
device and "device" to mean a remote device).

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
