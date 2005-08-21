Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matthias =?ISO-8859-1?Q?Gr=FCter?= <mgrueter@ee.ethz.ch>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1124653868.4816.16.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] authentication problem when pairing with headset
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
Date: Sun, 21 Aug 2005 21:51:08 +0200

I'm using a Logitech Mobile Freedom Headset with my iBook G4. I have
been using this device for some time now, but since a week or so I'm not
able to pair with my headset anymore.

Output of btsco:
# btsco -v 00:0D:44:32:D3:FF
btsco v0.4c
Device is 1:0
Error: Failed to connect to SDP server: Permission denied
Assuming channel 2

Voice setting: 0x0060
Can't connect RFCOMM channel: Permission denied


Sysconfig:
link_key_request (sba=00:0D:93:06:A6:19, dba=00:0D:44:32:D3:FF)


Output of hcidump:
# hcidump -V
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:32:D3:FF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:44:32:D3:FF
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:44:32:D3:FF key 56975B38589747E25A3B35A2F4C9399A
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:44:32:D3:FF
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 46 bdaddr 00:0D:44:32:D3:FF type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Read Voice Setting (0x03|0x0025) plen 0
> HCI Event: Command Complete (0x0e) plen 6
    Read Voice Setting (0x03|0x0025) ncmd 1
    status 0x00 voice setting 0x0060
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0D:44:32:D3:FF ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
    bdaddr 00:0D:44:32:D3:FF
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
    bdaddr 00:0D:44:32:D3:FF key 56975B38589747E25A3B35A2F4C9399A
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
    status 0x00 bdaddr 00:0D:44:32:D3:FF
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 47 bdaddr 00:0D:44:32:D3:FF type ACL encrypt 0x00
    Error: Authentication Failure

What kind of authentication failure is this? And how can I solve this
issue?

My version of the bluez-tools is 2.18.
The awkward thing is, that I'm still able to pair with other headsets
(same model) and my headset is still able to pair with other computers
or mobile phones.

I'd be glad for any kind of pointers in the right direction.



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
