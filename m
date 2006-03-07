Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <440D70C2.6090708@kernelconcepts.de>
From: Nils Faerber <nils.faerber@kernelconcepts.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Subject: [Bluez-users] New HCI-USB device, no MAC?
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
Date: Tue, 07 Mar 2006 12:38:42 +0100

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi!
I just acquired a new USB Bluetooth dongle.
Upon attachment it is correctly recognised as USB HCI but strangely it
does not carry any valid MAC address:

Requesting information ...
        BD Address:  11:11:11:11:11:11
        Device Name: piwi-1
        LMP Version: 1.2 (0x2) LMP Subversion: 0x1fe
        Manufacturer: Integrated System Solution Corp. (57)
        Features: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot
offset>
                <timing accuracy> <role switch> <sniff mode> <RSSI>
                <channel quality> <SCO link> <HV2 packets> <HV3 packets>
                <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO> <broadcast encrypt> <enhanced iscan>
                <interlaced iscan> <interlaced pscan> <inquiry with RSSI>
                <AFH cap. slave> <AFH cap. master> <AFH class. master>

Is this a known issue for that chipset?
In fact I bought two dongles with the same chipset (but different
casing) and both start with the above default MAC.
Is there a tool to set a valid MAC?
And if so, to which MAC should I set it?
Or would probably the Windows driver program an initial MAC if first
connected to Windows?

Hints are welcome ;)
Thanks!

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

iD8DBQFEDXDCJXeIURG1qHgRAu/2AKDx491XELi+LiPobdNdPp8lScZYBACdGH6A
HPpi1f+oidiWSOXA5XWCVN4=
=VQwz
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
