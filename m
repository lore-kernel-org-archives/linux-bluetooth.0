Return-Path: <cyrus@holtmann.org>
Message-ID: <49CCD669.7000704@powercraft.nl>
Date: Fri, 27 Mar 2009 14:36:41 +0100
From: Jelle de Jong <jelledejong@powercraft.nl>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: voice bluethooth headsets broken with latest git?
Content-Type: multipart/mixed;
 boundary="------------040809000805060909020403"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040809000805060909020403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello everybody,

I have been doing some testing for somebody that reported his blueotooth
voice headset was not working.

I did some testing and i can confirm this with my headsets.

I use the latest git:
http://filebin.ca/zowyxw/bluez-utils_4.34git_i386.deb

Please see the attached logs.

Why does it not work, and is there any indication when it will work again?

Thanks in advance,

Best regards,

Jelle de Jong

--------------040809000805060909020403
Content-Type: text/x-log;
 name="arecord0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="arecord0.log"

$ arecord -f S16_LE | aplay -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:1571:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1530:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
arecord: set_params:979: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
SAMPLE_BITS: 16
FRAME_BITS: 16
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 125000
PERIOD_SIZE: 1000
PERIOD_BYTES: 2000
PERIODS: 4
BUFFER_TIME: 500000
BUFFER_SIZE: 4000
BUFFER_BYTES: 8000
TICK_TIME: 0
aplay: playback:2019: read error

--------------040809000805060909020403
Content-Type: text/x-log;
 name="bluetoohd0.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluetoohd0.log"

