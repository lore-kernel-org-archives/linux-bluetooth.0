Return-Path: <cyrus@holtmann.org>
Message-ID: <49EB93C2.3090702@pook.es>
Date: Sun, 19 Apr 2009 23:12:34 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: BlueZ development <linux-bluetooth@vger.kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: bluez git + Linksys USBBT100 + 2.6.30-rc2 -> Segmentation fault
References: <49D89DCD.7090808@pook.es> <49D8E48A.2060807@pook.es> <20090405172212.GB6612@jh-x301> <49EB7950.4000802@pook.es> <20090419200528.GA18068@jh-x301>
In-Reply-To: <20090419200528.GA18068@jh-x301>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

On 19/04/09 22:05, Johan Hedberg wrote:
> On Sun, Apr 19, 2009, Stuart Pook wrote:
>> I guess that this is why my USBBT100 never (?) worked with bluez.

I should have said "bluez 4" because it did work with bluez 3.

> Yep. The reason is that you have somehow managed to get "onmode off" to
> your config file.

I might have put it there.  I think that I was trying to only allow
outgoing connections. How do I only allow outgoing connections (and
make my PC as invisible as possible)?

> I've just pushed a fix to git which falls back to the default "connectable"
> mode if the stored onmode if for some reason "off". This should prevent
> the infinite recursion of adapter_up:

I just pulled the new version and put back the bad config file. Bluetoothd now
works (mostly) and has corrected the config file.

:; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
mode connectable
class 0x480104
onmode connectable
discovto 60

I guess that I can use bluez-4.36 with the corrected config file.

I did get one error that I had never seen before "Refusing headset":

bluetoothd[30969]: HCI dev 0 up
bluetoothd[30969]: Starting security manager 0
bluetoothd[30969]: Adapter /org/bluez/30969/hci0 has been enabled
bluetoothd[30969]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[30969]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[30969]: kernel auth requirements = 0x00
bluetoothd[30969]: stored link key type = 0x00
bluetoothd[30969]: hcid_dbus_bonding_process_complete: status=00
bluetoothd[30969]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[30969]: hcid_dbus_bonding_process_complete: no pending auth request
bluetoothd[30969]: Refusing headset: too many existing connections
bluetoothd[30969]: Accepted new client connection on unix socket (fd=13)

I unplugged the USBBT100 and ran the bluetoothd from bluez-4.36. I plugged the
USBBT100 in and had to run aplay 8 times before it worked. (I prefer using my
installed version of bluetoothd because then I know that it matches the
libraries installed in /usr/lib/alsa-lib.)

:; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
mode connectable
class 0x000104
onmode connectable
discovto 60
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#+                                                 | 00%aplay: pcm_write:1442: write error: Input/output error
:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
#############+                                     | 24%


