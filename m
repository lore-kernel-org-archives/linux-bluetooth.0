Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb050530154229f338a2@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - Initial library
In-Reply-To: <1117143615.12036.74.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115901694.18499.32.camel@pegasus>
	 <Pine.LNX.4.33.0505121821020.3523-100000@redbean.intranet.gw-instruments.de>
	 <e1effdeb0505201404d05e818@mail.gmail.com>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
	 <e1effdeb050525152067a5cbd3@mail.gmail.com>
	 <1117098491.12036.23.camel@pegasus>
	 <e1effdeb05052614222118e70c@mail.gmail.com>
	 <1117143615.12036.74.camel@pegasus>
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
Date: Mon, 30 May 2005 19:42:13 -0300

Hi Marcel,

I am sending a new patch to be evaluated.
Regarding glib dependency we need discuss this
subject again. If you see the hcid code, there is a
file (glib-ectomy.c) that implements the event
processing, this code is a partial copy of glib.

What do you prefer? Repeat the glib-ectomy.c code
or use glib?

For Maemo, glib is not problem. It is included in
the SDK.

Regarding pthread I put two versions to be evaluated:
1. using pthread
   In my opinion because it save memory.
   http://www.indt.org.br/maemo/bluez/bluez-dbus-thread.diff
  =20
2. using fork
   In my opinion this is not a feasible approach
   because when listening is active two process=20
   will be running(a listening and another processing
   D-Bus messages).
   http://www.indt.org.br/maemo/bluez/bluez-dbus-fork.diff


Regards,
Claudio.

On 5/26/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > 1. Glib
> > I will fix it. I found another approach using dbus main loop function.
>=20
> perfect.
>=20
> > 2. libbridge
> > It should be removed. It is not being used at the momment.  I will fix
> > the Makefile.am
> > But in the the future, I would suggest provide automatic bridge creatio=
n.
> > Using libbridge it's possible create bridge and add bnep interfaces.
>=20
> I am not against it, but I think we need to make it optional. Does it
> make sense to put that into pand or leave it in the client?
>=20
> > 3. Coding style
> > sorry, I try do my best. I am not familiar with linux kernel coding sty=
le.
>=20
> Maybe you wanna read the paper from Greg KH on the BlueZ page. We will
> sort that out later.
>=20
> > 4. PThread
> > I will remove Posix Thread code.
>=20
> We don't really need threads.
>=20
> > I will send another patch until next monday.
>=20
> Keep up the good work.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?fr=3Doffad-ysdn-ostg-q22=
005
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
