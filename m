Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <41AAD7D2.4000902@avantwave.com>
From: mike <mikelee@avantwave.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: [Bluez-users] about link key
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
Date: Mon, 29 Nov 2004 16:03:30 +0800

Dear all

    I am new to this place, if i make anything wrong please fix me. And 
thanks for any help.

    I am using bluez lib-2.6 util-2.6 hcidump-1.8 in ARM9 platiform. 
Because of my devel-board with no input device, so i hardcode the pin 
"0000" to /etc/bluetooth/pin,  and bluepin script with echo "PIN:0000" 
only. When i pair the device with my computer USB dongle, it goes no 
problems. Pin code passed and link_key saved
    But when i use rfcomm connect to my computer from the device, 
hcidump state that link_key_negative_reply and ask for pin code again, 
then i input the pin code in my computer . Finally , rfcomm output 
"Can't connect RFCOMM socket: Connection refused"

This is linkkey generated in etc/bluetooth/link_key, the first 12 bytes 
is the device bdaddr and computer bdaddr.
0000000 496a e001 0008 1568 07cb 000e 3eef 19bf
0000010 02fd b3df 7994 db7d d26a 17f3 fc00 bfff
0000020 13ed 0000

hcidump
 > HCI Event: PIN Code Request(0x16) plen 6
  68 15 CB 07 0E 00
< HCI Command: PIN Code Request Reply(0x01|0x000d) plen 23
  68 15 CB 07 0E 00 04 30 30 30 30 00 00 00 00 00 00 00 00 00
  00 00 00
 > HCI Event: Command Complete(0x0e) plen 10
  01 0D 04 00 68 15 CB 07 0E 00
 > HCI Event: Link Key Notification(0x18) plen 23
  68 15 CB 07 0E 00 EF 3E BF 19 FD 02 DF B3 94 79 7D DB 6A D2
  F3 17 00
 > HCI Event: Connect Complete(0x03) plen 11
  00 2A 00 68 15 CB 07 0E 00 01 00


best regard
Mike,Lee


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
