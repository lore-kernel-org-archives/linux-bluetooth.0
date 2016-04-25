Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f6724251-c1d6-aae2-ad00-0177998396d3@gmail.com>
References: <f6724251-c1d6-aae2-ad00-0177998396d3@gmail.com>
Date: Mon, 25 Apr 2016 13:26:18 +0100
Message-ID: <CAOS+5GH2VkhqCqoMFKPdOik=7dwLYTd780DHVvqGDRs9m95SEg@mail.gmail.com>
Subject: Re: Unable to pair Logitech MX Anywhere 2
From: Another Sillyname <anothersname@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Joern

Is the receiver acting in HID mode?

http://www.0xf8.org/2014/02/flashing-the-d-link-dbt-120-to-become-a-hid-proxy-capable-usb-bluetooth-adapter/

I'm using Microsoft 8000 Bluetooth/Mouse combo's in conjunction with
DBT-120's on triple boot setups (also works with BIOS) Win7, Win10 and
Fedora.

Whatever I boot into the Keyboard and Mouse are seen properly and act
accordingly.

Hope this helps.



On 22 April 2016 at 11:34, Joern Koerner <joern.koerner@gmail.com> wrote:
> I just bought a new mouse, a Logitech MX Anywhere 2 because on my Laptop
> I need to dual-boot between Arch and Windows and this mouse supports up
> to three profiles/devices.
>
> The MX Anywhere 2 mouse is a bluetooth 4 LE device, the Laptop a Dell
> E7440 (00:19.0 Ethernet controller: Intel Corporation Ethernet
> Connection I218-LM (rev 04))
>
> Running Windows there is no problem at all.
>
> Running Arch (KDE5) the mouse shows as "Type unknown" but "Paired" but
> the mouse does not work at all.
>
> Version information: bluez-5.39-1
>
> Investigating the things on the console I get the following:
> # hciconfig hci0
> hci0:   Type: BR/EDR  Bus: USB
>         BD Address: 0C:8B:FD:EA:A7:67  ACL MTU: 1021:5  SCO MTU: 96:5
>         UP RUNNING PSCAN ISCAN
>         RX bytes:1580 acl:0 sco:0 events:189 errors:0
>         TX bytes:29212 acl:0 sco:0 commands:184 errors:0
>
> # bluetoothctl
> [NEW] Controller 0C:8B:FD:EA:A7:67 E7440 [default]
> [bluetooth]# power on
> Changing power on succeeded
> [bluetooth]# scan on
> Discovery started
> [CHG] Controller 0C:8B:FD:EA:A7:67 Discovering: yes
> [NEW] Device C0:D3:2A:76:D3:A1 MX Anywhere 2
> [bluetooth]# pair C0:D3:2A:76:D3:A1
> Attempting to pair with C0:D3:2A:76:D3:A1
> Failed to pair: org.bluez.Error.AuthenticationRejected
> [bluetooth]# trust C0:D3:2A:76:D3:A1
> [CHG] Device C0:D3:2A:76:D3:A1 Trusted: yes
> Changing C0:D3:2A:76:D3:A1 trust succeeded
> [bluetooth]# pair C0:D3:2A:76:D3:A1
> Attempting to pair with C0:D3:2A:76:D3:A1
> Failed to pair: org.bluez.Error.AuthenticationRejected
> [bluetooth]# connect C0:D3:2A:76:D3:A1
> Attempting to connect to C0:D3:2A:76:D3:A1
> Failed to connect: org.bluez.Error.Failed
> The kernel shows up this message
> Apr 21 12:03:40 E7440 kernel: Bluetooth: HCI request failed to create LE
> connection: status 0x0c
>
>
> The hcidump is here:
> HCI sniffer - Bluetooth packet analyzer ver 5.39
> device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
> ^[[A^[[A^[[A< HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Add Device To White List (0x08|0x0011) ncmd 1
>     status 0x00
> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>     type 0x00 (passive)
>     interval 60.000ms window 30.000ms
>     own address: 0x00 (Public) policy: white list only
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Set Scan Parameters (0x08|0x000b) ncmd 1
>     status 0x00
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>     value 0x01 (scanning enabled)
>     filter duplicates 0x01 (enabled)
>> HCI Event: Command Complete (0x0e) plen 4
>     LE Set Scan Enable (0x08|0x000c) ncmd 2
>     status 0x00
>> HCI Event: LE Meta Event (0x3e) plen 38
>     LE Advertising Report
>       ADV_IND - Connectable undirected advertising (0)
>       bdaddr C0:D3:2A:76:D3:A1 (Random)
>       Flags: 0x05
>       Unknown type 0x19 with 2 bytes data
>       Complete service classes: 0x1812
>       Complete local name: 'MX Anywhere 2'
>       RSSI: -43
> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>
>     value 0x00 (scanning disabled)
>
>     filter duplicates 0x00 (disabled)
>
>> HCI Event: Command Complete (0x0e) plen 4
>
>     LE Set Scan Enable (0x08|0x000c) ncmd 2
>
>     status 0x00
>
> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>
>     bdaddr C0:D3:2A:76:D3:A1 type 1
>
>     interval 96 window 96 initiator_filter 0
>
>     own_bdaddr_type 0 min_interval 40 max_interval 56
>
>     latency 0 supervision_to 42 min_ce 0 max_ce 0
>
>> HCI Event: Command Status (0x0f) plen 4
>
>     LE Create Connection (0x08|0x000d) status 0x00 ncmd 2
>> HCI Event: LE Meta Event (0x3e) plen 19
>     LE Connection Complete
>       status 0x00 handle 3585, role master
>       bdaddr C0:D3:2A:76:D3:A1 (Random)
> < HCI Command: LE Read Remote Used Features (0x08|0x0016) plen 2
>> HCI Event: Command Status (0x0f) plen 4
>     LE Read Remote Used Features (0x08|0x0016) status 0x00 ncmd 1
>> HCI Event: LE Meta Event (0x3e) plen 12
>     LE Read Remote Used Features Complete
>       status 0x00 handle 3585
>       Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: MTU req (0x02)
>       client rx mtu 517
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 7
>     ATT: MTU resp (0x03)
>       server rx mtu 23
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Group req (0x10)
>       start 0x0001, end 0xffff
>       type-uuid 0x2800
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 24
>     ATT: Read By Group resp (0x11)
>       attr handle 0x0001, end group handle 0x0007
>       value 0x00 0x18
>       attr handle 0x0008, end group handle 0x000b
>       value 0x01 0x18
>       attr handle 0x000c, end group handle 0x001a
>       value 0x0a 0x18
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Group req (0x10)
>       start 0x001b, end 0xffff
>       type-uuid 0x2800
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 18
>     ATT: Read By Group resp (0x11)
>       attr handle 0x001b, end group handle 0x001e
>       value 0x0f 0x18
>       attr handle 0x001f, end group handle 0x003e
>       value 0x12 0x18
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Group req (0x10)
>       start 0x003f, end 0xffff
>       type-uuid 0x2800
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 26
>     ATT: Read By Group resp (0x11)
>       attr handle 0x003f, end group handle 0xffff
>       value 0x6d 0x04 0x00 0x20 0x1f 0x01 0x00 0x80 0x00 0x10 0x00 0x00
> 0x00 0x00 0x01 0x00
> < ACL data: handle 3585 flags 0x00 dlen 9
>     ATT: Write req (0x12)
>       handle 0x000b value  0x02 0x00
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 5
>     ATT: Write resp (0x13)
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x0003
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 18
>     ATT: Read resp (0x0b)
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x0005
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 7
>     ATT: Read resp (0x0b)
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x001a
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 12
>     ATT: Read resp (0x0b)
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Type req (0x08)
>       start 0x001f, end 0x003e
>       type-uuid 0x2803
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 27
>     ATT: Read By Type resp (0x09)
>       length: 7
>         handle 0x0020, value 0x02 0x21 0x00 0x4a 0x2a
>         handle 0x0022, value 0x12 0x23 0x00 0x22 0x2a
>         handle 0x0025, value 0x0e 0x26 0x00 0x32 0x2a
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Type req (0x08)
>       start 0x0026, end 0x003e
>       type-uuid 0x2803
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 27
>     ATT: Read By Type resp (0x09)
>       length: 7
>         handle 0x0027, value 0x12 0x28 0x00 0x33 0x2a
>         handle 0x002a, value 0x02 0x2b 0x00 0x4b 0x2a
>         handle 0x002c, value 0x12 0x2d 0x00 0x4d 0x2a
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Type req (0x08)
>       start 0x002d, end 0x003e
>       type-uuid 0x2803
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 27
>     ATT: Read By Type resp (0x09)
>       length: 7
>         handle 0x0030, value 0x12 0x31 0x00 0x4d 0x2a
>         handle 0x0034, value 0x12 0x35 0x00 0x4d 0x2a
>         handle 0x0038, value 0x0e 0x39 0x00 0x4d 0x2a
> < ACL data: handle 3585 flags 0x00 dlen 11
>     ATT: Read By Type req (0x08)
>       start 0x0039, end 0x003e
>       type-uuid 0x2803
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 20
>     ATT: Read By Type resp (0x09)
>       length: 7
>         handle 0x003b, value 0x04 0x3c 0x00 0x4c 0x2a
>         handle 0x003d, value 0x06 0x3e 0x00 0x4e 0x2a
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x002b
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 9
>     ATT: Error (0x01)
>       Error: Insufficient authentication (5)
>       Read req (0x0a) on handle 0x002b
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x002b
>> ACL data: handle 3585 flags 0x02 dlen 9
>     ATT: Error (0x01)
>       Error: Insufficient authentication (5)
>       Read req (0x0a) on handle 0x002b
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x002b
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 9
>     ATT: Error (0x01)
>       Error: Insufficient authentication (5)
>       Read req (0x0a) on handle 0x002b
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x002b
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>> ACL data: handle 3585 flags 0x02 dlen 9
>     ATT: Error (0x01)
>       Error: Insufficient authentication (5)
>       Read req (0x0a) on handle 0x002b
> < ACL data: handle 3585 flags 0x00 dlen 7
>     ATT: Read req (0x0a)
>       handle 0x002b
>> HCI Event: Number of Completed Packets (0x13) plen 5
>     handle 3585 packets 1
>
> ... and so on until it timeouts.
>
>
> Any advice/help or whatever would be appreciated.
>
>
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
