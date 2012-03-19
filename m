Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAFufa9AcckkL_-u5Ba1bH_-Wtr0WrSYHruytfbXJ1y3r7Mt71w@mail.gmail.com>
References: <CAFufa9AcckkL_-u5Ba1bH_-Wtr0WrSYHruytfbXJ1y3r7Mt71w@mail.gmail.com>
Date: Mon, 19 Mar 2012 21:21:22 +0100
Message-ID: <CAFufa9CMrd4ZOO-biOoD2kyN2On5QXPZ3FWngZ0o6Qwuh_ptLg@mail.gmail.com>
Subject: bt headset problem; permission denied in rfcomm's connect
From: Robert Obryk <robryk@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi all,

I have a BT headset (Nokia BH-610) which I can use by connecting to it
with a2dp, but not with headset/handsfree protocol. It seems that I
get some authentication problems when creating first rfcomm connection
when playing audio.
I want to use handset or handsfree protocol because I want to use the
microphone that comes with the headset.

The headset's manual claims that it supports headset and handsfree
protocols and sdptool records/sdptool search confirms that. When I try
to play some audio, following happens:

robryk@bree ~ $ aplay -Dplug:bluetooth -fS16_LE < /dev/urandom
Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib audio/pcm_bluetooth.c:1614:(audioservice_expect)
BT_START_STREAM failed : Success(0)
ALSA lib audio/pcm_bluetooth.c:1573:(audioservice_recv) Too short (1
bytes) IPC packet from bluetoothd
aplay: set_params:1145: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  S16_LE
SUBFORMAT:  STD
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

The relevant part of bluetoothd -nd output (the part generated during
this request):

bluetoothd[25981]: audio/unix.c:server_cb() Accepted new client
connection on unix socket (fd=26)
bluetoothd[25981]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_GET_CAPABILITIES
bluetoothd[25981]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[25981]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[25981]: audio/unix.c:handle_sco_open() open sco -
object=ANY source=ANY destination=00:0B:E4:B1:BC:11 lock=write
bluetoothd[25981]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_OPEN
bluetoothd[25981]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_SET_CONFIGURATION
bluetoothd[25981]: audio/headset.c:headset_set_state() State changed
/org/bluez/25981/hci0/dev_00_0B_E4_B1_BC_11:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[25981]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[25981]: src/adapter.c:adapter_get_device() 00:0B:E4:B1:BC:11
bluetoothd[25981]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[25981]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[25981]: audio/headset.c:headset_set_channel() Discovered
Handsfree service on channel 1
bluetoothd[25981]: audio/headset.c:rfcomm_connect()
/org/bluez/25981/hci0/dev_00_0B_E4_B1_BC_11: Connecting to
00:0B:E4:B1:BC:11 channel 1
bluetoothd[25981]: plugins/hciops.c:link_key_request() hci0 dba
00:0B:E4:B1:BC:11
bluetoothd[25981]: plugins/hciops.c:get_auth_info() hci0 dba 00:0B:E4:B1:BC:11
bluetoothd[25981]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[25981]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[25981]: plugins/hciops.c:link_key_request() link key type 0x04
bluetoothd[25981]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[25981]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[25981]: src/adapter.c:adapter_get_device() 00:0B:E4:B1:BC:11
bluetoothd[25981]: src/device.c:device_bonding_complete() bonding
(nil) status 0x00
bluetoothd[25981]: Permission denied (13)
bluetoothd[25981]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[25981]: audio/headset.c:headset_set_state() State changed
/org/bluez/25981/hci0/dev_00_0B_E4_B1_BC_11: HEADSET_STATE_CONNECTING
-> HEADSET_STATE_DISCONNECTED
bluetoothd[25981]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_START_STREAM
bluetoothd[25981]: audio/headset.c:headset_set_state() State changed
/org/bluez/25981/hci0/dev_00_0B_E4_B1_BC_11:
HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[25981]: Unable to get service record: Permission denied (13)
bluetoothd[25981]: Unable to get a SCO fd
bluetoothd[25981]: headset_resume_complete: resume failed
bluetoothd[25981]: audio/unix.c:unix_ipc_error() sending error
Input/output error(5)
bluetoothd[25981]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_ERROR
-> BT_START_STREAM
bluetoothd[25981]: audio/headset.c:headset_set_state() State changed
/org/bluez/25981/hci0/dev_00_0B_E4_B1_BC_11: HEADSET_STATE_CONNECTING
-> HEADSET_STATE_DISCONNECTED
bluetoothd[25981]: audio/unix.c:client_cb() Unix client disconnected (fd=26)
bluetoothd[25981]: audio/unix.c:client_free() client_free(0x7ff60b780940)
bluetoothd[25981]: plugins/hciops.c:disconn_complete() handle 12 status 0x00
bluetoothd[25981]: src/event.c:btd_event_disconn_complete()
bluetoothd[25981]: src/adapter.c:adapter_remove_connection()

The output from hcidump during the attempt is in
http://pastebin.com/t6iZJU5P (not to swamp everyone with it). I think
that these last entries are surely relevant:
< ACL data: handle 12 flags 0x00 dlen 12
   L2CAP(s): Connect req: psm 3 scid 0x0041
> HCI Event: Number of Completed Packets (0x13) plen 5
   handle 12 packets 2
> ACL data: handle 12 flags 0x02 dlen 16
   L2CAP(s): Connect rsp: dcid 0x0049 scid 0x0041 result 1 status 2
     Connection pending - Authorization pending
> HCI Event: Disconn Complete (0x05) plen 4
   status 0x00 handle 12 reason 0x05
   Reason: Authentication Failure

I've discovered by adding additional debug statements and stracing
bluetoothd that the `Permission denied' comes from headset_connect_cb,
called as a callback from to a request from rfcomm_connect, in
audio/headset.c.
The socket gets created, set to async mode, bound -- all successfully
and then connect returns EINPROGRESS. Later getsockopt(SO_ERROR) gives
error 13.

I use an USB adapter (builtin into a Thinkpad T410) that reports as
(lsusb output):
Bus 001 Device 004: ID 0a5c:217f Broadcom Corp. Bluetooth Controller
I use 3.0.0 kernel and 4.9.8 bluez.

I've paired these devices by doing hcitool cc followed by hcitool
auth. For some reason gnome's bluetooth-wizard failed to see this
device, when I was able to use is to pair another device with my
adapter.

Best regards,
Robert Obryk
