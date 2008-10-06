Return-Path: <cyrus@holtmann.org>
Message-ID: <48EA7770.30307@pook.es>
Date: Mon, 06 Oct 2008 22:39:12 +0200
From: Stuart Pook <kernel6org@pook.es>
MIME-Version: 1.0
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: BlueZ development <linux-bluetooth@vger.kernel.org>
Subject: Re: bluez/git + 2.6.27-rc8 + Belkin F8T017 -> Can't read class of
 adapter
References: <48E29416.3030402@pook.es> <48E2B59A.7020600@dtsp.co.nz>	 <48E3B3BF.6070205@pook.es>	 <2d5a2c100810032047s47bec394w828852079d64e591@mail.gmail.com>	 <48E752A7.70600@pook.es> <1223121068.11272.46.camel@violet.holtmann.net> <48E7FB1E.8000504@pook.es> <48B8929D-29F9-4352-9C81-E95FDBC09876@gmail.com> <48E91E6F.1030202@pook.es> <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
In-Reply-To: <A34AC171-77C2-4377-A60C-60A2793A2297@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

> Why your application gives up prematurely is still unclear to me.

I must admit this what interests me most.

I wondered if it was by old USBBT100 Bluetooth dongle that is causing
my problems. I thus bought a Belkin F8T017 (Bluetooth v2.1 Class I).
It works even less than my old Linksys USBBT100.

bluetoothd (from git) says:

bluetoothd[3517]: HCI dev 0 up
bluetoothd[3517]: Can't read class of adapter on /org/bluez/hci0: Input/output error (5)

When I unplugged the dongle, bluetoothd also said

bluetoothd[3517]: proxy_remove: path /org/bluez/hci0
process 3517: arguments to dbus_connection_unref() were incorrect, assertion "connection != NULL" failed in file dbus-connection.c line 2645.
This is normally a bug in some application using the D-Bus library.

This dongle appears to contain a hub, a keyboard and a mouse!

Oct  6 21:57:36 kooka kernel: [85228.696180] usb 1-2: new full speed USB device using uhci_hcd and address 9
Oct  6 21:57:36 kooka kernel: [85228.873638] usb 1-2: configuration #1 chosen from 1 choice
Oct  6 21:57:36 kooka kernel: [85228.876578] hub 1-2:1.0: USB hub found
Oct  6 21:57:36 kooka kernel: [85228.878555] hub 1-2:1.0: 3 ports detected
Oct  6 21:57:36 kooka kernel: [85229.104656] usb 1-2: New USB device found, idVendor=0a5c, idProduct=4500
Oct  6 21:57:36 kooka kernel: [85229.104662] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=0
Oct  6 21:57:36 kooka kernel: [85229.104665] usb 1-2: Product: BCM2046B1
Oct  6 21:57:36 kooka kernel: [85229.104666] usb 1-2: Manufacturer: Broadcom
Oct  6 21:57:37 kooka kernel: [85229.181563] usb 1-2.1: new full speed USB device using uhci_hcd and address 10
Oct  6 21:57:37 kooka kernel: [85229.303641] usb 1-2.1: configuration #1 chosen from 1 choice
Oct  6 21:57:37 kooka kernel: [85229.309775] input: HID 0a5c:4502 as /class/input/input17
Oct  6 21:57:37 kooka kernel: [85229.340573] input,hidraw4: USB HID v1.11 Keyboard [HID 0a5c:4502] on usb-0000:00:1a.0-2.1
Oct  6 21:57:37 kooka kernel: [85229.340669] usb 1-2.1: New USB device found, idVendor=0a5c, idProduct=4502
Oct  6 21:57:37 kooka kernel: [85229.340671] usb 1-2.1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Oct  6 21:57:37 kooka kernel: [85229.413569] usb 1-2.2: new full speed USB device using uhci_hcd and address 11
Oct  6 21:57:37 kooka kernel: [85229.533664] usb 1-2.2: configuration #1 chosen from 1 choice
Oct  6 21:57:37 kooka kernel: [85229.540840] input: HID 0a5c:4503 as /class/input/input18
Oct  6 21:57:37 kooka kernel: [85229.580070] input,hidraw6: USB HID v1.11 Mouse [HID 0a5c:4503] on usb-0000:00:1a.0-2.2
Oct  6 21:57:37 kooka kernel: [85229.580166] usb 1-2.2: New USB device found, idVendor=0a5c, idProduct=4503
Oct  6 21:57:37 kooka kernel: [85229.580168] usb 1-2.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
Oct  6 21:57:37 kooka kernel: [85229.657571] usb 1-2.3: new full speed USB device using uhci_hcd and address 12
Oct  6 21:57:37 kooka kernel: [85229.794657] usb 1-2.3: configuration #1 chosen from 1 choice
Oct  6 21:57:37 kooka kernel: [85229.797922] usb 1-2.3: New USB device found, idVendor=050d, idProduct=0017
Oct  6 21:57:37 kooka kernel: [85229.797926] usb 1-2.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
Oct  6 21:57:37 kooka kernel: [85229.797928] usb 1-2.3: Product: BLUETOOTH USB +EDR ADAPTER Class 1 v2.1 UHE
Oct  6 21:57:37 kooka kernel: [85229.797930] usb 1-2.3: Manufacturer: Broadcom Corp
Oct  6 21:57:37 kooka kernel: [85229.797932] usb 1-2.3: SerialNumber: 000A3A8494D9

