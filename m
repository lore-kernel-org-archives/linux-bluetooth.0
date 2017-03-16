Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
From: Luke McKee <hojuruku@gmail.com>
Date: Thu, 16 Mar 2017 23:45:17 +0700
Message-ID: <CAENjB=+c1MqfkgWC+q7HUT1tKtKtKZoJk-dZ8GYX=CarhrUr5Q@mail.gmail.com>
Subject: Lower Level Host Stack bug - 0x1a (remote host feature) using EDR+SCO
 to non-capable Taiwanese/Chinese devices
To: linux-bluetooth@vger.kernel.org
Cc: georg@chini.tk, kubax.t.pawlak@intel.com, madingzhi@163.com,
        rimi@szaodasen.com, conwise@conwise.com.tw
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This bug at first sight appears to be a regression of this bug:
https://lists.freedesktop.org/archives/pulseaudio-discuss/2015-March/023305.html
reported by Georg Chini that's well known of by many pulseaudio users
but I believe it's a new one, brought about by incompatibility of many
Taiwanese Bluetooth stacks that support EDR only for A2DP / EDR
connection-less streams.   Many thanks for to Georg for support given
on #pulseaudio given to me (hojuruku)

The feedback from hcidump is near identical to the previous bug,
because but after even applying a patch to hci_event.c from George
(included below) however it didn't attempt a reconnect, so the cause
may be different, but the symptoms are the same.

The HSP or HFP protocols don't work due to the reliance on SCO with
this device and all other TW based hardware I have laying around here
(headphones / speakers)
https://www.mikrocontroller.net/attachment/193445/CW6626-Datasheet-DS6626V1.1.pdf
FYI this is the speaker:
http://www.szaodasen.com/en/productmore.asp?id=119&pid=6&i=119 It also
has a rfcomm profile and a proprietary app to remote control,
configure it set the clock etc. I might ask how to sniff rfcomm
connections later ;)

Unlike the previous issues this bluetooth speaker supports eSCO, but
not eSCO with a EDR packet type. This is affecting 4.9.13

The symptoms in userspace and hcidump are nearly identical but I have
verified the appropriate patches have been applied to work around the
issue of eSCO not being present in the bluetooth headset, as that's
not the problem here.

https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Bluetooth/

"The "Protocol not supported" problem

There was some regression in the kernel that was introduced in 3.12
and fixed in 3.18 that caused failure when trying to activate HSP/HFP
with some headsets. This problem can be identified by this error
message in pulseaudio log:

backend-native.c: connect(): Protocol not supported"

Here is a decent bug report for the 2015 bug mentioned above:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=788466

