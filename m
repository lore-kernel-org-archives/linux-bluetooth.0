Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Sunnan <sunnan@handgranat.org>
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain
Message-Id: <1137629054.7455.30.camel@localhost.localdomain>
Mime-Version: 1.0
Subject: [Bluez-users] Re: Apple mouse gives me various "Can't get device information"
 troubles
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
Date: Thu, 19 Jan 2006 01:04:14 +0100

Hi,
(Sorry that this message doesn't contain the thread headers; I read the
list from the web archives and am not subscribed at the moment.)

Here's the output of hcidump -X -V
HCI sniffer - Bluetooth packet analyzer ver 1.23
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:01:5F:57 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 45 bdaddr 00:0A:95:01:5F:57 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:01:5F:57 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 46 bdaddr 00:0A:95:01:5F:57 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:01:5F:57 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 47 bdaddr 00:0A:95:01:5F:57 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:01:5F:57 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 48 bdaddr 00:0A:95:01:5F:57 type ACL encrypt 0x00
    Error: Authentication Failure
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:0A:95:01:5F:57 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 45 bdaddr 00:0A:95:01:5F:57 type ACL encrypt 0x00
    Error: Authentication Failure

Sunnan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
