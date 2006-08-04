Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-Id: <200608031855.50972.Bearcat@feline-soul.com>
Date: Thu, 3 Aug 2006 18:55:50 -0600
From: "Bearcat M. Sandor" <Bearcat@feline-soul.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Subject: [Bluez-users] error when starting bluetooth..any ideas?
Reply-To: Bearcat@feline-soul.com,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hello folks,

I'm still working on connecting this keyboard and headset. However i noticed 
something in my logs that is probably pertainent:
Aug  3 18:42:53 [sdpd] Bluetooth SDP daemon_
Aug  3 18:43:59 [hcid] Bluetooth HCI daemon
Aug  3 18:43:59 [hcid] Register path:/org/bluez fallback:1
Aug  3 18:43:59 [hcid] Device hci0 has been added
Aug  3 18:43:59 [hcid] Starting security manager 0
Aug  3 18:43:59 [hcid] Can't write inquiry mode for hci0: Input/output error 
(5)
Aug  3 18:43:59 [hcid] Register path:/org/bluez/hci0 fallback:0
Aug  3 18:44:38 [hidd] Bluetooth HID daemon

Note the [hcid} lines seem to have an error. I have looked all over google and 
the bluetooth mailing lists and not found anything regarding it.

Thus, the keyboard is not seen at all ("page timeout") and connecting the 
headset with hcidump gives me:
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
< HCI Command: Create Connection (0x01|0x0005) plen 13
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: Mode Change (0x14) plen 6
> HCI Event: PIN Code Request (0x16) plen 6
< HCI Command: PIN Code Request Negative Reply (0x01|0x000e) plen 6
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11

hcid.conf file: http://www.feline-soul.net/files/bluetooth/hcid.conf
rfcomm.conf file: http://www.feline-soul.net/files/bluetooth/rfcomm.conf

Ideas? I've been struggling with this for over 2 weeks now. Any help is 
appreciated.

Bearcat M. Sandor


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