: root; bluetoothd -dn
bluetoothd[31228]: Bluetooth daemon 4.36
bluetoothd[31228]: Enabling debug information
bluetoothd[31228]: parsing main.conf
bluetoothd[31228]: discovto=0
bluetoothd[31228]: Key file does not have key 'PairableTimeout'
bluetoothd[31228]: pageto=8192
bluetoothd[31228]: name=%h-%d
bluetoothd[31228]: class=0x000100
bluetoothd[31228]: inqmode=0
bluetoothd[31228]: Key file does not have key 'InitiallyPowered'
bluetoothd[31228]: Key file does not have key 'RememberPowered'
bluetoothd[31228]: Key file does not have key 'DeviceID'
bluetoothd[31228]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[31228]: Starting SDP server
bluetoothd[31228]: Loading plugins /usr/local/lib/bluetooth/plugins
bluetoothd[31228]: register_interface: path /org/bluez/31228/any
bluetoothd[31228]: Registered interface org.bluez.Service on path /org/bluez/31228/any
bluetoothd[31228]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[31228]: Unix socket created: 11
bluetoothd[31228]: Telephony plugin initialized
bluetoothd[31228]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[31228]: Entering main loop
bluetoothd[31228]: HCI dev 0 registered
bluetoothd[31228]: child 31231 forked
bluetoothd[31228]: child 31231 exited
bluetoothd[31228]: HCI dev 0 up
bluetoothd[31228]: Starting security manager 0
bluetoothd[31228]: Adapter /org/bluez/31228/hci0 without an address
bluetoothd[31228]: register_interface: path /org/bluez/31228/hci0
bluetoothd[31228]: Registered interface org.bluez.Service on path /org/bluez/31228/hci0
bluetoothd[31228]: headset_server_probe: path /org/bluez/31228/hci0
bluetoothd[31228]: Adding record with handle 0x10000
bluetoothd[31228]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[31228]: Adding record with handle 0x10001
bluetoothd[31228]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[31228]: a2dp_server_probe: path /org/bluez/31228/hci0
bluetoothd[31228]: SEP 0xb9a070c0 registered: type:0 codec:0 seid:1
bluetoothd[31228]: Adding record with handle 0x10002
bluetoothd[31228]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[31228]: avrcp_server_probe: path /org/bluez/31228/hci0
bluetoothd[31228]: Adding record with handle 0x10003
bluetoothd[31228]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[31228]: Adding record with handle 0x10004
bluetoothd[31228]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[31228]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: Probe drivers for /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[31228]: Registered interface org.bluez.Audio on path /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: Found Headset record
bluetoothd[31228]: Registered interface org.bluez.Headset on path /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: Found Handsfree record
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_03_89_FE_E6_19
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_17_E5_16_88_6C
bluetoothd[31228]: Creating device /org/bluez/31228/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[31228]: Changing service classes to 0x480100
bluetoothd[31228]: Adapter /org/bluez/31228/hci0 has been enabled
bluetoothd[31228]: Computer is classified as desktop
bluetoothd[31228]: Current device class is 0x480100
bluetoothd[31228]: Setting 0x000104 for major/minor device class
bluetoothd[31228]: Changing major/minor class to 0x480104
bluetoothd[31228]: Agent registered for hci0 at :1.24:/org/bluez/agent/hci0
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[31228]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[31228]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[31228]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[31228]: kernel auth requirements = 0x00
bluetoothd[31228]: stored link key type = 0x00
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[31228]: Received AT+BRSF=27
bluetoothd[31228]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[31228]: Received AT+CIND=?
bluetoothd[31228]: Received AT+CIND?
bluetoothd[31228]: Received AT+CMER=3, 0, 0, 1
bluetoothd[31228]: Event reporting (CMER): mode=3, ind=1
bluetoothd[31228]: HFP Service Level Connection established
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 connected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: Received AT+VGS=00
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=20
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 44
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=18
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 46
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 disconnected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[31228]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[31228]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[31228]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[31228]: kernel auth requirements = 0x00
bluetoothd[31228]: stored link key type = 0x00
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[31228]: Received AT+BRSF=27
bluetoothd[31228]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[31228]: Received AT+CIND=?
bluetoothd[31228]: Received AT+CIND?
bluetoothd[31228]: Received AT+CMER=3, 0, 0, 1
bluetoothd[31228]: Event reporting (CMER): mode=3, ind=1
bluetoothd[31228]: HFP Service Level Connection established
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 connected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: Received AT+VGS=00
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=20
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 49
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 disconnected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[31228]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[31228]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[31228]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[31228]: kernel auth requirements = 0x00
bluetoothd[31228]: stored link key type = 0x00
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[31228]: Received AT+BRSF=27
bluetoothd[31228]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[31228]: Received AT+CIND=?
bluetoothd[31228]: Received AT+CIND?
bluetoothd[31228]: Received AT+CMER=3, 0, 0, 1
bluetoothd[31228]: Event reporting (CMER): mode=3, ind=1
bluetoothd[31228]: HFP Service Level Connection established
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 connected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: Received AT+VGS=00
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=20
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 41
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=18
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 49
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 disconnected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[31228]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[31228]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[31228]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[31228]: kernel auth requirements = 0x00
bluetoothd[31228]: stored link key type = 0x00
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[31228]: Received AT+BRSF=27
bluetoothd[31228]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[31228]: Received AT+CIND=?
bluetoothd[31228]: Received AT+CIND?
bluetoothd[31228]: Received AT+CMER=3, 0, 0, 1
bluetoothd[31228]: Event reporting (CMER): mode=3, ind=1
bluetoothd[31228]: HFP Service Level Connection established
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 connected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: Received AT+VGS=00
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=20
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 41
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 disconnected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[31228]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[31228]: Received AT+BRSF=27
bluetoothd[31228]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[31228]: Received AT+CIND=?
bluetoothd[31228]: Received AT+CIND?
bluetoothd[31228]: Received AT+CMER=3, 0, 0, 1
bluetoothd[31228]: Event reporting (CMER): mode=3, ind=1
bluetoothd[31228]: HFP Service Level Connection established
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 connected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: Received AT+VGS=00
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=20
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[31228]: Unix client disconnected (fd=13)
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: No matching connection found for handle 49
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 disconnected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[31228]: Accepted new client connection on unix socket (fd=13)
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[31228]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[31228]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[31228]: /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[31228]: Received AT+BRSF=27
bluetoothd[31228]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[31228]: Received AT+CIND=?
bluetoothd[31228]: Received AT+CIND?
bluetoothd[31228]: Received AT+CMER=3, 0, 0, 1
bluetoothd[31228]: Event reporting (CMER): mode=3, ind=1
bluetoothd[31228]: HFP Service Level Connection established
bluetoothd[31228]: telephony-dummy: device 0xb9a084b8 connected
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[31228]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[31228]: Received AT+VGS=00
bluetoothd[31228]: SCO socket opened for headset /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98
bluetoothd[31228]: SCO fd=20
bluetoothd[31228]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[31228]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[31228]: State changed /org/bluez/31228/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING

