Return-Path: <cyrus@holtmann.org>
Message-ID: <492B7A98.90603@gmail.com>
Date: Tue, 25 Nov 2008 12:10:00 +0800
From: Sam Lin <itrs.lin@gmail.com>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: HBH-PV270 headset get locked 
Content-Type: multipart/mixed;
 boundary="------------060604080604000407040103"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060604080604000407040103
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit

Hi All,

I tried Sony Ericsson HBH-PV720 with aplay and found something wrong.
Log as attachment.

from first try (timestamp in log 11:24:23 - 11:24:31 ) it works fine.
sound played.

but since 2nd try (timestamp in log 11:25:21 - 11:25:26) SCO packets
flow but no sound played.
something outstanding is:

Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Unable to lock headset
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: config failed

then headset works no more, SCO packets keep flow until powerdown headset.

would you please give any hint on this ?

Sam Lin


--------------060604080604000407040103
Content-Type: text/x-log;
 name="bluez-debug.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-debug.log"

Nov 25 11:24:01 itrs-ubuntu bluetoothd[10399]: Discovery session 0xb950df70 with :1.52 activated
Nov 25 11:24:01 itrs-ubuntu bluetoothd[10399]: session_ref(0xb950df70): ref=1
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: session_unref(0xb950df70): ref=0
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: Discovery session 0xb950df70 with :1.52 deactivated
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: Stopping discovery
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: bonding_request_new(00:1E:DC:AB:6D:3F)
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: adapter_create_device(00:1E:DC:AB:6D:3F)
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: Creating device /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:24:05 itrs-ubuntu bluetoothd[10399]: Temporary agent registered for hci0/00:1E:DC:AB:6D:3F at :1.52:/org/bluez/agent/wizard
Nov 25 11:24:06 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:24:06 itrs-ubuntu bluetoothd[10399]: link_key_request (sba=00:02:5B:00:A5:A5, dba=00:1E:DC:AB:6D:3F)
Nov 25 11:24:06 itrs-ubuntu bluetoothd[10399]: kernel auth requirements = 0x04
Nov 25 11:24:06 itrs-ubuntu bluetoothd[10399]: pin_code_request (sba=00:02:5B:00:A5:A5, dba=00:1E:DC:AB:6D:3F)
Nov 25 11:24:06 itrs-ubuntu bluetoothd[10399]: hcid_dbus_new_auth_request
Nov 25 11:24:07 itrs-ubuntu bluetoothd[10399]: link_key_notify (sba=00:02:5B:00:A5:A5, dba=00:1E:DC:AB:6D:3F)
Nov 25 11:24:07 itrs-ubuntu bluetoothd[10399]: hcid_dbus_bonding_process_complete: status=00
Nov 25 11:24:07 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:24:07 itrs-ubuntu bluetoothd[10399]: Releasing agent :1.52, /org/bluez/agent/wizard
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: Probe drivers for /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: Found Headset record
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: Discovered Headset service on RFCOMM channel 1
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: Registered interface org.bluez.Headset on path /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: audio handle_uuid: server not enabled for 0000111e-0000-1000-8000-00805f9b34fb (0x111e)
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: headset_probe: path /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F 
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: Registered interface org.bluez.Input on path /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: serial_probe: path /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: 00001108-0000-1000-8000-00805f9b34fb 
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: Registered interface org.bluez.Serial on path /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:24:08 itrs-ubuntu bluetoothd[10399]: serial_probe: path /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: 0000111e-0000-1000-8000-00805f9b34fb 
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: Accepted new client connection on unix socket (fd=24)
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_GETCAPABILITIES_REQ
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_GETCAPABILITIES_RSP
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_SETCONFIGURATION_REQ
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: config sco - device = 00:1E:DC:AB:6D:3F access_mode = 2
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connecting to 00:1E:DC:AB:6D:3F channel 1
Nov 25 11:24:23 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Nov 25 11:24:24 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:24:24 itrs-ubuntu bluetoothd[10399]: link_key_request (sba=00:02:5B:00:A5:A5, dba=00:1E:DC:AB:6D:3F)
Nov 25 11:24:24 itrs-ubuntu bluetoothd[10399]: kernel auth requirements = 0x04
Nov 25 11:24:24 itrs-ubuntu bluetoothd[10399]: stored link key type = 0x00
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connected to 00:1E:DC:AB:6D:3F
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 connected
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT+CLIP=1
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: SCO socket opened for headset /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: SCO fd=26
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_SETCONFIGURATION_RSP
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_STREAMSTART_REQ
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_STREAMSTART_RSP
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_STREAMFD_IND
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT+VGS=7
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT+CSCS="UTF-8"
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CSCS="UTF-8"
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT*SEAM="HBH-PV720",13
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT*SEAM="HBH-PV720",13
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT+CLAN?
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CLAN?
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT*EIPS=2,1
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT*EIPS=2,1
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT+COLP=1
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+COLP=1
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Received AT+CCLK?
Nov 25 11:24:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CCLK?
Nov 25 11:24:27 itrs-ubuntu bluetoothd[10399]: Unix client disconnected (fd=24)
Nov 25 11:24:27 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
Nov 25 11:24:27 itrs-ubuntu bluetoothd[10399]: No matching connection for handle 46
Nov 25 11:24:31 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 disconnected
Nov 25 11:24:31 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

