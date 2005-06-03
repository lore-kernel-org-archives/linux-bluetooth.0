Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <e1effdeb05060313345fb564a3@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] DBUS service support - poll patch
In-Reply-To: <1117494345.7072.235.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1115901694.18499.32.camel@pegasus>
	 <1116844053.30044.59.camel@pegasus>
	 <e1effdeb050523080216e96744@mail.gmail.com>
	 <1116925644.30044.140.camel@pegasus>
	 <e1effdeb050525152067a5cbd3@mail.gmail.com>
	 <1117098491.12036.23.camel@pegasus>
	 <e1effdeb05052614222118e70c@mail.gmail.com>
	 <1117143615.12036.74.camel@pegasus>
	 <e1effdeb050530154229f338a2@mail.gmail.com>
	 <1117494345.7072.235.camel@pegasus>
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
Date: Fri, 3 Jun 2005 17:34:07 -0300

Hi Marcel,


A new patch is available using a main loop and poll to wait for some event=
=20
on a file descriptor list (D-Bus and Bluetooth).

All Glib and pthread dependencies were remove.


http://www.indt.org.br/maemo/bluez/bluez-dbus-poll.diff


Regards,
Claudio.


On 5/30/05, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Claudio,
>=20
> > I am sending a new patch to be evaluated.
> > Regarding glib dependency we need discuss this
> > subject again. If you see the hcid code, there is a
> > file (glib-ectomy.c) that implements the event
> > processing, this code is a partial copy of glib.
> >
> > What do you prefer? Repeat the glib-ectomy.c code
> > or use glib?
>=20
> the glib-ectomy is only still there, because I was too lazy to replace
> it with a clean main loop using poll() implementation.
>=20
> > For Maemo, glib is not problem. It is included in
> > the SDK.
>=20
> This is not a valid argument. Creating a massive dependency chain is
> always bad. Using Glib inside bluez-utils is no option.
>=20
> > Regarding pthread I put two versions to be evaluated:
> > 1. using pthread
> >    In my opinion because it save memory.
> >    http://www.indt.org.br/maemo/bluez/bluez-dbus-thread.diff
> >
> > 2. using fork
> >    In my opinion this is not a feasible approach
> >    because when listening is active two process
> >    will be running(a listening and another processing
> >    D-Bus messages).
> >    http://www.indt.org.br/maemo/bluez/bluez-dbus-fork.diff
>=20
> Even without looking at the patches, I don't like any of it. I like to
> see a nice main loop and then using poll(). We don't need threads or
> forking out processes.
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
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