after this successfull connection I once again got
aplay: pcm_write:1442: write error: Input/output error

Once I got a bad connection and the music was very distorted (bluez 4.36).
When I'm using twinkle I sometimes get bad connections in the other direction;
ie the sound being recorded is very very distorted.

arecord | aplay works about 1 time in 10 (though it used to work more often)
:; arecord -v -D JX10 -f S16_LE | aplay -vv -D JX10 -f S16_LE
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : CAPTURE
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 1
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
Playing WAVE 'stdin' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
Bluetooth Audio Device
Its setup is:
  stream       : PLAYBACK
  access       : RW_INTERLEAVED
  format       : S16_LE
  subformat    : STD
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  msbits       : 16
  buffer_size  : 4000
  period_size  : 1000
  period_time  : 125000
  tstamp_mode  : NONE
  period_step  : 1
  avail_min    : 1000
  period_event : 0
  start_threshold  : 4000
  stop_threshold   : 4000
  silence_threshold: 0
  silence_size : 0
  boundary     : 2097152000
##################################################+| 99%aplay: pcm_write:1442: write error: Input/output error

I just get a very brief noise before the correction dies.

The git version of bluetoothd is not any better but the errors are different
(another Segmentation fault). This time I left the USBBT100 plugged in.

:; aplay -vv  -D JX10 /home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav
Playing WAVE '/home/stuart/ws/music_test/Rebecca_Pidgeon-You_Got_Me-8000-mono.wav' : Signed 16 bit Little Endian, Rate 8000 Hz, Mono
ALSA lib pcm_bluetooth.c:1607:(audioservice_expect) BT_START_STREAM failed : Success(0)
ALSA lib pcm_bluetooth.c:1566:(audioservice_recv) Too short (1 bytes) IPC packet from bluetoothd
aplay: set_params:1022: Unable to install hw params:
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
TICK_TIME: [0 0]

