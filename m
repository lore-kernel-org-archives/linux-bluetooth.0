Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pavel Ruzicka <pavouk@pavouk.org>
To: "Radoslav Reznicek" <radecek@email.cz>
Subject: Re: [Bluez-users] pairing i-Tech BT USB dongle and Nokia 6310i
References: <000e01c3f4d0$8128de60$4461daa0@radecek>
In-Reply-To: <000e01c3f4d0$8128de60$4461daa0@radecek>
Cc: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200402162247.13628.pavouk@pavouk.org>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 16 Feb 2004 22:47:13 +0100

Hello,

> I can't paired i-Tech BT USB dongle and phone Nokia 6310i. When I want
> connect to phone,  phone ask me for PIN. After enter PIN phone says "bad
> PIN". PC do not ask me for PIN. When I  try run bluepin script from shell,
> it return error. What do I bad?
> OS Mandrake9.2 kernel 2.4.22
> When I using Windows, i-Tech BT USB dongle and phone work correctly.

I was similar problem with Mandrake. You can try edit file /etc/bluetooth/p=
in
and change "BlueZ" to some numbers "1234". But I don't know, if I make some
other actions. Maybe restart of init script...

Best regards,

Pavel R=F9=BEi=E8ka



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
