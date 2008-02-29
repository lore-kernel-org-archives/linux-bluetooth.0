Return-Path: <cyrus@holtmann.org>
Message-Id: <1204246311.23160.1239722851@webmail.messagingengine.com>
From: "Christopher Armstrong" <carmstrong@fastmail.com.au>
To: bluez-users@lists.sourceforge.net
MIME-Version: 1.0
Date: Fri, 29 Feb 2008 11:51:51 +1100
Subject: [Bluez-users] Difficulties establishing SCO link for Bluetooth
	headset on PS3
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

I've been working on this for about four weeks now but to no avail. I'm
attempting to get a bluetooth headset to work on Linux. I can pair the
device successfully, and connect to it, but when it attempts to
establish the SCO link, the bluetooth headset either appears to return
an unusual error code or the connection times out.

I am trying to write audio out onto the headset using alsa with the
command:

aplay -D plug:bluetooth /usr/share/sounds/ekiga/ring.wav

But I hear nothing on the headset. Recording with the headset seems to
fail as well. aplay and arecord return after a few seconds with "I/O
error" and a dump of their audio settings. 

I am using a Playstation 3 with Debian stable Linux. The kernel I am
testing with has been modified for usage on the PS3, and this includes
some bluetooth specific patches (the details of which I am not familiar
with). I have tried his kernel and also this kernel patched patched with
the mh1 patches on the bluez web site for a 2.6.23 kernel
(http://www.bluez.org/patches.html). I had to adapt the patches so they
would cleanly apply.

It is specifically the 2.6.23rc6/CELL Linux 20070219 release maintained
by Geoff Lavand at Sony (the materials including kernel patches and
source are kept at
http://www.kernel.org/pub/linux/kernel/people/geoff/cell/).

I've modified the sco module on both kernels so that BT_DBG outputs
everything it tries to do. I've also added some custom debugging lines
in sco_connect to get more information about what it is doing.

I am trying to use either one of two Motorola HS801 bluetooth headsets.
I have tried Motorola H350s, specifically two different headsets, but I
refuse to try anymore since they have fried after trying them with bluez
and are now completely broken. (I'm not kidding about this: after trying
to connect with them, they refused to work anymore with *ANY* device
afterwards, when we were able to demonstrate them working with a Mobile
phone or other device beforehand. The button become unresponsive and the
light would only come on when you charged them. I have had to return
them as they are bricked).

I am using the latest version of bluez-utils and bluez-lib (3.27). 

My .asoundrc file reads as:

pcm.bluetooth_hw {
        type bluetooth
        #device  00:0B:2E:13:AC:14
        device  00:0B:2E:13:B2:D6
        profile  auto
 }

ctl.bluetooth {
        type bluetooth
        device btaddrs
}

pcm.bluetooth {
        type plug
        slave {
                pcm "bluetooth_hw"
        }
}


When using the CELL PS3 kernel *without* applying the mh1 patches would
give the following output:

hcid (run with -n -d):
-------------------------------------------------------------------
hcid[3037]: Bluetooth HCI daemon
hcid[3037]: Enabling debug information
hcid[3037]: HCI dev 0 registered
hcid[3037]: HCI dev 0 already up
hcid[3037]: Device hci0 has been added
hcid[3037]: Starting security manager 0
hcid[3037]: Device hci0 has been activated
hcid[3037]: Created local server at
unix:abstract=/var/run/dbus-F4ewowUUJG,guid=
ccf81d2868356574f7314a0047c742aa
hcid[3037]: Registering service object: ident=audio, name=Audio service
(/org/bl
uez/service_audio)
hcid[3037]: Registering service object: ident=serial, name=Serial
service (/org/
bluez/service_serial)
hcid[3037]: Registering service object: ident=input, name=Input service
(/org/bl
uez/service_input)
input[3040]: Bluetooth Input daemon
hcid[3037]:
/opt/bluez-3.27-install/lib/bluetooth/bluetoothd-service-input execu
ted with PID 3040
hcid[3037]: Registering service object: ident=network, name=Network
service (/or
g/bluez/service_network)
input[3040]: Registered input manager path:/org/bluez/input
hcid[3037]: child 3038 exited
hcid[3037]: child 3039 exited
-------------------------------------------------------------------

bluetoothd-service-audio:
-------------------------------------------------------------------
audio[3064]: Bluetooth Audio daemon
audio[3064]: Unix socket created: 5
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: key Enable not found
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: key Disable not found
audio[3064]: add_service_record: got record id 0x10000
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: key Disable not found
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[3064]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[3064]: SEP 0x10040290 registered: type:0 codec:0 seid:1
audio[3064]: add_service_record: got record id 0x10001
audio[3064]: add_service_record: got record id 0x10002
audio[3064]: add_service_record: got record id 0x10003
audio[3064]: Registered manager path:/org/bluez/audio
audio[3064]: Loading device 00:0B:2E:13:AC:14 (headset )
audio[3064]: Got path /org/bluez/hci0 for adapter with address
00:13:A9:E0:EC:B7
audio[3064]: Selecting default device
audio[3064]: Loading device 00:0B:2E:13:B2:D6 (headset )
audio[3064]: Got path /org/bluez/hci0 for adapter with address
00:13:A9:E0:EC:B7
audio[3064]: Accepted new client connection on unix socket (fd=9)
audio[3064]: Audio API: received BT_GETCAPABILITIES_REQ
audio[3064]: Audio API: sending BT_GETCAPABILITIES_RSP
audio[3064]: Audio API: received BT_SETCONFIGURATION_REQ
audio[3064]: config sco - device = 00:0B:2E:13:B2:D6 access_mode = 2
audio[3064]: State changed /org/bluez/audio/device1:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
audio[3064]: /org/bluez/audio/device1: Connecting to 00:0B:2E:13:B2:D6
channel 1
audio[3064]: /org/bluez/audio/device1: Connected to 00:0B:2E:13:B2:D6
audio[3064]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[3064]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
audio[3064]: Received AT+CCWA=1
audio[3064]: Badly formated or unrecognized command: AT+CCWA=1
audio[3064]: connect(): Function not implemented (38)
audio[3064]: config failed
audio[3064]: Audio API: sending BT_SETCONFIGURATION_RSP
audio[3064]: State changed /org/bluez/audio/device1:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[3064]: Unix client disconnected (fd=9)
audio[3064]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
-------------------------------------------------------------------

sdpd (run with -n -d):
sdpd[3054]: Bluetooth SDP daemon
sdpd[3054]: Enabling debug information
sdpd[3054]: Starting SDP server
sdpd[3054]: Adding rec : 0x1001d1f8
sdpd[3054]: with handle : 0x1
sdpd[3054]: Adding rec : 0x1001d2f0
sdpd[3054]: with handle : 0x0
sdpd[3054]: Service classes 0x00
sdpd[3054]: Service register request
sdpd[3054]: Look ahead attr id : 1
sdpd[3054]: Extract PDU, sequenceLength: 75 localExtractedLength: 0
sdpd[3054]: DTD of attrId : 9 Attr id : 0x1
sdpd[3054]: Attr id : 0x1 attrValueLength : 8
sdpd[3054]: Extract PDU, seqLength: 75 localExtractedLength: 11
sdpd[3054]: Extract PDU, sequenceLength: 75 localExtractedLength: 11
sdpd[3054]: DTD of attrId : 9 Attr id : 0x4
sdpd[3054]: Attr id : 0x4 attrValueLength : 14
sdpd[3054]: Extract PDU, seqLength: 75 localExtractedLength: 28
sdpd[3054]: Extract PDU, sequenceLength: 75 localExtractedLength: 28
sdpd[3054]: DTD of attrId : 9 Attr id : 0x5
sdpd[3054]: Attr id : 0x5 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 75 localExtractedLength: 36
sdpd[3054]: Extract PDU, sequenceLength: 75 localExtractedLength: 36
sdpd[3054]: DTD of attrId : 9 Attr id : 0x9
sdpd[3054]: Attr id : 0x9 attrValueLength : 10
sdpd[3054]: Extract PDU, seqLength: 75 localExtractedLength: 49
sdpd[3054]: Extract PDU, sequenceLength: 75 localExtractedLength: 49
sdpd[3054]: DTD of attrId : 9 Attr id : 0x100
sdpd[3054]: Attr id : 0x100 attrValueLength : 23
sdpd[3054]: Extract PDU, seqLength: 75 localExtractedLength: 75
sdpd[3054]: Successful extracting of Svc Rec attributes
sdpd[3054]: Couldn't find record for : 0x10000
sdpd[3054]: Adding rec : 0x1001b380
sdpd[3054]: with handle : 0x10000
sdpd[3054]: Service classes 0x00
sdpd[3054]: Sending rsp. status 0
sdpd[3054]: Bytes Sent : 9
sdpd[3054]: Service register request
sdpd[3054]: Look ahead attr id : 1
sdpd[3054]: Extract PDU, sequenceLength: 73 localExtractedLength: 0
sdpd[3054]: DTD of attrId : 9 Attr id : 0x1
sdpd[3054]: Attr id : 0x1 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 73 localExtractedLength: 8
sdpd[3054]: Extract PDU, sequenceLength: 73 localExtractedLength: 8
sdpd[3054]: DTD of attrId : 9 Attr id : 0x4
sdpd[3054]: Attr id : 0x4 attrValueLength : 18
sdpd[3054]: Extract PDU, seqLength: 73 localExtractedLength: 29
sdpd[3054]: Extract PDU, sequenceLength: 73 localExtractedLength: 29
sdpd[3054]: DTD of attrId : 9 Attr id : 0x5
sdpd[3054]: Attr id : 0x5 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 73 localExtractedLength: 37
sdpd[3054]: Extract PDU, sequenceLength: 73 localExtractedLength: 37
sdpd[3054]: DTD of attrId : 9 Attr id : 0x9
sdpd[3054]: Attr id : 0x9 attrValueLength : 10
sdpd[3054]: Extract PDU, seqLength: 73 localExtractedLength: 50
sdpd[3054]: Extract PDU, sequenceLength: 73 localExtractedLength: 50
sdpd[3054]: DTD of attrId : 9 Attr id : 0x100
sdpd[3054]: Attr id : 0x100 attrValueLength : 14
sdpd[3054]: Extract PDU, seqLength: 73 localExtractedLength: 67
sdpd[3054]: Extract PDU, sequenceLength: 73 localExtractedLength: 67
sdpd[3054]: DTD of attrId : 9 Attr id : 0x311
sdpd[3054]: Attr id : 0x311 attrValueLength : 3
sdpd[3054]: Extract PDU, seqLength: 73 localExtractedLength: 73
sdpd[3054]: Successful extracting of Svc Rec attributes
sdpd[3054]: Couldn't find record for : 0x10001
sdpd[3054]: Adding rec : 0x1001b218
sdpd[3054]: with handle : 0x10001
sdpd[3054]: Service classes 0x08
sdpd[3054]: Sending rsp. status 0
sdpd[3054]: Bytes Sent : 9
sdpd[3054]: Service register request
sdpd[3054]: Look ahead attr id : 1
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 0
sdpd[3054]: DTD of attrId : 9 Attr id : 0x1
sdpd[3054]: Attr id : 0x1 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 8
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 8
sdpd[3054]: DTD of attrId : 9 Attr id : 0x4
sdpd[3054]: Attr id : 0x4 attrValueLength : 18
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 29
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 29
sdpd[3054]: DTD of attrId : 9 Attr id : 0x5
sdpd[3054]: Attr id : 0x5 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 37
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 37
sdpd[3054]: DTD of attrId : 9 Attr id : 0x9
sdpd[3054]: Attr id : 0x9 attrValueLength : 10
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 50
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 50
sdpd[3054]: DTD of attrId : 9 Attr id : 0x100
sdpd[3054]: Attr id : 0x100 attrValueLength : 10
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 63
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 63
sdpd[3054]: DTD of attrId : 9 Attr id : 0x311
sdpd[3054]: Attr id : 0x311 attrValueLength : 3
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 69
sdpd[3054]: Successful extracting of Svc Rec attributes
sdpd[3054]: Couldn't find record for : 0x10002
sdpd[3054]: Adding rec : 0x1001b898
sdpd[3054]: with handle : 0x10002
sdpd[3054]: Service classes 0x08
sdpd[3054]: Sending rsp. status 0
sdpd[3054]: Bytes Sent : 9
sdpd[3054]: Service register request
sdpd[3054]: Look ahead attr id : 1
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 0
sdpd[3054]: DTD of attrId : 9 Attr id : 0x1
sdpd[3054]: Attr id : 0x1 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 8
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 8
sdpd[3054]: DTD of attrId : 9 Attr id : 0x4
sdpd[3054]: Attr id : 0x4 attrValueLength : 18
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 29
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 29
sdpd[3054]: DTD of attrId : 9 Attr id : 0x5
sdpd[3054]: Attr id : 0x5 attrValueLength : 5
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 37
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 37
sdpd[3054]: DTD of attrId : 9 Attr id : 0x9
sdpd[3054]: Attr id : 0x9 attrValueLength : 10
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 50
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 50
sdpd[3054]: DTD of attrId : 9 Attr id : 0x100
sdpd[3054]: Attr id : 0x100 attrValueLength : 10
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 63
sdpd[3054]: Extract PDU, sequenceLength: 69 localExtractedLength: 63
sdpd[3054]: DTD of attrId : 9 Attr id : 0x311
sdpd[3054]: Attr id : 0x311 attrValueLength : 3
sdpd[3054]: Extract PDU, seqLength: 69 localExtractedLength: 69
sdpd[3054]: Successful extracting of Svc Rec attributes
sdpd[3054]: Couldn't find record for : 0x10003
sdpd[3054]: Adding rec : 0x1001bdc8
sdpd[3054]: with handle : 0x10003
sdpd[3054]: Service classes 0x08
sdpd[3054]: Sending rsp. status 0
sdpd[3054]: Bytes Sent : 9

dmesg (with extended SCO module output):

VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 224k freed
sr 0:0:0:0: Attached scsi generic sg0 type 5
ps3_system_bus_match:354: dev=5(vuart_02), drv=5(ps3_sys_manager): match
 -> ps3_system_bus_probe:365: vuart_02
 <- ps3_system_bus_probe:376: vuart_02
Bluetooth: Core ver 2.11
NET: Registered protocol family 31
Bluetooth: HCI device and connection manager initialized
Bluetooth: HCI socket layer initialized
Initializing USB Mass Storage driver...
scsi1 : SCSI emulation for USB Mass Storage devices
usbcore: registered new interface driver usb-storage
usb-storage: device found at 2
usb-storage: waiting for device to settle before scanning
USB Mass Storage support registered.
input: Sony Computer Entertainment Inc. SCE USB MOUSE as
/class/input/input0
input: USB HID v1.00 Mouse [Sony Computer Entertainment Inc. SCE USB
MOUSE] on usb-sb_05-2.2
input: Sony Computer Entertainment Inc. SCE USB Keyboard as
/class/input/input1
input: USB HID v1.00 Keyboard [Sony Computer Entertainment Inc. SCE USB
Keyboard] on usb-sb_05-2.1.1
usbcore: registered new interface driver usbhid
drivers/hid/usbhid/hid-core.c: v2.6:USB HID core driver
Bluetooth: HCI USB driver ver 2.9
usbcore: registered new interface driver hci_usb
Adding 586332k swap on /dev/ps3da5.  Priority:-1 extents:1
across:586332k
EXT3 FS on ps3da1, internal journal
scsi 1:0:0:0: Direct-Access     Sony     GL819 MS         1.08 PQ: 0
ANSI: 0 CCS
scsi 1:0:0:0: Attached scsi generic sg1 type 0
scsi 1:0:0:1: Direct-Access     Sony     GL819 SD         1.08 PQ: 0
ANSI: 0
scsi 1:0:0:1: Attached scsi generic sg2 type 0
scsi 1:0:0:2: Direct-Access     Sony     GL819 CF         1.08 PQ: 0
ANSI: 0
scsi 1:0:0:2: Attached scsi generic sg3 type 0
usb-storage: device scan complete
sd 1:0:0:0: [sda] Attached SCSI removable disk
sd 1:0:0:1: [sdb] Attached SCSI removable disk
sd 1:0:0:2: [sdc] Attached SCSI removable disk
eth0: no IPv6 routers present
Bluetooth: L2CAP ver 2.8
Bluetooth: L2CAP socket layer initialized
eth0: no IPv6 routers present
usb 1-2.4: new full speed USB device using ps3-ehci-driver and address 6
usb 1-2.4: configuration #1 chosen from 1 choice
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
sco_sock_create: sock c000000005011580
sco_sock_init: sk c0006c0064376000
sco_sock_bind: sk c0006c0064376000 00:00:00:00:00:00
sco_sock_connect: sk c0006c0064376000
sco_connect: 00:00:00:00:00:00 -> D6:B2:13:2E:0B:00
sco_conn_add: hcon c0006c0066bc7000 conn c0006c00641f1200
__sco_chan_add: conn c0006c00641f1200
sco_connect: B7:EC:E0:A9:13:00 -> D6:B2:13:2E:0B:00 BT_CONNECT
sco_sock_set_timer: sock c0006c0064376000 state 5 timeout 10000
sco_connect_cfm: hcon c0006c0066bc7000 bdaddr D6:B2:13:2E:0B:00 status
31
sco_conn_del: hcon c0006c0066bc7000 conn c0006c00641f1200, err 38
sco_sock_clear_timer: sock c0006c0064376000 state 5
sco_chan_del: sk c0006c0064376000, conn c0006c00641f1200, err 38
sco_sock_release: sock c000000005011580, sk c0006c0064376000
sco_sock_clear_timer: sock c0006c0064376000 state 9
sco_sock_close: sk c0006c0064376000 state 9 conn 0000000000000000 socket
c000000005011580
sco_sock_kill: sk c0006c0064376000 state 9
sco_sock_destruct: sk c0006c0064376000

The above output (from bluetoothd-service-audio and dmesg) in particular
appears to show sco_connect() failing with bluetooth error code 31 which
I believe means something like "Unspecified Device Error". This is with
the unpatched kernel (i.e. without the mh1 patches on the bluez web
site).

After applying and fixing up the mh1 patches for this kernel, I am now
getting connection timeout errors. The output from hcid,
bluetoothd-service-audio and dmesg are shown below:

hcid:
-----

hcid[1940]: Bluetooth HCI daemon
hcid[1940]: Enabling debug information
hcid[1940]: HCI dev 0 registered
hcid[1940]: HCI dev 0 already up
hcid[1940]: Device hci0 has been added
hcid[1940]: Starting security manager 0
hcid[1940]: Device hci0 has been activated
hcid[1940]: Created local server at
unix:abstract=/var/run/dbus-1Fq9YBFxBi,guid=a577c9bc8d5b1272d4ef120047c753ff
hcid[1940]: Registering service object: ident=audio, name=Audio service
(/org/bluez/service_audio)
hcid[1940]: Registering service object: ident=serial, name=Serial
service (/org/bluez/service_serial)
hcid[1940]: Registering service object: ident=input, name=Input service
(/org/bluez/service_input)
hcid[1940]:
/opt/bluez-3.27-install/lib/bluetooth/bluetoothd-service-input executed
with PID 1943
hcid[1940]: Registering service object: ident=network, name=Network
service (/org/bluez/service_network)
input[1943]: Bluetooth Input daemon
hcid[1940]: child 1941 exited
hcid[1940]: child 1942 exited
input[1943]: Registered input manager path:/org/bluez/input
hcid[1940]: Child PID 1943 got the unique bus name :1.2
hcid[1940]: name_listener_add(:1.2)
hcid[1940]: /org/bluez: org.bluez.Database.AddServiceRecord()
hcid[1940]: name_listener_add(:1.3)
hcid[1940]: /org/bluez: org.bluez.Database.AddServiceRecord()
hcid[1940]: /org/bluez: org.bluez.Database.AddServiceRecord()
hcid[1940]: /org/bluez: org.bluez.Database.AddServiceRecord()
hcid[1940]: /org/bluez: org.bluez.Manager.FindAdapter()
hcid[1940]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteName()
hcid[1940]: /org/bluez: org.bluez.Manager.FindAdapter()
hcid[1940]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteName()
hcid[1940]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceHandles()
hcid[1940]: no matching session found. creating a new one
hcid[1940]: link_key_request (sba=00:13:A9:E0:EC:B7,
dba=00:0B:2E:13:B2:D6)
hcid[1940]: sdp session added to cache
hcid[1940]: /org/bluez/hci0: org.bluez.Adapter.GetRemoteServiceRecord()
hcid[1940]: found matching session, removing from list
hcid[1940]: sdp session added to cache
hcid[1940]: /org/bluez/hci0:
org.bluez.Adapter.FinishRemoteServiceTransaction()
hcid[1940]: found matching session, removing from list

bluetoothd-service-audio:
-------------------------
audio[1975]: Bluetooth Audio daemon
audio[1975]: Unix socket created: 5
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: key Enable not found
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: key Disable not found
audio[1975]: add_service_record: got record id 0x10000
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: key Disable not found
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[1975]: audio.conf:
/opt/bluez-3.27-install/etc/bluetooth/audio.conf: group A2DP not found
audio[1975]: SEP 0x10040290 registered: type:0 codec:0 seid:1
audio[1975]: add_service_record: got record id 0x10001
audio[1975]: add_service_record: got record id 0x10002
audio[1975]: add_service_record: got record id 0x10003
audio[1975]: Registered manager path:/org/bluez/audio
audio[1975]: Loading device 00:0B:2E:13:AC:14 (headset )
audio[1975]: Got path /org/bluez/hci0 for adapter with address
00:13:A9:E0:EC:B7
audio[1975]: Selecting default device
audio[1975]: Loading device 00:0B:2E:13:B2:D6 (headset )
audio[1975]: Got path /org/bluez/hci0 for adapter with address
00:13:A9:E0:EC:B7
audio[1975]: Accepted new client connection on unix socket (fd=9)
audio[1975]: Audio API: received BT_GETCAPABILITIES_REQ
audio[1975]: Audio API: sending BT_GETCAPABILITIES_RSP
audio[1975]: Audio API: received BT_SETCONFIGURATION_REQ
audio[1975]: config sco - device = 00:0B:2E:13:B2:D6 access_mode = 2
audio[1975]: State changed /org/bluez/audio/device1:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
audio[1975]: /org/bluez/audio/device1: Connecting to 00:0B:2E:13:B2:D6
channel 1
audio[1975]: /org/bluez/audio/device1: Connected to 00:0B:2E:13:B2:D6
audio[1975]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[1975]: State changed /org/bluez/audio/device1:
HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
audio[1975]: Received AT+CCWA=1
audio[1975]: Badly formated or unrecognized command: AT+CCWA=1
audio[1975]: connect(): Connection timed out (110)
audio[1975]: config failed
audio[1975]: Audio API: sending BT_SETCONFIGURATION_RSP
audio[1975]: State changed /org/bluez/audio/device1:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_CONNECTED
audio[1975]: Unix client disconnected (fd=9)

dmesg:




Bluetooth: L2CAP ver 2.9
Bluetooth: L2CAP socket layer initialized
Bluetooth: RFCOMM socket layer initialized
Bluetooth: RFCOMM TTY layer initialized
Bluetooth: RFCOMM ver 1.8
Bluetooth: SCO (Voice Link) ver 0.5
Bluetooth: SCO socket layer initialized
sco_sock_create: sock c0006c0062526580
sco_sock_init: sk c0006c0066b8a800
sco_sock_bind: sk c0006c0066b8a800 00:00:00:00:00:00
sco_sock_connect: sk c0006c0066b8a800
sco_connect: 00:00:00:00:00:00 -> D6:B2:13:2E:0B:00
sco_conn_add: hcon c0006c0066b8a000 conn c000000007935300
__sco_chan_add: conn c000000007935300
sco_sock_set_timer: sock c0006c0066b8a800 state 5 timeout 10000
sco_sock_timeout: sock c0006c0066b8a800 state 5
sco_sock_release: sock c0006c0062526580, sk c0006c0066b8a800
sco_sock_clear_timer: sock c0006c0066b8a800 state 5
sco_sock_close: sk c0006c0066b8a800 state 5 conn c000000007935300 socket
c0006c0062526580
sco_chan_del: sk c0006c0066b8a800, conn c000000007935300, err 104
sco_sock_kill: sk c0006c0066b8a800 state 9
sco_sock_destruct: sk c0006c0066b8a800
----------------------------------------

And this I presume may be helpful:

>hciconfig hci0 version
hci0:   Type: USB
        BD Address: 00:13:A9:E0:EC:B7 ACL MTU: 384:8 SCO MTU: 64:8
        HCI Ver: 2.0 (0x3) HCI Rev: 0xe18 LMP Ver: 2.0 (0x3) LMP Subver:
        0xe18
        Manufacturer: Cambridge Silicon Radio (10)

hciconfig hci0 features


I have also tried reloadng hci_usb with the force_scofix=1 option as
suggested by a previous message on this list from a person experiencing
sco timeout issues. Is there anyone else who has had success either
getting this model of headset to work with Linux, or got headsets to
work on the PS3? I don't mind changing to another headset, but I would
really like to get this to work with a PS3 without the risk of frying
more headsets.
-- 
  Christopher Armstrong
  carmstrong ^^AT^ fastmail dOT com /Dot/ au


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
