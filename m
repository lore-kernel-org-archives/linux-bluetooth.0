Return-Path: <cyrus@holtmann.org>
Date: Tue, 16 Dec 2014 18:24:21 +0100
From: Veseli Veseljko <veseljko75@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: ShanWan Sixaxis PS3 controller
Message-ID: <20141216172421.GA12748@ubuntu.localnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Dear bluez developers,

I have a Sony PS3 Sixaxis compatible controller made by ShanWan. Is it
possible to make it work with bluez sixaxis plugin? I tried it on Ubuntu
14.10 running Linux kernel 3.16 and bluez 5.20, compiled with sixaxis
option.

I've paired this sixaxis controller with sixpair tool. I've run
'bluetoothctl' and issued commands 'agent on', 'default-agent',
'pairable on', 'power on' and pressed 'PS' button on controller, but
didn't get sixaxis controller to pair:
 
----bluetoothctl--begin----
[NEW] Controller 00:20:E0:xx:xx:xx desktop [default]
[bluetooth]# agent on
Agent registered
[bluetooth]# default-agent 
Default agent request successful
[bluetooth]# pairable on
Changing pairable on succeeded
[bluetooth]# power on
[CHG] Controller 00:20:E0:xx:xx:xx Class: 0x00010c
Changing power on succeeded
[CHG] Controller 00:20:E0:xx:xx:xx Powered: yes
[NEW] Device 00:16:FE:xx:xx:xx 00-16-FE-xx-xx-xx
[bluetooth]# trust 00:16:FE:xx:xx:xx
[CHG] Device 00:16:FE:xx:xx:xx Trusted: yes
Changing 00:16:FE:xx:xx:xx trust succeeded
[CHG] Device 00:16:FE:xx:xx:xx Connected: no
[DEL] Device 00:16:FE:xx:xx:xx 00-16-FE-xx-xx-xx
----bluetoothctl------

In syslog I got following messages:

----/var/log/syslog--part1--begin----
bluetoothd[648]: Refusing input device connect: No such file or directory (2)
bluetoothd[648]: Refusing connection from 00:16:FE:xx:xx:xx: unknown device
----/var/log/syslog--part1--end----

I'v run 'hcidump -x' and two parts of the dump caught my attention.

Misspelled controller name 'PLAYSTATION(R)3Conteroller-VINS':

----hcidump--part1--begin----
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:16:FE:xx:xx:xx name 'PLAYSTATION(R)3Conteroller-VINS'
----hcidump--part1--end----

Bluez disconnected sixaxis controller, and then controller was refused
to connect:

----hcidump--part2--begin----
< ACL data: handle 41 flags 0x02 dlen 5
    L2CAP(d): cid 0x20ee len 1 [psm 17]
      HIDP: Control: Virtual cable unplug
< ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Disconn req: dcid 0x20ee scid 0x0040
> ACL data: handle 41 flags 0x02 dlen 12
    L2CAP(s): Connect req: psm 19 scid 0x20ef
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x20ef result 1 status 2
      Connection pending - Authorization pending
< ACL data: handle 41 flags 0x02 dlen 16
    L2CAP(s): Connect rsp: dcid 0x0041 scid 0x20ef result 3 status 0
      Connection refused - security block
----hcidump--part2--end----

It looks like 'trust 00:16:FE:xx:xx:xx' in bluetoothctl has no effect.

When I connect this sixaxis controller to USB, I got following lines in
syslog:

----/var/log/syslog--part2--begin----
usb 2-2: new full-speed USB device number 2 using uhci_hcd
usb 2-2: New USB device found, idVendor=054c, idProduct=0268
usb 2-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-2: Product: PLAYSTATION(R)3 Controller
usb 2-2: Manufacturer: ShanWan    
hidraw: raw HID events driver (C) Jiri Kosina
usbcore: registered new interface driver usbhid
usbhid: USB HID core driver
sony 0003:054C:0268.0001: Fixing up Sony Sixaxis report descriptor
sony 0003:054C:0268.0001: usb_submit_urb(ctrl) failed: -1
sony 0003:054C:0268.0001: timeout initializing reports
input: ShanWan     PLAYSTATION(R)3 Controller as /devices/pci0000:00/0000:00:1d.0/usb2/2-2/2-2:1.0/0003:054C:0268.0001/input/input13
sony 0003:054C:0268.0001: input,hiddev0,hidraw0: USB HID v1.10 Joystick [ShanWan     PLAYSTATION(R)3 Controller] on usb-0000:00:1d.0-2/input0
----/var/log/syslog--part2--end----

This sixaxis controller works as joystick input device when it is
connected to USB. It also works ower bluetooth with SHANWAN_FAKE_DS3
branch of sixad from:

https://github.com/yarick123/qtsixa/tree/feature/SHANWAN_FAKE_DS3

The problem with sixad is that it takes over bluetooth service and other
bluetooth devices can't connect when sixad is active and that is the
reason why I would like to ge it work with bluez.

Please tell me if you need any more information.

Best regards,

Veseljko
