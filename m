Return-Path: <cyrus@holtmann.org>
From: M.E.M.Lijding@ewi.utwente.nl
MIME-Version: 1.0
Date: Tue, 11 Dec 2007 15:08:36 +0100
Message-ID: <FA783DEE7533904091C5F59BF22169ADFCC34A@EWIEX12.dynamic.ewi.utwente.nl>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] Problems opening L2CAP connections concurrently
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
 
I'm trying to open concurrently L2CAP connections to different Bluetooth
devices. What I experience is that opening the connection occurs in a
sequential manner. This becomes a problem especially when a device is
not in range, because then the other connection requests get delayed by
the page timeout. 
 
I should like to know if this is a problem of Bluetooth, BlueZ, the
firmware (I've tried Belkin F8T012 and FT8012xx1) or something else?
 
Do you have any suggestions to solve the problem? 
 
Here is the output of hcidump of a program with 4 threads each trying to
open a connection to a different device. Only one device was available
(the one corresponding to the third thread launched 39 C7 06 E4 18 00).
The page timeout is set to 6.25 seconds.
 
sudo hcidump -tx
HCI sniffer - Bluetooth packet analyzer ver 1.39
device: hci0 snap_len: 1028 filter: 0xffffffff
1197140124.182914 < HCI Command: Create Connection (0x01|0x0005) plen 13
  8B C9 06 E4 18 00 18 CC 02 00 00 00 01
1197140124.185025 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
1197140124.185892 < HCI Command: Create Connection (0x01|0x0005) plen 13
  8A C9 06 E4 18 00 18 CC 02 00 00 00 01
1197140124.188024 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
1197140124.188051 < HCI Command: Create Connection (0x01|0x0005) plen 13
  39 C7 06 E4 18 00 18 CC 02 00 00 00 01
1197140124.191024 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
1197140124.191063 < HCI Command: Create Connection (0x01|0x0005) plen 13
  8D C9 06 E4 18 00 18 CC 02 00 00 00 01
1197140124.194022 > HCI Event: Command Status (0x0f) plen 4
  00 01 05 04
1197140130.447228 > HCI Event: Connect Complete (0x03) plen 11
  04 0C 00 8B C9 06 E4 18 00 01 00
1197140136.703435 > HCI Event: Connect Complete (0x03) plen 11
  04 0D 00 8A C9 06 E4 18 00 01 00
1197140140.217989 > HCI Event: Connect Complete (0x03) plen 11
  00 0B 00 39 C7 06 E4 18 00 01 00
1197140140.218021 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 1 scid 0x0040
1197140140.218031 < HCI Command: Read Remote Supported Features
(0x01|0x001b) plen 2
  0B 00
1197140140.220989 > HCI Event: Command Status (0x0f) plen 4
  00 01 1B 04
1197140140.221011 < HCI Command: Write Link Policy Settings
(0x02|0x000d) plen 4
  0B 00 0F 00
1197140140.221987 > HCI Event: Read Remote Supported Features (0x0b)
plen 11
  00 0B 00 FC FE 0F 80 0B A8 00 00
1197140140.223985 > HCI Event: Command Complete (0x0e) plen 6
  01 0D 08 00 0B 00
1197140140.223999 < HCI Command: Remote Name Request (0x01|0x0019) plen
10
  39 C7 06 E4 18 00 02 00 00 00
1197140140.226984 > HCI Event: Command Status (0x0f) plen 4
  00 01 19 04
1197140140.382966 > HCI Event: Remote Name Req Complete (0x07) plen 255
  00 39 C7 06 E4 18 00 50 53 33 2D 4D 41 58 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
1197140140.386986 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 1 status 2
      Connection pending - Authorization pending
1197140140.387968 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0048 scid 0x0040 result 0 status 0
      Connection successful
1197140140.387986 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Config req: dcid 0x0048 flags 0x00 clen 0
1197140140.428962 > ACL data: handle 11 flags 0x02 dlen 14
    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 0
      Success
1197140140.429967 > ACL data: handle 11 flags 0x02 dlen 16
    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4
      MTU 48
1197140140.430001 < ACL data: handle 11 flags 0x02 dlen 18
    L2CAP(s): Config rsp: scid 0x0048 flags 0x00 result 0 clen 4
      Success
      MTU 48
1197140140.430907 < ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x0048 scid 0x0040
1197140140.470963 > HCI Event: Number of Completed Packets (0x13) plen 5
  01 0B 00 04 00
1197140140.470973 > ACL data: handle 11 flags 0x02 dlen 12
    L2CAP(s): Disconn rsp: dcid 0x0048 scid 0x0040
1197140142.469105 < HCI Command: Disconnect (0x01|0x0006) plen 3
  0B 00 13
1197140142.471701 > HCI Event: Command Status (0x0f) plen 4
  00 01 06 04
1197140142.650681 > HCI Event: Disconn Complete (0x05) plen 4
  00 0B 00 16
1197140146.126239 > HCI Event: Connect Complete (0x03) plen 11
  04 0E 00 8D C9 06 E4 18 00 01 00

 
Best regards,
 
Maria

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
