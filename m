Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <427CD50D.2010906@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] pushing objects
References: <20050507142120.GT4344@vanheusden.com>
In-Reply-To: <20050507142120.GT4344@vanheusden.com>
Content-Type: text/plain; charset=ISO-8859-1
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
Date: Sat, 07 May 2005 16:47:41 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Folkert van Heusden wrote:
> Hi,
Hi!

> Are there any tools for pushing a businesscard/vcard (or whatever it
> is called in english) to a bluetooth device?

The best tool I found by now is the gome-bluetooth package which
contains a very nicely working bluetooth-obex-server und
bluetooth-obex-client.
For Debian use this apt source line
	deb http://debian.usefulinc.com/gnome ./
Install the package
	gnome-bluetooth

You should then be able to send a vCard (or any other file object) to a
bluetooth device using
	gnome-obex-send -d <bdaddr> <file>

and you can start your Obex server locally simply by running
	gnome-obex-server

and then you can receive objects back.

Cool, isn't it ;)

> Folkert van Heusden
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

iD8DBQFCfNUNJXeIURG1qHgRAi1OAKCAmUUqo0dVkr+dRC2bym+NdxYLRACg4BM7
MTVnc8k0vk90ZSeZBJ4hY5A=
=ou4H
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
