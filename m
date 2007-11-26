Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1195956126.10878.444.camel@cookie.hadess.net>
References: <47477234.9010007@free.fr>
	<1195956126.10878.444.camel@cookie.hadess.net>
Date: Mon, 26 Nov 2007 07:15:24 +0100
Message-Id: <1196057724.4217.71.camel@aeonflux>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Sony PS3 sixaxis & bluez
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

Hi Bastien,

> > With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth 
> > controller (Sixaxis) is
> > not recognized.
> 
> The input service doesn't support device initiated connections. See:
> http://thread.gmane.org/gmane.linux.bluez.devel/12584/focus=12614

please remember that hidd file format is different from the input file
format. I am serious here. It is different.

> Haaa. Once I get the capabilities right in my sixaxis patch (I'll be
> able to compare the hidd generated output with the one from my patch), I
> think I'll be able to use udev to automatically add the device as
> supported via Bluetooth once connected via USB.

I haven't spend any time on this, but here is how it should work. We
need a udev rule that detects the PS3 controller and then runs an
application. This application has to find the local Bluetooth adapter
and get its BD_ADDR. Then it has to read the adapter address and
controller address stored in the controller. This should be done via
hidraw (or if possible via hiddev), because otherwise you have to
disconnect the controller from the HID driver. If the stored adapter
address is not one of the local Bluetooth adapters it should change it
and add an entry into the input file. For this entry it needs the HID
report descriptor. Best is to read this via USB (since it can change
with a new generation of the controller), but it could also be hardcoded
since currently it is fixed. The modification of the trusts file is
optional, but it could be automated to avoid confusion. Since you attach
the cable you basically give authorization.

The case were you have multiple Bluetooth adapters attached to your
local system is a bit tricky. We must make sure that we don't keep
overwriting the settings if the adapter order changes. Also if assigned
to a new adapter, the device should be removed from the other ones.

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
