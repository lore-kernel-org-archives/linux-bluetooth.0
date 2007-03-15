Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <45F92629.4070207@endian.se>
Date: Thu, 15 Mar 2007 11:55:37 +0100
From: =?ISO-8859-1?Q?Richard_R=F6jfors?= <richard.rojfors@endian.se>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Inquiry response containing RSSI
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi everyone,

Thanks for developing this stack, it works very well I must say!

But I have ran into a small limitation:
I want to do inquiries that contains rssi in the response. (I know it
requires bluetooth >= 1.2).
I have a such dongle from CSR. I bluez from 2.6.20.1 and bluez-libs 3.9
btw. I set the inquiry mode to 1 using the bluez-libs function
hci_write_inquiry_mode.

The interesting thing is that the RSSI makes it up to the inquiry cache
inside the hci_module, but the interface (hci_inquiry, called by ioctl)
only uses the struct inquiry_info, which does not contain RSSI.

So I was thinking of a way to support this, could be to introduce
another more generic IOCTL. Which returns the struct
inquiry_info_with_rssi, or rather a struct of a new type which is the
combination of struct inquiry_info_with_rssi and struct inquiry_info.

What do you think?

- --
Richard

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (Darwin)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFF+SYp9yPqN8x056cRAm7ZAKClpMbse3jCc7eVVxVSUIEsUXHLbwCfWKJx
wmUt/xXy6yZIrI3gNTcNqjQ=
=KE3K
-----END PGP SIGNATURE-----

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