$ sudo killall bluetoothd ; sudo bluetoothd -d -n
bluetoothd: no process killed
bluetoothd[4286]: Bluetooth daemon
bluetoothd[4286]: Enabling debug information
bluetoothd[4286]: parsing main.conf
bluetoothd[4286]: discovto=0
bluetoothd[4286]: pairto=0
bluetoothd[4286]: pageto=8192
bluetoothd[4286]: name=%h-%d
bluetoothd[4286]: class=0x000100
bluetoothd[4286]: inqmode=0
bluetoothd[4286]: Key file does not have key 'DeviceID'
bluetoothd[4286]: Starting SDP server
bluetoothd[4286]: Loading plugins /usr/lib/bluetooth/plugins
bluetoothd[4286]: register_interface: path /org/bluez/4286/any
bluetoothd[4286]: Registered interface org.bluez.Service on path /org/bluez/4286/any
bluetoothd[4286]: Parsing /etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[4286]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[4286]: Unix socket created: 10
bluetoothd[4286]: Telephony plugin initialized
bluetoothd[4286]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes"
bluetoothd[4286]: HCI dev 0 registered
bluetoothd[4286]: child 4287 forked
bluetoothd[4286]: HCI dev 1 registered
bluetoothd[4286]: child 4288 forked
bluetoothd[4286]: child 4287 exited
bluetoothd[4286]: HCI dev 0 up
bluetoothd[4286]: Starting security manager 0
bluetoothd[4286]: register_interface: path /org/bluez/4286/hci0
bluetoothd[4286]: Registered interface org.bluez.Service on path /org/bluez/4286/hci0
bluetoothd[4286]: proxy_probe: path /org/bluez/4286/hci0
bluetoothd[4286]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/4286/hci0
bluetoothd[4286]: headset_server_probe: path /org/bluez/4286/hci0
bluetoothd[4286]: Adding record with handle 0x10000
bluetoothd[4286]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4286]: Adding record with handle 0x10001
bluetoothd[4286]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4286]: Changing service classes to 0x40010c
bluetoothd[4286]: a2dp_server_probe: path /org/bluez/4286/hci0
bluetoothd[4286]: SEP 0xb8025018 registered: type:0 codec:0 seid:1
bluetoothd[4286]: Adding record with handle 0x10002
bluetoothd[4286]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[4286]: Changing service classes to 0x48010c
bluetoothd[4286]: avrcp_server_probe: path /org/bluez/4286/hci0
bluetoothd[4286]: Adding record with handle 0x10003
bluetoothd[4286]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4286]: Changing service classes to 0x48010c
bluetoothd[4286]: Changing service classes to 0x480000
bluetoothd[4286]: Adding record with handle 0x10004
bluetoothd[4286]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4286]: Changing service classes to 0x48010c
bluetoothd[4286]: Changing service classes to 0x480000
bluetoothd[4286]: Creating device /org/bluez/4286/hci0/dev_00_07_61_8A_1A_AA
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci0/dev_00_07_61_8A_1A_AA
bluetoothd[4286]: hid_device_probe: path /org/bluez/4286/hci0/dev_00_07_61_8A_1A_AA
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci0/dev_00_07_61_8A_1A_AA
bluetoothd[4286]: Creating device /org/bluez/4286/hci0/dev_11_11_11_11_17_95
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci0/dev_11_11_11_11_17_95
bluetoothd[4286]: hid_device_probe: path /org/bluez/4286/hci0/dev_11_11_11_11_17_95
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci0/dev_11_11_11_11_17_95
bluetoothd[4286]: Creating device /org/bluez/4286/hci0/dev_00_12_A1_01_05_43
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci0/dev_00_12_A1_01_05_43
bluetoothd[4286]: hid_device_probe: path /org/bluez/4286/hci0/dev_00_12_A1_01_05_43
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci0/dev_00_12_A1_01_05_43
bluetoothd[4286]: Creating device /org/bluez/4286/hci0/dev_00_12_A1_01_04_16
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci0/dev_00_12_A1_01_04_16
bluetoothd[4286]: hid_device_probe: path /org/bluez/4286/hci0/dev_00_12_A1_01_04_16
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci0/dev_00_12_A1_01_04_16
bluetoothd[4286]: Creating device /org/bluez/4286/hci0/dev_00_07_61_0F_4A_60
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci0/dev_00_07_61_0F_4A_60
bluetoothd[4286]: hid_device_probe: path /org/bluez/4286/hci0/dev_00_07_61_0F_4A_60
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci0/dev_00_07_61_0F_4A_60
bluetoothd[4286]: Creating device /org/bluez/4286/hci0/dev_B9_81_08_01_03_45
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci0/dev_B9_81_08_01_03_45
bluetoothd[4286]: hid_device_probe: path /org/bluez/4286/hci0/dev_B9_81_08_01_03_45
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci0/dev_B9_81_08_01_03_45
bluetoothd[4286]: Adapter /org/bluez/4286/hci0 has been enabled
bluetoothd[4286]: child 4288 exited
bluetoothd[4286]: HCI dev 1 up
bluetoothd[4286]: Starting security manager 1
bluetoothd[4286]: register_interface: path /org/bluez/4286/hci1
bluetoothd[4286]: Registered interface org.bluez.Service on path /org/bluez/4286/hci1
bluetoothd[4286]: proxy_probe: path /org/bluez/4286/hci1
bluetoothd[4286]: Registered interface org.bluez.SerialProxyManager on path /org/bluez/4286/hci1
bluetoothd[4286]: headset_server_probe: path /org/bluez/4286/hci1
bluetoothd[4286]: Adding record with handle 0x10005
bluetoothd[4286]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4286]: Adding record with handle 0x10006
bluetoothd[4286]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[4286]: a2dp_server_probe: path /org/bluez/4286/hci1
bluetoothd[4286]: SEP 0xb8028ae8 registered: type:0 codec:0 seid:1
bluetoothd[4286]: Adding record with handle 0x10007
bluetoothd[4286]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[4286]: avrcp_server_probe: path /org/bluez/4286/hci1
bluetoothd[4286]: Adding record with handle 0x10008
bluetoothd[4286]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4286]: Adding record with handle 0x10009
bluetoothd[4286]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[4286]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[4286]: Creating device /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: serial_probe: path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[4286]: Registered interface org.bluez.Serial on path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: serial_probe: path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[4286]: headset_probe: path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: adapter_get_device(00:0C:55:D1:C9:78)
bluetoothd[4286]: Found Headset record
bluetoothd[4286]: Discovered Headset service on RFCOMM channel 2
bluetoothd[4286]: Registered interface org.bluez.Headset on path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: Found Handsfree record
bluetoothd[4286]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[4286]: Found Audio Sink
bluetoothd[4286]: Registered interface org.bluez.AudioSink on path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: Found AV Remote
bluetoothd[4286]: Registered interface org.bluez.Control on path /org/bluez/4286/hci1/dev_00_0C_55_D1_C9_78
bluetoothd[4286]: Creating device /org/bluez/4286/hci1/dev_00_1A_80_AB_0A_B1
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci1/dev_00_1A_80_AB_0A_B1
bluetoothd[4286]: adapter_get_device(00:1A:80:AB:0A:B1)
bluetoothd[4286]: Found Audio Sink
bluetoothd[4286]: Registered interface org.bluez.AudioSink on path /org/bluez/4286/hci1/dev_00_1A_80_AB_0A_B1
bluetoothd[4286]: Found AV Target
bluetoothd[4286]: Registered interface org.bluez.Control on path /org/bluez/4286/hci1/dev_00_1A_80_AB_0A_B1
bluetoothd[4286]: Found AV Target
bluetoothd[4286]: Creating device /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C
bluetoothd[4286]: Probe drivers for /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C
bluetoothd[4286]: serial_probe: path /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[4286]: Registered interface org.bluez.Serial on path /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C
bluetoothd[4286]: serial_probe: path /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[4286]: headset_probe: path /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C
bluetoothd[4286]: Registered interface org.bluez.Input on path /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C
bluetoothd[4286]: adapter_get_device(00:53:53:FB:7E:9C)
bluetoothd[4286]: Found Headset record
bluetoothd[4286]: Discovered Headset service on RFCOMM channel 1
bluetoothd[4286]: Registered interface org.bluez.Headset on path /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C
bluetoothd[4286]: Found Handsfree record
bluetoothd[4286]: Discovered Handsfree service on RFCOMM channel 2
bluetoothd[4286]: Adapter /org/bluez/4286/hci1 has been enabled
bluetoothd[4286]: Computer is classified as laptop
bluetoothd[4286]: Current device class is 0x48010c
bluetoothd[4286]: Setting 0x00010c for major/minor device class
bluetoothd[4286]: Changing major/minor class to 0x48010c
bluetoothd[4286]: Computer is classified as laptop
bluetoothd[4286]: Current device class is 0x48010c
bluetoothd[4286]: Setting 0x00010c for major/minor device class
bluetoothd[4286]: Changing major/minor class to 0x48010c
bluetoothd[4286]: adapter_get_device(00:12:A1:01:05:43)
bluetoothd[4286]: Incoming connection on PSM 17
bluetoothd[4286]: Incoming connection on PSM 19
bluetoothd[4286]: link_key_request (sba=00:15:AF:F4:E9:E0, dba=00:07:61:8A:1A:AA)
bluetoothd[4286]: kernel auth requirements = 0x00
bluetoothd[4286]: stored link key type = 0x00
bluetoothd[4286]: adapter_get_device(00:07:61:8A:1A:AA)
bluetoothd[4286]: Incoming connection on PSM 17
bluetoothd[4286]: Incoming connection on PSM 19
bluetoothd[4286]: link_key_request (sba=00:15:AF:F4:E9:E0, dba=00:07:61:8A:1A:AA)
bluetoothd[4286]: kernel auth requirements = 0x00
bluetoothd[4286]: stored link key type = 0x00
bluetoothd[4286]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[4286]: adapter_get_device(00:07:61:8A:1A:AA)
bluetoothd[4286]: hcid_dbus_bonding_process_complete: no pending auth request
^[[Abluetoothd[4286]: Accepted new client connection on unix socket (fd=29)
bluetoothd[4286]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[4286]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[4286]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[4286]: config sco - device = 00:53:53:FB:7E:9C access_mode = 1
bluetoothd[4286]: /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: Connecting to 00:53:53:FB:7E:9C channel 2
bluetoothd[4286]: State changed /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[4286]: Accepted new client connection on unix socket (fd=31)
bluetoothd[4286]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[4286]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[4286]: adapter_get_device(00:53:53:FB:7E:9C)
bluetoothd[4286]: link_key_request (sba=00:1B:DC:00:32:71, dba=00:53:53:FB:7E:9C)
bluetoothd[4286]: kernel auth requirements = 0x00
bluetoothd[4286]: stored link key type = 0x00
bluetoothd[4286]: /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: Connected to 00:53:53:FB:7E:9C
bluetoothd[4286]: Received AT+BRSF=30
bluetoothd[4286]: HFP HF features: "Call waiting and 3-way calling" "CLI presentation capability" "Voice recognition activation" "Remote volume control"
bluetoothd[4286]: Received AT+CIND=?
bluetoothd[4286]: Received AT+CIND?
bluetoothd[4286]: Received AT+CMER=3,0,0,1
bluetoothd[4286]: Event reporting (CMER): mode=3, ind=1
bluetoothd[4286]: HFP Service Level Connection established
bluetoothd[4286]: telephony-dummy: device 0xb802bb40 connected
bluetoothd[4286]: State changed /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[4286]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[4286]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[4286]: State changed /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[4286]: Received AT+VGM=11
bluetoothd[4286]: Received AT+VGS=0
bluetoothd[4286]: Received AT+CLIP=1
bluetoothd[4286]: Received AT+CCWA=1
bluetoothd[4286]: Call waiting notification enabled for headset 0xb802bba8
bluetoothd[4286]: Received AT+COPS=3,0
bluetoothd[4286]: Received AT+CMEE=1
bluetoothd[4286]: CME errors enabled for headset 0xb802bba8
bluetoothd[4286]: HUP or ERR on socket
bluetoothd[4286]: Unable to get a SCO fd
bluetoothd[4286]: telephony-dummy: device 0xb802bb40 disconnected
bluetoothd[4286]: State changed /org/bluez/4286/hci1/dev_00_53_53_FB_7E_9C: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[4286]: headset_resume_complete: resume failed
bluetoothd[4286]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[4286]: Unix client disconnected (fd=29)
bluetoothd[4286]: Unix client disconnected (fd=31)
bluetoothd[4286]: No matching connection found for handle 45



--------------040809000805060909020403
Content-Type: text/plain;
 name="asoundrc"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="asoundrc"

cGNtLmhlYWRzZXQgewogICAgdHlwZSBibHVldG9vdGgKICAgICN+IGRldmljZSAwMDowRDox
ODpBMDozNTo3MAogICAgZGV2aWNlIDAwOjUzOjUzOkZCOjdFOjlDICMgTm9raWEgQkgtODAx
CiAgICAjfiBkZXZpY2UgMDA6MEM6NTU6RDE6Qzk6NzggIyBNb3Rvcm9sYSBTODA1CiAgICAj
fiBkZXZpY2UgMDA6MEQ6RkQ6MTg6NkU6M0MgIyBtb3Rvcm9sYSBzOQogICAgI34gcHJvZmls
ZSBoaWZpCiAgICBwcm9maWxlIHZvaWNlCiAgICAjcHJvZmlsZSBhdXRvCn0KcGNtLnNvZnR2
b2wgewogICAgdHlwZSBzb2Z0dm9sCiAgICBzbGF2ZS5wY20gaGVhZHNldAogICAgY29udHJv
bC5uYW1lIEhlYWRzZXQKICAgIGNvbnRyb2wuY2FyZCAwCn0KcGNtLiFkZWZhdWx0IHsKICAg
ICN+IHR5cGUgaHcKICAgICN+IGNhcmQgMAogICAgdHlwZSBwbHVnCiAgICBzbGF2ZS5wY20g
c29mdHZvbAp9Cg==
--------------040809000805060909020403
Content-Type: text/plain;
 name="nokia-bh-801-information.txt"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="nokia-bh-801-information.txt"

aGNpdG9vbCBzY2FuClNjYW5uaW5nIC4uLgogICAgMDA6NTM6NTM6RkI6N0U6OUMgICBOb2tp
YSBCSC04MDEKCnN1ZG8gcHl0aG9uIC5zaW1wbGUtYWdlbnQucHkgaGNpMSAwMDo1Mzo1MzpG
Qjo3RTo5QwpSZXF1ZXN0UGluQ29kZSAoL29yZy9ibHVlei8yMjU3L2hjaTEvZGV2XzAwXzUz
XzUzX0ZCXzdFXzlDKQpFbnRlciBQSU4gQ29kZTogMDAwMApSZWxlYXNlCk5ldyBkZXZpY2Ug
KC9vcmcvYmx1ZXovMjI1Ny9oY2kxL2Rldl8wMF81M181M19GQl83RV85QykKCnN1ZG8gaGNp
dG9vbCBpbmZvIDAwOjUzOjUzOkZCOjdFOjlDClJlcXVlc3RpbmcgaW5mb3JtYXRpb24gLi4u
CiAgICBCRCBBZGRyZXNzOiAgMDA6NTM6NTM6RkI6N0U6OUMKICAgIERldmljZSBOYW1lOiBO
b2tpYSBCSC04MDEKICAgIExNUCBWZXJzaW9uOiAyLjAgKDB4MykgTE1QIFN1YnZlcnNpb246
IDB4MjEyYgogICAgTWFudWZhY3R1cmVyOiBCcm9hZGNvbSBDb3Jwb3JhdGlvbiAoMTUpCiAg
ICBGZWF0dXJlczogMHhiYyAweGZlIDB4OGYgMHg3ZSAweDE4IDB4MTggMHgwMCAweDgwCiAg
ICAgICAgPGVuY3J5cHRpb24+IDxzbG90IG9mZnNldD4gPHRpbWluZyBhY2N1cmFjeT4gPHJv
bGUgc3dpdGNoPgogICAgICAgIDxzbmlmZiBtb2RlPiA8UlNTST4gPGNoYW5uZWwgcXVhbGl0
eT4gPFNDTyBsaW5rPiA8SFYyIHBhY2tldHM+CiAgICAgICAgPEhWMyBwYWNrZXRzPiA8dS1s
YXcgbG9nPiA8QS1sYXcgbG9nPiA8Q1ZTRD4gPHBhZ2luZyBzY2hlbWU+CiAgICAgICAgPHBv
d2VyIGNvbnRyb2w+IDx0cmFuc3BhcmVudCBTQ08+IDxicm9hZGNhc3QgZW5jcnlwdD4KICAg
ICAgICA8RURSIEFDTCAyIE1icHM+IDxFRFIgQUNMIDMgTWJwcz4gPGVuaGFuY2VkIGlzY2Fu
PgogICAgICAgIDxpbnRlcmxhY2VkIGlzY2FuPiA8aW50ZXJsYWNlZCBwc2Nhbj4gPGlucXVp
cnkgd2l0aCBSU1NJPgogICAgICAgIDxBRkggY2FwLiBzbGF2ZT4gPEFGSCBjbGFzcy4gc2xh
dmU+IDxBRkggY2FwLiBtYXN0ZXI+CiAgICAgICAgPEFGSCBjbGFzcy4gbWFzdGVyPiA8ZXh0
ZW5kZWQgZmVhdHVyZXM+Cgo=
--------------040809000805060909020403--
