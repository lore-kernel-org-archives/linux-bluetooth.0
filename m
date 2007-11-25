Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Bastien Nocera <hadess@hadess.net>
To: bluez@frederic-blain.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <47477234.9010007@free.fr>
References: <47477234.9010007@free.fr>
Date: Sun, 25 Nov 2007 02:02:06 +0000
Message-Id: <1195956126.10878.444.camel@cookie.hadess.net>
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
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


On Sat, 2007-11-24 at 00:37 +0000, Fr=E9d=E9ric Blain wrote:
> Hello,
> =

> With the current bluez-utils version (3.22 or CVS), the PS3 bluetooth =

> controller (Sixaxis) is
> not recognized.

The input service doesn't support device initiated connections. See:
http://thread.gmane.org/gmane.linux.bluez.devel/12584/focus=3D12614

<snip>
> =3D=3D=3D=3D Workaround =3D=3D=3D=3D
> =

> Basically, using the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/hidd =

> renamed as input will help since at startup,
> bluetoothd-service-input will scan this file and fill 'GSList *devices' =

> accordingly.
> Also, the file /var/lib/bluetooth/xx:xx:xx:xx:xx:xx/trusts has to be =

> updated .
> =

> For those interested, a step by step description can be found here :
> http://creber.free.fr/frederic-blain/index.php?n=3DMain.GentooOnPS3Sixaxi=
sBluetooth#Workaround.

Haaa. Once I get the capabilities right in my sixaxis patch (I'll be
able to compare the hidd generated output with the one from my patch), I
think I'll be able to use udev to automatically add the device as
supported via Bluetooth once connected via USB.

I'll try and get to it in the week.

Cheers


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
