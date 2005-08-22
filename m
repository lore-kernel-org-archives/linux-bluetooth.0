Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05082205517cac906c@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <5256d0b050822053737c9cd8f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050816154545b6f046@mail.gmail.com>
	 <e1effdeb05081805054a0be4aa@mail.gmail.com>
	 <9307f5f2050818135877575293@mail.gmail.com>
	 <8c9e090508191027e4646f1@mail.gmail.com>
	 <1124709468.23599.27.camel@pegasus>
	 <8c9e090508220504100c127e@mail.gmail.com>
	 <e1effdeb0508220527500878ab@mail.gmail.com>
	 <5256d0b050822053737c9cd8f@mail.gmail.com>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 22 Aug 2005 09:51:58 -0300

Hi Peter,

I am planning provide a D-Bus service for setup a default adapter. But
the developer will
have to call a service to discover all available adapters. The steps shall =
be:
1. Call a method to discover the available adapters=20
    org.bluez.bluetoothd.getAdapters will return a array of the
available devices

2. Call a method to setup the default adapter.
   org.bluez.bluetoothd.setDefaultAdapter, passing the adapter id=20

After that you will be able call the services passing the default path

In the future we can try discover the best adapter to use and set it as
default.

Regards,
Claudio.




On 8/22/05, Peter Robinson <pbrobinson@gmail.com> wrote:
> On 8/22/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> > Hi folks,
> >
> >
> > It's possible register multiple D-Bus object paths. My suggestion
> > for handle multiple adapters is register a default path and paths
> > based on the device address.
> > eg: suppose two adapters(11:22:33:44:55:66, 77:88:99:00:11:22)
> >
> > The possible paths are:
> >
> > /org/bluez/bluetoothd/hci (default path - first adapter)
> > /org/bluez/bluetoothd/112233445566/hci (first adapter)
> > /org/bluez/bluetoothd/778899001122/hci (second adapter)
> >
> > /org/bluez/bluetoothd/pan (default path - first adapter)
> > /org/bluez/bluetoothd/112233445566/pan (first adapter)
> > /org/bluez/bluetoothd/778899001122/pan (second adapter)
> > ...
> >
> > The service to list the adapter must be moved to the main path
> > (/org/bluez/bluetoothd) or to a new one /org/bluez/bluetoothd/devices.
> >
> > The message handle function will become more complex, but I don't
> > see other solution.
>=20
> What happens if you want to use your second adapter as the default? EG
> if I have a BT2.0 and a BT1.2 adapter but the BT1.2 adapter is
> detected first but you want to use the BT2.0 adapter as the default as
> its faster.
>=20
> Peter
>=20
>=20
> -------------------------------------------------------
> SF.Net email is Sponsored by the Better Software Conference & EXPO
> September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
> Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
> Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
