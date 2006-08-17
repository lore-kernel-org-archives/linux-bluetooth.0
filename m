Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Thu, 17 Aug 2006 09:15:03 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Message-ID: <20060817081503.GA1086@srcf.ucam.org>
References: <20060816153432.GA13691@srcf.ucam.org>
	<1155770177.4075.102.camel@aeonflux.holtmann.net>
	<20060816214606.GA21719@srcf.ucam.org>
	<66dc03c80608161821pda00e42ra69e3775814614de@mail.gmail.com>
Mime-Version: 1.0
In-Reply-To: <66dc03c80608161821pda00e42ra69e3775814614de@mail.gmail.com>
Subject: Re: [Bluez-devel] DBus interface - determining whether a device
	exists
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

On Wed, Aug 16, 2006 at 10:21:19PM -0300, Cezar S=E1 Espinola wrote:
> > Right. But the DBus interface doesn't seem to provide any mechanism for
> > initiating a connection to the device. GetName and the like appear to
> > provide cached results even if the device is now out of range, which
> > isn't what I want.
> Hi Matthew,
> =

> What about RFCOMM ConnectByChannel? Wouldn't it do the job?

Well, it's not necessarily an RFCOMM connection. I'd prefer to just be =

able to store the fact that a device exists rather than what sort of =

connection and on what channels, especially since Marcel mentioned that =

the channel may well have changed if the Bluetooth device has been =

rebooted.

-- =

Matthew Garrett | mjg59@srcf.ucam.org

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easi=
er
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D1=
21642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
