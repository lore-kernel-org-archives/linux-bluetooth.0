Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41FB066B.3080904@coriand.com>
From: Franz Coriand <franz@coriand.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] scanning possible, but no l2ping?
References: <41FB0236.3030600@coriand.com> <1106969620.10580.23.camel@pegasus>
In-Reply-To: <1106969620.10580.23.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0FE9479CC4838DCA75FFAFE4"
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
Date: Fri, 28 Jan 2005 22:43:39 -0500

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0FE9479CC4838DCA75FFAFE4
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

Marcel Holtmann schrieb:

>>My problem with my two bluetooth adapter is, it's possible to scan the
>>area und I get the right result, but it isn't possible to execute l2ping?
>>I've a desktop computer and my crappy linux watch ... only with the
>>desktop i've hcidump yet.
>>I hope it is something with the config wrong?!
>>
>>Franz
>>
>>DESKTOP:
>>========
>>
>>[root@dervish root]# hciconfig -a
>>hci0:   Type: USB
>>        BD Address: 00:0F:3D:0B:EE:6C ACL MTU: 192:8  SCO MTU: 64:8
>>        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>>        RX bytes:1004 acl:0 sco:0 events:31 errors:0
>>        TX bytes:379 acl:0 sco:0 commands:21 errors:0
>>        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
>>        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
>>        Link policy: HOLD SNIFF PARK
>>        Link mode: ACCEPT MASTER
>>        Name: 'dervish-0'
>>        Class: 0x120104
>>        Service Classes: Networking, Object Transfer
>>        Device Class: Computer, Desktop workstation
>>        HCI Ver: 1.1 (0x1) HCI Rev: 0x20d LMP Ver: 1.1 (0x1) LMP Subver:
>>0x20d
>>        Manufacturer: Cambridge Silicon Radio (10)
>>
>>[root@dervish root]# hcitool scan
>>Scanning ...
>>        00:60:57:01:10:AE       WatchPad_15
>>
>>[root@dervish root]# l2ping 00:60:57:01:10:AE
>>Can't connect.: Connection timed out
>>
>>hcidump (desktop) during  try to execute l2ping from desktop to watch:
>>------------------------------------------------------------------------
>>[root@dervish sbin]# ./hcidump
>>HCIDump - HCI packet analyzer ver 1.5
>>device: hci0 snap_len: 1028 filter: 0xffffffff
>>
>>
>>< HCI Command: Create Connection(0x01|0x0005) plen 13
>> > HCI Event: Command Status(0x0f) plen 4
>> > HCI Event: Link Key Request(0x17) plen 6
>> > HCI Event: Connect Complete(0x03) plen 11
>>
>>
Securty Mode 3 is not safty, isn't it ;) My problem is, I need a f***
connection between Watch and computer for a special live-demo in a
closed lab.
And the next problem is that pairing doesn't work with the watch, so I
turned everything off. So all I need is just a connection to send tcp
packages - I don't care about the secury.

... hcid is running ...

[root@dervish root]# ps -afe | grep -v grep | grep -i hcid
root      2374     1  0 19:46 ?        00:00:00 hcid: processing events

Franz

--------------enig0FE9479CC4838DCA75FFAFE4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB+wZsRct14D3a7wsRAq4gAJwK2YpAQ/8A1wi7DpGF/Pzs5WAHowCffHiD
6BEiUQgoaXPMC6qYriPUr54=
=59xn
-----END PGP SIGNATURE-----

--------------enig0FE9479CC4838DCA75FFAFE4--


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
