Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Cc: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] MS Wireless keyboard scans remapping
Message-ID: <20031028084018.GA1875@smartdata.ch>
References: <200310280847.39317.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
In-Reply-To: <200310280847.39317.cijoml@volny.cz>
From: Olivier Bornet <Olivier.Bornet@smartdata.ch>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 28 Oct 2003 09:40:18 +0100


--eAbsdosE1cNLO4uF
Content-Type: multipart/mixed; boundary="J/dobhs11T7y2rNN"
Content-Disposition: inline


--J/dobhs11T7y2rNN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

> my keyboard works now fine, but I found keys which doesn't. Looks like MS=
=20
> changed scan codes for them.

I have had this kind of problem with a Logitech diNovo Media Desktop
(http://www.logitech.com/bluetooth/). My main problems where that some
keys are not mapped correctly in the bthid-0.6 of Peter, and the code
for the mouse buttons is not OK. (at least with my Logitech Bluetooth
mouse).

The problem with the keys is that my keyboard is a swiss french one, and
the code of Peter has some keys missing. I have take the mapping from
the USB driver, and it is now working great. :-)

I have send my patches to Peter, but I have receive no answer. So, I
have attached my previous email to him. Try the patches to see if this
correct also your problem.

Good day.

		Olivier
--=20
Olivier Bornet                      http://www.smartdata.ch/
Olivier.Bornet@smartdata.ch         SMARTDATA SA
GPG key ID: C53D9218                CH Martigny/Lausanne

--J/dobhs11T7y2rNN
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <Olivier.Bornet@puck.ch>
Received: from mail.axiom.ch [213.221.158.30]
	by localhost with IMAP (fetchmail-6.1.0)
	for bol@localhost (single-drop); Tue, 28 Oct 2003 09:28:42 +0100 (CET)
