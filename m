Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050822124710aa8798@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <1124733046.23599.81.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <1124709468.23599.27.camel@pegasus>
	 <8c9e090508220504100c127e@mail.gmail.com>
	 <e1effdeb0508220527500878ab@mail.gmail.com>
	 <5256d0b050822053737c9cd8f@mail.gmail.com>
	 <e1effdeb05082205517cac906c@mail.gmail.com>
	 <9307f5f2050822072659387e3b@mail.gmail.com>
	 <1124721252.23599.53.camel@pegasus>
	 <e1effdeb05082210394bed468@mail.gmail.com>
	 <1124733046.23599.81.camel@pegasus>
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
Date: Mon, 22 Aug 2005 16:47:25 -0300

Hi folks,

The discussion focus moved to address multiple adapters. In the next
BlueZ D-Bus specification I will handle only the default
adapter(BDADDR_ANY).

There are other points that I want feebacks.
* Unify rfcomm and dun D-Bus interfaces/path?=20
* Provide IP parameter setup. Is it necessary provide D-Bus services
to configurate IP address, netmask, ...?
* Provide services for automatic bridge creation(PAN context). Is really us=
eful?
* Where provide pair/authentication? Pair services does not belongs to
a nice object path. Maybe should be "org.bluez.bluetoothd.security"
* How SDP should work? How should be the interaction between SDP and
the profiles in order to save memory, avoid code dupplication and use
cache?
* Multi level signals. For connection, disconnections and signal level
would make sense to have both low level signals(eg: hci vs. pan). Is
it really necessary?
* Remove "Sig", "Req" from the method name. The type field in the
header can be used to identify the message type(method call, method
return, message error or signal), but in my opinion we must keep to
make messages more clear.

The latest specification (draft 00.05) can be found at:
http://www.cin.ufpe.br/~ckt/bluez

Regards,
Claudio.

On 8/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > After this long discussion I think control multiple apdaters
> > will not be easy. If we register multiple paths will not be easy
> > map device register/unregister to D-Bus paths. When the user
> > remove the default dongle the D-Bus path should be unregistered and
> > the default adapter should be changed.
>=20
> never was and never will be ;)
>=20
> > Considering that bluez daemons are using the BDADDR_ANY. The D-Bus
> > services should use the same approach. I agree that the default
> > adapter must go through the kernel.
> >
> > Is there a way/interface to change the default adapter in the kernel?
>=20
> No. It has a simple route heuristic and normally uses the first adapter
> that is marked as up and is not a raw device. Unless the destination is
> not itself.
>=20
> This means that the default adapter depends on the destination which is
> not easy to configure.
>=20
> Regards
>=20
> Marcel
>=20
>=20
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
