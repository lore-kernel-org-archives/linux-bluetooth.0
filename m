Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Message-ID: <09D3F703EF3B0A4CBE28449EA9F3D320020AB455@nicta-atp-mail.in.nicta.com.au>
From: "Marco Candiago" <Marco.Candiago@nicta.com.au>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Strange Behaviour
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
Date: Fri, 10 Feb 2006 16:49:12 +1100


Hello,

I'm currently experiencing some strange behaviour with my embedded BT
device. =0D
I'm trying to connect to a BT enabled weight scale with a CSR V1.1 BT
chip. =0D
The weighscale is PIN enabled.

On my embedded BT device, Ican connect to the weight scale initially.
However=0D
when I disconnect and try to reconnect with hcitool I get "Can't create=0D
connection:  Input/output error.  In order to connect again to the=0D
weighscale, I have to get another BT device to connect to the
weighscale. =0D
This other BT device has no problems with multiple connections to the
weigh=0D
scale. =0D

Bellow is a dump of what I am doing.  Can any one shed any light on this

problem.  Any help would be greatly appreciated.

Marco

/ # hcitool cc 00:02:5B:00:A5:A4
/ # hcitool dc 00:02:5B:00:A5:A4
/ # hcitool cc 00:02:5B:00:A5:A4
Can't create connection: Input/output error
=0D

/ # hcidump -aV
HCI sniffer - Bluetooth packet analyzer ver 1.29
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:5B:00:A5:A4 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: PIN Code Request (0x16) plen 6
    bdaddr 00:02:5B:00:A5:A4
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
    bdaddr 00:02:5B:00:A5:A4 len 3 pin 'bsl'
> HCI Event: Command Complete (0x0e) plen 10
    PIN Code Request Reply (0x01|0x000d) ncmd 1
    status 0x00 bdaddr 00:02:5B:00:A5:A4
> HCI Event: Link Key Notification (0x18) plen 23
    bdaddr 00:02:5B:00:A5:A4 key 30BFBB49D88BB6C482C1EEE92E976903 type 0
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 41 bdaddr 00:02:5B:00:A5:A4 type ACL encrypt 0x00
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
    handle 41 policy 0x0f
    Link policy: RSWITCH HOLD SNIFF PARK
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:02:5B:00:A5:A4 mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 41 slots 5
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
    status 0x00 handle 41
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 41 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 41 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:02:5B:00:A5:A4 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1=0D
                > HCI Event: Connect Complete (0x03) plen 11
    status 0x05 handle 42 bdaddr 00:02:5B:00:A5:A4 type ACL encrypt 0x00
    Error: Authentication Failure




--------------------------------------------------------------------------
This email and any attachments may be confidential. They may contain=
 legally
privileged information or copyright material. You should not read, copy,
use or disclose them without authorisation. If you are not an intended
recipient, please contact us at once by return email and then delete both
messages. We do not accept liability in connection with computer virus,
data corruption, delay, interruption, unauthorised access or unauthorised
amendment. This notice should not be removed.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
