Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <20040821112417.59255.qmail@web40705.mail.yahoo.com>
From: George Tarantilis <milgt@yahoo.com>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Invalid Exchange..
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 21 Aug 2004 04:24:17 -0700 (PDT)

Hi all,

I'm trying to connect my Logitech MX900 mouse and I'm
getting a "Can't create HID control channel: Invalid
exchange" message.
Specifically:

[gtaranti@fedora gtaranti]$ /sbin/hciconfig
hci0:   Type: USB
        BD Address: 00:10:60:A5:11:3E ACL MTU: 192:8 
SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH ENCRYPT
        RX bytes:1063 acl:0 sco:0 events:110 errors:0
        TX bytes:828 acl:0 sco:0 commands:55 errors:0

[gtaranti@fedora gtaranti]$ hidd --search
Searching ...
        Connecting to device 00:07:61:05:65:22
Can't create HID control channel: Invalid exchange
[gtaranti@fedora gtaranti]$ hidd --connect
00:07:61:05:65:22
Can't create HID control channel: Invalid exchange

The hcidump logs the previous commands as:

HCIDump - HCI packet analyzer ver 1.10
device: hci0 snap_len: 1028 filter: 0xffffffff
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Inquiry Result (0x02) plen 15
> HCI Event: Inquiry Complete (0x01) plen 1
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
> HCI Event: Command Status (0x0f) plen 4
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Command Complete (0x0e) plen 10
> HCI Event: Connect Complete (0x03) plen 11
...


It seems that the server can see the device but cannot
connect to it.

I'm using the fedora core 2.6.8-1.521smp kernel and
the 2.9 bluez-libs and bluez-utils.

What am I doing wrong?
 


		
_______________________________
Do you Yahoo!?
Win 1 of 4,000 free domain names from Yahoo! Enter now.
http://promotions.yahoo.com/goldrush


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
