Return-Path: <cyrus@holtmann.org>
Message-ID: <4884D04F.9000800@suse.de>
Date: Mon, 21 Jul 2008 20:07:11 +0200
From: Stefan Seyfried <seife@suse.de>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Mouse connect problem, since 3.36?
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi,

Since we fixed the idle timeout for the Logitech MX1000, everything was fin=
e.
However, since i moved to a freshly installed new machine, at the same time
upgrading to bluez-3.36, i have another mouse connect problem.

The mouse does not connect initially (e.g. after boot), or, to put it more
correct: it connects, but there is no input device created and it gets
disconnected again very soon.
To get an input device, i need to issue

   dbus-send --system --type=3Dmethod_call --print-reply --dest=3D"org.blue=
z" \
             /org/bluez/input/pointing1 org.bluez.input.Device.Connect

(which should not be necessary).

As long as the mouse is trying to connect (before dbus-send), i get this wi=
th
apitest -l:

RemoteDeviceConnected - /org/bluez/hci0: 00:07:61:3F:1B:6D
RemoteNameUpdated - /org/bluez/hci0: 00:07:61:3F:1B:6D Logitech MX1000 mouse

RemoteDeviceDisconnected - /org/bluez/hci0: 00:07:61:3F:1B:6D

RemoteDeviceConnected - /org/bluez/hci0: 00:07:61:3F:1B:6D

RemoteNameUpdated - /org/bluez/hci0: 00:07:61:3F:1B:6D Logitech MX1000 mouse

RemoteDeviceDisconnected - /org/bluez/hci0: 00:07:61:3F:1B:6D

"hcid -x -n -d" shows:

root@susi:~# hcid -x -n -d
hcid[28609]: Bluetooth HCI daemon
hcid[28609]: Enabling debug information
hcid[28609]: Parsing /etc/bluetooth/main.conf failed: No such file or direc=
tory
hcid[28609]: Registering experimental manager interface
hcid[28609]: Starting SDP server
hcid[28609]: Adding rec : 0xb7faeef0
hcid[28609]: with handle : 0x1
hcid[28609]: Adding rec : 0xb7faf0c0
hcid[28609]: with handle : 0x0
hcid[28609]: Service classes 0x00
hcid[28609]: Loading plugins /usr/lib/bluetooth/plugins
hcid[28609]: /usr/lib/bluetooth/plugins/libnetlink.so
hcid[28609]: Starting experimental netlink support
hcid[28609]: Failed to find Bluetooth netlink family
hcid[28609]: Can't init plugin /usr/lib/bluetooth/plugins/libnetlink.so
hcid[28609]: /usr/lib/bluetooth/plugins/libnetwork.so
hcid[28609]: Parsing /etc/bluetooth/network.conf failed: No such file or di=
rectory
hcid[28609]: Config options: InterfacePrefix=3Dbnep%d, PANU_Script=3D(null),
GN_Script=3D(null), NAP_Script=3D(null), GN_Interface=3Dpan0, NAP_Interface=
=3Dpan1,
Security=3Dtrue



hcid[28609]: bridge pan0 created


hcid[28609]: Registered manager path:/org/bluez/network


hcid[28609]: Registered server path:/org/bluez/network/nap


hcid[28609]: Registered server path:/org/bluez/network/gn


hcid[28609]: Registered server path:/org/bluez/network/panu


hcid[28609]: name network uuid 00001115-0000-1000-8000-00805f9b34fb


hcid[28609]: name network uuid 00001116-0000-1000-8000-00805f9b34fb


hcid[28609]: name network uuid 00001117-0000-1000-8000-00805f9b34fb


hcid[28609]: Registering service object: network (/org/bluez/service_networ=
k)


hcid[28609]: /usr/lib/bluetooth/plugins/libinput.so


hcid[28609]: Parsing /etc/bluetooth/input.conf failed: No such file or
directory

hcid[28609]: Registered input manager path:/org/bluez/input


hcid[28609]: Created input device: /org/bluez/input/keyboard0


hcid[28609]: Created input device: /org/bluez/input/pointing1


hcid[28609]: name input uuid 00001124-0000-1000-8000-00805f9b34fb


hcid[28609]: Registering service object: input (/org/bluez/service_input)