This is not just a pulseaudio issue, bluez-alsa (for 5.x bluez
https://github.com/Arkq/bluez-alsa) reports the same:

bluealsa: Couldn't open SCO link: Protocol not supported

Both bluealsa & puleaudio work fine with ACL/A2DP. Also did a test to
make sure after a cold boot with only a HSP profile connection
attempted, used the distro kernel (sabayon) and the same kernel
bluetooth kernel configuration as Georg who worked around the old
issue with eSCO not being supported by the speaker.

This is on 4.9.13 sabayon.org sources that's pretty close to mainline,
and my own sensible kernel configuration for a Haswell. The distro
kernel also has the same problems. I can test again on vanilla if
requested.

hcidump of the failure:
< HCI Command: Setup Synchronous Connection (0x01|0x0028) plen 17
     handle 12 voice setting 0x0060 ptype 0x0380
 > HCI Event: Command Status (0x0f) plen 4
     Setup Synchronous Connection (0x01|0x0028) status 0x1a ncmd 1
     Error: Unsupported Remote Feature / Unsupported LMP Feature
 > HCI Event: Max Slots Change (0x1b) plen 3
     handle 12 slots 1
 > HCI Event: Mode Change (0x14) plen 6
     status 0x00 handle 12 mode 0x02 interval 800
     Mode: Sniff

bluetoothd:
bluetoothd[2477]: src/profile.c:ext_connect() Headset Voice gateway
connected to 30:21:57:95:5A:3A
bluetoothd[2477]: src/service.c:change_state() 0x563d7d550920: device
30:21:57:95:5A:3A profile Headset Voice gateway state changed:
disconnected -> connecting (0)
bluetoothd[2477]: src/service.c:change_state() 0x563d7d550920: device
30:21:57:95:5A:3A profile Headset Voice gateway state changed:
connecting -> connected (0)
bluetoothd[2477]: src/device.c:device_profile_connected() Headset
Voice gateway Success (0)
bluetoothd[2477]: src/service.c:btd_service_ref() 0x563d7d550920: ref=3
bluetoothd[2477]: plugins/policy.c:service_cb() Added Headset Voice
gateway reconnect 0
bluetoothd[2477]: src/device.c:att_disconnected_cb()
bluetoothd[2477]: src/device.c:att_disconnected_cb() Success (0)
bluetoothd[2477]: src/gatt-client.c:btd_gatt_client_disconnected()
Device disconnected. Cleaning up.
bluetoothd[2477]: src/device.c:att_disconnected_cb() Automatic
connection disabled
bluetoothd[2477]: attrib/gattrib.c:g_attrib_unref() 0x563d7d545c30:
g_attrib_unref=0

hciconfig -a

hci0: Type: Primary  Bus: USB
BD Address: 00:19:86:00:00:2E  ACL MTU: 1021:7  SCO MTU: 64:1
UP RUNNING
RX bytes:2505067 acl:176 sco:0 events:357072 errors:0
TX bytes:430951824 acl:713834 sco:0 commands:103 errors:0
Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
Link policy: RSWITCH HOLD SNIFF PARK
Link mode: SLAVE ACCEPT
Name: 'hojuruku'
Class: 0x0c0104
Service Classes: Rendering, Capturing
Device Class: Computer, Desktop workstation
HCI Version: 2.1 (0x4)  Revision: 0x5332
LMP Version: 2.1 (0x4)  Subversion: 0x420e
Manufacturer: Broadcom Corporation (15)

lsusb
Bus 003 Device 007: ID 0a5c:2148 Broadcom Corp. BCM92046DG-CL1ROM
Bluetooth 2.1 Adapter

loading btusb with the option to tweak the SCO MTU made no difference either.

hcitool info 30:21:57:95:5A:3A
Requesting information ...
BD Address:  30:21:57:95:5A:3A
Device Name: JY-17
LMP Version: 3.0 (0x5) LMP Subversion: 0x1f4
Manufacturer: CONWISE Technology Corporation Ltd (66)
Features page 0: 0xbf 0x3a 0x85 0xfa 0x98 0x1d 0x59 0x87
<3-slot packets> <5-slot packets> <encryption> <slot offset>
<timing accuracy> <role switch> <sniff mode> <RSSI> <SCO link>
<HV2 packets> <HV3 packets> <CVSD> <power control>
<broadcast encrypt> <EDR ACL 2 Mbps> <enhanced iscan>
<interlaced iscan> <interlaced pscan> <inquiry with RSSI>
<extended SCO> <AFH cap. slave> <AFH class. slave>
<3-slot EDR ACL> <5-slot EDR ACL> <pause encryption>
<AFH cap. master> <AFH class. master> <extended inquiry>
<simple pairing> <encapsulated PDU> <non-flush flag> <LSTO>
<inquiry TX power> <EPC> <extended features>
Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

 hciconfig
hci0: Type: Primary  Bus: USB
BD Address: 00:19:86:00:00:2E  ACL MTU: 1021:7  SCO MTU: 64:1
UP RUNNING
RX bytes:2505684 acl:176 sco:0 events:357085 errors:0
TX bytes:430951868 acl:713834 sco:0 commands:111 errors:0

^^ As you can see A2DP profile works fine using sbc ^^

hciconfig hci0 features
hci0: Type: Primary  Bus: USB
BD Address: 00:19:86:00:00:2E  ACL MTU: 1021:7  SCO MTU: 64:1
Features page 0: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
<3-slot packets> <5-slot packets> <encryption> <slot offset>
<timing accuracy> <role switch> <hold mode> <sniff mode>
<park state> <RSSI> <channel quality> <SCO link> <HV2 packets>
<HV3 packets> <u-law log> <A-law log> <CVSD> <paging scheme>
<power control> <transparent SCO> <broadcast encrypt>
<EDR ACL 2 Mbps> <EDR ACL 3 Mbps> <enhanced iscan>
<interlaced iscan> <interlaced pscan> <inquiry with RSSI>
<extended SCO> <EV4 packets> <EV5 packets> <AFH cap. slave>
<AFH class. slave> <3-slot EDR ACL> <5-slot EDR ACL>
<sniff subrating> <pause encryption> <AFH cap. master>
<AFH class. master> <EDR eSCO 2 Mbps> <EDR eSCO 3 Mbps>
<3-slot EDR eSCO> <extended inquiry> <simple pairing>
<encapsulated PDU> <err. data report> <non-flush flag> <LSTO>
<inquiry TX power> <extended features>
Features page 1: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00

Similar bug - only userspace errors reported
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1331748

This one is very interesting, it shows a hcidump of it retrying until
a connection is made with a DIFFERENT pkgtype. The patch seems applied
to 4.9.13 yet my system borks after only once unsuccessful attempt to
connect with a 0x1a remote feature not supported error.
https://marc.info/?l=linux-bluetooth&m=144076356407749&w=1

2015-05-18 01:27:57.336610 > HCI Event: Synchronous Connect Complete
(0x2c) plen 17
    status 0x1a handle 0 bdaddr 30:7C:30:B3:A8:86 type SCO
    Error: Unsupported Remote Feature / Unsupported LMP Feature
2015-05-18 01:27:57.336685 < HCI Command: Setup Synchronous Connection
(0x01|0x0028) plen 17
    handle 256 voice setting 0x0060 ptype 0x03c8
2015-05-18 01:27:57.337603 > HCI Event: Command Status (0x0f) plen 4
    Setup Synchronous Connection (0x01|0x0028) status 0x00 ncmd 1
2015-05-18 01:27:57.342608 > HCI Event: Max Slots Change (0x1b) plen 3
    handle 256 slots 1
2015-05-18 01:27:57.377631 > HCI Event: Synchronous Connect Complete
(0x2c) plen 17
    status 0x00 handle 257 bdaddr 30:7C:30:B3:A8:86 type eSCO
    Air mode: CVSD

Thanks in advance to anyone willing provide a patch for me to test. In
the meantime I'll try and track down a bluetooth 2.0 non EDR capable
dongle that works to prove my theory, as people did last time with a
non eSCO capable dongle.

These patches only make 4.9.13 have the identical fix to George's
proposed patch to 3.17 and didn't solve the issue
(https://lists.freedesktop.org/archives/pulseaudio-discuss/2015-March/023366.html)

diff -u  /usr/src/linux/net/bluetooth/hci_conn.c /usr/src/hci_conn.c
--- /usr/src/linux/net/bluetooth/hci_conn.c 2016-12-12 02:17:54.000000000 +0700
+++ /usr/src/hci_conn.c 2017-03-16 14:53:44.211312575 +0700
@@ -45,8 +45,8 @@
  { EDR_ESCO_MASK & ~ESCO_2EV3, 0x000a, 0x01 }, /* S3 */
  { EDR_ESCO_MASK & ~ESCO_2EV3, 0x0007, 0x01 }, /* S2 */
  { EDR_ESCO_MASK | ESCO_EV3,   0x0007, 0x01 }, /* S1 */
- { EDR_ESCO_MASK | ESCO_HV3,   0xffff, 0x01 }, /* D1 */
- { EDR_ESCO_MASK | ESCO_HV1,   0xffff, 0x01 }, /* D0 */
+ { EDR_ESCO_MASK | ESCO_HV3,   0xffff, 0xff }, /* D1 */
+ { EDR_ESCO_MASK | ESCO_HV1,   0xffff, 0xff }, /* D0 */
 };

 static const struct sco_param sco_param_cvsd[] = {

--- /usr/src/linux/net/bluetooth/hci_event.c 2016-12-12 02:17:54.000000000 +0700
+++ /usr/src/hci_event.c 2017-03-16 15:53:52.569396159 +0700
@@ -1519,8 +1519,13 @@
  if (sco) {
  sco->state = BT_CLOSED;

- hci_connect_cfm(sco, status);
+/* hci_connect_cfm(sco, status);
  hci_conn_del(sco);
+ */
+ if (!hci_setup_sync(sco, handle)) {
+ hci_connect_cfm(sco, status);
+ hci_conn_del(sco);
+ }
  }
  }