: root; src/bluetoothd -dn
bluetoothd[32401]: Bluetooth daemon 4.36
bluetoothd[32401]: Enabling debug information
bluetoothd[32401]: parsing main.conf
bluetoothd[32401]: discovto=0
bluetoothd[32401]: Key file does not have key 'PairableTimeout'
bluetoothd[32401]: pageto=8192
bluetoothd[32401]: name=%h-%d
bluetoothd[32401]: class=0x000100
bluetoothd[32401]: inqmode=0
bluetoothd[32401]: Key file does not have key 'InitiallyPowered'
bluetoothd[32401]: Key file does not have key 'RememberPowered'
bluetoothd[32401]: Key file does not have key 'DeviceID'
bluetoothd[32401]: Key file does not have key 'ReverseServiceDiscovery'
bluetoothd[32401]: Starting SDP server
bluetoothd[32401]: Loading plugins /home/stuart/ws/install/bluez/git/bluez/plugins
bluetoothd[32401]: register_interface: path /org/bluez/32401/any
bluetoothd[32401]: Registered interface org.bluez.Service on path /org/bluez/32401/any
bluetoothd[32401]: Parsing /etc/bluetooth/audio.conf failed: No such file or directory
bluetoothd[32401]: Unix socket created: 11
bluetoothd[32401]: Telephony plugin initialized
bluetoothd[32401]: HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[32401]: HCI dev 0 registered
bluetoothd[32401]: child 32421 forked
bluetoothd[32401]: Entering main loop
bluetoothd[32401]: child 32421 exited
bluetoothd[32401]: HCI dev 0 up
bluetoothd[32401]: Starting security manager 0
bluetoothd[32401]: register_interface: path /org/bluez/32401/hci0
bluetoothd[32401]: Registered interface org.bluez.Service on path /org/bluez/32401/hci0
bluetoothd[32401]: headset_server_probe: path /org/bluez/32401/hci0
bluetoothd[32401]: Adding record with handle 0x10000
bluetoothd[32401]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[32401]: Adding record with handle 0x10001
bluetoothd[32401]: Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[32401]: a2dp_server_probe: path /org/bluez/32401/hci0
bluetoothd[32401]: SEP 0xb8f2b158 registered: type:0 codec:0 seid:1
bluetoothd[32401]: Adding record with handle 0x10002
bluetoothd[32401]: Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[32401]: avrcp_server_probe: path /org/bluez/32401/hci0
bluetoothd[32401]: Adding record with handle 0x10003
bluetoothd[32401]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[32401]: Adding record with handle 0x10004
bluetoothd[32401]: Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[32401]: Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98
bluetoothd[32401]: Probe drivers for /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98
bluetoothd[32401]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[32401]: Registered interface org.bluez.Audio on path /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98
bluetoothd[32401]: Found Headset record 
bluetoothd[32401]: Registered interface org.bluez.Headset on path /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98
bluetoothd[32401]: Found Handsfree record
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_14_A7_74_D3_AF
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_03_89_B7_F8_D3
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_0A_94_94_4F_B3
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_03_89_DC_5C_9F
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_03_89_DC_FC_EC
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_03_89_FE_E6_19
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_0E_6D_8F_91_6A
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_17_E5_E6_25_AB
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_17_E5_16_88_6C
bluetoothd[32401]: Creating device /org/bluez/32401/hci0/dev_00_17_E5_0C_EA_70
bluetoothd[32401]: Changing service classes to 0x480104
bluetoothd[32401]: Adapter /org/bluez/32401/hci0 has been enabled
bluetoothd[32401]: Computer is classified as desktop
bluetoothd[32401]: Current device class is 0x480104
bluetoothd[32401]: Setting 0x000104 for major/minor device class
bluetoothd[32401]: Changing major/minor class to 0x480104
bluetoothd[32401]: Agent registered for hci0 at :1.24:/org/bluez/agent/hci0
bluetoothd[32401]: Accepted new client connection on unix socket (fd=13)
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[32401]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[32401]: adapter_get_device(00:1A:45:2F:49:98)
bluetoothd[32401]: Discovered Handsfree service on RFCOMM channel 1
bluetoothd[32401]: /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: Connecting to 00:1A:45:2F:49:98 channel 1
bluetoothd[32401]: link_key_request (sba=00:0C:41:E1:FF:30, dba=00:1A:45:2F:49:98)
bluetoothd[32401]: kernel auth requirements = 0x00
bluetoothd[32401]: stored link key type = 0x00
bluetoothd[32401]: /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: Connected to 00:1A:45:2F:49:98
bluetoothd[32401]: Received AT+BRSF=27
bluetoothd[32401]: HFP HF features: "EC and/or NR function" "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[32401]: Received AT+CIND=?
bluetoothd[32401]: Received AT+CIND?
bluetoothd[32401]: Received AT+CMER=3, 0, 0, 1
bluetoothd[32401]: Event reporting (CMER): mode=3, ind=1
bluetoothd[32401]: HFP Service Level Connection established
bluetoothd[32401]: telephony-dummy: device 0xb8f2c550 connected
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_CONNECTED
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[32401]: Received AT+VGS=00
bluetoothd[32401]: SCO socket opened for headset /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98
bluetoothd[32401]: SCO fd=18
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[32401]: Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[32401]: Unix client disconnected (fd=13)
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[32401]: Accepted new client connection on unix socket (fd=13)
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[32401]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[32401]: Unix client disconnected (fd=13)
bluetoothd[32401]: telephony-dummy: device 0xb8f2c550 disconnected
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[32401]: Accepted new client connection on unix socket (fd=13)
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[32401]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[32401]: No matching connection found for handle 44
bluetoothd[32401]: Unix client disconnected (fd=13)
bluetoothd[32401]: telephony-dummy: device 0xb8f2c550 disconnected
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[32401]: Accepted new client connection on unix socket (fd=13)
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[32401]: open sco - object=ANY source=ANY destination=00:1A:45:2F:49:98 lock=write
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[32401]: Unable to get service record: Connection timed out (110)
bluetoothd[32401]: Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[32401]: telephony-dummy: device 0xb8f2c550 disconnected
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[32401]: Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECT_IN_PROGRESS
bluetoothd[32401]: Unable to get service record: Connection timed out (110)
bluetoothd[32401]: Unable to get a SCO fd
bluetoothd[32401]: headset_resume_complete: resume failed
bluetoothd[32401]: Audio API: BT_ERROR -> BT_START_STREAM
bluetoothd[32401]: telephony-dummy: device 0xb8f2c550 disconnected
bluetoothd[32401]: State changed /org/bluez/32401/hci0/dev_00_1A_45_2F_49_98: HEADSET_STATE_CONNECT_IN_PROGRESS -> HEADSET_STATE_DISCONNECTED
bluetoothd[32401]: Unix client disconnected (fd=13)
bluetoothd[32401]: Unable to get service record: Connection timed out (110)
Segmentation fault

: root; cat /var/lib/bluetooth/00:0C:41:E1:FF:30/config
class 0x480104

In fact I get the "Too short (1 bytes) IPC packet from bluetoothd" error
even from bluetoothd 4.36.

Twinkle 1.4.1 & 1.4.2 are able to open the headset almost everytime
(once I turned the "Validate devices before usage" option off).
http://www.twinklephone.com/

-- 
If the From address bounces, please see http://www.pook.it/.
