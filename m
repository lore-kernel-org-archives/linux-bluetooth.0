Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c0509150944132bb8f1@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] Problem with l2test, rctest
In-Reply-To: <1126801476.15633.2.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_8365_19211447.1126802640480"
References: <becc9d2c05091505534b795f7b@mail.gmail.com>
	 <becc9d2c05091506452748d6a0@mail.gmail.com>
	 <1126792737.3505.6.camel@station6.example.com>
	 <becc9d2c050915091830e5a609@mail.gmail.com>
	 <1126801476.15633.2.camel@localhost.localdomain>
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
Date: Thu, 15 Sep 2005 18:44:00 +0200

------=_Part_8365_19211447.1126802640480
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, i compiled correctly hcidump.

So, when from my client i call i get:
./l2test -n 00:10:60:29:3B:9A
l2test[1349]: Can't connect: Function not implemented (38)

and the dump is:

HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
bdaddr 00:10:60:29:3B:9A ptype 0xcc18 rswitch 0x00 clkoffset 0x0000
Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
status 0x21 handle 41 bdaddr 00:10:60:29:3B:9A type ACL encrypt 0x00
Error: Role Change Not Allowed



On my server-side, i call:
>./l2test
>l2test[3280]: Waiting for connection on psm 10 ...

and nothing happens.

The dump of the server is:

> HCI Event: Connect Request (0x04) plen 10
bdaddr 00:10:60:A5:81:68 class 0x820100 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
bdaddr 00:10:60:A5:81:68 role 0x00
Role: Master
> HCI Event: Command Status (0x0f) plen 4
Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
status 0x21 handle 40 bdaddr 00:10:60:A5:81:68 type ACL encrypt 0x00
Error: Role Change Not Allowed


some ideas ?

------=_Part_8365_19211447.1126802640480
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Marcel, i compiled correctly hcidump.<br>
<br>
So, when from my client i call i get:<br>
./l2test -n 00:10:60:29:3B:9A<br>
l2test[1349]: Can't connect: Function not implemented (38)<br>
<br>
and the dump is:<br>
<br>
HCI sniffer - Bluetooth packet analyzer ver 1.23<br>
device: hci0 snap_len: 1028 filter: 0xffffffff<br>
&lt; HCI Command: Create Connection (0x01|0x0005) plen 13<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:10:60:29:3B:9A ptype 0xcc18 rswitch 0x00 clkof=
fset 0x0000<br>
&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Create Connection (0x01|0x0005) status 0x00 ncmd 1<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x21 handle 41 bdaddr 00:10:60:29:3B:9A type ACL =
encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: Role Change Not Allowed<br>
<br>
<br>
<br>
On my server-side, i call:<br>
&gt;./l2test<br>
&gt;l2test[3280]: Waiting for connection on psm 10 ...<br>
<br>
and nothing happens.<br>
<br>
The dump of the server is:<br>
<br>
&gt; HCI Event: Connect Request (0x04) plen 10<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:10:60:A5:81:68 class 0x820100 type ACL<br>
&lt; HCI Command: Accept Connection Request (0x01|0x0009) plen 7<br>
&nbsp;&nbsp;&nbsp; bdaddr 00:10:60:A5:81:68 role 0x00<br>
&nbsp;&nbsp;&nbsp; Role: Master<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp;&nbsp;&nbsp; Accept Connection Request (0x01|0x0009) status 0x00 ncmd=
 1<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp;&nbsp;&nbsp; status 0x21 handle 40 bdaddr 00:10:60:A5:81:68 type ACL =
encrypt 0x00<br>
&nbsp;&nbsp;&nbsp; Error: Role Change Not Allowed<br>
<br>
<br>
some ideas ?<br>
<br>
<br>
<br>
<br>

------=_Part_8365_19211447.1126802640480--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
