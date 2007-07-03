Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100707031254o330ce2b5se3ca0c30520deac0@mail.gmail.com>
Date: Tue, 3 Jul 2007 16:54:21 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <468A02F2.7030903@free.fr>
MIME-Version: 1.0
References: <46852386.8050608@free.fr>
	<2d5a2c100706291110i473d080bv6ba634f0eb8d9deb@mail.gmail.com>
	<46892FEC.7000705@free.fr>
	<d89ddf300707022031p349950e7w821a74cce27fb321@mail.gmail.com>
	<468A02F2.7030903@free.fr>
Subject: Re: [Bluez-devel] CVS audio-api.txt : 1st question
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1818147723=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1818147723==
Content-Type: multipart/alternative;
	boundary="----=_Part_134063_11372437.1183492461150"

------=_Part_134063_11372437.1183492461150
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Fabien,

Yep, you are right we cannot stop application using alsa plugin while in PC=
M
mode,
Im not so familiar with alsa so I have no clue about slave pcm, but if we
can make
it to just open/close the device (the only thing left in PCM mode) that is
the way
to go.

Another point I would like to discuss is about not having the intermediate
state when
we are connected to the rfcomm but not yet to the sco socket, it seems
useless
to have to Connect() and then Play(), the alsa plugin already goes direct t=
o
Play the
stream. Do you guys see any value in having a device connected but not
streaming?

--=20
Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

------=_Part_134063_11372437.1183492461150
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Fabien,<br><br>Yep, you are right we cannot stop application using alsa =
plugin while in PCM mode,<br>Im not so familiar with alsa so I have no clue=
 about slave pcm, but if we can make<br>it to just open/close the device (t=
he only thing left in PCM mode) that is the way
<br>to go.<br clear=3D"all"><br>Another point I would like to discuss is ab=
out not having the intermediate state when<br>we are connected to the rfcom=
m but not yet to the sco socket, it seems useless<br>to have to Connect() a=
nd then Play(), the alsa plugin already goes  direct to Play the
<br>stream. Do you guys see any value in having a device connected but not =
streaming?<br><br>-- <br>Luiz Augusto von Dentz<br>Engenheiro de Computa=E7=
=E3o

------=_Part_134063_11372437.1183492461150--


--===============1818147723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1818147723==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1818147723==--
