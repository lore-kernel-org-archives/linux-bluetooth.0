Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Invalid Exchange..
From: Marcel Holtmann <marcel@holtmann.org>
To: George Tarantilis <milgt@yahoo.com>
Cc: bluez-users@lists.sourceforge.net
In-Reply-To: <20040821112417.59255.qmail@web40705.mail.yahoo.com>
References: <20040821112417.59255.qmail@web40705.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1093089124.3385.1.camel@notepaq>
Mime-Version: 1.0
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
Date: Sat, 21 Aug 2004 13:52:04 +0200

Hi George,

> I'm trying to connect my Logitech MX900 mouse and I'm
> getting a "Can't create HID control channel: Invalid
> exchange" message.
> Specifically:
> 
> [gtaranti@fedora gtaranti]$ /sbin/hciconfig
> hci0:   Type: USB
>         BD Address: 00:10:60:A5:11:3E ACL MTU: 192:8 
> SCO MTU: 64:8
>         UP RUNNING PSCAN ISCAN AUTH ENCRYPT
>         RX bytes:1063 acl:0 sco:0 events:110 errors:0
>         TX bytes:828 acl:0 sco:0 commands:55 errors:0
> 
> [gtaranti@fedora gtaranti]$ hidd --search
> Searching ...
>         Connecting to device 00:07:61:05:65:22
> Can't create HID control channel: Invalid exchange
> [gtaranti@fedora gtaranti]$ hidd --connect
> 00:07:61:05:65:22
> Can't create HID control channel: Invalid exchange
> 
> The hcidump logs the previous commands as:
> 
> HCIDump - HCI packet analyzer ver 1.10
> device: hci0 snap_len: 1028 filter: 0xffffffff
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Inquiry Result (0x02) plen 15
> > HCI Event: Inquiry Complete (0x01) plen 1
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Connect Complete (0x03) plen 11
> > HCI Event: Command Status (0x0f) plen 4
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Command Complete (0x0e) plen 10
> > HCI Event: Connect Complete (0x03) plen 11
> ...
> 
> 
> It seems that the server can see the device but cannot
> connect to it.
> 
> I'm using the fedora core 2.6.8-1.521smp kernel and
> the 2.9 bluez-libs and bluez-utils.

run "hcidump -x" as root and lets see what it shows. Do you enabled
security mode 3? It won't work with a CSR based mouse.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
