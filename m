Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <435FB0B1.6000707@cefriel.it>
From: Luca Pizzamiglio <pizzamiglio@cefriel.it>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-devel] big SCO packet
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
Date: Wed, 26 Oct 2005 18:37:05 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi to all.

I've a little question for Steven or Marcel.
In some circumstances, hcidump show me that chip receive SCO packet with
96 byte of dlen, when mtu is 64.

> SCO data: handle 41 dlen 96
> SCO data: handle 47 dlen 96
< SCO data: handle 41 dlen 48
< SCO data: handle 41 dlen 48
< SCO data: handle 47 dlen 48
< SCO data: handle 47 dlen 48

I see this behaviour with my phone or when I connect my dongle with two
devices.
With a headset, received packet dlen is always 48.

How this circumstance occurs?
Why I can't write SCO packet with dlen = 96, but always dlen < mtu?

Thanks in advance for your reply!!

Cheers,
Pizza
- -------------------------------------------
Luca Pizzamiglio
CEFRIEL - Embedded Systems Design Unit
Via Fucini, 2 - 20133 MILANO (ITALY)
Phone:		+39 02 23954 343
e-mail:		pizzamiglio@cefriel.it
ICQ:		5046978
- -------------------------------------------
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDX7CwAoUy56ORfbERAivuAJ91ujERP5Xoeyf8lI2i+Jrz7zXc2wCgwYOm
KnzD4lKWUPps7RDOOpgkwXo=
=eVuA
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
