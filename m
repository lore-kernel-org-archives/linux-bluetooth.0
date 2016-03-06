Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Message-ID: <1457280149.2961.1.camel@salo.salonseutu.fi>
Subject: hci connection problem
From: Kari Lehtinen <karit.lehtinen@salo.salonseutu.fi>
To: linux-bluetooth@vger.kernel.org
Date: Sun, 06 Mar 2016 18:02:29 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I'm using bluez 5.36 in Fedora 23 and try to make a hci connection to
Nokia E5 or Adeunis ARF-BTC2 BT module from my desktop. The connection
attempts fail. I start with 'hcitool scan' and get a correct response
from both. To check the status I also run 'hcitool name <addr>' and,
again, get a correct response from both. When running 'hcitool info
<addr>' as a root I also get good responses that I assume to be valid.
However, running 'hcitool cc <addr>' does not succeed. I get no error
message but when checking with 'hcitool rssi <addr>' I get the response
"No connection" in both cases. Then, I switch to bluetoothctl and run
successfully the commands scan and info. But again, when trying to
connect I don't succeed. The response I get is the following:

 [bluetooth]# connect 04:A8:2A:17:A8:18
Attempting to connect to 04:A8:2A:17:A8:18
[CHG] Device 04:A8:2A:17:A8:18 Connected: yes
Failed to connect: org.bluez.Error.Failed
[CHG] Device 04:A8:2A:17:A8:18 Connected: no
[CHG] Device 04:A8:2A:17:A8:18 Connected: yes
[CHG] Device 04:A8:2A:17:A8:18 Connected: no

So, somehow it promises but eventually fails. I have checked with 'ps
-e' that both bluetoothd and dbus-daemon are up and the result is
positive. Also, I checked with systemctl the status of
bluetooth.service and it seems to be OK as well although there seems to
be one failure that may tell something, I'm not sure:

------------------------

bluetooth.service - Bluetooth service
   Loaded: loaded (/usr/lib/systemd/system/bluetooth.service; enabled;
vendor preset: enabled)
   Active: active (running) since Sun 2016-02-28 18:53:18 EET; 5s ago
     Docs: man:bluetoothd(8)
 Main PID: 4332 (bluetoothd)
   Status: "Running"
   CGroup: /system.slice/bluetooth.service
           └─4332 /usr/libexec/bluetooth/bluetoothd

Feb 28 18:53:18 Alpha60 systemd[1]: Starting Bluetooth service...
Feb 28 18:53:18 Alpha60 bluetoothd[4332]: Bluetooth daemon 5.36
Feb 28 18:53:18 Alpha60 systemd[1]: Started Bluetooth service.
Feb 28 18:53:18 Alpha60 bluetoothd[4332]: Starting SDP server
Feb 28 18:53:18 Alpha60 bluetoothd[4332]: Bluetooth management
interface 1.10 initialized
Feb 28 18:53:18 Alpha60 bluetoothd[4332]: Failed to obtain handles for
"Service Changed" characteristic
Feb 28 18:53:18 Alpha60 bluetoothd[4332]: Endpoint registered:
sender=:1.50 path=/MediaEndpoint/A2DPSource
Feb 28 18:53:18 Alpha60 bluetoothd[4332]: Endpoint registered:
sender=:1.50 path=/MediaEndpoint/A2DPSink

-------------------

This is an example of hcidump data of one of those hcitool cc <addr>-
trials:

-------------------

< HCI Command: Create Connection (0x01|0x0005) plen 13
    bdaddr 00:18:B2:03:15:ED ptype 0xcc18 rswitch 0x01 clkoffset 0x0000
    Packet type: DM1 DM3 DM5 DH1 DH3 DH5 
> HCI Event: Command Status (0x0f) plen 4
    Create Connection (0x01|0x0005) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 71 bdaddr 00:18:B2:03:15:ED type ACL encrypt
0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 71
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 0
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:18:B2:03:15:ED mode 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 71 slots 5
> HCI Event: Command Status (0x0f) plen 4
    Unknown (0x00|0x0000) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 71
    Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 71 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 71 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:18:B2:03:15:ED mode 2 clkoffset 0x0000
< ACL data: handle 71 flags 0x00 dlen 10
    L2CAP(s): Info req: type 2
> HCI Event: Number of Completed Packets (0x13) plen 5
    handle 71 packets 1
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> ACL data: handle 71 flags 0x02 dlen 16
    L2CAP(s): Info rsp: type 2 result 0
      Extended feature mask 0x0228
        Enhanced Retransmission mode
        FCS Option
        Unicast Connectless Data Reception
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:18:B2:03:15:ED name 'Serial Port Device'
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 71 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 71 reason 0x16
    Reason: Connection Terminated by Local Host

------------------------

Again, it seems to succeed but eventually fails. In fact, even the
Bluetooth connection sign appears in the upper right corner of the
display for a while.


I have browsed through some of the archives to find similarities with
my problem, especially regarding configuration stuff but haven't so far
found anything that might solve my problem. Do you have any advice how
to proceed with this issue?

Regards,
Kari Lehtinen
