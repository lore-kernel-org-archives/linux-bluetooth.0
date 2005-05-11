Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42823CAE.6050709@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Bluetooth-adapter not detected
References: <4281F089.1090404@web.de> <1115812535.11503.77.camel@pegasus>	 <4281F811.1080306@gmx.de> <1115814650.11503.90.camel@pegasus>	 <42820C7A.6030704@gmx.de> <1115830592.23458.59.camel@pegasus>
In-Reply-To: <1115830592.23458.59.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15
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
Date: Wed, 11 May 2005 19:11:10 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Marcel Holtmann wrote:
> Hi Johannes,
Hi!

>>>first check /proc/bus/usb/devices.
>>I did and found nothing about the bluetooth adapter. A copy of the
>>output is enclosed.
> I doubt that it is connected otherwise then USB, but check lspci and
> dmesg for weird entries.
> 
> Does is have a hardware switch for WiFi/Bluetooth somewhere. Otherwise I
> think you need a special tool or ACPI module for it. Ask Asus or your
> manufacturer about it.

Asking Asus is IMHO pointless.
I still have a bad and nasty dispute with them going on for over two
years now. Everyone at Asus except the Asians has no clue of the
hardware they are selling :( And besides this dispute we ha d aproject
using Asus hardware and Asus promised to supply development information.
The docs they gave us were partially plain wrong and incomplete.
And besides that some of their parts are really obscure.

At least for me and a friend speaking, no Asus ever again :( They used
to be quite good but recent experience proofs this wrong.

So my tip would be: bring that thing back to your dealer and buy
something that is known to work... for notebooks I now went towards IBM,
T42p currently the best workstation alike notebook I know and fully
Linux supported. But that's another story and off-topic.

> Regards
> Marcel
CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCgjyuJXeIURG1qHgRAj99AJ45QYIeBaR+4nElBii73P7Kxd/OpwCfWxBr
voYjbFuPUoql1hF4WP9pL7Y=
=L7js
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