Received: from obelix.spectraweb.ch (mailrelay03.sunrise.ch [194.158.229.31])
	by pop.axiomail.ch (8.11.6/8.11.6) with ESMTP id h9S8ROa28771
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:25 +0100
Received: from delta (adsl-62-167-40-36.adslplus.ch [62.167.40.36])
	by obelix.spectraweb.ch (8.12.9/8.12.6) with ESMTP id h9S8RXwZ024825
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:33 +0100
Received: from bol by delta with local (Exim 3.36 #1 (Debian))
	id 1AEPBy-0003Vz-00
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:06 +0100
Resent-From: Olivier.Bornet@puck.ch
Resent-Date: Tue, 28 Oct 2003 09:27:06 +0100
Resent-Message-ID: <20031028082706.GB27228@puck.ch>
Resent-To: olivier.bornet@smartdata.ch
Received: from puck.ch [153.109.180.3]
	by localhost with IMAP (fetchmail-5.9.11)
	for bol@localhost (single-drop); Mon, 13 Oct 2003 01:29:02 +0200 (CEST)
Received: from duba04h04-0.dplanet.ch ([212.35.36.38])
	by puck.ch with esmtp (Exim 3.36 #1)
	id 1A8pe3-0003tZ-00
	for Olivier.Bornet@puck.ch; Mon, 13 Oct 2003 01:29:03 +0200
Received: from delta (adsl-62-167-97-142.adslplus.ch [62.167.97.142])
	by duba04h04-0.dplanet.ch (8.12.10/8.12.10/2.00dplanet-smtp) with ESMTP id h9CNSuCq029282;
	Mon, 13 Oct 2003 01:28:57 +0200
Received: from bol by delta with local (Exim 3.36 #1 (Debian))
	id 1A8pcx-00062N-00; Mon, 13 Oct 2003 01:27:55 +0200
Date: Mon, 13 Oct 2003 01:27:55 +0200
To: Peter Klausler <peter@klausler.com>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>
Subject: bthid 0.6 with logitech keyboard/mouse
Message-ID: <20031012232755.GA21217@puck.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.4i
From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Virus-Scan: Scanned by TrashScan v0.09 running on delta
X-Spam-Status: No, hits=-3.7 required=5.0
	tests=NO_EXPERIENCE,PGP_SIGNATURE_2,RESENT_TO,USER_AGENT_MUTT
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Peter,

first, thanks for your bthid software. I'm trying to use it with a
Logitech bluetooth keyboard. (see http://www.logitech.com/bluetooth for
more information on it). but don't search it on the market at this
time, it is not available now. I have one sample because we work with
Logitech on it.

I have try to use bthid-0.6 today with my Debian 2.4.21-mh2 system.
Connecting the keyboard/mouse is sometime ok, sometime not. But this is
not a problem at this time, and I will search the reason why the
connection is not always ok later.

The first "major" problem I was having is with the button 1 of the
mouse. It doesn't work. I see the bluetooth packets, but nothing in X. I
have do some debuging, and all is ok now. :-) The problem was with the
number of buttons of the Logitech mouse : 8 buttons:
- 1: left
- 2: right
- 3: middle
- 4: side 1 (SIDE)
- 5: side 2 (EXTRA)
- 6: top (don't know the function, maybe "new window")
- 7: forward
- 8: backward
and the wheel.

Your code was mapping unknown button (in this case top, forward and
backward) to "primary" button left. And, as when I use the mouse all the
"buttons events" are sent to bthid whith theyre state, the buttons 6, 7
and 8 cleared the 1, event if the 1 is setted.

The attached patch correct this. Note I'm not sure this will be
necessary with the public product, as mine are alpha release product
with alpha firmeware. But if the mouse send all the buttons when one has
is state changed, this patch is necessary.

Another problem I have is the key < and > are not working. The layout of
my keyboard is fr_CH (Swiss French), and the key with < and > is on the
bottom line. Here is the bottom line:

lowercase:
SHIFT < y x c v b n m , . - SHIFT
uppercase:
SHIFT > Y X C V B N M ; : _ SHIFT

The key with the  < and > has also the \ with the Alt Gr mode.

Here is the hcidump when I press and release the < key:

> ACL data: handle 0x002e flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      A1 01 00 00 64 00 00 00 00 00=20
> ACL data: handle 0x002e flags 0x02 dlen 14
    L2CAP(d): cid 0x41 len 10 [psm 19]
      A1 01 00 00 00 00 00 00 00 00=20

I suspect I must put something in the array hid_to_linux[], position
0x64, but I don't have search what to put at this time. (maybe next
patch ;-), but another day: I must go to sleep now. )

Other normal keys seems to work ok.

Last point. I will be happy if I can try to use the "hotkeys". I have
see this must be supported, but I don't known how. I have installed the
hotkeys package, but as I have no experience with hotkeys, I don't know
how to use it. I have try to start with:
hotkeys --type=3Dlogitech-cfo --osd=3Don -b --loglevel=3D7
but I see only the splash screen, and nothing else. The keys are routed
on the bluetooth layer, here is the hcidump -x of the "home" key:

> ACL data: handle 0x002e flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      A1 03 23 02 00 00=20
> ACL data: handle 0x002e flags 0x02 dlen 10
    L2CAP(d): cid 0x41 len 6 [psm 19]
      A1 03 00 00 00 00=20

Can you help me with this feature ?

Thanks in advance for your help. And thanks for bthid.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ieN6dj3R/MU9khgRArcmAKDjmBwcpQm1oz+ekrFe5gxr8LAstgCfRLOd
2FOSXS3LWKO8ovqjOjtgdwc=
=+RbS
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--


--J/dobhs11T7y2rNN
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <Olivier.Bornet@puck.ch>
Received: from mail.axiom.ch [213.221.158.30]
	by localhost with IMAP (fetchmail-6.1.0)
	for bol@localhost (single-drop); Tue, 28 Oct 2003 09:27:37 +0100 (CET)
Received: from obelix.spectraweb.ch (mailrelay03.sunrise.ch [194.158.229.31])
	by pop.axiomail.ch (8.11.6/8.11.6) with ESMTP id h9S8RPa28775
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:25 +0100
Received: from delta (adsl-62-167-40-36.adslplus.ch [62.167.40.36])
	by obelix.spectraweb.ch (8.12.9/8.12.6) with ESMTP id h9S8RXwZ024826
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:33 +0100
Received: from bol by delta with local (Exim 3.36 #1 (Debian))
	id 1AEPBz-0003W4-00
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:07 +0100
Resent-From: Olivier.Bornet@puck.ch
Resent-Date: Tue, 28 Oct 2003 09:27:06 +0100
Resent-Message-ID: <20031028082706.GC27228@puck.ch>
Resent-To: olivier.bornet@smartdata.ch
Received: from puck.ch [153.109.180.3]
	by localhost with IMAP (fetchmail-5.9.11)
	for bol@localhost (single-drop); Mon, 13 Oct 2003 08:19:12 +0200 (CEST)
Received: from duba05h05-0.dplanet.ch ([212.35.36.52])
	by puck.ch with esmtp (Exim 3.36 #1)
	id 1A8w3V-0005F2-00
	for Olivier.Bornet@puck.ch; Mon, 13 Oct 2003 08:19:45 +0200
Received: from delta (adsl-62-167-97-142.adslplus.ch [62.167.97.142])
	by duba05h05-0.dplanet.ch (8.12.10/8.12.10/2.00dplanet-smtp) with ESMTP id h9D6Jg5a013566;
	Mon, 13 Oct 2003 08:19:42 +0200
Received: from bol by delta with local (Exim 3.36 #1 (Debian))
	id 1A8w2R-0006cC-00; Mon, 13 Oct 2003 08:18:39 +0200
Date: Mon, 13 Oct 2003 08:18:39 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Peter Klausler <peter@klausler.com>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>
Subject: Re: bthid 0.6 with logitech keyboard/mouse
Message-ID: <20031013061839.GB21217@puck.ch>
References: <20031012232755.GA21217@puck.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="iFRdW5/EC4oqxDHL"
Content-Disposition: inline
In-Reply-To: <20031012232755.GA21217@puck.ch>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.4i
Sender: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Virus-Scan: Scanned by TrashScan v0.09 running on delta
X-Spam-Status: No, hits=-6.2 required=5.0
	tests=IN_REP_TO,PGP_SIGNATURE_2,REFERENCES,RESENT_TO,
	      USER_AGENT_MUTT
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)


--iFRdW5/EC4oqxDHL
Content-Type: multipart/mixed; boundary="KFztAG8eRSV9hGtP"
Content-Disposition: inline


--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello again,

> The attached patch correct this.

Forgot the patch. Here is it.

Good day.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--KFztAG8eRSV9hGtP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-bthid-0.6-for-lt.txt"
Content-Transfer-Encoding: quoted-printable

--- bthid-0.6-orig/hid.c	2003-04-29 22:00:53.000000000 +0200
+++ bthid-0.6/hid.c	2003-10-13 00:03:03.000000000 +0200
@@ -527,9 +527,12 @@
 		return;
=20
 	case 0x0009:	/* Buttons */
+
+                /* init */
+	        butt =3D BTN_LEFT;
+	 =20
 		switch (usage & 0xffff) {
 		case 0:	return;
-		default:
 		case 1:	butt =3D BTN_LEFT;	break;
 		case 2:	butt =3D BTN_RIGHT;	break;
 		case 3:	if (swap_buttons_2_5)	return;
@@ -537,6 +540,12 @@
 		case 4:	butt =3D BTN_SIDE;	break;
 		case 5:	butt =3D swap_buttons_2_5 ? BTN_MIDDLE : BTN_EXTRA;
 			break;
+		case 6:	return;  /* no definition in input.h ... */
+		case 7:	butt =3D BTN_FORWARD;	break;
+		case 8:	butt =3D BTN_BACK;	break;
+		default:
+		  printf ("Pb. handling 0x%04lx", usage & 0xffff);
+		  break;
 		}
 		buttmask =3D 1 << butt - BTN_MOUSE;
 		if (val && !(mouse_butt & buttmask)) {

--KFztAG8eRSV9hGtP--

--iFRdW5/EC4oqxDHL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/ikO/dj3R/MU9khgRAu5DAJ4xJektEjG82yNlVP5JwxpV9GWogACfVFEd
JS0Wpj8UZIJ+LZBQAA2rivk=
=Sa4z
-----END PGP SIGNATURE-----

--iFRdW5/EC4oqxDHL--


--J/dobhs11T7y2rNN
Content-Type: message/rfc822
Content-Disposition: inline

Return-Path: <Olivier.Bornet@puck.ch>
Received: from mail.axiom.ch [213.221.158.30]
	by localhost with IMAP (fetchmail-6.1.0)
	for bol@localhost (single-drop); Tue, 28 Oct 2003 09:28:46 +0100 (CET)
Received: from obelix.spectraweb.ch (mailrelay03.sunrise.ch [194.158.229.31])
	by pop.axiomail.ch (8.11.6/8.11.6) with ESMTP id h9S8RPa28776
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:25 +0100
Received: from delta (adsl-62-167-40-36.adslplus.ch [62.167.40.36])
	by obelix.spectraweb.ch (8.12.9/8.12.6) with ESMTP id h9S8RXwZ024827
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:33 +0100
Received: from bol by delta with local (Exim 3.36 #1 (Debian))
	id 1AEPBz-0003W8-00
	for <olivier.bornet@smartdata.ch>; Tue, 28 Oct 2003 09:27:07 +0100
Resent-From: Olivier.Bornet@puck.ch
Resent-Date: Tue, 28 Oct 2003 09:27:07 +0100
Resent-Message-ID: <20031028082707.GD27228@puck.ch>
Resent-To: olivier.bornet@smartdata.ch
Received: from puck.ch [153.109.180.3]
	by localhost with IMAP (fetchmail-5.9.11)
	for bol@localhost (single-drop); Tue, 14 Oct 2003 09:14:39 +0200 (CEST)
Received: from duba05h05-0.dplanet.ch ([212.35.36.52])
	by puck.ch with esmtp (Exim 3.36 #1)
	id 1A9JMH-0006ks-00
	for Olivier.Bornet@puck.ch; Tue, 14 Oct 2003 09:14:02 +0200
Received: from delta (adsl-62-167-38-5.adslplus.ch [62.167.38.5])
	by duba05h05-0.dplanet.ch (8.12.10/8.12.10/2.00dplanet-smtp) with ESMTP id h9E7CeA1009314
	for <Olivier.Bornet@puck.ch>; Tue, 14 Oct 2003 09:12:40 +0200
Received: from bol by delta with local (Exim 3.36 #1 (Debian))
	id 1A9JME-0002Pq-00
	for <Olivier.Bornet@puck.ch>; Tue, 14 Oct 2003 09:12:38 +0200
Resent-From: Olivier.Bornet@puck.ch
Resent-Date: Tue, 14 Oct 2003 09:12:38 +0200
Resent-Message-ID: <20031014071238.GF21217@puck.ch>
Resent-To: Olivier Bornet <Olivier.Bornet@puck.ch>
Date: Tue, 14 Oct 2003 09:08:43 +0200
From: Olivier Bornet <Olivier.Bornet@puck.ch>
To: Peter Klausler <peter@klausler.com>
Cc: Olivier Bornet <Olivier.Bornet@puck.ch>
Subject: Re: bthid 0.6 with logitech keyboard/mouse
Message-ID: <20031014070843.GE21217@puck.ch>
References: <20031012232755.GA21217@puck.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0z5c7mBtSy1wdr4F"
Content-Disposition: inline
In-Reply-To: <20031012232755.GA21217@puck.ch>
X-From: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Url: http://puck.ch/
User-Agent: Mutt/1.5.4i
X-Virus-Scan: Scanned by TrashScan v0.09 running on delta
Resent-Sender: Olivier Bornet <Olivier.Bornet@puck.ch>
X-Spam-Status: No, hits=-6.2 required=5.0
	tests=IN_REP_TO,PGP_SIGNATURE_2,REFERENCES,RESENT_TO,
	      USER_AGENT_MUTT
	version=2.55
X-Spam-Level: 
X-Spam-Checker-Version: SpamAssassin 2.55 (1.174.2.19-2003-05-19-exp)


--0z5c7mBtSy1wdr4F
Content-Type: multipart/mixed; boundary="ULyIDA2m8JTe+TiX"
Content-Disposition: inline


--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Mon, Oct 13, 2003 at 01:27:55AM +0200, Olivier Bornet wrote:
> Another problem I have is the key < and > are not working. The layout of
> my keyboard is fr_CH (Swiss French), and the key with < and > is on the
> bottom line.

I have find a solution for this problem: use the same array as the usb
one (hid_keyboard from /usr/src/linux/drivers/usb/hid-input.c). This is
working great for me will all the "normal" keys. (don't know how to
enable hotkeys).

The patch for this is attached.

Good day.

		Olivier
--=20
Olivier Bornet                 |      fran=E7ais : http://puck.ch/f
Swiss Ice Hockey Results       |      english  : http://puck.ch/e
http://puck.ch/                |      deutsch  : http://puck.ch/g
Olivier.Bornet@puck.ch         |      italiano : http://puck.ch/i
Get my PGP-key at http://puck.ch/pgp or at http://wwwkeys.pgp.net

--ULyIDA2m8JTe+TiX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-bthid-0.6-for-lt-kbd-sf.txt"
Content-Transfer-Encoding: quoted-printable

--- bthid-0.6-orig/hid.c	2003-04-29 22:00:53.000000000 +0200
+++ bthid-0.6/hid.c	2003-10-14 08:58:25.000000000 +0200
@@ -369,46 +369,26 @@
 static	int	any_keyboard;
=20
=20
-static	int	hid_to_linux [256] =3D {
-
-/* 0x00 */	0 /* no event */, 0 /* rollover error */, 0 /* POST fail */,
-		0 /* undefined error */, KEY_A, KEY_B, KEY_C, KEY_D,
-/* 0x08 */	KEY_E, KEY_F, KEY_G, KEY_H, KEY_I, KEY_J, KEY_K, KEY_L,
-/* 0x10 */	KEY_M, KEY_N, KEY_O, KEY_P, KEY_Q, KEY_R, KEY_S, KEY_T,
-/* 0x18 */	KEY_U, KEY_V, KEY_W, KEY_X, KEY_Y, KEY_Z, KEY_1, KEY_2,
-/* 0x20 */	KEY_3, KEY_4, KEY_5, KEY_6, KEY_7, KEY_8, KEY_9, KEY_0,
-/* 0x28 */	KEY_ENTER, KEY_ESC, KEY_BACKSPACE, KEY_TAB,
-		KEY_SPACE, KEY_MINUS, KEY_EQUAL, KEY_LEFTBRACE,
-/* 0x30 */	KEY_RIGHTBRACE, KEY_BACKSLASH, 0, KEY_SEMICOLON,
-		KEY_APOSTROPHE, KEY_GRAVE, KEY_COMMA, KEY_DOT,
-/* 0x38 */	KEY_SLASH, KEY_CAPSLOCK, KEY_F1, KEY_F2,
-		KEY_F3, KEY_F4, KEY_F5, KEY_F6,
-/* 0x40 */	KEY_F7, KEY_F8, KEY_F9, KEY_F10,
-		KEY_F11, KEY_F12, KEY_SYSRQ, KEY_SCROLLLOCK,
-/* 0x48 */	KEY_PAUSE, KEY_INSERT, KEY_HOME, KEY_PAGEUP,
-		KEY_DELETE, KEY_END, KEY_PAGEDOWN, KEY_RIGHT,
-/* 0x50 */	KEY_LEFT, KEY_DOWN, KEY_UP, KEY_NUMLOCK,
-		KEY_KPSLASH, KEY_KPASTERISK, KEY_KPMINUS, KEY_KPPLUS,
-/* 0x58 */	KEY_KPENTER, KEY_KP1, KEY_KP2, KEY_KP3,
-		KEY_KP4, KEY_KP5, KEY_KP6, KEY_KP7,
-/* 0x60 */	KEY_KP8, KEY_KP9, KEY_KP0, KEY_KPDOT, 0, 0, 0, 0,
-/* pmk!! fill these in, even though my keyboard doesn't use them... */
-/* 0x68 */	0, 0, 0, 0, 0, 0, 0, 0,
-/* 0x70 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0x80 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0x90 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0xa0 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0xb0 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0xc0 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0xd0 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
-/* 0xe0 */	KEY_LEFTCTRL, KEY_LEFTSHIFT, KEY_LEFTALT,
-		KEY_LEFTMETA,	/* Would COMPOSE be better? */
-		KEY_RIGHTCTRL, KEY_RIGHTSHIFT, KEY_RIGHTALT, 0,
-/* 0xe8 */	0, 0, 0, 0, 0, 0, 0, 0,
-/* 0xf0 */	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
+#define unk     KEY_UNKNOWN
+static unsigned char hid_to_linux [256] =3D {
+          0,  0,  0,  0, 30, 48, 46, 32, 18, 33, 34, 35, 23, 36, 37, 38,
+         50, 49, 24, 25, 16, 19, 31, 20, 22, 47, 17, 45, 21, 44,  2,  3,
+          4,  5,  6,  7,  8,  9, 10, 11, 28,  1, 14, 15, 57, 12, 13, 26,
+         27, 43, 84, 39, 40, 41, 51, 52, 53, 58, 59, 60, 61, 62, 63, 64,
+         65, 66, 67, 68, 87, 88, 99, 70,119,110,102,104,111,107,109,106,
+        105,108,103, 69, 98, 55, 74, 78, 96, 79, 80, 81, 75, 76, 77, 71,
+         72, 73, 82, 83, 86,127,116,117, 85, 89, 90, 91, 92, 93, 94, 95,
+        120,121,122,123,134,138,130,132,128,129,131,137,133,135,136,113,
+        115,114,unk,unk,unk,124,unk,181,182,183,184,185,186,187,188,189,
+        190,191,192,193,194,195,196,197,198,unk,unk,unk,unk,unk,unk,unk,
+        unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+        unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+        unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+        unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,unk,
+         29, 42, 56,125, 97, 54,100,126,164,166,165,163,161,115,114,113,
+        150,158,159,128,136,177,178,176,142,152,173,140,unk,unk,unk,unk
 };
=20
-
 static	int	hid_dvorak_to_linux [256] =3D {
=20
 /* 0x00 */	0 /* no event */, 0 /* rollover error */, 0 /* POST fail */,

--ULyIDA2m8JTe+TiX--

--0z5c7mBtSy1wdr4F
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/i6D7dj3R/MU9khgRAlcQAJ41MNNu/y/XoOunRa+W5giTC0HYmwCgkVqh
2TYpDE+aGkXHDBp2fP+c6+k=
=ff9S
-----END PGP SIGNATURE-----

--0z5c7mBtSy1wdr4F--


--J/dobhs11T7y2rNN--

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/nitydj3R/MU9khgRAnP1AJ9/fjbQdZNvpOxv/irWVCDTHjszrQCgvy/l
JF/XpcRTKhdr0pOX05pn6ac=
=C1+J
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
