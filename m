Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 04 Jul 2012 10:23:23 +0200
From: <bluetooth@allegro.yum.pl>
To: <linux-bluetooth@vger.kernel.org>
Subject: Problem with creating audio connection using Nokia Symbian devices
Message-ID: <7680ae91d9e0bc5286a7e7c8833efeae@localhost>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HI
I'm trying to connect my Nokia Symbian phone to computer in order to use
it as a headset (to stream music from phone to computer). Generally
procedure of connecting these devices is simple and generally works (I use
Pulse Audio sink/source), but I have problem with Nokia's phones.

Pairing is successful (using simple-pairing-agent that is included to the
Bluez deb package), but when I try to connect to audio service I get
message "Unable to connect". If I try to initiate an audio connection from
computer side then everything works great (eg.: dbus-send --system
--dest=org.bluez  --print-reply --type=method_call /org/bluez/`pgrep
bluetooth`/hci0/dev_5C_57_C8_B5_62_E0 org.bluez.AudioSource.Connect).

I've tested it with following Nokia-made Symbian phones (bluez
4.98-2ubuntu7, 4.101-git20120704-1):
Nokia E52	081.003
Nokia E52	091.003
Nokia 601	Symbian Belle (S^3)
Nokia 701	Symbian Belle (S^3)

I've tested this on some another, non-Symbian devices, all works perfectly
(bluez 4.98-2ubuntu7):
HTC Nexus One	Android		2.3.6 (2.6.35.7-ge0fb012htc-kernel@and18-2 #1)
BlackBerry 9520	BlackBerry	v5.0.0.1010
Nokia Lumia 800			

How can I fix this problem? 
I've attached my syslog, my bluetoothd has been run with -d parameter.
Maybe I can provide more logs/debug messages, but I don't know where can I
find them and/or how to enable them.

My system: Linux 3.2.0-25-generic-pae #40-Ubuntu SMP Wed May 23 22:11:24
UTC 2012 i686 i686 i386 GNU/Linux

SYSLOG:

Jun 26 14:01:36 localhost bluetoothd[393]:
plugins/hciops.c:conn_complete() status 0x00
Jun 26 14:01:36 localhost bluetoothd[393]:
src/adapter.c:adapter_get_device() D8:75:33:B0:92:F3
Jun 26 14:01:36 localhost bluetoothd[393]:
plugins/hciops.c:remote_features_information() hci0 status 0
Jun 26 14:01:36 localhost bluetoothd[393]:
plugins/hciops.c:remote_name_information() hci0 status 0
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() hci0 dba D8:75:33:B0:92:F3
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:get_auth_info() hci0 dba D8:75:33:B0:92:F3
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() Matching key found
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() link key type 0x00
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() hci0 dba D8:75:33:B0:92:F3
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:get_auth_info() hci0 dba D8:75:33:B0:92:F3
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() Matching key found
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:link_key_request() link key type 0x00
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:auth_complete() hci0 status 0
Jun 26 14:01:37 localhost bluetoothd[393]:
plugins/hciops.c:bonding_complete() status 0x00
Jun 26 14:01:37 localhost bluetoothd[393]:
src/adapter.c:adapter_get_device() D8:75:33:B0:92:F3
Jun 26 14:01:37 localhost bluetoothd[393]:
src/device.c:device_bonding_complete() bonding (nil) status 0x00
Jun 26 14:01:37 localhost bluetoothd[393]:
src/device.c:device_probe_drivers() Probing drivers for D8:75:33:B0:92:F3
Jun 26 14:01:37 localhost bluetoothd[393]: audio/manager.c:handle_uuid()
Found Handsfree record
Jun 26 14:01:37 localhost bluetoothd[393]: audio/headset.c:headset_init()
Registered interface org.bluez.Headset on path
/org/bluez/393/hci0/dev_D8_75_33_B0_92_F3
Jun 26 14:01:37 localhost bluetoothd[393]:
audio/headset.c:headset_set_state() State changed
/org/bluez/393/hci0/dev_D8_75_33_B0_92_F3: HEADSET_STATE_DISCONNECTED ->
HEADSET_STATE_CONNECTING
Jun 26 14:01:37 localhost bluetoothd[393]:
audio/media.c:headset_state_changed() 
Jun 26 14:01:37 localhost bluetoothd[393]:
audio/media.c:media_endpoint_async_call() Calling SetConfiguration: name =
:1.14 path = /MediaEndpoint/HFPAG
Jun 26 14:01:37 localhost bluetoothd[393]: src/agent.c:agent_authorize()
authorize request was sent for /org/bluez/393/hci0/dev_D8_75_33_B0_92_F3
Jun 26 14:01:37 localhost bluetoothd[393]:
audio/headset.c:headset_connect_cb()
/org/bluez/393/hci0/dev_D8_75_33_B0_92_F3: Connected to D8:75:33:B0:92:F3

Jun 26 14:01:57 localhost bluetoothd[393]: audio/headset.c:rfcomm_io_cb()
ERR or HUP on RFCOMM socket

Jun 26 14:01:57 localhost bluetoothd[393]:
audio/headset.c:headset_set_state() State changed
/org/bluez/393/hci0/dev_D8_75_33_B0_92_F3: HEADSET_STATE_CONNECTING ->
HEADSET_STATE_DISCONNECTED
Jun 26 14:01:57 localhost bluetoothd[393]:
audio/media.c:headset_state_changed() 
Jun 26 14:01:57 localhost bluetoothd[393]:
audio/media.c:headset_state_changed() Clear endpoint 0x21fe9898
Jun 26 14:02:03 localhost bluetoothd[393]:
plugins/hciops.c:disconn_complete() handle 44 status 0x00
Jun 26 14:02:03 localhost bluetoothd[393]:
src/event.c:btd_event_disconn_complete() 
Jun 26 14:02:03 localhost bluetoothd[393]:
src/adapter.c:adapter_remove_connection() 

Tested with following USB dongles:

hci0:	Type: BR/EDR  Bus: USB
	BD Address: 00:15:83:38:C4:06  ACL MTU: 310:10  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:3205570 acl:11046 sco:0 events:240 errors:0
	TX bytes:3648 acl:112 sco:0 commands:79 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x59 0x83
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'nieserver-ivi'
	Class: 0x4e0100
	Service Classes: Networking, Rendering, Capturing, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 2.1 (0x4)  Revision: 0x149c
	LMP Version: 2.1 (0x4)  Subversion: 0x149c
	Manufacturer: Cambridge Silicon Radio (10)

hci1:	Type: BR/EDR  Bus: USB
	BD Address: 00:1A:6B:FA:89:E4  ACL MTU: 310:10  SCO MTU: 64:8
	UP RUNNING PSCAN ISCAN 
	RX bytes:117167 acl:23 sco:0 events:6947 errors:0
	TX bytes:2725 acl:23 sco:0 commands:215 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'pllzls056-0'
	Class: 0x6e0100
	Service Classes: Networking, Rendering, Capturing, Audio, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 2.0 (0x3)  Revision: 0x10db
	LMP Version: 2.0 (0x3)  Subversion: 0x10db
	Manufacturer: Cambridge Silicon Radio (10)

hci2:	Type: BR/EDR  Bus: USB
	BD Address: 00:02:72:AE:5A:7C  ACL MTU: 1021:8  SCO MTU: 64:1
	UP RUNNING PSCAN 
	RX bytes:822 acl:0 sco:0 events:33 errors:0
	TX bytes:637 acl:0 sco:0 commands:33 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x87
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'pllzls056-1'
	Class: 0x6e0100
	Service Classes: Networking, Rendering, Capturing, Audio, Telephony
	Device Class: Computer, Uncategorized
	HCI Version: 3.0 (0x5)  Revision: 0x0
	LMP Version: 3.0 (0x5)  Subversion: 0x4203
	Manufacturer: Broadcom Corporation (15)

hci3:	Type: BR/EDR  Bus: USB
	BD Address: 00:15:83:15:A3:10  ACL MTU: 672:3  SCO MTU: 128:2
	UP RUNNING PSCAN 
	RX bytes:914 acl:0 sco:0 events:30 errors:0
	TX bytes:360 acl:0 sco:0 commands:23 errors:0
	Features: 0xff 0x3e 0x85 0x30 0x18 0x18 0x00 0x00
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF 
	Link mode: SLAVE ACCEPT 
	Name: 'pllzls056-1'
	Class: 0x000208
	Service Classes: Unspecified
	Device Class: Phone, Cordless
	HCI Version: 2.0 (0x3)  Revision: 0xc5c
	LMP Version: 2.0 (0x3)  Subversion: 0xc5c
	Manufacturer: Cambridge Silicon Radio (10)
