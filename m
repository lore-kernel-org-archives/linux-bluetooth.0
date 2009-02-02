Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: How can i configure bluez to transmit Voice over PCM
Date: Mon, 2 Feb 2009 17:23:40 +0100
Message-ID: <49ED01FC03EE524BB7BB258E8F93BFF32F3E28@bfl-exchange-1.BFL.local>
In-Reply-To: <1233565089.4668.15.camel@californication>
References: <49ED01FC03EE524BB7BB258E8F93BFF32F3DB5@bfl-exchange-1.BFL.local> <1233507125.4809.2.camel@californication> <49ED01FC03EE524BB7BB258E8F93BFF32F3DD5@bfl-exchange-1.BFL.local> <1233565089.4668.15.camel@californication>
From: "Matuschka, Sebastian" <Sebastian.Matuschka@gcd-solutions.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: <linux-bluetooth@vger.kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>

>=20
> let me repeat this; _NO_ top-posting. I really mean it.
>=20
Sorry, i should have known it.

> > is it possible to use Version 4.27 for embedded systems without any
> > Desktop Environment only with commandline?
> > I will try to switch to 4.27.
>=20
> it is possible. Currently we only have Python scripts that use the
D-Bus
> interfaces, but in the future we gonna have a full blown command line
> client for BlueZ.

Python is not really an option for our embedded system.
I got bluez 4.27 running and all I have tested worked.
But I have a problem with the pairing:
Since there is no passkey-agent any longer and I don't want to run
python scripts I tried agent but it starts with an error message:
=20
/usr/bin # agent 0000
Can't register agent
Method "RegisterAgent" with signature "os" on interface
"org.bluez.Adapter" doesn't exist

It is the new agent:
/usr/bin # agent
Bluetooth agent ver 4.27

Usage:
        agent [--device interface] [--path agent-path] <passkey>

var/log/messages says: daemon.err bluetoothd[371]: Failed to access HAL
Maybe this is a problem?
But the device is ok:
~ # hciconfig -a
hci0:   Type: UART
        BD Address: 00:80:25:07:1F:7E ACL MTU: 310:10 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN AUTH
        RX bytes:1161 acl:0 sco:0 events:47 errors:0
        TX bytes:502 acl:0 sco:0 commands:47 errors:0
        Features: 0xff 0xff 0x8f 0xfe 0x9b 0xf9 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'ravenbt-0'
        Class: 0x0a220c
        Service Classes: Networking, Capturing
        Device Class: Phone, Smart phone
        HCI Ver: 2.0 (0x3) HCI Rev: 0x10c6 LMP Ver: 2.0 (0x3) LMP
Subver: 0x10c6
        Manufacturer: Cambridge Silicon Radio (10)


Regards
Sebastian

Full var/log/messages:
Dec 31 23:00:08 ravenbt daemon.info bluetoothd[371]: Bluetooth daemon
Dec 31 23:00:08 ravenbt daemon.info bluetoothd[371]: Enabling debug
information
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: parsing main.conf
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: discovto=3D0
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: pairto=3D0
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: pageto=3D8192
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: name=3D%h-%d
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: class=3D0x000100
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: inqmode=3D0
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: Key file does not
have key 'DeviceID'
Dec 31 23:00:08 ravenbt daemon.info bluetoothd[371]: Starting SDP server
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: Loading plugins
/usr/lib/bluetooth/plugins
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]:
register_interface: path /org/bluez/371/any
Dec 31 23:00:08 ravenbt daemon.info bluetoothd[371]: Registered
interface org.bluez.Service on path /org/bluez/371/any
Dec 31 23:00:08 ravenbt daemon.err bluetoothd[371]: Parsing
/etc/bluetooth/network.conf failed: No such file or directory
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: Config options:
InterfacePrefix=3Dbnep%d, PANU_Script=3D(null), GN_Script=3D(null),
NAP_Script=3D(null), GN_Interface=3Dpan0, NAP_Interface=3Dpan1, =
Security=3Dtrue
Dec 31 23:00:08 ravenbt daemon.err bluetoothd[371]: Can't create GN
bridge
Dec 31 23:00:08 ravenbt daemon.err bluetoothd[371]: Parsing
/etc/bluetooth/input.conf failed: No such file or directory
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: Unix socket
created: 13
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have key 'MaxConnected'
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: Telephony plugin
initialized
Dec 31 23:00:08 ravenbt daemon.debug bluetoothd[371]: HFP AG features:
"Ability to reject a call" "Enhanced call status" "Extended Error Result
Codes"
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: HCI dev 0
registered
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: child 376 forked
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: child 376 exited
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: HCI dev 0 up
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Starting security
manager 0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
register_interface: path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Registered
interface org.bluez.Service on path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: proxy_probe: path
/org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Registered
interface org.bluez.SerialProxyManager on path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
network_server_probe: path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10000
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000000f-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001115-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
register_server_record: got record id 0x10000
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Registered
interface org.bluez.NetworkPeer on path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
network_server_probe: path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10001
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000000f-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001117-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
register_server_record: got record id 0x10001
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Registered
interface org.bluez.NetworkHub on path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
network_server_probe: path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10002
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000000f-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001116-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
register_server_record: got record id 0x10002
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Registered
interface org.bluez.NetworkRouter on path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
headset_server_probe: path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have key 'Master'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10003
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000003-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001108-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001112-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001203-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: a2dp_server_probe:
path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have key 'Disable'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have group 'A2DP'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have group 'A2DP'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have group 'A2DP'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have group 'A2DP'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have key 'Master'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: SEP 0x375f0
registered: type:0 codec:0 seid:1
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10004
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000019-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000110a-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000110d-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]:
avrcp_server_probe: path /org/bluez/371/hci0
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: audio.conf: Key
file does not have key 'Master'
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10005
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000017-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000110c-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000110e-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Adding record with
handle 0x10006
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000017-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00000100-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 00001002-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Record pattern
UUID 0000110e-0000-1000-8000-00805f9
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Creating device
/org/bluez/371/hci0/dev_00_16_38_CA_56_4D
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Creating device
/org/bluez/371/hci0/dev_00_17_E3_94_54_70
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Creating device
/org/bluez/371/hci0/dev_00_1F_01_0D_06_3D
Dec 31 23:00:12 ravenbt daemon.debug bluetoothd[371]: Creating device
/org/bluez/371/hci0/dev_00_13_1E_14_FA_E4
Dec 31 23:00:12 ravenbt daemon.info bluetoothd[371]: Adapter
/org/bluez/371/hci0 has been enabled
Dec 31 23:00:12 ravenbt daemon.err bluetoothd[371]: Failed to access HAL
