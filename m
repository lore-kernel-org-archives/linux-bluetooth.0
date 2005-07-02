Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Johan Hedin <sua@home.se>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200507021912.29173.sua@home.se>
Subject: [Bluez-devel] HCI reset problem
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 2 Jul 2005 19:12:29 +0200

Hi everyone!

After spending a few days googling and browsing the e-mail archives of
bluez-devel, I need some expert help for my strange "HCI reset"/USB disconnect
problem.

This is what happens; A while after the bluetooth subsystem is started
(by started I mean that the kernel modules are loaded and that hcid and
sdpd are started), the USB dongle disconnects from the host and then
immediately reconnects again. If I have a rfcomm connection up when this
happens, I'm forced to do "rfcomm release", reload the rfcomm kernel module
and "rfcomm bind" again to be able to use /dev/rfcomm0.

The problem is 100% reproducible for me by establish a rfcomm connetion
to my cell phone and just type AT<enter> a couple of times in minicom and
then, disconnect... Even without any active rfcomm connection the
disconnect happens, it just takes a little bit longer. If I let my computer
run, the disconnet happens a couple of times per day without me doing
anyting.

My system is Fedora Core 4 (kernel 2.6.11) on a Dell Latitude X300 with
a Dell TrueMobile 300 Bluetooth built in USB dongle (CSR BlueCore02 chip).
I'm using the latest bluez-libs, bluez-utils and bluez-hcidump from bluez.org
and NOT the Fedora RPM:s (even though the problem is the same with the
Fedora supplied bluez packages)

hciconfig says the following:

[root@x300 ~]# hciconfig -a hci0 version features revision
hci0:   Type: USB
        BD Address: 00:10:C6:60:34:21 ACL MTU: 192:8 SCO MTU: 64:8
        HCI Ver: 1.2 (0x2) HCI Rev: 0x4f2 LMP Ver: 1.2 (0x2) LMP Subver: 0x4f2
        Manufacturer: Cambridge Silicon Radio (10)
        Features: 0xff 0xff 0x8f 0x78 0x18 0x18 0x00 0x80
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
                <power control> <transparent SCO> <broadcast encrypt>
                <enhanced iscan> <interlaced iscan> <interlaced pscan>
                <inquiry with RSSI> <AFH cap. slave> <AFH class. slave>
                <AFH cap. master> <AFH class. master> <extended features>
        Build 1266
        Chip version: BlueCore02-External
        Max key size: 128 bi
        SCO mapping:  HCI
        Panic code:   0x16
        Fault code:   0x1e


This is what I see when the reset happens (and yes, there are two output lines
from hcidump):

[root@x300 ~]# hcidump -t -X -V 
2005-07-02 14:09:10.093053 < HCI Command: Reset (0x03|0x0003) plen 0
2005-07-02 14:09:10.093053 < HCI Command: Reset (0x03|0x0003) plen 0


This is what the syslog says at the same moment (I have compiled hci_usb, 
rfcomm, l2cap and bluetooth with debug on):

Jul  2 14:09:10 x300 kernel: usb 3-2: USB disconnect, address 26
Jul  2 14:09:10 x300 kernel: hci_unregister_dev: e3bc4000 name hci0 type 1
Jul  2 14:09:10 x300 kernel: hci_unregister_sysfs: e3bc4000 name hci0 type 1
Jul  2 14:09:10 x300 kernel: hci_dev_do_close: hci0 e3bc4000
Jul  2 14:09:10 x300 kernel: hci_req_cancel: hci0 err 0x13
Jul  2 14:09:10 x300 kernel: inquiry_cache_flush: cache e3bc4174
Jul  2 14:09:10 x300 kernel: hci_conn_hash_flush: hdev hci0
Jul  2 14:09:10 x300 kernel: hci_sock_dev_event: hdev hci0 event 4
Jul  2 14:09:10 x300 kernel: hci_send_to_sock: hdev 00000000 len 8
Jul  2 14:09:10 x300 kernel: __hci_request: hci0 start
Jul  2 14:09:10 x300 kernel: hci_reset_req: hci0 0
Jul  2 14:09:10 x300 kernel: hci_send_cmd: hci0 ogf 0x3 ocf 0x3 plen 0
Jul  2 14:09:10 x300 kernel: hci_send_cmd: skb len 3
Jul  2 14:09:10 x300 hcid[21360]: HCI dev 0 down
Jul  2 14:09:10 x300 kernel: hci_cmd_task: hci0 cmd 1
Jul  2 14:09:10 x300 hcid[21360]: Stoping security manager 0
Jul  2 14:09:10 x300 kernel: hci_send_frame: hci0 type 1 len 3
Jul  2 14:09:10 x300 kernel: hci_send_to_sock: hdev e3bc4000 len 3
Jul  2 14:09:10 x300 kernel: hci_sock_recvmsg: sock ce652dc0, sk dba03200
Jul  2 14:09:10 x300 kernel: hci_sock_recvmsg: sock cf129440, sk d3c6dc00
Jul  2 14:09:10 x300 kernel: hci_sock_release: sock d28b2bc0 sk dbfec200
Jul  2 14:09:10 x300 kernel: __hci_request: hci0 end: err -110
Jul  2 14:09:10 x300 kernel: hci_sock_dev_event: hdev hci0 event 2
Jul  2 14:09:10 x300 kernel: hci_send_to_sock: hdev 00000000 len 8
Jul  2 14:09:10 x300 hcid[21360]: HCI dev 0 unregistered
Jul  2 14:09:10 x300 kernel: hci_sock_recvmsg: sock cf129440, sk d3c6dc00
Jul  2 14:09:10 x300 kernel: hci_sock_recvmsg: sock ce652dc0, sk dba03200

The reset shown above happend without any active rfcomm connection.

So, some questions I have:

1. What can cause a HCI reset being sent from the host to the device?

2. Is the USB disconnect a result of the HCI reset seen from hcidump or is
   the HCI reset a result of the USB disconnect (the syslog have one line
   saying hci_reset_req: hci0 0)?

3. If the HCI reset is sent as a result of some error reported by the device,
   shouldn't hcidump show some activity in the direction FROM the device TO
   the host?

4. Is this perhaps a USB problem and not a Bluetooth problem?


When I use my external Bluetooth dongle, I don't have the reset problem and
everything is working as normal. This is what hciconfig says about my external
dongle:

[root@x300 ~]# hciconfig -a hci1 version features revision
hci1:   Type: USB
        BD Address: 00:0A:9A:00:A2:56 ACL MTU: 339:4 SCO MTU: 64:0
        HCI Ver: 1.1 (0x1) HCI Rev: 0x93 LMP Ver: 1.1 (0x1) LMP Subver: 0x93
        Manufacturer: Transilica, Inc. (24)
        Features: 0xff 0xff 0x3d 0x00 0x00 0x00 0x00 0x00
                <3-slot packets> <5-slot packets> <encryption> <slot offset>
                <timing accuracy> <role switch> <hold mode> <sniff mode>
                <park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
                <HV3 packets> <u-law log> <A-law log> <CVSD> <power control>
                <transparent SCO>
        Unsupported manufacturer


Do any of you spot my problem, or can you point me in some direction
so that I can do some more debugging (perhaps where in the source to look)?

Sorry for the rather long mail, but I wanted to get as much information in
as possible :-)

Thankful for any help!

Regards Johan


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
