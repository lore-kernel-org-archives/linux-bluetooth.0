Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: "bluez-users@lists.sourceforge.net" <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] timeout after rfcomm or pan connection
References: <20040309161702.24407.qmail@web40713.mail.yahoo.com>  <opr4mgbutyeocfdv@debian> <1078882388.30990.24.camel@pegasus>  <opr4wj0bjgeocfdv@debian> <1079358305.3405.32.camel@pegasus>
From: "Christoph Torens" <c.torens@web.de>
Content-Type: text/plain; format=flowed; delsp=yes; charset=iso-8859-15
MIME-Version: 1.0
Message-ID: <opr4zbdmyoeocfdv@debian>
In-Reply-To: <1079358305.3405.32.camel@pegasus>
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
Date: Wed, 17 Mar 2004 00:54:48 +0100

Hi,

> ask them if they use big or little endian with their Xscale.

i'll ask them, but can't I figure this out somehow manually?
(could probably be faster... ? )


> Show us the
> Bluetooth specific parts of the kernel config.


#
# USB Host Controller Drivers
#
# CONFIG_USB_EHCI_HCD is not set
# CONFIG_USB_UHCI is not set
# CONFIG_USB_UHCI_ALT is not set
# CONFIG_USB_OHCI is not set
# CONFIG_USB_OHCI_SA1111 is not set
CONFIG_USB_ISP116x=m

#
# USB Device Class drivers
#
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_EMI26 is not set

#
#   USB Bluetooth can only be used with disabled Bluetooth subsystem
#
# CONFIG_USB_MIDI is not set
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DEBUG=y
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_HP8200e=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y
# CONFIG_USB_ACM is not set
CONFIG_USB_PRINTER=m


[...]


#
# Bluetooth support
#
CONFIG_BLUEZ=m
CONFIG_BLUEZ_L2CAP=m
CONFIG_BLUEZ_SCO=m
CONFIG_BLUEZ_RFCOMM=m
CONFIG_BLUEZ_RFCOMM_TTY=y
CONFIG_BLUEZ_BNEP=m
CONFIG_BLUEZ_BNEP_MC_FILTER=y
CONFIG_BLUEZ_BNEP_PROTO_FILTER=y

#
# Bluetooth device drivers
#
CONFIG_BLUEZ_HCIUSB=m
CONFIG_BLUEZ_USB_SCO=y
CONFIG_BLUEZ_USB_ZERO_PACKET=y
CONFIG_BLUEZ_HCIUART=m
# CONFIG_BLUEZ_HCIUART_H4 is not set
CONFIG_BLUEZ_HCIUART_BCSP=y
CONFIG_BLUEZ_HCIUART_BCSP_TXCRC=y
# CONFIG_BLUEZ_HCIBFUSB is not set
# CONFIG_BLUEZ_HCIDTL1 is not set
# CONFIG_BLUEZ_HCIBT3C is not set
# CONFIG_BLUEZ_HCIBLUECARD is not set
# CONFIG_BLUEZ_HCIBTUART is not set
# CONFIG_BLUEZ_HCIVHCI is not set


hm, why does the comment say:
"USB Bluetooth can only be used with disabled Bluetooth subsystem"
?



> Run "hcidump -x" to see what is on the ACL link.

root@viper root# pand --search -Q 20 --service NAP -n
pand[320]: PAN daemon ver 1.1
pand[320]: Inquiring
pand[320]: Searching for NAP on 00:04:3E:C0:9D:79
pand[320]: Connecting to 00:04:3E:C0:9D:79
pand[320]: bnep0 connected
root@viper root# ifconfig bnep0 10.0.0.2
root@viper root# hciconfig -a
hci0:   Type: USB
         BD Address: 00:60:57:0C:88:1A ACL MTU: 192:8  SCO MTU: 64:8
         UP RUNNING PSCAN ISCAN
         RX bytes:526 acl:11 sco:0 events:39 errors:0
         TX bytes:675 acl:14 sco:0 commands:19 errors:0
         Features: 0xff 0xff 0x0b 0x00
         Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
         Link policy: HOLD SNIFF PARK
         Link mode: SLAVE ACCEPT
Can't read local name on hci0. Connection timed out(110)

*the hcidump of the above action follows*

root@viper root# hcidump -x
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Inquiry(0x01|0x0001) plen 5
   33 8B 9E 0A 0A
> HCI Event: Command Status(0x0f) plen 4
   00 01 01 04
> HCI Event: Inquiry Result(0x02) plen 15
   01 79 9D C0 3E 04 00 01 00 00 00 01 00 FD 6C