:; hciconfig -a
hci0:	Type: USB
	BD Address: 00:0A:3A:84:94:D9 ACL MTU: 1021:8 SCO MTU: 64:1
	UP RUNNING
	RX bytes:299 acl:0 sco:0 events:25 errors:0
	TX bytes:344 acl:0 sco:0 commands:25 errors:0
	Features: 0xff 0xff 0x8f 0xfe 0x9b 0xff 0x79 0x83
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
	Link policy:
	Link mode: SLAVE ACCEPT
Can't read local name on hci0: Input/output error (5)
:; hciconfig  hci0 commands
hci0:	Type: USB
	BD Address: 00:0A:3A:84:94:D9 ACL MTU: 1021:8 SCO MTU: 64:1
	Commands: Octet 0  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 1  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 2  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 3  = 0x03 (Bit 0 1)
		  Octet 4  = 0xfe (Bit 1 2 3 4 5 6 7)
		  Octet 5  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 6  = 0xef (Bit 0 1 2 3 5 6 7)
		  Octet 7  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 8  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 9  = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 10 = 0xef (Bit 0 1 2 3 5 6 7)
		  Octet 11 = 0x1f (Bit 0 1 2 3 4)
		  Octet 12 = 0xf2 (Bit 1 4 5 6 7)
		  Octet 13 = 0x0f (Bit 0 1 2 3)
		  Octet 14 = 0xe8 (Bit 3 5 6 7)
		  Octet 15 = 0xfe (Bit 1 2 3 4 5 6 7)
		  Octet 16 = 0x3f (Bit 0 1 2 3 4 5)
		  Octet 17 = 0xf7 (Bit 0 1 2 4 5 6 7)
		  Octet 18 = 0x8f (Bit 0 1 2 3 7)
		  Octet 19 = 0xff (Bit 0 1 2 3 4 5 6 7)
		  Octet 20 = 0x0c (Bit 2 3)
	'Inquiry' 'Inquiry Cancel' 'Periodic Inquiry Mode'
	'Exit Periodic Inquiry Mode' 'Create Connection' 'Disconnect'
	'Add SCO Connection' 'Cancel Create Connection'
	'Accept Connection Request' 'Reject Connection Request'
	'Link Key Request Reply' 'Link Key Request Negative Reply'
	'PIN Code Request Reply' 'PIN Code Request Negative Reply'
	'Change Connection Packet Type' 'Authentication Requested'
	'Set Connection Encryption' 'Change Connection Link Key'
	'Master Link Key' 'Remote Name Request' 'Cancel Remote Name Request'
	'Read Remote Supported Features' 'Read Remote Extended Features'
	'Read Remote Version Information' 'Read Clock Offset'
	'Read LMP Handle' 'Hold Mode' 'Sniff Mode' 'Exit Sniff Mode'
	'Park State' 'Exit Park State' 'QoS Setup' 'Role Discovery'
	'Switch Role' 'Read Link Policy Settings' 'Write Link Policy Settings'
	'Read Default Link Policy Settings'
	'Write Default Link Policy Settings' 'Flow Specification'
	'Set Event Mask' 'Reset' 'Set Event Filter' 'Flush' 'Read PIN Type'
	'Write PIN Type' 'Read Stored Link Key' 'Write Stored Link Key'
	'Delete Stored Link Key' 'Write Local Name' 'Read Local Name'
	'Read Connection Accept Timeout' 'Write Connection Accept Timeout'
	'Read Page Timeout' 'Write Page Timeout' 'Read Scan Enable'
	'Write Scan Enable' 'Read Page Scan Activity'
	'Write Page Scan Activity' 'Read Inquiry Scan Activity'
	'Write Inquiry Scan Activity' 'Read Authentication Enable'
	'Write Authentication Enable' 'Read Encryption Mode'
	'Write Encryption Mode' 'Read Class Of Device' 'Write Class Of Device'
	'Read Voice Setting' 'Write Voice Setting'
	'Read Automatic Flush Timeout' 'Write Automatic Flush Timeout'
	'Read Num Broadcast Retransmissions'
	'Write Num Broadcast Retransmissions' 'Read Hold Mode Activity'
	'Write Hold Mode Activity' 'Read Transmit Power Level'
	'Read Synchronous Flow Control Enable'
	'Set Host Controller To Host Flow Control' 'Host Buffer Size'
	'Host Number Of Completed Packets' 'Read Link Supervision Timeout'
	'Write Link Supervision Timeout' 'Read Number of Supported IAC'
	'Read Current IAC LAP' 'Write Current IAC LAP'
	'Set AFH Channel Classification' 'Read Inquiry Scan Type'
	'Write Inquiry Scan Type' 'Read Inquiry Mode' 'Write Inquiry Mode'
	'Read Page Scan Type' 'Write Page Scan Type'
	'Read AFH Channel Assessment Mode' 'Write AFH Channel Assessment Mode'
	'Read Local Version Information' 'Read Local Supported Features'
	'Read Local Extended Features' 'Read Buffer Size' 'Read BD ADDR'
	'Read Failed Contact Counter' 'Reset Failed Contact Counter'
	'Get Link Quality' 'Read RSSI' 'Read AFH Channel Map' 'Read BD Clock'
	'Read Loopback Mode' 'Write Loopback Mode'
	'Enable Device Under Test Mode' 'Setup Synchronous Connection'
	'Accept Synchronous Connection' 'Reject Synchronous Connection'
	'Read Extended Inquiry Response' 'Write Extended Inquiry Response'
	'Refresh Encryption Key' 'Sniff Subrating' 'Read Simple Pairing Mode'
	'Write Simple Pairing Mode' 'Read Local OOB Data'
	'Read Inquiry Transmit Power Level'
	'Write Inquiry Transmit Power Level'
	'Read Default Erroneous Data Reporting'
	'Write Default Erroneous Data Reporting' 'IO Capability Request Reply'
	'User Confirmation Request Reply'
	'User Confirmation Request Negative Reply'
	'User Passkey Request Reply' 'User Passkey Request Negative Reply'
	'Remote OOB Data Request Reply' 'Write Simple Pairing Debug Mode'
	'Enhanced Flush' 'Remote OOB Data Request Negative Reply'
	'Send Keypress Notification' 'IO Capabilities Response Negative Reply'
