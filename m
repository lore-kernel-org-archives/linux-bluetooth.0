Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41F5C90D.90401@coriand.com>
From: Franz Coriand <franz@coriand.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE10FD2946035BDFDE0BE434A"
Subject: [Bluez-users] setup pairing?
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
Date: Mon, 24 Jan 2005 23:20:29 -0500

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE10FD2946035BDFDE0BE434A
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

I'm new in this area and I've a problem with setting up a simple key
pairing mechanism for bluetooth with BlueZ.

I'd like to setup a bluetooth connection with tcp/ip between a
Linux-Watch (kernel 2.4.18) and a Windows XP SP2.
My problem is, I can access the Windows host only with the help of a key
pairing, because with  my current windows bluetooth driver it's not
possible to establish a "unsecure connection" without a keypairs.

With the Linux-Watch and the Windows computer I can search for devices
and they find earch other, but the key pairing doesn't work.

I wrote a /etc/bluetooth/hcid.conf-file:

##########begin
# HCI daemon configuration file.
#
#
options {
        autoinit yes;
        security auto;
        pairing multi;
        pin_helper /etc/bluetooth/givepin;
}
###########end

and loaded this file with "/usr/local/bin/hcid -f /etc/bluetooth/hcid.conf"!
"/etc/bluetooth/givepin" rights are 710 and looks like:

#####givepin######
#!/bin/sh
echo "PIN:0000"
################

But it still doesn't work - any idea?

Software:
bluez-libs-2.4.
bluez-pan-1.1
bluez-sdp-1.2
bluez-utils-2.3

Bye,
Franz

--------------enigE10FD2946035BDFDE0BE434A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9ckQRct14D3a7wsRAqbPAJ4xvFc7Jc6Suqini59IQDlwRqQJ1gCguJIJ
h/L4iX48srPyew578ZQGBDk=
=aoyE
-----END PGP SIGNATURE-----

--------------enigE10FD2946035BDFDE0BE434A--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
