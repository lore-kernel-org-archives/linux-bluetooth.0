Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <430F2C70.5090601@gulik.org>
From: Gregory Gulik <greg@gulik.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Trouble with D-LINK adapter w/Treo 650 and FC4
References: <430D4681.80609@gulik.org> <1124996595.8019.58.camel@pegasus>
In-Reply-To: <1124996595.8019.58.camel@pegasus>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Fri, 26 Aug 2005 09:51:28 -0500

The bluez version in FC4 are:

bluez-hcidump-1.18-1
bluez-utils-2.15-7
bluez-pin-0.24-2
bluez-bluefw-1.0-6
bluez-libs-2.15-1
bluez-utils-cups-2.15-7


And here is the contents of hcidump -X -V:

HCI sniffer - Bluetooth packet analyzer ver 1.18
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Create Connection (0x01|0x0005) plen 13
     bdaddr 00:07:E0:03:D3:99 ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
     Packet type: DM1 DM3 DM5 DH1 DH3 DH5
 > HCI Event: Command Status (0x0f) plen 4
     Create Connection (0x01|0x0005) status 0x00 ncmd 1
 > HCI Event: Link Key Request (0x17) plen 6
     bdaddr 00:07:E0:03:D3:75
< HCI Command: Link Key Request Reply (0x01|0x000b) plen 22
     bdaddr 00:07:E0:03:D3:99
     Link key: 5e937eccd8e812c626964b66cd838bce
 > HCI Event: Command Complete (0x0e) plen 10
     Link Key Request Reply (0x01|0x000b) ncmd 1
     status 0x00 bdaddr 00:07:E0:03:D3:99
 > HCI Event: Connect Complete (0x03) plen 11
     status 0x00 handle 41 bdaddr 00:07:E0:03:D3:99 type ACL encrypt 0x01
< ACL data: handle 41 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 3 scid 0x0040
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
     handle 41 policy 0x0f
     Link policy: RSWITCH HOLD SNIFF PARK
 > HCI Event: Number of Completed Packets (0x13) plen 5
     handle 41
 > HCI Event: Max Slots Change (0x1b) plen 3
   0000: 29 00 05                                          )..
 > HCI Event: Command Complete (0x0e) plen 6
     Write Link Policy Settings (0x02|0x000d) ncmd 1
     status 0x00 handle 41
 > HCI Event: Disconn Complete (0x05) plen 4
     status 0x00 handle 41 reason 0x13
     Reason: Remote User Teminated Connection


Marcel Holtmann wrote:
> what version of bluez-utils is installed with your FC4? Provide us with
> a "hcidump -X -V" for that failure.

-- 
Greg Gulik                                 http://www.gulik.org/greg/
greg @ gulik.org



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
