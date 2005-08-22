Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05082210394bed468@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] bluetoothd D-Bus interface proposals(draft 00.05)
In-Reply-To: <1124721252.23599.53.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <e1effdeb05081614151ee4f4bd@mail.gmail.com>
	 <9307f5f2050818135877575293@mail.gmail.com>
	 <8c9e090508191027e4646f1@mail.gmail.com>
	 <1124709468.23599.27.camel@pegasus>
	 <8c9e090508220504100c127e@mail.gmail.com>
	 <e1effdeb0508220527500878ab@mail.gmail.com>
	 <5256d0b050822053737c9cd8f@mail.gmail.com>
	 <e1effdeb05082205517cac906c@mail.gmail.com>
	 <9307f5f2050822072659387e3b@mail.gmail.com>
	 <1124721252.23599.53.camel@pegasus>
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
Date: Mon, 22 Aug 2005 14:39:18 -0300

Hi folks,


After this long discussion I think control multiple apdaters
will not be easy. If we register multiple paths will not be easy=20
map device register/unregister to D-Bus paths. When the user=20
remove the default dongle the D-Bus path should be unregistered and=20
the default adapter should be changed.=20

Considering that bluez daemons are using the BDADDR_ANY. The D-Bus=20
services should use the same approach. I agree that the default=20
adapter must go through the kernel.

Is there a way/interface to change the default adapter in the kernel?=20

Regarding security issues. The bluetoothd will run with root right.
The security policy shall be controlled by D-Bus configuration
files. It's possible add rule based on method names and interfaces.

Regards,
Claudio.

On 8/22/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Paul,
>=20
> > Another big concern I'm having is about security, most hciconfig
> > commands require 'higher than normal' privileges to execute, should
> > the daemon allow certain requests only to the root user ? (luckily
> > dbus was conceived with security in mind, so adding such a policy
> > would not be difficult).
> > This would just make things more complicated and I don't think there's
> > any real gain in doing so, but maybe there are some security issues I
> > ignore at the moment, let me know your opinion.
> > (if for example, a program calls ListDevices to list the adapters, and
> > the user wants to use an interface which is not active, should the
> > program be allowed to bring it up?)
>=20
> the bluetoothd run with root (or chroot) rights and thus it needs to
> provide its own security policy.
>=20
> > What if two (or more) applications chose, for whatever reason, to set
> > a different default adapter? If you *really* want such a mechanism,
> > maybe you should make such a method callable only by authorized code
> > (hence my dilemma above) or simply select the default adapter
> > internally in the daemon and don't expose this method at all.
>=20
> as I said in the previous answers, the setting which is the default
> adapter must go through the kernel.
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
