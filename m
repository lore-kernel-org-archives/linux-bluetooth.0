Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42BABCBE.1060200@cefriel.it>
From: Luca Pizzamiglio <pizzamiglio@cefriel.it>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] btsco and Musicool 300
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
Date: Thu, 23 Jun 2005 15:44:30 +0200

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi.
I'm trying to use the Musicool 300 headset with BlueZ.
I see Marcel Holtmann reports on him site.
I have some trouble because my headset doesn't reply to my question:

~# hcitool inq
Inquiring ...
        00:0B:0D:50:15:C7       clock offset: 0x2705    class: 0x200404
~# hcitool name 00:0B:0D:50:15:C7
Headphone[15C7]
~# hcitool info 00:0B:0D:50:15:C7
Requesting information ...
Can't create connection: Connection timed out
~#

I report hcidump output:
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:0B:0D:50:15:C7 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:0B:0D:50:15:C7 name 'Headphone[15C7]'

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0B:0D:50:15:C7 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0B:0D:50:15:C7
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:0B:0D:50:15:C7 type ACL encrypt 0x00
    Error: LMP Response Timeout

When I try to connect btsco with the headset, I obtain:

~# btsco 00:0B:0D:50:15:C7
Error: Failed to connect to SDP server: Function not implemented
Assuming channel 2

Can't connect RFCOMM channel: Resource temporarily unavailable
~#

and the hcidump output is:

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0B:0D:50:15:C7 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0B:0D:50:15:C7
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 41 bdaddr 00:0B:0D:50:15:C7 type ACL encrypt 0x00
    Error: LMP Response Timeout
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0B:0D:50:15:C7 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:0B:0D:50:15:C7
> HCI Event: Connect Complete (0x03) plen 11
    status 0x22 handle 42 bdaddr 00:0B:0D:50:15:C7 type ACL encrypt 0x00
    Error: LMP Response Timeout


pin helper application doesn't start in both cases.
Any ideas or suggestions?

thx in advance!

PS: with the same system, I've configured a working NAP, so my bluetooth
dongle is ok.

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

iD8DBQFCury+AoUy56ORfbERAhTqAJ9Ggtu5FOHRaCW9cRp2DQa7KhAHRwCfaKpS
UMnl3vEsOk8sYwHQAuDy3AU=
=HxsQ
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
