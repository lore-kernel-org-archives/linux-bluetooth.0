Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Thilo Riessner <thilo@riessner.de>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 2 Jul 2007 17:35:51 +0200
References: <200706181148.34291.thilo@riessner.de>
In-Reply-To: <200706181148.34291.thilo@riessner.de>
MIME-Version: 1.0
Message-Id: <200707021735.52364.thilo@riessner.de>
Subject: Re: [Bluez-users] HP Bluetooth PC Card Mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

After I got no response so far, I try again with some additional informatio=
n. =

The "hidd --server" process running in the background detects the the mouse =

when it gets switched on again (after a powersave or off mode) and produces =

the line:
############################################################################
hidd[28927]: New HID device 00:02:76:00:D0:3E (Broadcom Four Button Mouse)
input: Bluetooth HID Boot Protocol Device as /class/input/input15
############################################################################
in syslog. =

also an "hidd show" gives:
############################################################################
00:02:76:00:D0:3E Bluetooth HID Boot Protocol Device [0a5c:2004] connected =

[boot-protocol]
############################################################################
So the mouse is obviously detected and somehow connected. But the LED is of=
f, =

and the mouse pointer does not react on movements.
I should mention, that directly after turning the mouse on, the laser LED =

turns on for less than an second and than off again. The mouse is than not =

yet discovered by the notebook. I have to press a mouse button first, and =

than after a second, the above mentioned logs appear.
So what last bit is missing, to get it work again without making the annoyi=
ng =

procedure with the connect button.

Am Montag, 18. Juni 2007 11:48 schrieb Thilo Riessner:
> I bought a HP Bluetooth PC Card Mouse. It works when I press the connect
> button underneath the mouse, and hidd -c adress. This is ok for the first
> time using it, but I have to press the button every time i am using it.
> This is bothersome. Is there a possibility to avoid this procedure? I am
> using a Dell Latitude D620 with OpenSuSE 10.2 operating system.
> Thanks for any help
>
> Thilo
>

> -------------------------------------------------------------------------
> This SF.net email is sponsored by DB2 Express
> Download DB2 Express C - the FREE version of DB2 express and take
> control of your XML. No limits. Just data. Click to get it now.
> http://sourceforge.net/powerbar/db2/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users

-- =

----------------------------------------------------
|Rie=DFner Gase GmbH & Co. KG                        |
|Rudolf-Diesel-Stra=DFe 5                            |
|96215 Lichtenfels                                 |
|Telefon: 0049 (0) 9571 / 765 - 0                  |
|Telefax: 0049 (0) 9571 / 765 - 67                 |
|Komplement=E4rin: Rie=DFner-Gase Beteiligungs-GmbH    |
|Sitz: Lichtenfels                                 |
|Registergericht Coburg HRB 2616                   |
|Registergericht Coburg HRA 3533                   |
|Gesch=E4ftsf=FChrer: Dipl.-Ing. Dr. Rolf Rie=DFner,     |
|                 Dr. Thilo Rie=DFner                |
|Umsatzsteuernummer: 173/06405                     |
|Umsatz-IdNr.: DE 812 175 462                      |
----------------------------------------------------

-----------------------------------------------------------------------
|Diese E-Mail (ggf. nebst Anhang) enth=E4lt vertrauliche und/oder       |
|rechtlich gesch=FCtzte Informationen. Wenn Sie nicht der richtige      |
|Adressat sind, oder diese E-Mail irrt=FCmlich erhalten haben,          |
|informieren |Sie bitte sofort den Absender und vernichten Sie        |
|diese Mail. Das unerlaubte Kopieren sowie die unbefugte Weitergabe   |
|dieser Mail ist nicht gestattet.                                     |
|---------------------------------------------------------------------|
|This e-mail (and any attachment/s) contains confidential and/or      |
|privileged information. If you are not the intended recipient        |
|(or have received this e-mail in error) please notify the sender     |
|immediately and destroy this e-mail. Any unauthorised copying,       |
|disclosure or distribution of the material in this e-mail is         |
|strictly forbidden.                                                  |
-----------------------------------------------------------------------


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
