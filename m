Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: Miernik <miernik@ffii.org>
Message-ID: <20050529221527.10F1.1.NOFFLE@localhost.localdomain.local>
Subject: [Bluez-users] Can't create connection: Input/output error - more info
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
Date: Mon, 30 May 2005 00:15:27 +0200

Follow-up to my post a whle ago, about connecting Aplle Wireless
Keyboard to PCMCIA SPHINX PICO Card.

l2ping works: when I start it, a GTK window pops up with pin request, I
type i n a PIN, then the same PIN on the bluetooth keyboard, and then
the ping starts going as below.

szrenica:~# l2ping 00:0A:95:3E:C4:35
Ping: 00:0A:95:3E:C4:35 from 00:80:37:15:4B:AF (data size 20) ...
0 bytes from 00:0A:95:3E:C4:35 id 0 time 12.23ms
0 bytes from 00:0A:95:3E:C4:35 id 1 time 19.10ms
0 bytes from 00:0A:95:3E:C4:35 id 2 time 20.13ms
0 bytes from 00:0A:95:3E:C4:35 id 3 time 18.97ms
0 bytes from 00:0A:95:3E:C4:35 id 4 time 19.11ms
0 bytes from 00:0A:95:3E:C4:35 id 5 time 20.14ms


When running hcidump during trying to connect with hcitool, the dumps
are like this:




szrenica:~# hcidump -V
HCI sniffer - Bluetooth packet analyzer ver 1.17
device: hci0 snap_len: 1028 filter: 0xffffffff

(below while hcitool inq --flush): 

< HCI Command: Inquiry (0x01|0x0001) plen 5
> HCI Event: Command Status (0x0f) plen 4
    Inquiry (0x01|0x0001) status 0x00 ncmd 1
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:60:57:AC:BA:5B clkoffset 0x150b class 0x500204
> HCI Event: Inquiry Result (0x02) plen 15
    bdaddr 00:0A:95:3E:C4:35 clkoffset 0x177f class 0x002540
> HCI Event: Inquiry Complete (0x01) plen 1
    status 0x00


(below while hcitool cc 00:0A:95:3E:C4:35 to the Apple Wireless
Keyboard):

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x11 ncmd 1
    Error: Unsupported Feature or Parameter Value


(below while hcitool cc 00:60:57:AC:BA:5B to the other bluetooth
device):

< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x11 ncmd 1
    Error: Unsupported Feature or Parameter Value



(below while running l2ping 00:0A:95:3E:C4:35, executed a second time,
so it didn't ask for a PIN this time):



< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Link Key Request (0x17) plen 6
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
> HCI Event: Command Complete (0x0e) plen 10
    Link Key Request Reply (0x01|0x000b) ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:0A:95:3E:C4:35 type ACL encrypt 0x01
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
> HCI Event: Command Complete (0x0e) plen 6
    Write Link Policy Settings (0x02|0x000d) ncmd 1
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> HCI Event: Number of Completed Packets (0x13) plen 5
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< ACL data: handle 1 flags 0x02 dlen 28
    L2CAP(s): Echo req: dlen 20
> ACL data: handle 1 flags 0x02 dlen 8
    L2CAP(s): Echo rsp: dlen 0
< HCI Command: Disconnect (0x01|0x0006) plen 3
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 0
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
> HCI Event: Command Complete (0x0e) plen 4
    Unknown (0x00|0x0000) ncmd 1



-- 
Miernik             _________________________  xmpp:miernik@amessage.info
___________________/_______________________/      mailto:miernik@ffii.org
                       Save Europe from Software Patents
                http://www.gnu.org/philosophy/savingeurope.html



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
