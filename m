Return-Path: <cyrus@holtmann.org>
Message-ID: <1ec247c80901100548p2887b917m42284168322752ea@mail.gmail.com>
Date: Sat, 10 Jan 2009 14:48:48 +0100
From: Nicolas <ngclaude@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluez 4.26 and connection timed out
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello,

I want to test an headset on Linux with Bluetooth.
I use the adapter Ovislink EVO-BT2-100 (Bluetooth 2.0), headset
Motorola H270 (Bluetooth 2.1), Gentoo on Linux kernel 2.6.27.6 (with
the driver hci_usb, btusb doesn't pairing) and Bluez 4.26.
I have a problem similar to this discussion:
http://thread.gmane.org/gmane.linux.bluez.kernel/456

When I start the headset, the pairing process is ok, and the heandset
go into sleep/unpairing.
bluetoothd[21367]: kernel auth requirements = 0x00
bluetoothd[21367]: stored link key type = 0x00
bluetoothd[21367]: State changed
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[21367]: authorize request was sent for
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01
bluetoothd[21367]: Accepted headset connection from 00:1A:0E:DA:1F:01
for /org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01
bluetoothd[21367]: telephony-dummy: device 0x7fe033401790 disconnected
bluetoothd[21367]: State changed
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED


Next when I run the command "arecord -D bluetooth -f S16_LE test.wav"
Bluetoothd connect to the headset and start the record. But after 40s
the record stop (no file created) and bluetoothd make a connect timed
out :

bluetoothd[21367]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[21367]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[21367]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[21367]: config sco - device = 00:1A:0E:DA:1F:01 access_mode = 1
bluetoothd[21367]: /org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
Connecting to 00:1A:0E:DA:1F:01 channel 1
bluetoothd[21367]: State changed
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[21367]: adapter_get_device(00:1A:0E:DA:1F:01)
bluetoothd[21367]: link_key_request (sba=00:11:67:C3:00:99,
dba=00:1A:0E:DA:1F:01)
bluetoothd[21367]: kernel auth requirements = 0x04
bluetoothd[21367]: stored link key type = 0x00
bluetoothd[21367]: /org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
Connected to 00:1A:0E:DA:1F:01
bluetoothd[21367]: telephony-dummy: device 0x7fe033401790 connected
bluetoothd[21367]: State changed
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[21367]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[21367]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[21367]: State changed
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01: HEADSET_STATE_CONNECTED
-> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[21367]: Received AT+VGS=15
bluetoothd[21367]: Received AT+VGM=9
bluetoothd[21367]: connect(): Connection timed out (110)
bluetoothd[21367]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[21367]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[21367]: unix_sendmsg_fd: Bad file descriptor(9)
bluetoothd[21367]: telephony-dummy: device 0x7fe033401790 disconnected
bluetoothd[21367]: State changed
/org/bluez/21367/hci0/dev_00_1A_0E_DA_1F_01:
HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[21367]: headset_resume_complete: resume failed
bluetoothd[21367]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[21367]: Unix client disconnected (fd=13)
bluetoothd[21367]: No matching connection for handle 2

The Alsa error is:
arecord: set_params:1015: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
....

With Strace I see it's a PF_BLUETOOTH (with ther kernel ??) socket error.

Recent Bluez 3.x make the same problem and old crash rfcomm in the kernel.
It's only work on Ubuntu Hardy, kernel 2.6.24 bluez 3.26 with "lm
accept,master;" and "lp hold,sniff,park;" (not in bluez 4),, but
2.6.24 is a bit old for ext4...

Thanks in advance.
Regards.

Nicolas
