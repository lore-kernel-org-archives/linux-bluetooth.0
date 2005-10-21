Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <43591455.7070005@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-devel] dfutool - IBM X23 refuses to update ;)
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
Date: Fri, 21 Oct 2005 18:16:21 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all!
Some time ago I purchased an IBM X23 notebook (nice thing BTW) with
Bluetooth. The Bluetooth chip is, of course, a CSR one, labeled as ITSE.
IBM offers a Bluetooth firmware upgrade for it to help support of
multiple connections.
So I would like to upgrade my firmware using the dfutool. IBM's uprade
file can easily be unpacked and what you get is the, I guess, proper DFU
file for the upgrade.

Using the dfutool I can nicely backup my firmware to a file - works like
charm!
But when I try to flash the new firmware the dfutool waits a couple of
seconds at "switching device to dfu mode", then sais "Dowloading
firmware" without progress indication and then sais "Can't get status:
Broken pipe (32)".

Pity, so close but yet so far ;)

If it is of help I can provide the original and update firmware files.
Here is additonally what hciconfig tells me about my chip:

root@miu:~ # hciconfig hci0 revision
hci0:   Type: USB
        BD Address: 00:80:98:24:80:BE ACL MTU: 128:8  SCO MTU: 64:8
        HCI 11.3
        Chip version: BlueCore01b
        SCO mapping:  HCI

root@miu:~ # hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:80:98:24:80:BE ACL MTU: 128:8  SCO MTU: 64:8
        HCI Ver: 1.1 (0x1) HCI Rev: 0x73 LMP Ver: 1.1 (0x1) LMP Subver: 0x73
        Manufacturer: Cambridge Silicon Radio (10)

And this is the name of the new firmware file
	ITSE_00003_07_IBM_BDC_Firmware128_Rev310.dfu


So, does anyone have an idea how to debug or even fix this?
If yes, I would be quite glad ;)

Cheers
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDWRRUJXeIURG1qHgRAj9zAJ44uxswEeiI7QGqOs/xTTHzZxWRbgCglEIE
bH8E26NDvBvH0gev1KSCMlc=
=XgsB
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
