Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41F71444.4080404@coriand.com>
From: Franz Coriand <franz@coriand.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] setup pairing?
References: <41F5C90D.90401@coriand.com> <1106660253.8242.7.camel@pegasus>
In-Reply-To: <1106660253.8242.7.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig66F07DC6CEFADA7E74DA01F3"
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
Date: Tue, 25 Jan 2005 22:53:40 -0500

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig66F07DC6CEFADA7E74DA01F3
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann schrieb:

>Hi Franz,
>
>
>
>>I'm new in this area and I've a problem with setting up a simple key
>>pairing mechanism for bluetooth with BlueZ.
>>
>>I'd like to setup a bluetooth connection with tcp/ip between a
>>Linux-Watch (kernel 2.4.18) and a Windows XP SP2.
>>My problem is, I can access the Windows host only with the help of a key
>>pairing, because with  my current windows bluetooth driver it's not
>>possible to establish a "unsecure connection" without a keypairs.
>>
>>With the Linux-Watch and the Windows computer I can search for devices
>>and they find earch other, but the key pairing doesn't work.
>>
>>
>
>show us the output of "hcidump -x" as root while you are trying to
>connect.
>
>What kind of Windows driver is this. The Windows XP SP2 Bluetooth stack
>allows unpaired connection as long as both devices are not in security
>mode 3. What does "hciconfig -a" show you?
>
>Regards
>
>Marcel
>
>
>

Hi Marcel,

thanks for your response!

#./hciconfig -a
hci0:   Type: UART
        BD Address: 00:60:57:01:10:AE ACL MTU: 384:80  SCO MTU: 128:80
        UP RUNNING PSCAN ISCAN
        RX bytes:172 acl:0 sco:0 events:17 errors:0
        TX bytes:80 acl:0 sco:0 commands:17 errors:0
        Features: 0xff 0xff 0x09 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy:
        Link mode: SLAVE ACCEPT
        Name: 'WatchPad_15'
        Class: 0x000000
        Service Classes: Unspecified
        Device Class: Miscellaneous,
        HCI Ver: 1.1 (0x1) HCI Rev: 0xbc LMP Ver: 1.1 (0x1) LMP Subver: 0xbc
        Manufacturer: Cambridge Silicon Radio (10)
#

Problem is now, that I don't have ./hcidump cause of memory problems on
this watch.
/usr/local/bin only inlcudes the following files.

# ls -la
drwxr-xr-x    1 root     root            0 Nov 10 03:32 .
drwxr-xr-x    1 root     root            0 Nov 10 03:13 ..
-rwxr-xr-x    1 root     root        19064 Nov 10 03:13 dund
-rwx------    1 root     root          321 Nov 10 03:13 end
-rwxr-xr-x    1 root     root        15068 Nov 10 03:13 hciattach
-rwxr-xr-x    1 root     root        22636 Nov 10 03:13 hciconfig
-rwxr-xr-x    1 root     root        33220 Nov 10 03:13 hcid
-rwxr-xr-x    1 root     root        20452 Nov 10 03:13 hcitool
-rwxr-xr-x    1 root     root          507 Nov 10 03:13 keep_bluez
-rwxr-xr-x    1 root     root         7408 Nov 10 03:13 l2ping
-rwxr-xr-x    1 root     root        19008 Nov 10 03:13 pand
-rwxr-xr-x    1 root     root         3300 Nov 10 03:13 pantest
-rwxr-xr-x    1 root     root         6516 Nov 10 03:13 ppporc
-rwxr-xr-x    1 root     root        25440 Nov 10 03:13 rfcomm
-rwxr-xr-x    1 root     root        35036 Nov 10 03:13 sdpd
-rwxr-xr-x    1 root     root       117939 Nov 10 03:13 sdptool
-rwx------    1 root     root          350 Nov 10 03:13 start

I'm able to scan and l2ping to the windows xp computer!
On the windows computer I use a "D-Link DBT-120 B.4" usb bluetooth stick
with a D-Link driver (version 1.4.2.8 from the 1.4.2.10 package), cause
the original one from XP SP2 doesn't work with tihs dongle :-(

Franz

--------------enig66F07DC6CEFADA7E74DA01F3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB9xRHRct14D3a7wsRAiXjAKDgBtxsTqB8tBR7tYWps1M52hkKSgCgmutM
Cm55rOs8G8TZy57n86X06YQ=
=RIZc
-----END PGP SIGNATURE-----

--------------enig66F07DC6CEFADA7E74DA01F3--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
