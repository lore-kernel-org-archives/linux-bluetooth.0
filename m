Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Alain Volmat <avolmat@src.ricoh.co.jp>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] rfcomm question 3
Message-ID: <20050202031659.GA7073@snoopy.src.ricoh.co.jp>
References: <1107245676.8848.27.camel@pegasus> <20050202024903.71368.qmail@web60905.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20050202024903.71368.qmail@web60905.mail.yahoo.com>
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
Date: Wed, 2 Feb 2005 12:16:59 +0900

Hi Michael,

> So I wish to know which one is about socket based programming?
The one using socket :D
By saying so, you can already remove the first one. It is only for
handling Bluetooth address, as the comment says.

The second function is about connection, not listening.
I haven't found the 3rd function you mention about, or maybe I just
misread your email ... reading source code without indentation is not
that simple.

Basically RFCOMM socket programming is just very standard socket programm=
ing.
in very short, to start listening,
	socket
	bind (specifying RFCOMM port)
	setsockopt (for MTU ... I guess)
	listen
	accept
	..

Alain







* Ka Kin Cheung [Wed,  2 Feb 2005 at 10:49 +0800]
<quote>
> Hi Marcel,
>     I've found one powerpoint you made about Bluetooth programming on L=
inux in Wireless Technologies Congress 2003. But I don't know for those t=
hree programs you put, which one is describing about the PC listening the=
 mobile in RFCOMM channel. Let me put here.
> For Handling of Bluetooth device addresses
> #include <bluetooth/bluetooth.h>
> void main(int argc, char *argv[])
> {
> bdaddr_t bdaddr;
> char *str, addr[18];
> str2ba("00:a5:b4:c3:d2:e1", &bdaddr);
> ba2str(&bdaddr, addr);
> str =3D batostr(&bdaddr);
> printf("%s %s\n", addr, str);
> free(str);
> bacpy(&bdaddr, BDADDR_ANY);
> }
>=20
> For definition of the socket data types
> static int rfcomm_connect(bdaddr_t *src, bdaddr_t *dst, uint8_t channel=
)
> {
> struct sockaddr_rc addr;
> int sk;
> if ((sk =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0)
> return -1;
> addr.rc_family =3D AF_BLUETOOTH;
> bacpy(&addr.rc_bdaddr, src);
> addr.rc_channel =3D 0;
> if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> close(sk);
> return -1;
> }
> addr.rc_family =3D AF_BLUETOOTH;
> bacpy(&addr.rc_bdaddr, dst);
> addr.rc_channel =3D channel;
> if (connect(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
> close(sk);
> return -1;
> }
> So I wish to know which one is about socket based programming? Thanks a=
 lot!
> Michael
>=20
> Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Michael,
>=20
> > I thank Marcel here for help on initializing
> > connection from mobile to PC. Now, before I can do
> > that, I initialize the rfcomm connection from PC to
> > mobile, and then run my project program. The syntax is
> > as follows:
> > snprintf (tmp, sizeof (tmp), "t68_remote_v2 (%s)",
> > modemname);
> > tmp[sizeof (tmp) - 1] =3D 0;
> > openlogfile (tmp, logfile, LOG_DAEMON, loglevel);
> > set_alarmhandler (alarmhandler, alarmlevel,
> > modemname);
> > openmodem ();
> > setmodemparams ();
> > But now, when I initialize the connection from mobile
> > to PC, once I run the program, "/dev/rfcomm0: No such
> > device" is shown. So, I wish to know how can I modify
> > the program by changing some syntax from that I post
> > here? Or is there any program that I can include in my
> > main program? Thank you very much.
>=20
> if you wanna connect from a mobile phone to a machine running BlueZ you
> need to write an application that listens on a RFCOMM channel. This is
> about socket programming and you convert this socket later in to a TTY
> with a /dev/rfcommX device node, but actually unless you have some
> legacy application like pppd this should not be needed. What you need i=
s
> to do direct socket programming. It is as easy as using a TTY and I
> posted detailed information about how to change a TTY based program int=
o
> a socket based program years ago. Check the mailing list archive.
>=20
> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
> Tool for open source databases. Create drag-&-drop reports. Save time
> by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
> Download a FREE copy at http://www.intelliview.com/go/osdn_nl
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20
>=20
>=20
> ---------------------------------
> =E6=96=B0=E5=B9=B4=E9=A1=98=E6=9C=9B=E7=AC=AC=E4=B8=80=E4=BD=8D :  =E6=89=
=BE=E5=88=B0=E5=8F=8B=E7=B7=A3=E4=BA=BA=20
</quote>


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
