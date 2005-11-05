Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <b47e603e0511050301i5e515811y58412c28aa581c8f@mail.gmail.com>
From: George Friedman <george.friedman@gmail.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9735_11590597.1131188480300"
Subject: [Bluez-users] what is libbluetooth library?
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
Date: Sat, 5 Nov 2005 19:01:20 +0800

------=_Part_9735_11590597.1131188480300
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi

i am installing pjbluez package (add on to jbluez) for location sensing.
source: http://www.mobilab.unina.it/PJBLUEZ.htm

when i run the shell script that can build the libraries for pjbluez, i get
an error saying,

checking bluetooth/bluetooth.h usability... no
checking bluetooth/bluetooth.h presence... no
checking for bluetooth/bluetooth.h... no
checking for hci_open_dev in -lbluetooth... no
configure: error: Sorry, you should install the libbluetooth library before
trying to compile this package

what does the last line mean?i have installed bluez and jbluez on fc 4 so i
don't understand what libbluetooth library i'm required to install

thank you
george

------=_Part_9735_11590597.1131188480300
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi<br>
<br>
i am installing pjbluez package (add on to jbluez) for location sensing. so=
urce: <a href=3D"http://www.mobilab.unina.it/PJBLUEZ.htm">http://www.mobila=
b.unina.it/PJBLUEZ.htm</a><br>
<br>
when i run the shell script that can build the libraries for pjbluez, i get=
 an error saying, <br>
<br>
checking bluetooth/bluetooth.h usability... no<br>
checking bluetooth/bluetooth.h presence... no<br>
checking for bluetooth/bluetooth.h... no<br>
checking for hci_open_dev in -lbluetooth... no<br>
configure: error: Sorry, you should install the libbluetooth library before=
 trying to compile this package<br>
<br>
what does the last line mean?i have installed bluez and jbluez on fc 4
so i don't understand what libbluetooth library i'm required to install<br>
<br>
thank you<br>
george<br>

------=_Part_9735_11590597.1131188480300--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