:; hciconfig  hci0 features
hci0:	Type: USB
	BD Address: 00:0A:3A:84:94:D9 ACL MTU: 1021:8 SCO MTU: 64:1
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
	Features page 1: 0x00 0x00 0x00 0x00 0x00 0x00 0x00 0x00
:; hciconfig  hci0 version
hci0:	Type: USB
	BD Address: 00:0A:3A:84:94:D9 ACL MTU: 1021:8 SCO MTU: 64:1
	HCI Ver: 2.1 (0x4) HCI Rev: 0x5123 LMP Ver: 2.1 (0x4) LMP Subver: 0x420e
	Manufacturer: Broadcom Corporation (15)
:; hciconfig  hci0 revision
hci0:	Type: USB
	BD Address: 00:0A:3A:84:94:D9 ACL MTU: 1021:8 SCO MTU: 64:1
	Firmware 35.66 / 14
:; lsusb -s 001:
Bus 001 Device 012: ID 050d:0017 Belkin Components
Bus 001 Device 011: ID 0a5c:4503 Broadcom Corp.
Bus 001 Device 010: ID 0a5c:4502 Broadcom Corp.
Bus 001 Device 009: ID 0a5c:4500 Broadcom Corp.
Bus 001 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
:; aplay -D JX10 ~/lib/alarm.wav
ALSA lib pcm_bluetooth.c:1619:(bluetooth_init) BT_GETCAPABILITIES failed : Input/output error(5)
aplay: main:564: audio open error: Input/output error

