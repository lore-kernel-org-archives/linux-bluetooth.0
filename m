Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <becc9d2c050914054534d59263@mail.gmail.com>
From: Andrea Carlevato <andrea.carlevatoml@gmail.com>
To: bluez-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6890_26755820.1126701916002"
Subject: [Bluez-devel] How 'respond' in BlueZ to a PIN request ?
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
Date: Wed, 14 Sep 2005 14:45:16 +0200

------=_Part_6890_26755820.1126701916002
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi to all,
if i set my usb dongle in authentication mode
(hciconfig hci0 auth) and connect to my bluetooth phone,=20
(hcitool cc BTADDR) the phone ask me for the pin of my pc,=20
and after i ve entered correctly, the connection i created.

My question is: how can i control the same thing on my
bluez pc ? If i do the same (hcitool cc BTADDR) to connect
another pc instead of my phone no PIN is requested and
create connection fails!=20

I need to know this beacause i need to write a simple program
that listen for l2cap connection on a socket, GIVE THE PIN, and
allows the connection to be estabilished.

Thanks a lot!

Andrea

------=_Part_6890_26755820.1126701916002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi to all,<br>
if i set my usb dongle in authentication mode<br>
(hciconfig hci0 auth) and connect to my bluetooth phone, <br>
(hcitool cc BTADDR)&nbsp; the phone&nbsp; ask me for the pin of my pc, <br>
and after i ve entered correctly, the connection i created.<br>
<br>
My question is: how can i control the same thing on my<br>
bluez pc ? If i do the same (hcitool cc BTADDR) to connect<br>
another pc instead of my phone no PIN is requested and<br>
create connection fails! <br>
<br>
I need to know this beacause i need to write a simple program<br>
that listen for l2cap connection on a socket, GIVE THE PIN, and<br>
allows the connection to be estabilished.<br>
<br>
Thanks a lot!<br>
<br>
Andrea<br>
<br>
<br>
<br>
<br>

------=_Part_6890_26755820.1126701916002--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
