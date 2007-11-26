Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1196057724.4217.71.camel@aeonflux>
References: <47477234.9010007@free.fr>
	<1195956126.10878.444.camel@cookie.hadess.net>
	<1196057724.4217.71.camel@aeonflux>
Date: Mon, 26 Nov 2007 17:38:01 +0000
Message-Id: <1196098681.10878.486.camel@cookie.hadess.net>
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


On Mon, 2007-11-26 at 07:15 +0100, Marcel Holtmann wrote:
> Hi Bastien,
> 
> > > With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth 
> > > controller (Sixaxis) is
> > > not recognized.
> > 
> > The input service doesn't support device initiated connections. See:
> > http://thread.gmane.org/gmane.linux.bluez.devel/12584/focus=12614
> 
> please remember that hidd file format is different from the input file
> format. I am serious here. It is different.
> 
> > Haaa. Once I get the capabilities right in my sixaxis patch (I'll be
> > able to compare the hidd generated output with the one from my patch), I
> > think I'll be able to use udev to automatically add the device as
> > supported via Bluetooth once connected via USB.
> 
> I haven't spend any time on this, but here is how it should work. We
> need a udev rule that detects the PS3 controller and then runs an
> application.

That was always the plan for sixpair2.c

>  This application has to find the local Bluetooth adapter
> and get its BD_ADDR.

Not done yet, but low-prio (you need to pass it on the command-line
right now).

>  Then it has to read the adapter address and
> controller address stored in the controller. This should be done via
> hidraw (or if possible via hiddev), because otherwise you have to
> disconnect the controller from the HID driver.

That's a problem. hiddev.h has some info on how to get the report
descriptors, but more example code is sorely missing. That's not my main
concern right now though (I'll dig this up when I get the sixaxis
working...).

>  If the stored adapter
> address is not one of the local Bluetooth adapters it should change it
> and add an entry into the input file.

Nod.

>  For this entry it needs the HID
> report descriptor. Best is to read this via USB (since it can change
> with a new generation of the controller), but it could also be hardcoded
> since currently it is fixed.

OK.

sixpair2.c has a couple of bugs:
- country is wrong
- version is wrong
- report is missing 4 bytes

I guess the later is the most important one. Once I get this working to
some level, I'll have a look at using hiddev instead.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