> HCI Event: Inquiry Complete(0x01) plen 1
   00
< HCI Command: Create Connection(0x01|0x0005) plen 13
   79 9D C0 3E 04 00 18 CC 01 00 FD EC 01
> HCI Event: Command Status(0x0f) plen 4
   00 01 05 04
> HCI Event: Role Change(0x12) plen 8
   00 79 9D C0 3E 04 00 01
> HCI Event: Connect Complete(0x03) plen 11
   00 28 00 79 9D C0 3E 04 00 01 00
< ACL data: handle 0x0028 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 1 scid 0x0040
< HCI Command: Write Link Policy Settings(0x02|0x000d) plen 4
   28 00 0E 00
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> HCI Event: Command Complete(0x0e) plen 6
   01 0D 08 00 28 00
> HCI Event: Max Slots Change(0x1b) plen 3
   28 00 05
> ACL data: handle 0x0028 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 12
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 17
     L2CAP(d): cid 0x40 len 13 [psm 1]
         SDP SS Req: tid 0x0 len 0x8
           pat uuid-16 0x1116 (NAP)
           max 0x1
           cont 00
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 18
     L2CAP(d): cid 0x40 len 14 [psm 1]
         SDP SS Rsp: tid 0x0 len 0x9
           cur 0x1 tot 0x1 hndl 0x804f230
           cont 00
< ACL data: handle 0x0028 flags 0x02 dlen 12
     L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040
< ACL data: handle 0x0028 flags 0x02 dlen 12
     L2CAP(s): Connect req: psm 15 scid 0x0041
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 12
     L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 16
     L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0041 result 0 status 0
< ACL data: handle 0x0028 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0040 flags 0x0000 clen 4
     MTU 39682
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0041 flags 0x0000 result 0 clen 0
> ACL data: handle 0x0028 flags 0x02 dlen 16
     L2CAP(s): Config req: dcid 0x0041 flags 0x0000 clen 4
     MTU 39682
< ACL data: handle 0x0028 flags 0x02 dlen 14
     L2CAP(s): Config rsp: scid 0x0040 flags 0x0000 result 0 clen 0
< ACL data: handle 0x0028 flags 0x02 dlen 11
     L2CAP(d): cid 0x40 len 7 [psm 15]
       BNEP: Control(0x01|0)
         Setup Req(0x01) size 0x02 dst 0x1116(NAP) src 0x1115(PANU)
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> HCI Event: Number of Completed Packets(0x13) plen 5
   01 28 00 01 00
> ACL data: handle 0x0028 flags 0x02 dlen 8
     L2CAP(d): cid 0x41 len 4 [psm 15]
       BNEP: Control(0x01|0)
         Setup Rsp(0x02) res 0x0000
< ACL data: handle 0x0028 flags 0x02 dlen 20
     L2CAP(d): cid 0x40 len 16 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x000c
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
< ACL data: handle 0x0028 flags 0x02 dlen 32
     L2CAP(d): cid 0x40 len 28 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x0018
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
           01:00:5e:00:00:01 - 01:00:5e:00:00:01
< ACL data: handle 0x0028 flags 0x02 dlen 32
     L2CAP(d): cid 0x40 len 28 [psm 15]
       BNEP: Control(0x01|0)
         Filter MultAddr Set(0x05) len 0x0018
           ff:ff:ff:ff:ff:ff - ff:ff:ff:ff:ff:ff
           01:00:5e:00:00:01 - 01:00:5e:00:00:01
< HCI Command: Read Local Name(0x03|0x0014) plen 0
Receive failed: Broken pipe

So, I don't understand this, but to me this looks very unusefull :-(
because there aren't any outputs after the last command "Read Local Name"
the last line takes VERY long ("Receive failed"). I nearly hadn't have  
seen it.

But, accidently I found something that is perhaps more wicked.
After a reboot everything works fine:
"hciconfig -a"
"hcitool scan"
but after I put hci0 down manually, I can't get it up again :-(


root@viper root# hciconfig hci0 down
root@viper root# hciconfig hci0 up
Can't init device hci0. Connection timed out(110)

root@viper root# hcidump -x
HCIDump - HCI packet analyzer ver 1.5
device: hci0 snap_len: 1028 filter: 0xffffffff
< HCI Command: Reset(0x03|0x0003) plen 0
> HCI Event: Command Complete(0x0e) plen 4
   01 03 0C 00
< HCI Command: Read Local Supported Features(0x04|0x0003) plen 0

Well, thats bad because this definitly works with the zeevo chip.
I just rechecked that.


-- 
Regards,
Christoph Torens


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
