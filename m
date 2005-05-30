Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <e1effdeb0505300532fe36918@mail.gmail.com>
From: Claudio Takahasi <cktakahasi@gmail.com>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] bluez-utils-2.17 -- Error compiling dbus.o
In-Reply-To: <12a241ad050529081764ef7ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12a241ad05052907591c593c6@mail.gmail.com>
	 <1117379509.7072.95.camel@pegasus>
	 <12a241ad050529081764ef7ed1@mail.gmail.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 30 May 2005 09:32:33 -0300

Hi Bruno,

The DBUS is under development, the functions name/signatures changed.
The bluez-utils 2.17 is compatible with D-Bus 0.23.

I recommend use the D-Bus version 0.23. Change hcid and bluez-pin
to support D-Bus 0.33 will require a signicant effort due bugs in the=20
array iterator functions. I not sure if this problem was solved in the=20
CVS version.

Regards,
Claudio.

On 5/29/05, Bruno Abinader <brunoabinader@gmail.com> wrote:
> Hi Marcel, sorry for not saying the dbus version, it is dbus-0.33.
> I will try the CVS ones and tell you if it works, thanks!
>=20
> 2005/5/29, Marcel Holtmann <marcel@holtmann.org>:
> > Hi Bruno,
> >
> > > i recently updated my dbus package and now i'm having
> > > some problems trying to compile hcid/dbus.o file, the error is the
> > > follow:
> > >
> > > gcc -I/usr/include -DDBUS_API_SUBJECT_TO_CHANGE
> > > -I/usr/include/dbus-1.0 -I/usr/lib/dbus-1.0/include -DENABLE_DBUS
> > > -DDBUS_API_SUBJECT_TO_CHANGE -Wall -O2 -o hcid main.o security.o
> > > storage.o lib.o parser.o lexer.o kword.o glib-ectomy.o dbus.o
> > > -L/usr/lib /usr/lib/libdbus-1.so /usr/lib/libbluetooth.so
> > > dbus.o(.text+0x7a): In function `hcid_dbus_request_pin':
> > > : undefined reference to `dbus_message_append_iter_init'
> > > dbus.o(.text+0x8b): In function `hcid_dbus_request_pin':
> > > : undefined reference to `dbus_message_iter_append_boolean'
> > > dbus.o(.text+0x97): In function `hcid_dbus_request_pin':
> > > : undefined reference to `dbus_message_iter_append_byte_array'
> > > dbus.o(.text+0x381): In function `reply_handler_function':
> > > : undefined reference to `dbus_pending_call_get_reply'
> > > dbus.o(.text+0x3dd): In function `reply_handler_function':
> > > : undefined reference to `dbus_message_iter_get_string'
> > > collect2: ld returned 1 exit status
> > > make[2]: ** [hcid] Erro 1
> > > make[2]: Saindo do diret=F3rio `/home/bruno/src/bluez-utils-2.17/hcid=
'
> > > make[1]: ** [all-recursive] Erro 1
> > > make[1]: Saindo do diret=F3rio `/home/bruno/src/bluez-utils-2.17'
> > > make: ** [all] Erro 2
> > >
> > > Any help would be appreciated!
> >
> > it would be great if you tell us about what version of D-Bus we are
> > talking about. I am unable read minds ;)
> >
> > However it seems that these functions are missing:
> >
> >         dbus_message_append_iter_init()
> >         dbus_message_iter_append_boolean()
> >         dbus_message_iter_append_byte_array()
> >         dbus_pending_call_get_reply()
> >         dbus_message_iter_get_string()
> >
> > You can try the CVS, because I added the support for newer D-Bus
> > libraries after the 2.17 release was out.
> >
> > Regards
> >
> > Marcel
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by Yahoo.
> > Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> > Search APIs Find out how you can build Yahoo! directly into your own
> > Applications - visit http://developer.yahoo.net/?froffad-ysdn-ostg-q220=
05
> > _______________________________________________
> > Bluez-users mailing list
> > Bluez-users@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/bluez-users
> >
>=20
>=20
> --
> Bruno de Oliveira Abinader
> GVoIP - INdT/UFAM
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Yahoo.
> Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
> Search APIs Find out how you can build Yahoo! directly into your own
> Applications - visit http://developer.yahoo.net/?froffad-ysdn-ostg-q22005
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
