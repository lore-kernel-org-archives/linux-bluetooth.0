Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <863CEBAE-1469-4E15-A90A-ED373C614FAB@holtmann.org>
References: <1381131496-9417-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1381243883-2745-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1381243883-2745-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<60443344-0A54-4EF4-ABBB-1EAAE168E541@holtmann.org>
	<20131014115131.GG2861@aemeltch-MOBL1>
	<863CEBAE-1469-4E15-A90A-ED373C614FAB@holtmann.org>
Date: Mon, 14 Oct 2013 15:39:29 +0200
Message-ID: <CALkxMhHcb1Da8CeE+4tnH4nswy4EUwLo4jsp-rsM=6cFVSf9cA@mail.gmail.com>
Subject: Re: [PATCHv3 14/15] android: Add makefile for hciconfig
From: Michal Labedzki <michal.labedzki@tieto.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>, linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=089e01419e8cf353a204e8b39886
List-ID: <linux-bluetooth.vger.kernel.org>

--089e01419e8cf353a204e8b39886
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello Andrei,

If you want to have support for new format of BNSNOOP in Wireshark please
create new bug/feature request on Wireshark bugzilla:
https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=3D---&query_form=
at=3Dadvanced&list_id=3D10586
Please attach example trace file(s).

Also if anyone known a bug in Wireshark or need new feature please use
bugzilla too.

There is a second way to sniffing Bluetooth with Wireshark: if you have two
Bluetooth USB dongles then you can sniffing over USB (optionally filtering
by "hci_usb" {+ is SCO in logs; - is that only for USB devices}).


By the way: Wireshark can support BlueZ BTSNOOP format, but btmon can
support "pcap" or "pcapng" format too. Most similar tools use them.

PS. Wireshark seems to decode whole Bluetooth stack, also tshark can be
replacement for your btmon.


Pozdrawiam / Best regards
---------------------------------------------------------------------------=
----------------------------------
Micha=C5=82 =C5=81ab=C4=99dzki, Software Engineer
Tieto Corporation

Product Development Services
http://www.tieto.com / http://www.tieto.pl
---
ASCII: Michal Labedzki
location: Swobodna 1 Street, 50-088 Wroc=C5=82aw, Poland
room: 5.01 (desk next to 5.08)
---
Please note: The information contained in this message may be legally
privileged and confidential and protected from disclosure. If the reader of
this message is not the intended recipient, you are hereby notified that
any unauthorised use, distribution or copying of this communication is
strictly prohibited. If you have received this communication in error,
please notify us immediately by replying to the message and deleting it
from your computer. Thank You.
---
Please consider the environment before printing this e-mail.
---
Tieto Poland sp=C3=B3=C5=82ka z ograniczon=C4=85 odpowiedzialno=C5=9Bci=C4=
=85 z siedzib=C4=85 w
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S=C4=85dzie Rejonowym
Szczecin-Centrum w Szczecinie, XIII Wydzia=C5=82 Gospodarczy Krajowego Reje=
stru
S=C4=85dowego pod numerem 0000124858. NIP: 8542085557. REGON: 812023656. Ka=
pita=C5=82
zak=C5=82adowy: 4 271500 PLN

--089e01419e8cf353a204e8b39886
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hello Andrei,<br><br></div>If you want=
 to have support for new format of BNSNOOP in Wireshark please create new b=
ug/feature request on Wireshark bugzilla: <a href=3D"https://bugs.wireshark=
.org/bugzilla/buglist.cgi?resolution=3D---&amp;query_format=3Dadvanced&amp;=
list_id=3D10586">https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=
=3D---&amp;query_format=3Dadvanced&amp;list_id=3D10586</a><br>
</div>Please attach example trace file(s). <br><br></div>Also if anyone kno=
wn a bug in Wireshark or need new feature please use bugzilla too.<br><br><=
/div><div>There is a second way to sniffing Bluetooth with Wireshark: if yo=
u have two Bluetooth USB dongles then you can sniffing over USB (optionally=
 filtering by &quot;hci_usb&quot; {+ is SCO in logs; - is that only for USB=
 devices}).<br>
</div><div><br><br></div><div>By the way: Wireshark can support BlueZ BTSNO=
OP format, but btmon can support &quot;pcap&quot; or &quot;pcapng&quot; for=
mat too. Most similar tools use them.<br></div><div><br>PS. Wireshark seems=
 to decode whole Bluetooth stack, also tshark can be replacement for your b=
tmon.<br>
</div><div><div><div><div><br><div><div class=3D"gmail_extra"><div dir=3D"l=
tr"><table cellpadding=3D"0" cellspacing=3D"0"><tbody><tr><td rowspan=3D"3"=
><img src=3D"https://email.tieto.com/owa/8.3.298.1/themes/base/clear.gif" a=
lt=3D""></td>
<td><br></td><td rowspan=3D"3"><img src=3D"https://email.tieto.com/owa/8.3.=
298.1/themes/base/clear.gif" alt=3D""></td></tr><tr><td><div>
<font><div>Pozdrawiam / Best regards<br>
---------------------------------------------------------------------------=
----------------------------------<br>
Micha=C5=82 =C5=81ab=C4=99dzki, Software Engineer<br>
Tieto Corporation<br>



=09
=09
=09
=09


<p style=3D"margin-left:0cm;margin-top:0cm" lang=3D"en-GB"><font color=3D"#=
000000"><font><span style=3D"font-weight:normal">Product
Development Services</span></font></font></p>


<a href=3D"http://www.tieto.com" target=3D"_blank">http://www.tieto.com</a>=
 / <a href=3D"http://www.tieto.pl" target=3D"_blank">http://www.tieto.pl</a=
><br>
---<br>
ASCII: Michal Labedzki<br>
location: Swobodna 1 Street, 50-088 Wroc=C5=82aw, Poland<br>
room: 5.01 (desk next to 5.08)<br>
---<br>
Please note: The information contained in this message may be legally=20
privileged and confidential and protected from disclosure. If the reader
 of this message is not the intended recipient, you are hereby notified=20
that any unauthorised use, distribution or copying of this communication
 is strictly prohibited. If you have received this communication in=20
error, please notify us immediately by replying to the message and=20
deleting it from your computer. Thank You.<br>
---<br>
Please consider the environment before printing this e-mail.<br>
---<br>
Tieto Poland sp=C3=B3=C5=82ka z ograniczon=C4=85 odpowiedzialno=C5=9Bci=C4=
=85 z siedzib=C4=85 w=20
Szczecinie, ul. Malczewskiego 26. Zarejestrowana w S=C4=85dzie Rejonowym=20
Szczecin-Centrum w Szczecinie, XIII Wydzia=C5=82 Gospodarczy Krajowego=20
Rejestru S=C4=85dowego pod numerem 0000124858. NIP: 8542085557. REGON:=20
812023656. Kapita=C5=82 zak=C5=82adowy: 4 271500 PLN</div></font>
</div></td></tr></tbody></table></div>
</div></div></div></div></div></div></div>

--089e01419e8cf353a204e8b39886--