-----------------------------------------


Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: Accepted new client connection on unix socket (fd=24)
Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_GETCAPABILITIES_REQ
Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_GETCAPABILITIES_RSP
Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_SETCONFIGURATION_REQ
Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: config sco - device = 00:1E:DC:AB:6D:3F access_mode = 2
Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connecting to 00:1E:DC:AB:6D:3F channel 1
Nov 25 11:24:55 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: connect(): Host is down (112)
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_SETCONFIGURATION_RSP
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 disconnected
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_STREAMSTART_REQ
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_STREAMSTART_RSP
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_STREAMFD_IND
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: unix_sendmsg_fd: Bad file descriptor(9)
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: resume failed
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_STREAMSTART_RSP
Nov 25 11:25:00 itrs-ubuntu bluetoothd[10399]: Unix client disconnected (fd=24)


-----------------------------------------


Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: Accepted new client connection on unix socket (fd=24)
Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_GETCAPABILITIES_REQ
Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_GETCAPABILITIES_RSP
Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_SETCONFIGURATION_REQ
Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: config sco - device = 00:1E:DC:AB:6D:3F access_mode = 2
Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connecting to 00:1E:DC:AB:6D:3F channel 1
Nov 25 11:25:21 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Nov 25 11:25:24 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: link_key_request (sba=00:02:5B:00:A5:A5, dba=00:1E:DC:AB:6D:3F)
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: kernel auth requirements = 0x04
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: stored link key type = 0x00
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connected to 00:1E:DC:AB:6D:3F
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 connected
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT+CLIP=1
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: SCO socket opened for headset /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: SCO fd=26
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Unable to lock headset
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: config failed
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_SETCONFIGURATION_RSP
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Unix client disconnected (fd=24)
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT+VGS=7
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT+CSCS="UTF-8"
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CSCS="UTF-8"
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT*SEAM="HBH-PV720",13
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT*SEAM="HBH-PV720",13
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT+CLAN?
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CLAN?
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT*EIPS=2,1
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT*EIPS=2,1
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Received AT+COLP=1
Nov 25 11:25:25 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+COLP=1
Nov 25 11:25:26 itrs-ubuntu bluetoothd[10399]: Received AT+CCLK?
Nov 25 11:25:26 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CCLK?
Nov 25 11:26:07 itrs-ubuntu bluetoothd[10399]: No matching connection for handle 45
Nov 25 11:26:07 itrs-ubuntu bluetoothd[10399]: Audio connection got disconnected
Nov 25 11:26:07 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
Nov 25 11:26:30 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 disconnected
Nov 25 11:26:30 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED



-----------------------------------------



Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: Accepted new client connection on unix socket (fd=24)
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_GETCAPABILITIES_REQ
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_GETCAPABILITIES_RSP
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: Audio API: received BT_SETCONFIGURATION_REQ
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: config sco - device = 00:1E:DC:AB:6D:3F access_mode = 2
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connecting to 00:1E:DC:AB:6D:3F channel 1
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
Nov 25 11:28:45 itrs-ubuntu bluetoothd[10399]: adapter_get_device(00:1E:DC:AB:6D:3F)
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: link_key_request (sba=00:02:5B:00:A5:A5, dba=00:1E:DC:AB:6D:3F)
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: kernel auth requirements = 0x04
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: stored link key type = 0x00
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: Connected to 00:1E:DC:AB:6D:3F
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 connected
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT+CLIP=1
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: SCO socket opened for headset /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: SCO fd=26
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Unable to lock headset
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: config failed
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Audio API: sending BT_SETCONFIGURATION_RSP
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Unix client disconnected (fd=24)
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT+VGS=7
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT+CSCS="UTF-8"
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CSCS="UTF-8"
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT*SEAM="HBH-PV720",13
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT*SEAM="HBH-PV720",13
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT+CLAN?
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CLAN?
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT*EIPS=2,1
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT*EIPS=2,1
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT+COLP=1
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+COLP=1
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Received AT+CCLK?
Nov 25 11:28:46 itrs-ubuntu bluetoothd[10399]: Badly formated or unrecognized command: AT+CCLK?
Nov 25 11:29:08 itrs-ubuntu bluetoothd[10399]: No matching connection for handle 45
Nov 25 11:29:08 itrs-ubuntu bluetoothd[10399]: Audio connection got disconnected
Nov 25 11:29:08 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
Nov 25 11:29:10 itrs-ubuntu bluetoothd[10399]: telephony-dummy: device 0xb950ba28 disconnected
Nov 25 11:29:10 itrs-ubuntu bluetoothd[10399]: State changed /org/bluez/10399/hci0/dev_00_1E_DC_AB_6D_3F: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED

--------------060604080604000407040103--
