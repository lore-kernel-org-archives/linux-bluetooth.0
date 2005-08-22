Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <9307f5f2050822072659387e3b@mail.gmail.com>
From: "P. Durante" <shackan@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <e1effdeb05082205517cac906c@mail.gmail.com>
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
	 <e1effdeb05082205517cac906c@mail.gmail.com>
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
Date: Mon, 22 Aug 2005 16:26:00 +0200

On 8/22/05, Claudio Takahasi <cktakahasi@gmail.com> wrote:
> Hi Peter,
>=20
> I am planning provide a D-Bus service for setup a default adapter. But
> the developer will
> have to call a service to discover all available adapters. The steps shal=
l be:
> 1. Call a method to discover the available adapters
>     org.bluez.bluetoothd.getAdapters will return a array of the
> available devices
>=20

That's exactly what I do now in org.bluetool.manager.ListDevices.
I was thinking if it's worth returning, for each adapter, together
with the device path, a boolean value indicating if the device is up
or not, so that applications can immediately check what adapters a
effectively 'available'
ps: I also added signals which are broadcasted when an interface is
brought up/down

Another big concern I'm having is about security, most hciconfig
commands require 'higher than normal' privileges to execute, should
the daemon allow certain requests only to the root user ? (luckily
dbus was conceived with security in mind, so adding such a policy
would not be difficult).
This would just make things more complicated and I don't think there's
any real gain in doing so, but maybe there are some security issues I
ignore at the moment, let me know your opinion.
(if for example, a program calls ListDevices to list the adapters, and
the user wants to use an interface which is not active, should the
program be allowed to bring it up?)

> 2. Call a method to setup the default adapter.
>    org.bluez.bluetoothd.setDefaultAdapter, passing the adapter id
>=20

What if two (or more) applications chose, for whatever reason, to set
a different default adapter? If you *really* want such a mechanism,
maybe you should make such a method callable only by authorized code
(hence my dilemma above) or simply select the default adapter
internally in the daemon and don't expose this method at all.

> After that you will be able call the services passing the default path
>=20
> In the future we can try discover the best adapter to use and set it as
> default.
>=20
> Regards,
> Claudio.
>=20
>=20

Regards,
Paul


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
