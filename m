Return-Path: <cyrus@holtmann.org>
From: Oliver Neukum <oliver@neukum.org>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [rfc]btusb with SCO support
Date: Wed, 13 Aug 2008 17:16:39 +0200
Cc: linux-bluetooth@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <200807311452.24166.oliver@neukum.org> <200808122253.45829.oliver@neukum.org> <1218577018.25524.39.camel@californication>
In-Reply-To: <1218577018.25524.39.camel@californication>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200808131716.39806.oliver@neukum.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Am Dienstag 12 August 2008 23:36:58 schrieb Marcel Holtmann:
> > Still testing. I am new to bluetooth so getting a sound testing environ=
ment
> > up takes a bit of time. I am getting iso urbs to complete now.
>=20
> I think using scotest would be fine in the beginning. It will of course
> not send proper audio, but you see data going forth and back.

Compiling scotest is the problem:

make[3]: Entering directory `/home/oliver/Documents/bluez-utils-3.36/hcid'
gcc -DHAVE_CONFIG_H -I. -I.. -I../common -I../sdpd   -I/usr/include/dbus-1.=
0 -I/usr/lib64/dbus-1.0/include -I/usr/include/glib-2.0 -I/usr/lib64/glib-2=
=2E0/include   -I/usr/include/glib-2.0 -I/usr/lib64/glib-2.0/include   -I..=
/gdbus -DPLUGINDIR=3D\""/usr/local/lib/bluetooth/plugins"\" -Wall -O2 -D_FO=
RTIFY_SOURCE=3D2 -fPIE -MT security.o -MD -MP -MF .deps/security.Tpo -c -o =
security.o security.c
security.c: In function =E2=80=98link_key_request=E2=80=99:
security.c:279: error: storage size of =E2=80=98req=E2=80=99 isn=E2=80=99t =
known
security.c:291: error: =E2=80=98HCIGETAUTHINFO=E2=80=99 undeclared (first u=
se in this function)
security.c:291: error: (Each undeclared identifier is reported only once
security.c:291: error: for each function it appears in.)
security.c:279: warning: unused variable =E2=80=98req=E2=80=99
make[3]: *** [security.o] Fehler 1
make[3]: Leaving directory `/home/oliver/Documents/bluez-utils-3.36/hcid'
make[2]: *** [all] Fehler 2
make[2]: Leaving directory `/home/oliver/Documents/bluez-utils-3.36/hcid'
make[1]: *** [all-recursive] Fehler 1
make[1]: Leaving directory `/home/oliver/Documents/bluez-utils-3.36'
make: *** [all] Fehler 2

	Regards
		Oliver