: root@kooka; valgrind src/.libs/bluetoothd -dn
==3517== Memcheck, a memory error detector.
==3517== Copyright (C) 2002-2007, and GNU GPL'd, by Julian Seward et al.
==3517== Using LibVEX rev 1854, a library for dynamic binary translation.
==3517== Copyright (C) 2004-2007, and GNU GPL'd, by OpenWorks LLP.
==3517== Using valgrind-3.3.1-Debian, a dynamic binary instrumentation framework.
==3517== Copyright (C) 2000-2007, and GNU GPL'd, by Julian Seward et al.
==3517== For more details, rerun with: -v
==3517==
bluetoothd[3517]: Bluetooth daemon
bluetoothd[3517]: Enabling debug information
bluetoothd[3517]: parsing main.conf
bluetoothd[3517]: offmode=NoScan
bluetoothd[3517]: discovto=0
bluetoothd[3517]: pageto=8192
bluetoothd[3517]: name=%h-%d
bluetoothd[3517]: class=0x000100
bluetoothd[3517]: inqmode=0
bluetoothd[3517]: Starting SDP server
bluetoothd[3517]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[3517]: /home/stuart/ws/install/bluez/git/bluez/plugins/audio.so
bluetoothd[3517]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[3517]: Unix socket created: 11
bluetoothd[3517]: Telephony plugin initialized
bluetoothd[3517]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[3517]: /home/stuart/ws/install/bluez/git/bluez/plugins/serial.so
bluetoothd[3517]: /home/stuart/ws/install/bluez/git/bluez/plugins/hal.so
bluetoothd[3517]: /home/stuart/ws/install/bluez/git/bluez/plugins/service.so
bluetoothd[3517]: /home/stuart/ws/install/bluez/git/bluez/plugins/network.so
bluetoothd[3517]: Parsing /etc/bluetooth/network.conf failed: No such file or directory
bluetoothd[3517]: Config options: InterfacePrefix=bnep%d, PANU_Script=(null), GN_Script=(null), NAP_Script=(null), GN_Interface=pan0, NAP_Interface=pan1, Security=true
==3517== Warning: noted but unhandled ioctl 0x89a0 with no size/direction hints
==3517==    This could cause spurious value errors to appear.
==3517==    See README_MISSING_SYSCALL_OR_IOCTL for guidance on writing a proper wrapper.
bluetoothd[3517]: Can't create GN bridge
bluetoothd[3517]: /home/stuart/ws/install/bluez/git/bluez/plugins/input.so
bluetoothd[3517]: input.conf: Key file does not have key 'IdleTimeout'
bluetoothd[3517]: HCI dev 0 registered
bluetoothd[3517]: child 3518 forked
bluetoothd[3517]: HCI dev 0 up
bluetoothd[3517]: Can't read class of adapter on /org/bluez/hci0: Input/output error (5)
bluetoothd[3517]: Starting security manager 0
==3518==
==3518== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 104 from 2)
==3518== malloc/free: in use at exit: 30,412 bytes in 352 blocks.
==3518== malloc/free: 751 allocs, 399 frees, 292,193 bytes allocated.
==3518== For counts of detected errors, rerun with: -v
==3518== searching for pointers to 352 not-freed blocks.
==3518== checked 146,352 bytes.
==3518==
==3518== LEAK SUMMARY:
==3518==    definitely lost: 0 bytes in 0 blocks.
==3518==      possibly lost: 744 bytes in 3 blocks.
==3518==    still reachable: 29,668 bytes in 349 blocks.
==3518==         suppressed: 0 bytes in 0 blocks.
==3518== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[3517]: child 3518 exited
bluetoothd[3517]: Accepted new client connection on unix socket (fd=16)
bluetoothd[3517]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[3517]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[3517]: Unix client disconnected (fd=16)
bluetoothd[3517]: HCI dev 0 down
bluetoothd[3517]: headset_server_remove: path /org/bluez/hci0
bluetoothd[3517]: a2dp_server_remove: path /org/bluez/hci0
bluetoothd[3517]: avrcp_server_remove: path /org/bluez/hci0
bluetoothd[3517]: proxy_remove: path /org/bluez/hci0
process 3517: arguments to dbus_connection_unref() were incorrect, assertion "connection != NULL" failed in file dbus-connection.c line 2645.
This is normally a bug in some application using the D-Bus library.
bluetoothd[3517]: service_remove: path /org/bluez/hci0
bluetoothd[3517]: network_server_remove: path /org/bluez/hci0
bluetoothd[3517]: network_server_remove: path /org/bluez/hci0
bluetoothd[3517]: network_server_remove: path /org/bluez/hci0
bluetoothd[3517]: Adapter /org/bluez/hci0 has been disabled
bluetoothd[3517]: Stopping security manager 0
bluetoothd[3517]: HCI dev 0 unregistered
bluetoothd[3517]: Unregister path: /org/bluez/hci0
bluetoothd[3517]: Removing adapter /org/bluez/hci0
bluetoothd[3517]: HCI dev 0 registered
bluetoothd[3517]: child 3787 forked
bluetoothd[3517]: HCI dev 0 up
bluetoothd[3517]: Can't read class of adapter on /org/bluez/hci0: Input/output error (5)
bluetoothd[3517]: Starting security manager 0
==3787==
==3787== ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 104 from 2)
==3787== malloc/free: in use at exit: 30,422 bytes in 353 blocks.
==3787== malloc/free: 927 allocs, 574 frees, 501,820 bytes allocated.
==3787== For counts of detected errors, rerun with: -v
==3787== searching for pointers to 353 not-freed blocks.
==3787== checked 146,624 bytes.
==3787==
==3787== LEAK SUMMARY:
==3787==    definitely lost: 0 bytes in 0 blocks.
==3787==      possibly lost: 744 bytes in 3 blocks.
==3787==    still reachable: 29,678 bytes in 350 blocks.
==3787==         suppressed: 0 bytes in 0 blocks.
==3787== Rerun with --leak-check=full to see details of leaked memory.
bluetoothd[3517]: child 3787 exited
bluetoothd[3517]: Accepted new client connection on unix socket (fd=17)
bluetoothd[3517]: Audio API: received BT_GETCAPABILITIES_REQ
bluetoothd[3517]: Audio API: sending BT_GETCAPABILITIES_RSP
bluetoothd[3517]: Unix client disconnected (fd=17)