hcid[28609]: /usr/lib/bluetooth/plugins/libserial.so


hcid[28609]: Registered manager path:/org/bluez/serial


hcid[28609]: name serial uuid 00001101-0000-1000-8000-00805F9B34FB


hcid[28609]: name serial uuid 00001103-0000-1000-8000-00805F9B34FB


hcid[28609]: Registering service object: serial (/org/bluez/service_serial)


hcid[28609]: HCI dev 0 registered


hcid[28609]: HCI dev 0 already up


hcid[28609]: Device hci0 has been added


hcid[28609]: Starting security manager 0


hcid[28609]: Device hci0 has been activated


hcid[28609]: Creating device /hci0/dev_00_07_61_99_AF_D6


hcid[28609]: Creating device /hci0/dev_00_12_EE_23_CE_EA


hcid[28609]: child 28618 exited


hcid[28609]: child 28621 exited


hcid[28609]: Incoming connection on PSM 17


hcid[28609]: Incoming connection on PSM 19


hcid[28609]: Incoming connection on PSM 17


hcid[28609]: Incoming connection on PSM 19


hcid[28609]: Default passkey agent (:1.1155, /org/kde/kbluetooth_1234)
registered

hcid[28609]: Default authorization agent (:1.1155,
/org/kde/kbluetooth_auth_1234) registered

hcid[28609]: Service register request


hcid[28609]: Look ahead attr id : 1


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 0


hcid[28609]: DTD of attrId : 9 Attr id : 0x1


hcid[28609]: Attr id : 0x1 attrValueLength : 5


hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 8


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 8


hcid[28609]: DTD of attrId : 9 Attr id : 0x4


hcid[28609]: Attr id : 0x4 attrValueLength : 19


hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 30


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 30


hcid[28609]: DTD of attrId : 9 Attr id : 0x5


hcid[28609]: Attr id : 0x5 attrValueLength : 5


hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 38


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 38


hcid[28609]: DTD of attrId : 9 Attr id : 0x9


hcid[28609]: Attr id : 0x9 attrValueLength : 10


hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 51


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 51


hcid[28609]: DTD of attrId : 9 Attr id : 0x100


hcid[28609]: Attr id : 0x100 attrValueLength : 18


hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 72


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 72


hcid[28609]: DTD of attrId : 9 Attr id : 0x101


hcid[28609]: Attr id : 0x101 attrValueLength : 30


hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 105


hcid[28609]: Extract PDU, sequenceLength: 124 localExtractedLength: 105


hcid[28609]: DTD of attrId : 9 Attr id : 0x303
hcid[28609]: Attr id : 0x303 attrValueLength : 16
hcid[28609]: Extract PDU, seqLength: 124 localExtractedLength: 124
hcid[28609]: Successful extracting of Svc Rec attributes
hcid[28609]: Couldn't find record for : 0x10000
hcid[28609]: Adding rec : 0xb7fb3720
hcid[28609]: with handle : 0x10000
hcid[28609]: Service classes 0x10
hcid[28609]: Sending rsp. status 0
hcid[28609]: Bytes Sent : 9
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
hcid[28609]: Incoming connection on PSM 17
hcid[28609]: Incoming connection on PSM 19
####### dbus-send here #######
hcid[28609]: New input device 00:07:61:3F:1B:6D (Logitech MX1000 mouse)

I had also rumors that this happens with openSUSE 11.0 which has bluez-3.32,
but i need to confirm that.

Anything else needed to debug this?

I can reproduce it easily with

    dbus-send --system --type=3Dmethod_call --print-reply --dest=3D"org.blu=
ez" \
              /org/bluez/input/pointing1 org.bluez.input.Device.Disconnect

The mouse will not reconnect until I issue a "Connect" again.

Thanks,

	Stefan
-- =

Stefan Seyfried
R&D Team Mobile Devices            |              "Any ideas, John?"
SUSE LINUX Products GmbH, N=FCrnberg | "Well, surrounding them's out."

This footer brought to you by insane German lawmakers:
SUSE Linux Products GmbH, GF: Markus Rex, HRB 16746 (AG N=FCrnberg)

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great priz=
es
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=3D100&url=3D/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
