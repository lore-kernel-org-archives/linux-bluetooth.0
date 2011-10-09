Return-Path: <cyrus@holtmann.org>
Message-ID: <4E91AC1C.9020306@optimaster.eu>
Date: Sun, 09 Oct 2011 16:13:48 +0200
From: Krisztian Kocsis <krisztian.kocsis@optimaster.eu>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Fwd: [pulseaudio-discuss] Fwd: Re: Bluetooth Headset Problem #2
References: <bf39f3bbabbfb3881523f71163d1359b@optimaster.eu>
In-Reply-To: <bf39f3bbabbfb3881523f71163d1359b@optimaster.eu>
Content-Type: multipart/mixed;
 boundary="------------090007030505090905000309"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090007030505090905000309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit



-------- Original Message --------
Subject: 	[pulseaudio-discuss] Fwd: Re: Bluetooth Headset Problem #2
Date: 	Sat, 08 Oct 2011 15:52:11 +0200
From: 	krisztian.kocsis@optimaster.eu
Reply-To: 	General PulseAudio Discussion 
<pulseaudio-discuss@lists.freedesktop.org>
To: 	<pulseaudio-discuss@lists.freedesktop.org>



Sorry, here are the attachments.

-------- Original Message --------
Subject: Re: Bluetooth Headset Problem
Date: Sat, 08 Oct 2011 14:11:31 +0200
  From: krisztian.kocsis@optimaster.eu
To: Luiz Augusto von Dentz<luiz.dentz@gmail.com>

Hello!

I didn't help!

Here is who I test it:

- Load kernel (2.6.24.6) modules: bluetooth, hci_usb, l2cap, rfcomm,
sco
- Start bluez (4.96): bluetoothd -d -n (debug, foreground)
- Start simple-agent: simple-agent 0000
- Test device connection with: hcitool cc 00:07:A4:EE:8F:03 (already
paired)
- Start pulseaudio (0.9.23):
LD_LIBRARY_PATH=/afc/lib/pulse-0.9.23/modules /afc/bin/pulseaudio
--system --high-priority --disallow-exit --log-target=stderr
--use-pid-file --disable-shm -vvvvvvv
- Connect to headset: dbus-send --system --print-reply --dest=org.bluez
/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03 org.bluez.Headset.Connect
(dbus 1.4.14)
- Activate hsp profile: pactl set-card-profile 0 hsp
- Trying to play a WAV: paplay -p -v /afc/tmp/test.wav (hangs at Time:
0.000s)
- Trying to play an MP3 with mpg123 (1.13.3): mpg123 -vvvvv -o pulse
/afc/tmp/armin.mp3 (hangs at frame 6)

Did I miss some commands or actions which are required to play
something on a headset?
I'v attached the config files of bluez and pulseaudio and the logs
also.

BR,
Krisztian

On Thu, 8 Sep 2011 13:32:10 +0300, Luiz Augusto von Dentz wrote:
>  Hi,
>
>  On Sat, Sep 3, 2011 at 5:16 PM, Colin Guthrie<gmane@colin.guthr.ie>
>  wrote:
>>>  4. Play a WAV with paplay:
>>>  paplay -p -v /afc/Noise.wav
>>>
>>>  Opening a playback stream with sample specification 's16be 1ch
>>>  48000Hz'
>>>  and channel map 'mono'.
>>>
>>>  Connection established..
>>>
>>>  Stream successfully created.
>>>
>>>  Buffer metrics: maxlength=4194304, tlength=192000, prebuf=190082,
>>>  minreq=1920
>>>
>>>  Using sample spec 's16be 1ch 48000Hz', channel map 'mono'.
>>>
>>>  Connected to device bto (2, not suspended).
>>>
>>>  Time: 0.000 sec; Latency: 1407895 usec.
>>>
>>>  Time: 0.000 sec; Latency: 1407895 usec.
>>>
>>>  Time: 0.000 sec; Latency: 1407895 usec.
>>>
>>>  Got signal, exiting.ency: 1407895 usec.
>>>
>>>
>>>
>>>  Debug from Pulseaudio:
>>>
>>>  I: client.c: Created 3 "Native client (UNIX socket client)"
>>>
>>>  D: protocol-native.c: Protocol version: remote 16, local 16
>>>
>>>  I: protocol-native.c: Got credentials: uid=0 gid=0 success=1
>>>
>>>  D: protocol-native.c: SHM possible: no
>>>
>>>  D: protocol-native.c: Negotiated SHM: no
>>>
>>>  I: resampler.c: Using resampler 'speex-float-3'
>>>
>>>  I: resampler.c: Using float32be as working format.
>>>
>>>  I: resampler.c: Choosing speex quality setting 3.
>>>
>>>  D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0,
>>>  base=2, prebuf=0, minreq=1 maxrewind=0
>>>
>>>  D: memblockq.c: memblockq sanitized: maxlength=33554432,
>>>  tlength=33554432, base=2, prebuf=0, minreq=2 maxrewind=0
>>>
>>>  I: sink-input.c: Created input 3 "/afc/Noise.wav" on bto with
>>>  sample
>>>  spec s16be 1ch 48000Hz and channel map mono
>>>
>>>  I: sink-input.c: Â  Â  media.format = "WAV (Microsoft)"
>>>
>>>  I: sink-input.c: Â  Â  application.name = "paplay"
>>>
>>>  I: sink-input.c: Â  Â  media.name = "/afc/Noise.wav"
>>>
>>>  I: sink-input.c: Â  Â  native-protocol.peer = "UNIX socket client"
>>>
>>>  I: sink-input.c: Â  Â  native-protocol..version = "16"
>>>
>>>  I: sink-input.c: Â  Â  application.process.id = "4796"
>>>
>>>  I: sink-input.c: Â  Â  application.process.user = "root"
>>>
>>>  I: sink-input.c: Â  Â  application.process.host = "Viper"
>>>
>>>  I: sink-input.c: Â  Â  application.process.binary = "pacat"
>>>
>>>  I: sink-input.c: Â  Â  application.language = "C"
>>>
>>>  I: sink-input.c: Â  Â  application.process.machine_id =
>>>  "d63a8b34983dc07124730b71000003f9"
>>>
>>>  I: protocol-native.c: Requested tlength=2000.00 ms, minreq=20.00 ms
>>>
>>>  D: protocol-native.c: Traditional mode enabled, modifying sink usec
>>>  only
>>>  for compat with minreq.
>>>
>>>  D: memblockq.c: memblockq requested: maxlength=4194304,
>>>  tlength=192000,
>>>  base=2, prebuf=190082, minreq=1920 maxrewind=0
>>>
>>>  D: memblockq.c: memblockq sanitized: maxlength=4194304,
>>>  tlength=192000,
>>>  base=2, prebuf=190082, minreq=1920 maxrewind=0
>>>
>>>  I: protocol-native.c: Final latency 2128.00 ms = 1960.00 ms +
>>>  2*20.00 ms
>>>  + 128.00 ms
>>>
>>>  D: protocol-native.c: Requesting rewind due to end of underrun.
>>>
>>>  D: core.c: Hmm, no streams around, trying to vacuum.
>>>
>>>  I: sink-input.c: Freeing input 3 "/afc/Noise.wav"
>>>
>>>  I: client.c: Freed 3 "paplay"
>>>
>>>  I: protocol-native.c: Connection died.
>>>
>>>
>>>
>>>  Debug from bluez:
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_state() State changed
>>>  /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03:
>>>  HEADSET_STATE_DISCONNECTED
>>>  ->  HEADSET_STATE_CONNECTING
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:link_key_request() hci0 dba
>>>  00:07:A4:EE:8F:03
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:get_auth_info() hci0 dba
>>>  00:07:A4:EE:8F:03
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:link_key_request() kernel auth
>>>  requirements = 0xff
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:link_key_request() Matching key
>>>  found
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:link_key_request() link key type
>>>  0x00
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:conn_complete() status 0x00
>>>
>>>  bluetoothd[4776]: src/adapter.c:adapter_get_device()
>>>  00:07:A4:EE:8F:03
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:bonding_complete() status 0x00
>>>
>>>  bluetoothd[4776]: src/event.c:btd_event_bonding_complete() status
>>>  0x00
>>>
>>>  bluetoothd[4776]: src/adapter.c:adapter_get_device()
>>>  00:07:A4:EE:8F:03
>>>
>>>  bluetoothd[4776]: src/device.c:device_bonding_complete() bonding
>>>  (nil)
>>>  status 0x00
>>>
>>>  bluetoothd[4776]: plugins/hciops.c:remote_features_information()
>>>  hci0
>>>  status 0
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_channel() Discovered
>>>  Handsfree service on channel 2
>>>
>>>  bluetoothd[4776]: audio/headset.c:rfcomm_connect()
>>>  /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03: Connecting to
>>>  00:07:A4:EE:8F:03 channel 2
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_connect_cb()
>>>  /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03: Connected to
>>>  00:07:A4:EE:8F:03
>>>
>>>  bluetoothd[4776]: audio/headset.c:handle_event() Received
>>>  AT+BRSF=26
>>>
>>>  bluetoothd[4776]: audio/headset.c:print_hf_features() HFP HF
>>>  features:
>>>  "Call waiting and 3-way calling" "Voice recognition activation"
>>>  "Remote
>>>  volume control"
>>>
>>>  bluetoothd[4776]: audio/headset.c:handle_event() Received AT+CIND=?
>>>
>>>  bluetoothd[4776]: audio/headset.c:handle_event() Received AT+CIND?
>>>
>>>  bluetoothd[4776]: audio/headset.c:handle_event() Received
>>>  AT+CMER=3,0,0,1
>>>
>>>  bluetoothd[4776]: audio/headset.c:event_reporting() Event reporting
>>>  (CMER): mode=3, ind=1
>>>
>>>  bluetoothd[4776]: audio/headset.c:hfp_slc_complete() HFP Service
>>>  Level
>>>  Connection established
>>>
>>>  bluetoothd[4776]: audio/telephony.c:telephony_device_connected()
>>>  telephony-dummy: device 0x200b7738 connected
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_state() State changed
>>>  /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03:
>>>  HEADSET_STATE_CONNECTING ->
>>>  HEADSET_STATE_CONNECTED
>>>
>>>  bluetoothd[4776]: audio/headset.c:handle_event() Received AT+VGS=15
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_gain() Ignoring
>>>  no-change
>>>  in speaker gain
>>>
>>>  bluetoothd[4776]: audio/unix.c:server_cb() Accepted new client
>>>  connection on unix socket (fd=21)
>>>
>>>  bluetoothd[4776]: audio/unix.c:client_cb() Audio API: BT_REQUEST<-
>>>  BT_GET_CAPABILITIES
>>>
>>>  bluetoothd[4776]: audio/unix.c:unix_ipc_sendmsg() Audio API:
>>>  BT_RESPONSE
>>>  ->  BT_GET_CAPABILITIES
>>>
>>>  bluetoothd[4776]: audio/unix.c:client_cb() Audio API: BT_REQUEST<-
>>>  BT_GET_CAPABILITIES
>>>
>>>  bluetoothd[4776]: audio/unix.c:unix_ipc_sendmsg() Audio API:
>>>  BT_RESPONSE
>>>  ->  BT_GET_CAPABILITIES
>>>
>>>  bluetoothd[4776]: audio/unix.c:client_cb() Audio API: BT_REQUEST<-
>>>  BT_OPEN
>>>
>>>  bluetoothd[4776]: audio/unix.c:handle_sco_open() open sco -
>>>  object=/org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03 source=ANY
>>>  destination=ANY lock=readwrite
>>>
>>>  bluetoothd[4776]: audio/unix.c:unix_ipc_sendmsg() Audio API:
>>>  BT_RESPONSE
>>>  ->  BT_OPEN
>>>
>>>  bluetoothd[4776]: audio/unix.c:client_cb() Audio API: BT_REQUEST<-
>>>  BT_SET_CONFIGURATION
>>>
>>>  bluetoothd[4776]: audio/unix.c:unix_ipc_sendmsg() Audio API:
>>>  BT_RESPONSE
>>>  ->  BT_SET_CONFIGURATION
>>>
>>>  bluetoothd[4776]: audio/unix.c:client_cb() Audio API: BT_REQUEST<-
>>>  BT_START_STREAM
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_state() State changed
>>>  /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTED
>>>  ->
>>>  HEADSET_STATE_PLAY_IN_PROGRESS
>>>
>>>  bluetoothd[4776]: audio/headset.c:sco_connect_cb() SCO socket
>>>  opened for
>>>  headset /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03
>>>
>>>  bluetoothd[4776]: audio/headset.c:sco_connect_cb() SCO fd=23
>>>
>>>  bluetoothd[4776]: audio/unix.c:unix_ipc_sendmsg() Audio API:
>>>  BT_RESPONSE
>>>  ->  BT_START_STREAM
>>>
>>>  bluetoothd[4776]: audio/unix.c:unix_ipc_sendmsg() Audio API:
>>>  BT_INDICATION ->  BT_NEW_STREAM
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_state() State changed
>>>  /org/bluez/4776/hci0/dev_00_07_A4_EE_8F_03:
>>>  HEADSET_STATE_PLAY_IN_PROGRESS ->  HEADSET_STATE_PLAYING
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_gain() Ignoring
>>>  no-change
>>>  in speaker gain
>>>
>>>  bluetoothd[4776]: audio/headset.c:headset_set_gain() Ignoring
>>>  no-change
>>>  in microphone gain
>>>
>>>
>>>
>>>  After that I'v changed the resampler method to trivial. Now paplays
>>>  returns with this:
>>>
>>>  Opening a playback stream with sample specification 's16be 1ch
>>>  48000Hz'
>>>  and channel map 'mono'.
>>>
>>>  Connection established.
>>>
>>>  Stream successfully created.
>>>
>>>  Buffer metrics: maxlength=4194304, tlength=192000, prebuf=190082,
>>>  minreq=1920
>>>
>>>  Using sample spec 's16be 1ch 48000Hz', channel map 'mono'.
>>>
>>>  Connected to device bto (2, not suspended).
>>>
>>>  Failed to drain stream: Timeout95 usec.
>>>
>>>  Playback stream drained.
>>>
>>>  Draining connection to server.
>>>
>>>
>>>
>>>  As you see paplay is unable to output audio data but I didn't see
>>>  why?
>>>  Do somebody know what is the problem?
>>>
>>>  CPU: PowerPC 603e (No FPU)
>>>  Linux: 2.6.24.6
>>>  Glibc: 2.5
>>>
>>>  Pulseaudio system.pa (no other config files):
>>>
>>>  load-module module-null-sink
>>>
>>>  load-module module-oss sink_name=output source_name=input mmap=0
>>>
>>>  load-module module-native-protocol-unix
>>>
>>>  load-module module-native-protocol-tcp
>>>
>>>  # load-module module-stream-restore
>>>
>>>  # load-module module-rescue-streams
>>>
>>>  # load-module module-always-sink
>>>
>>>  # load-module module-suspend-on-idle
>>>
>>>  load-module module-bluetooth-device profile=hsp
>>>  address=00:07:A4:EE:8F:03 auto_connect=1 sink_name=bto
>>>  source_name=bti
>>>
>>>  set-default-sink bto
>>>
>>>  set-default-source input
>
>  It looks like you are using PCM routing to bto/bti devices, in that
>  cause make sure you have /etc/bluetooth/audio.conf to use PCM routing
>  instead of HCI (default), the signalling part seems ok meaning the
>  SCO
>  link is connected so it appears something is wrong with bto
>  configuration, usually SCO sample spec is 8khz.



--------------090007030505090905000309
Content-Type: text/x-log;
 name="bluez.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bluez.log"

# bluetoothd -d -n
bluetoothd[2848]: Bluetooth daemon 4.96
bluetoothd[2848]: src/main.c:parse_config() parsing main.conf
bluetoothd[2848]: src/main.c:parse_config() discovto=0
bluetoothd[2848]: src/main.c:parse_config() pairto=0
bluetoothd[2848]: src/main.c:parse_config() pageto=8192
bluetoothd[2848]: src/main.c:parse_config() name=%h-%d
bluetoothd[2848]: src/main.c:parse_config() class=0x000100
bluetoothd[2848]: src/main.c:parse_config() discov_interval=30
bluetoothd[2848]: src/main.c:parse_config() Key file does not have key 'DeviceID'
bluetoothd[2848]: Starting SDP server
bluetoothd[2848]: src/plugin.c:plugin_init() Loading builtin plugins
bluetoothd[2848]: src/plugin.c:add_plugin() Loading audio plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading input plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading serial plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading network plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading service plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading hciops plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading mgmtops plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading formfactor plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading storage plugin
bluetoothd[2848]: src/plugin.c:add_plugin() Loading adaptername plugin
bluetoothd[2848]: src/plugin.c:plugin_init() Loading plugins /afc/lib/bluetooth/plugins
bluetoothd[2848]: plugins/service.c:register_interface() path /[ 8185.494159] hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb cf249214 err -28
[ 8185.502471] hci_usb_isoc_rx_submit: hci0 isoc rx submit failed urb cf249214 err -28
org/bluez/2848/any
bluetoothd[2848]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/2848/any
bluetoothd[2848]: network/manager.c:read_config() Config options: Security=true
bluetoothd[2848]: Failed to open control socket: Protocol not supported (93)
bluetoothd[2848]: Can't init bnep module
bluetoothd[2848]: Failed to init network plugin
bluetoothd[2848]: Parsing /afc/etc/bluetooth/input.conf failed: No such file or directory
bluetoothd[2848]: audio/unix.c:unix_init() Unix socket created: 7
bluetoothd[2848]: plugins/hciops.c:hciops_init() 
bluetoothd[2848]: plugins/hciops.c:hciops_setup() 
bluetoothd[2848]: Failed to open RFKILL control device
bluetoothd[2848]: src/main.c:main() Entering main loop
bluetoothd[2848]: plugins/hciops.c:init_known_adapters() 
bluetoothd[2848]: plugins/hciops.c:init_device() hci0
bluetoothd[2848]: Listening for HCI events on hci0
bluetoothd[2848]: plugins/hciops.c:init_device() child 2849 forked
bluetoothd[2848]: plugins/hciops.c:child_exit() child 2849 exited
bluetoothd[2848]: HCI dev 0 up
bluetoothd[2848]: plugins/hciops.c:device_devup_setup() hci0
bluetoothd[2848]: plugins/hciops.c:read_local_features_complete() Got features for hci0
bluetoothd[2848]: plugins/hciops.c:read_local_version_complete() Got version for hci0
bluetoothd[2848]: plugins/hciops.c:read_bd_addr_complete() hci0 status 0
bluetoothd[2848]: plugins/hciops.c:read_bd_addr_complete() Got bdaddr for hci0
bluetoothd[2848]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[2848]: plugins/hciops.c:read_local_name_complete() Got name for hci0
bluetoothd[2848]: src/adapter.c:btd_adapter_ref() 0x200b4020: ref=1
bluetoothd[2848]: plugins/hciops.c:hciops_read_bdaddr() hci0
bluetoothd[2848]: src/sdpd-database.c:sdp_init_services_list() 
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[2848]: plugins/service.c:register_interface() path /org/bluez/2848/hci0
bluetoothd[2848]: plugins/service.c:register_interface() Registered interface org.bluez.Service on path /org/bluez/2848/hci0
bluetoothd[2848]: serial/manager.c:proxy_probe() path /org/bluez/2848/hci0
bluetoothd[2848]: src/adapter.c:btd_adapter_ref() 0x200b4020: ref=2
bluetoothd[2848]: serial/proxy.c:proxy_register() Registered interface org.bluez.SerialProxyManager on path /org/bluez/2848/hci0
bluetoothd[2848]: Parsing /afc/etc/bluetooth/serial.conf failed: No such file or directory
bluetoothd[2848]: src/adapter.c:btd_adapter_ref() 0x200b4020: ref=3
bluetoothd[2848]: audio/manager.c:headset_server_probe() path /org/bluez/2848/hci0
bluetoothd[2848]: src/adapter.c:btd_adapter_ref() 0x200b4020: ref=4
bluetoothd[2848]: audio/manager.c:audio_adapter_ref() 0x200b44c8: ref=1
bluetoothd[2848]: audio/manager.c:state_changed() /org/bluez/2848/hci0 powered on
bluetoothd[2848]: audio/telephony.c:telephony_init() 
bluetoothd[2848]: audio/headset.c:telephony_ready_ind() Telephony plugin initialized
bluetoothd[2848]: audio/headset.c:print_ag_features() HFP AG features: "Ability to reject a call" "Enhanced call status" "Extended Error Result Codes" 
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10000
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 0
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001108-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001112-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2848]: audio/headset.c:headset_config_init() audio.conf: Key file does not have key 'FastConnectable'
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10001
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000003-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111e-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000111f-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001203-0000-1000-8000-00805f9
bluetoothd[2848]: audio/manager.c:a2dp_server_probe() path /org/bluez/2848/hci0
bluetoothd[2848]: audio/manager.c:audio_adapter_ref() 0x200b44c8: ref=2
bluetoothd[2848]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Enable'
bluetoothd[2848]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have key 'Disable'
bluetoothd[2848]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[2848]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[2848]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[2848]: audio/a2dp.c:a2dp_register() audio.conf: Key file does not have group 'A2DP'
bluetoothd[2848]: audio/avdtp.c:avdtp_register_sep() SEP 0x200b5448 registered: type:0 codec:0 seid:1
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10002
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[2848]: audio/manager.c:avrcp_server_probe() path /org/bluez/2848/hci0
bluetoothd[2848]: audio/manager.c:audio_adapter_ref() 0x200b44c8: ref=3
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10003
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110c-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[2848]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[2848]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000017-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[2848]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110e-0000-1000-8000-00805f9
bluetoothd[2848]: plugins/adaptername.c:adaptername_probe() Setting name 'Viper-0' for device 'hci0'
bluetoothd[2848]: plugins/hciops.c:hciops_set_name() hci0, name Viper-0
bluetoothd[2848]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2848]: Could not get the contents of DMI chassis type
bluetoothd[2848]: plugins/hciops.c:hciops_unblock_device() hci0 dba 00:00:00:00:00:00
bluetoothd[2848]: Clearing blocked list failed: Invalid argument (22)
bluetoothd[2848]: src/device.c:device_create() Creating device /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: src/device.c:device_set_bonded() bonded 1
bluetoothd[2848]: src/device.c:btd_device_ref() 0x200b6570: ref=1
bluetoothd[2848]: src/device.c:device_set_temporary() temporary 0
bluetoothd[2848]: src/device.c:device_probe_drivers() Probing drivers for 00:07:A4:EE:8F:03
bluetoothd[2848]: serial/manager.c:serial_probe() path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: 00001101-0000-1000-8000-00805f9b34fb
bluetoothd[2848]: serial/port.c:create_serial_device() Registered interface org.bluez.Serial on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: serial/manager.c:serial_probe() path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: 00001108-0000-1000-8000-00805f9b34fb
bluetoothd[2848]: serial/manager.c:serial_probe() path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: 0000111e-0000-1000-8000-00805f9b34fb
bluetoothd[2848]: input/manager.c:headset_probe() path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: src/device.c:btd_device_ref() 0x200b6570: ref=2
bluetoothd[2848]: input/device.c:input_device_new() Registered interface org.bluez.Input on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2848]: src/device.c:btd_device_ref() 0x200b6570: ref=3
bluetoothd[2848]: audio/device.c:audio_device_register() Registered interface org.bluez.Audio on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: audio/manager.c:handle_uuid() Found Headset record
bluetoothd[2848]: audio/headset.c:headset_init() Registered interface org.bluez.Headset on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: audio/manager.c:handle_uuid() Found Handsfree record
bluetoothd[2848]: plugins/hciops.c:hciops_load_keys() hci0 keys 1 debug_keys 0
bluetoothd[2848]: plugins/hciops.c:hciops_get_conn_list() hci0
bluetoothd[2848]: src/manager.c:btd_manager_register_adapter() Adapter /org/bluez/2848/hci0 registered
bluetoothd[2848]: src/adapter.c:btd_adapter_ref() 0x200b4020: ref=5
bluetoothd[2848]: plugins/hciops.c:hciops_set_name() hci0, name Viper-0
bluetoothd[2848]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2848]: plugins/hciops.c:hciops_set_dev_class() hci0 major 1 minor 0
bluetoothd[2848]: audio/manager.c:state_changed() /org/bluez/2848/hci0 powered on
bluetoothd[2848]: plugins/hciops.c:hciops_disable_cod_cache() hci0 cache_enable 1
bluetoothd[2848]: plugins/hciops.c:hciops_disable_cod_cache() hci0 current_cod 0x000000 wanted_cod 0x480100
bluetoothd[2848]: plugins/hciops.c:write_class() hci0 class 0x480100
bluetoothd[2848]: Adapter /org/bluez/2848/hci0 has been enabled
bluetoothd[2848]: plugins/hciops.c:hciops_set_discoverable() hci0 discoverable 0
bluetoothd[2848]: plugins/hciops.c:hciops_set_pairable() hci0 pairable 1
bluetoothd[2848]: src/adapter.c:btd_adapter_unref() 0x200b4020: ref=4
bluetoothd[2848]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2848]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[2848]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2848]: plugins/hciops.c:read_local_name_complete() hci0 status 0
bluetoothd[2848]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[2848]: plugins/hciops.c:read_scan_complete() hci0 status 0
bluetoothd[2848]: src/adapter.c:adapter_mode_changed() old 0x00 new 0x02
bluetoothd[2848]: src/adapter.c:adapter_set_limited_discoverable() FALSE
bluetoothd[2848]: plugins/hciops.c:hciops_set_limited_discoverable() hci0 limited 0
bluetoothd[2848]: src/adapter.c:set_mode_complete() 
bluetoothd[2848]: src/adapter.c:register_agent() Agent registered for hci0 at :1.67:/org/bluez/agent_2850
bluetoothd[2848]: plugins/hciops.c:link_key_request() hci0 dba 00:07:A4:EE:8F:03
bluetoothd[2848]: plugins/hciops.c:get_auth_info() hci0 dba 00:07:A4:EE:8F:03
bluetoothd[2848]: plugins/hciops.c:link_key_request() kernel auth requirements = 0xff
bluetoothd[2848]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[2848]: plugins/hciops.c:link_key_request() link key type 0x00
bluetoothd[2848]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[2848]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2848]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[2848]: src/event.c:btd_event_bonding_complete() status 0x00
bluetoothd[2848]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2848]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[2848]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[2848]: plugins/hciops.c:disconn_complete() handle 1 status 0x00
bluetoothd[2848]: src/event.c:btd_event_disconn_complete() 
bluetoothd[2848]: src/adapter.c:adapter_remove_connection() 
bluetoothd[2848]: audio/unix.c:server_cb() Accepted new client connection on unix socket (fd=20)
bluetoothd[2848]: audio/headset.c:headset_set_state() State changed /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_DISCONNECTED -> HEADSET_STATE_CONNECTING
bluetoothd[2848]: plugins/hciops.c:link_key_request() hci0 dba 00:07:A4:EE:8F:03
bluetoothd[2848]: plugins/hciops.c:get_auth_info() hci0 dba 00:07:A4:EE:8F:03
bluetoothd[2848]: plugins/hciops.c:link_key_request() kernel auth requirements = 0xff
bluetoothd[2848]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[2848]: plugins/hciops.c:link_key_request() link key type 0x00
bluetoothd[2848]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[2848]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2848]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[2848]: src/event.c:btd_event_bonding_complete() status 0x00
bluetoothd[2848]: src/adapter.c:adapter_get_device() 00:07:A4:EE:8F:03
bluetoothd[2848]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[2848]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[2848]: audio/headset.c:headset_set_channel() Discovered Handsfree service on channel 2
bluetoothd[2848]: audio/headset.c:rfcomm_connect() /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: Connecting to 00:07:A4:EE:8F:03 channel 2
bluetoothd[2848]: audio/headset.c:headset_connect_cb() /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: Connected to 00:07:A4:EE:8F:03
bluetoothd[2848]: audio/headset.c:handle_event() Received AT+BRSF=26
bluetoothd[2848]: audio/headset.c:print_hf_features() HFP HF features: "Call waiting and 3-way calling" "Voice recognition activation" "Remote volume control" 
bluetoothd[2848]: audio/headset.c:handle_event() Received AT+CIND=?
bluetoothd[2848]: audio/headset.c:handle_event() Received AT+CIND?
bluetoothd[2848]: audio/headset.c:handle_event() Received AT+CMER=3,0,0,1
bluetoothd[2848]: audio/headset.c:event_reporting() Event reporting (CMER): mode=3, ind=1
bluetoothd[2848]: audio/headset.c:hfp_slc_complete() HFP Service Level Connection established
bluetoothd[2848]: audio/telephony.c:telephony_device_connected() telephony-dummy: device 0x200b79b0 connected
bluetoothd[2848]: audio/headset.c:headset_set_state() State changed /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTING -> HEADSET_STATE_CONNECTED
bluetoothd[2848]: audio/headset.c:handle_event() Received AT+VGS=07
bluetoothd[2848]: audio/unix.c:server_cb() Accepted new client connection on unix socket (fd=21)
bluetoothd[2848]: audio/unix.c:client_cb() Unix client disconnected (fd=20)
bluetoothd[2848]: audio/unix.c:client_free() client_free(0x200b7b28)
bluetoothd[2848]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[2848]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[2848]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_GET_CAPABILITIES
bluetoothd[2848]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[2848]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[2848]: audio/unix.c:handle_sco_open() open sco - object=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03 source=ANY destination=ANY lock=readwrite
bluetoothd[2848]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[2848]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[2848]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[2848]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[2848]: audio/headset.c:headset_set_state() State changed /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTED -> HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[2848]: audio/headset.c:sco_connect_cb() SCO socket opened for headset /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: audio/headset.c:sco_connect_cb() SCO fd=20
bluetoothd[2848]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[2848]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_INDICATION -> BT_NEW_STREAM
bluetoothd[2848]: audio/headset.c:headset_set_state() State changed /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_PLAY_IN_PROGRESS -> HEADSET_STATE_PLAYING
bluetoothd[2848]: audio/headset.c:headset_set_gain() Ignoring no-change in microphone gain
bluetoothd[2848]: audio/unix.c:client_cb() Unix client disconnected (fd=21)
bluetoothd[2848]: audio/headset.c:headset_set_state() State changed /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_PLAYING -> HEADSET_STATE_CONNECTED
bluetoothd[2848]: audio/unix.c:client_free() client_free(0x200b6518)
bluetoothd[2848]: plugins/hciops.c:disconn_complete() handle 2 status 0x00
bluetoothd[2848]: src/agent.c:agent_release() Releasing agent :1.67, /org/bluez/agent_2850
bluetoothd[2848]: src/adapter.c:adapter_remove() Removing adapter /org/bluez/2848/hci0
bluetoothd[2848]: src/device.c:device_remove() Removing device /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: plugins/hciops.c:hciops_disconnect() hci0
bluetoothd[2848]: plugins/hciops.c:get_handle() hci0 dba 00:07:A4:EE:8F:03
bluetoothd[2848]: serial/manager.c:serial_remove() path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: serial/port.c:path_unregister() Unregistered interface org.bluez.Serial on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: input/manager.c:input_remove() path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: input/device.c:device_unregister() Unregistered interface org.bluez.Input on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: src/device.c:btd_device_unref() 0x200b6570: ref=2
bluetoothd[2848]: audio/unix.c:unix_device_removed() unix_device_removed(0x200b79b0)
bluetoothd[2848]: audio/headset.c:path_unregister() Headset unregistered while device was connected!
bluetoothd[2848]: audio/telephony.c:telephony_device_disconnected() telephony-dummy: device 0x200b79b0 disconnected
bluetoothd[2848]: audio/headset.c:headset_set_state() State changed /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03: HEADSET_STATE_CONNECTED -> HEADSET_STATE_DISCONNECTED
bluetoothd[2848]: audio/headset.c:path_unregister() Unregistered interface org.bluez.Headset on path /org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03
bluetoothd[2848]: src/device.c:btd_device_unref() 0x200b6570: ref=1
bluetoothd[2848]: src/device.c:btd_device_unref() 0x200b6570: ref=0
bluetoothd[2848]: src/device.c:device_free() 0x200b6570
bluetoothd[2848]: audio/manager.c:avrcp_server_remove() path /org/bluez/2848/hci0
bluetoothd[2848]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
bluetoothd[2848]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10003
bluetoothd[2848]: audio/manager.c:audio_adapter_unref() 0x200b44c8: ref=2
bluetoothd[2848]: audio/manager.c:a2dp_server_remove() path /org/bluez/2848/hci0
bluetoothd[2848]: audio/avdtp.c:avdtp_unregister_sep() SEP 0x200b5448 unregistered: type:0 codec:0 seid:1
bluetoothd[2848]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10002
bluetoothd[2848]: audio/manager.c:audio_adapter_unref() 0x200b44c8: ref=1
bluetoothd[2848]: audio/manager.c:headset_server_remove() path /org/bluez/2848/hci0
bluetoothd[2848]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10000
bluetoothd[2848]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10001
bluetoothd[2848]: audio/manager.c:audio_adapter_unref() 0x200b44c8: ref=0
bluetoothd[2848]: src/adapter.c:btd_adapter_unref() 0x200b4020: ref=3
bluetoothd[2848]: src/adapter.c:btd_adapter_unref() 0x200b4020: ref=2
bluetoothd[2848]: serial/manager.c:proxy_remove() path /org/bluez/2848/hci0
bluetoothd[2848]: src/adapter.c:btd_adapter_unref() 0x200b4020: ref=1
bluetoothd[2848]: plugins/service.c:unregister_interface() path /org/bluez/2848/hci0
bluetoothd[2848]: plugins/hciops.c:hciops_power_off() hci0
bluetoothd[2848]: src/adapter.c:btd_adapter_unref() 0x200b4020: ref=0
bluetoothd[2848]: src/adapter.c:adapter_free() 0x200b4020
bluetoothd[2848]: src/plugin.c:plugin_cleanup() Cleanup plugins
bluetoothd[2848]: plugins/service.c:unregister_interface() path /org/bluez/2848/any
bluetoothd[2848]: plugins/hciops.c:hciops_exit() 
bluetoothd[2848]: plugins/hciops.c:hciops_cleanup() 
bluetoothd[2848]: Stopping hci0 event socket
bluetoothd[2848]: Stopping SDP server
bluetoothd[2848]: Exit


--------------090007030505090905000309
Content-Type: text/x-log;
 name="pulseaudio.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="pulseaudio.log"

# LD_LIBRARY_PATH=/afc/lib/pulse-0.9.23/modules /afc/bin/pulseaudio --system --high-priority --disallow-exit --log-target=stderr --use-pid-file --disable-shm -vvvvvvv
W: main.c: Running in system mode, but --disallow-module-loading not set!
N: main.c: Running in system mode, forcibly disabling exit idle time!
I: main.c: setrlimit(RLIMIT_RTTIME, (1000000, 1000000)) failed: Invalid argument
D: core-util.c: setpriority() worked.
I: core-util.c: Successfully gained nice level -11.
I: main.c: Found user 'pulse' (UID 110) and group 'pulse' (GID 115).
I: main.c: Successfully dropped root privileges.
I: main.c: This is PulseAudio 0.9.23
D: main.c: Compilation host: powerpc-603e-linux-gnu
D: main.c: Compilation CFLAGS: -pipe -g -O2 -mcpu=603e -Wall -W -Wextra -pipe -Wno-long-long -Winline -Wunsafe-loop-optimizations -Wundef -Wformat=2 -Wsign-compare -Wformat-security -Wmissing-include-dirs -Wformat-nonliteral -Wold-style-definition -Wpointer-arith -Winit-self -Wdeclaration-after-statement -Wfloat-equal -Wmissing-prototypes -Wstrict-prototypes -Wredundant-decls -Wmissing-declarations -Wmissing-noreturn -Wshadow -Wendif-labels -Wcast-align -Wstrict-aliasing=2 -Wwrite-strings -Wno-unused-parameter -ffast-math -Wp,-D_FORTIFY_SOURCE=2 -fno-common -fdiagnostics-show-option
D: main.c: Running on host: Linux ppc 2.6.24.6.0.54000 #1 PREEMPT Wed Dec 1 12:42:48 WST 2010
D: main.c: Found 1 CPUs.
I: main.c: Page size is 4096 bytes
D: main.c: Compiled with Valgrind support: no
D: main.c: Running in valgrind mode: no
D: main.c: Running in VM: no
D: main.c: Optimized build: yes
D: main.c: All asserts enabled.
I: main.c: Machine ID is 5852ddc3a8694cf3ea59e202000000a8.
I: main.c: Using runtime directory /afc/var/run/pulse.
I: main.c: Using state directory /afc/var/lib/pulse.
I: main.c: Using modules directory /afc/lib/pulse-0.9.23/modules.
I: main.c: Running in system mode: yes
W: main.c: OK, so you are running PA in system mode. Please note that you most likely shouldn't be doing that.
W: main.c: If you do it nonetheless then it's your own fault if things don't work as expected.
W: main.c: Please read http://pulseaudio.org/wiki/WhatIsWrongWithSystemMode for an explanation why system mode is usually a bad idea.
I: main.c: Fresh high-resolution timers available! Bon appetit!
W: shm.c: Failed to read /dev/shm/: No such file or directory
D: memblock.c: Using private memory pool with 1024 slots of size 64.0 KiB each, total size is 64.0 MiB, maximum usable slot size is 65496
I: sink.c: Created sink 0 "null" with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: sink.c:     device.description = "Null Output"
I: sink.c:     device.class = "abstract"
I: sink.c:     device.icon_name = "audio-card"
I: source.c: Created source 0 "null.monitor" with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: source.c:     device.description = "Monitor of Null Output"
I: source.c:     device.class = "monitor"
I: source.c:     device.icon_name = "audio-input-microphone"
D: module-null-sink.c: Thread starting up
I: module.c: Loaded "module-null-sink" (index: #0; argument: "").
W: module.c: module-oss is deprecated: Please use module-alsa-card instead of module-oss!
D: oss-util.c: capabilities: DUPLEX MMAP REALTIME TRIGGER
I: module-oss.c: Hardware name is '(DUPLEX)'.
I: module-oss.c: Device opened in O_RDWR mode.
D: oss-util.c: Asking for 4 fragments of size 4096 (requested 4408)
I: module-oss.c: Input -- 4 fragments of size 8192.
I: module-oss.c: Output -- 4 fragments of size 8192.
I: source.c: Created source 1 "input" with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: source.c:     device.string = "/dev/dsp"
I: source.c:     device.api = "oss"
I: source.c:     device.description = "(DUPLEX)"
I: source.c:     device.access_mode = "serial"
I: source.c:     device.buffering.buffer_size = "32768"
I: source.c:     device.buffering.fragment_size = "8192"
I: source.c:     device.icon_name = "audio-input-microphone"
I: sink.c: Created sink 1 "output" with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: sink.c:     device.string = "/dev/dsp"
I: sink.c:     device.api = "oss"
I: sink.c:     device.description = "(DUPLEX)"
I: sink.c:     device.access_mode = "serial"
I: sink.c:     device.buffering.buffer_size = "32768"
I: sink.c:     device.buffering.fragment_size = "8192"
I: sink.c:     device.icon_name = "audio-card"
I: source.c: Created source 2 "output.monitor" with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: source.c:     device.description = "Monitor of (DUPLEX)"
I: source.c:     device.class = "monitor"
I: source.c:     device.icon_name = "audio-input-microphone"
D: module-oss.c: Found hardware mixer track for playback.
D: module-oss.c: Found hardware mixer track for recording.
D: module-oss.c: Thread starting up
D: core-util.c: SCHED_RR worked.
I: core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
D: oss-util.c: Read mixer settings: 0:   0% 1:   0%
D: oss-util.c: Read mixer settings: 0:   0% 1:   0%
D: module-oss.c: trigger
D: module-oss.c: trigger: 2
D: module-oss.c: trigger
D: module-oss.c: trigger: 3
I: module.c: Loaded "module-oss" (index: #1; argument: "sink_name=output source_name=input mmap=0").
I: module.c: Loaded "module-native-protocol-unix" (index: #2; argument: "").
I: module.c: Loaded "module-native-protocol-tcp" (index: #3; argument: "").
D: dbus-util.c: Successfully connected to D-Bus system bus 6ed812901a8b6cba296de51300000b96 as :1.68
D: bluetooth-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameAcquired
D: bluetooth-util.c: Unknown Bluetooth minor device class 3
I: card.c: Created 0 "bluez_card.00_07_A4_EE_8F_03"
W: module-bluetooth-device.c: Default profile not connected, selecting off profile
D: module-bluetooth-device.c: Connected to the bluetooth audio service
I: module.c: Loaded "module-bluetooth-device" (index: #4; argument: "sink_name=bluetooth_output source_name=bluetooth_input profile=hsp address=00:07:A4:EE:8F:03").
E: main.c: Sink bluetooth_output does not exist.
E: main.c: Source bluetooth_input does not exist.
D: main.c: Got org.pulseaudio.Server!
I: main.c: Daemon startup complete.
D: bluetooth-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameAcquired
D: module-bluetooth-device.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameAcquired
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Audio, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Device, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Device, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Audio, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=SpeakerGainChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=SpeakerGainChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
I: client.c: Created 0 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 16, local 16
I: protocol-native.c: Got credentials: uid=0 gid=0 success=1
D: protocol-native.c: SHM possible: no
D: protocol-native.c: Negotiated SHM: no
D: module-bluetooth-device.c: Connected to the bluetooth audio service
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_GET_CAPABILITIES
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_RESPONSE <- BT_GET_CAPABILITIES
D: module-bluetooth-device.c: Payload size is 9 6
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_GET_CAPABILITIES
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_RESPONSE <- BT_GET_CAPABILITIES
D: module-bluetooth-device.c: Payload size is 9 6
D: module-bluetooth-device.c: Got device capabilities
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_OPEN
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_RESPONSE <- BT_OPEN
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_SET_CONFIGURATION
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_RESPONSE <- BT_SET_CONFIGURATION
D: module-bluetooth-device.c: Connection to the device configured
D: module-bluetooth-device.c: Got the stream socket
I: sink.c: Created sink 2 "bluetooth_output" with sample spec s16le 1ch 8000Hz and channel map mono
I: sink.c:     bluetooth.protocol = "sco"
I: sink.c:     device.intended_roles = "phone"
I: sink.c:     device.description = "Samsung WEP150"
I: sink.c:     device.string = "00:07:A4:EE:8F:03"
I: sink.c:     device.api = "bluez"
I: sink.c:     device.class = "sound"
I: sink.c:     device.bus = "bluetooth"
I: sink.c:     bluez.path = "/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03"
I: sink.c:     bluez.class = "0x20040c"
I: sink.c:     bluez.name = "Samsung WEP150"
I: sink.c:     device.icon_name = "audio-card-bluetooth"
I: source.c: Created source 3 "bluetooth_output.monitor" with sample spec s16le 1ch 8000Hz and channel map mono
I: source.c:     device.description = "Monitor of Samsung WEP150"
I: source.c:     device.class = "monitor"
I: source.c:     device.string = "00:07:A4:EE:8F:03"
I: source.c:     device.api = "bluez"
I: source.c:     device.bus = "bluetooth"
I: source.c:     bluez.path = "/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03"
I: source.c:     bluez.class = "0x20040c"
I: source.c:     bluez.name = "Samsung WEP150"
I: source.c:     device.icon_name = "audio-card-bluetooth"
I: source.c: Created source 4 "bluetooth_input" with sample spec s16le 1ch 8000Hz and channel map mono
I: source.c:     bluetooth.protocol = "hsp"
I: source.c:     device.intended_roles = "phone"
I: source.c:     device.description = "Samsung WEP150"
I: source.c:     device.string = "00:07:A4:EE:8F:03"
I: source.c:     device.api = "bluez"
I: source.c:     device.class = "sound"
I: source.c:     device.bus = "bluetooth"
I: source.c:     bluez.path = "/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03"
I: source.c:     bluez.class = "0x20040c"
I: source.c:     bluez.name = "Samsung WEP150"
I: source.c:     device.icon_name = "audio-card-bluetooth"
D: module-bluetooth-device.c: IO Thread starting up
D: core-util.c: SCHED_RR worked.
I: core-util.c: Successfully enabled SCHED_RR scheduling for thread, with priority 5.
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_START_STREAM
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_RESPONSE <- BT_START_STREAM
D: module-bluetooth-device.c: Trying to receive message from audio service...
D: module-bluetooth-device.c: Received BT_INDICATION <- BT_NEW_STREAM
D: module-bluetooth-device.c: Stream properly set up, we're ready to roll!
I: card.c: Changed profile of card 0 "bluez_card.00_07_A4_EE_8F_03" to hsp
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=SpeakerGainChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=SpeakerGainChanged
D: bluetooth-util.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: module-bluetooth-device.c: dbus: interface=org.bluez.Headset, path=/org/bluez/2848/hci0/dev_00_07_A4_EE_8F_03, member=PropertyChanged
D: bluetooth-util.c: dbus: interface=(null), path=(null), member=(null)
D: module-bluetooth-device.c: dbus: interface=(null), path=(null), member=(null)
D: bluetooth-util.c: dbus: interface=(null), path=(null), member=(null)
D: module-bluetooth-device.c: dbus: interface=(null), path=(null), member=(null)
I: client.c: Freed 0 "pactl"
I: protocol-native.c: Connection died.
I: client.c: Created 1 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 16, local 16
I: protocol-native.c: Got credentials: uid=0 gid=0 success=1
D: protocol-native.c: SHM possible: no
D: protocol-native.c: Negotiated SHM: no
I: resampler.c: Forcing resampler 'copy', because of fixed, identical sample rates.
I: resampler.c: Using resampler 'copy'
I: resampler.c: Using s16be as working format.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0, base=2, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432, tlength=33554432, base=2, prebuf=0, minreq=2 maxrewind=0
I: sink-input.c: Created input 0 "/afc/tmp/test.wav" on bluetooth_output with sample spec s16be 1ch 8000Hz and channel map mono
I: sink-input.c:     media.format = "WAV (Microsoft)"
I: sink-input.c:     application.name = "paplay"
I: sink-input.c:     media.name = "/afc/tmp/test.wav"
I: sink-input.c:     native-protocol.peer = "UNIX socket client"
I: sink-input.c:     native-protocol.version = "16"
I: sink-input.c:     application.process.id = "2867"
I: sink-input.c:     application.process.user = "root"
I: sink-input.c:     application.process.host = "Viper"
I: sink-input.c:     application.process.binary = "pacat"
I: sink-input.c:     application.language = "C"
I: sink-input.c:     application.process.machine_id = "5852ddc3a8694cf3ea59e202000000a8"
I: protocol-native.c: Requested tlength=2000.00 ms, minreq=20.00 ms
D: protocol-native.c: Traditional mode enabled, modifying sink usec only for compat with minreq.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=32000, base=2, prebuf=31682, minreq=320 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=32000, base=2, prebuf=31682, minreq=320 maxrewind=0
I: protocol-native.c: Final latency 2128.00 ms = 1960.00 ms + 2*20.00 ms + 128.00 ms
D: protocol-native.c: Requesting rewind due to end of underrun.
D: core.c: Hmm, no streams around, trying to vacuum.
I: sink-input.c: Freeing input 0 "/afc/tmp/test.wav"
I: client.c: Freed 1 "paplay"
I: protocol-native.c: Connection died.
I: client.c: Created 2 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 16, local 16
I: protocol-native.c: Got credentials: uid=0 gid=0 success=1
D: protocol-native.c: SHM possible: no
D: protocol-native.c: Negotiated SHM: no
D: resampler.c: Channel matrix:
D: resampler.c:        I00   I01 
D: resampler.c:     +------------
D: resampler.c: O00 | 1.000 1.000
I: remap.c: Using generic matrix remapping
I: resampler.c: Using resampler 'speex-float-3'
I: resampler.c: Using float32be as working format.
I: resampler.c: Choosing speex quality setting 3.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0, base=2, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432, tlength=33554432, base=2, prebuf=0, minreq=2 maxrewind=0
I: sink-input.c: Created input 1 "MPEG Audio" on bluetooth_output with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: sink-input.c:     media.name = "MPEG Audio"
I: sink-input.c:     application.name = "mpg123"
I: sink-input.c:     native-protocol.peer = "UNIX socket client"
I: sink-input.c:     native-protocol.version = "16"
I: sink-input.c:     application.process.id = "2868"
I: sink-input.c:     application.process.user = "root"
I: sink-input.c:     application.process.host = "Viper"
I: sink-input.c:     application.process.binary = "mpg123"
I: sink-input.c:     application.language = "C"
I: sink-input.c:     application.process.machine_id = "5852ddc3a8694cf3ea59e202000000a8"
I: protocol-native.c: Requested tlength=250.00 ms, minreq=20.00 ms
D: protocol-native.c: Adjust latency mode enabled, configuring sink latency to half of overall latency.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=29636, base=4, prebuf=26112, minreq=3528 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=29636, base=4, prebuf=26112, minreq=3528 maxrewind=0
I: protocol-native.c: Final latency 296.00 ms = 128.00 ms + 2*20.00 ms + 128.00 ms
D: core.c: Hmm, no streams around, trying to vacuum.
I: sink-input.c: Freeing input 1 "MPEG Audio"
I: client.c: Freed 2 "mpg123"
I: protocol-native.c: Connection died.
I: client.c: Created 3 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 16, local 16
I: protocol-native.c: Got credentials: uid=0 gid=0 success=1
D: protocol-native.c: SHM possible: no
D: protocol-native.c: Negotiated SHM: no
D: resampler.c: Channel matrix:
D: resampler.c:        I00   I01 
D: resampler.c:     +------------
D: resampler.c: O00 | 1.000 1.000
I: remap.c: Using generic matrix remapping
I: resampler.c: Using resampler 'speex-float-3'
I: resampler.c: Using float32be as working format.
I: resampler.c: Choosing speex quality setting 3.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0, base=2, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432, tlength=33554432, base=2, prebuf=0, minreq=2 maxrewind=0
I: sink-input.c: Created input 2 "MPEG Audio" on bluetooth_output with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: sink-input.c:     media.name = "MPEG Audio"
I: sink-input.c:     application.name = "mpg123"
I: sink-input.c:     native-protocol.peer = "UNIX socket client"
I: sink-input.c:     native-protocol.version = "16"
I: sink-input.c:     application.process.id = "2868"
I: sink-input.c:     application.process.user = "root"
I: sink-input.c:     application.process.host = "Viper"
I: sink-input.c:     application.process.binary = "mpg123"
I: sink-input.c:     application.language = "C"
I: sink-input.c:     application.process.machine_id = "5852ddc3a8694cf3ea59e202000000a8"
I: protocol-native.c: Requested tlength=250.00 ms, minreq=20.00 ms
D: protocol-native.c: Adjust latency mode enabled, configuring sink latency to half of overall latency.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=29636, base=4, prebuf=26112, minreq=3528 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=29636, base=4, prebuf=26112, minreq=3528 maxrewind=0
I: protocol-native.c: Final latency 296.00 ms = 128.00 ms + 2*20.00 ms + 128.00 ms
D: core.c: Hmm, no streams around, trying to vacuum.
I: sink-input.c: Freeing input 2 "MPEG Audio"
I: client.c: Freed 3 "mpg123"
I: protocol-native.c: Connection died.
I: client.c: Created 4 "Native client (UNIX socket client)"
D: protocol-native.c: Protocol version: remote 16, local 16
I: protocol-native.c: Got credentials: uid=0 gid=0 success=1
D: protocol-native.c: SHM possible: no
D: protocol-native.c: Negotiated SHM: no
D: resampler.c: Channel matrix:
D: resampler.c:        I00   I01 
D: resampler.c:     +------------
D: resampler.c: O00 | 1.000 1.000
I: remap.c: Using generic matrix remapping
I: resampler.c: Using resampler 'speex-float-3'
I: resampler.c: Using float32be as working format.
I: resampler.c: Choosing speex quality setting 3.
D: memblockq.c: memblockq requested: maxlength=33554432, tlength=0, base=2, prebuf=0, minreq=1 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=33554432, tlength=33554432, base=2, prebuf=0, minreq=2 maxrewind=0
I: sink-input.c: Created input 3 "MPEG Audio" on bluetooth_output with sample spec s16be 2ch 44100Hz and channel map front-left,front-right
I: sink-input.c:     media.name = "MPEG Audio"
I: sink-input.c:     application.name = "mpg123"
I: sink-input.c:     native-protocol.peer = "UNIX socket client"
I: sink-input.c:     native-protocol.version = "16"
I: sink-input.c:     application.process.id = "2868"
I: sink-input.c:     application.process.user = "root"
I: sink-input.c:     application.process.host = "Viper"
I: sink-input.c:     application.process.binary = "mpg123"
I: sink-input.c:     application.language = "C"
I: sink-input.c:     application.process.machine_id = "5852ddc3a8694cf3ea59e202000000a8"
I: protocol-native.c: Requested tlength=250.00 ms, minreq=20.00 ms
D: protocol-native.c: Adjust latency mode enabled, configuring sink latency to half of overall latency.
D: memblockq.c: memblockq requested: maxlength=4194304, tlength=29636, base=4, prebuf=26112, minreq=3528 maxrewind=0
D: memblockq.c: memblockq sanitized: maxlength=4194304, tlength=29636, base=4, prebuf=26112, minreq=3528 maxrewind=0
I: protocol-native.c: Final latency 296.00 ms = 128.00 ms + 2*20.00 ms + 128.00 ms
D: protocol-native.c: Requesting rewind due to end of underrun.
D: protocol-native.c: Requesting rewind due to end of underrun.
D: core.c: Hmm, no streams around, trying to vacuum.
I: sink-input.c: Freeing input 3 "MPEG Audio"
I: client.c: Freed 4 "mpg123"
I: protocol-native.c: Connection died.
I: main.c: Got signal SIGINT.
I: main.c: Exiting.
I: main.c: Daemon shutdown initiated.
I: module.c: Unloading "module-null-sink" (index: #0).
D: module-null-sink.c: Thread shutting down
I: sink.c: Freeing sink 0 "null"
I: source.c: Freeing source 0 "null.monitor"
I: module.c: Unloaded "module-null-sink" (index: #0).
I: module.c: Unloading "module-oss" (index: #1).
D: module-oss.c: Thread shutting down
I: sink.c: Freeing sink 1 "output"
I: source.c: Freeing source 2 "output.monitor"
I: source.c: Freeing source 1 "input"
I: module.c: Unloaded "module-oss" (index: #1).
I: module.c: Unloading "module-native-protocol-unix" (index: #2).
I: module.c: Unloaded "module-native-protocol-unix" (index: #2).
I: module.c: Unloading "module-native-protocol-tcp" (index: #3).
I: module.c: Unloaded "module-native-protocol-tcp" (index: #3).
I: module.c: Unloading "module-bluetooth-device" (index: #4).
D: module-bluetooth-device.c: IO thread shutting down
I: sink.c: Freeing sink 2 "bluetooth_output"
I: source.c: Freeing source 3 "bluetooth_output.monitor"
I: source.c: Freeing source 4 "bluetooth_input"
I: card.c: Freed 0 "bluez_card.00_07_A4_EE_8F_03"
I: module.c: Unloaded "module-bluetooth-device" (index: #4).
I: main.c: Daemon terminated.


--------------090007030505090905000309
Content-Type: text/x-log;
 name="mpg123.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="mpg123.log"

# mpg123 -vvvvv -o pulse /afc/tmp/armin.mp3 
Trying output module pulse.
Using default module dir: /afc/lib/mpg123
Module dir: /afc/lib/mpg123
Module path: ./output_pulse.la
Note: pulse is the last output option... showing you any error messages now.
Output module 'pulse' chosen.
High Performance MPEG 1.0/2.0/2.5 Audio Player for Layers 1, 2 and 3
	version 1.13.3; written and copyright by Michael Hipp and others
	free software (LGPL/GPL) without any warranty but with best wishes
Decoder: generic
Note: Disabling all formats.
Note: checking support for 8000Hz/1ch.
Note: result 0xd0
Note: Want to enable format 8000/1 for encodings 0xd0.
Note: checking support for 11025Hz/1ch.
Note: result 0xd0
Note: Want to enable format 11025/1 for encodings 0xd0.
Note: checking support for 12000Hz/1ch.
Note: result 0xd0
Note: Want to enable format 12000/1 for encodings 0xd0.
Note: checking support for 16000Hz/1ch.
Note: result 0xd0
Note: Want to enable format 16000/1 for encodings 0xd0.
Note: checking support for 22050Hz/1ch.
Note: result 0xd0
Note: Want to enable format 22050/1 for encodings 0xd0.
Note: checking support for 24000Hz/1ch.
Note: result 0xd0
Note: Want to enable format 24000/1 for encodings 0xd0.
Note: checking support for 32000Hz/1ch.
Note: result 0xd0
Note: Want to enable format 32000/1 for encodings 0xd0.
Note: checking support for 44100Hz/1ch.
Note: result 0xd0
Note: Want to enable format 44100/1 for encodings 0xd0.
Note: checking support for 48000Hz/1ch.
Note: result 0xd0
Note: Want to enable format 48000/1 for encodings 0xd0.
Note: checking support for 8000Hz/2ch.
Note: result 0xd0
Note: Want to enable format 8000/2 for encodings 0xd0.
Note: checking support for 11025Hz/2ch.
Note: result 0xd0
Note: Want to enable format 11025/2 for encodings 0xd0.
Note: checking support for 12000Hz/2ch.
Note: result 0xd0
Note: Want to enable format 12000/2 for encodings 0xd0.
Note: checking support for 16000Hz/2ch.
Note: result 0xd0
Note: Want to enable format 16000/2 for encodings 0xd0.
Note: checking support for 22050Hz/2ch.
Note: result 0xd0
Note: Want to enable format 22050/2 for encodings 0xd0.
Note: checking support for 24000Hz/2ch.
Note: result 0xd0
Note: Want to enable format 24000/2 for encodings 0xd0.
Note: checking support for 32000Hz/2ch.
Note: result 0xd0
Note: Want to enable format 32000/2 for encodings 0xd0.
Note: checking support for 44100Hz/2ch.
Note: result 0xd0
Note: Want to enable format 44100/2 for encodings 0xd0.
Note: checking support for 48000Hz/2ch.
Note: result 0xd0
Note: Want to enable format 48000/2 for encodings 0xd0.

Audio driver: pulse
Audio device: <none>
Audio capabilities:
(matrix of [S]tereo or [M]ono support for sample format and rate in Hz)
       |  s16  |  u16  |  s8   |  u8   | ulaw  | alaw  |
 ------|-------|-------|-------|-------|-------|-------|
  8000 |  M/S  |       |       |       |       |       |
 11025 |  M/S  |       |       |       |       |       |
 12000 |  M/S  |       |       |       |       |       |
 16000 |  M/S  |       |       |       |       |       |
 22050 |  M/S  |       |       |       |       |       |
 24000 |  M/S  |       |       |       |       |       |
 32000 |  M/S  |       |       |       |       |       |
 44100 |  M/S  |       |       |       |       |       |
 48000 |  M/S  |       |       |       |       |       |


playlist in normal order:
/afc/tmp/armin.mp3


Directory: /afc/tmp/
Playing MPEG stream 1 of 1: armin.mp3 ...
Note: ID3v2.3 rev 0 tag of 1329 bytes
Note: ID3v2 COMM frame of size 44
Note: Storing comment from UTF-16 BOM encoding
Note: ID3 comm/uslt desc of length 2.
Note: ID3 comm/uslt text of length 18.
Note: ID3v2 TCOM frame of size 37
Note: Storing text from UTF-16 BOM encoding
Note: ID3v2 TCOM text frame: www.club-team.net
Note: ID3v2 TPE2 frame of size 37
Note: Storing text from UTF-16 BOM encoding
Note: ID3v2 TPE2 text frame: www.club-team.net
Note: ID3v2 TIT2 frame of size 77
Note: Storing text from UTF-16 BOM encoding
Note: ID3v2 TIT2 text frame: Falling Away (armin van buuren remix)
Note: ID3v2 TPE1 frame of size 7
Note: Storing text from Latin 1 encoding
Note: ID3v2 TPE1 text frame: Hannah
Note: ID3v2 TALB frame of size 37
Note: Storing text from UTF-16 BOM encoding
Note: ID3v2 TALB text frame: www.club-team.net
Note: ID3v2 TCON frame of size 6
Note: Storing text from Latin 1 encoding
Note: ID3v2 TCON text frame: DANCE
Note: ID3v2 TIT3 frame of size 23
Note: Storing text from Latin 1 encoding
Note: ID3v2 TIT3 text frame: Armin van Buuren Remix
Note: ID3v2 TYER frame of size 5
Note: Storing text from Latin 1 encoding
Note: ID3v2 TYER text frame: 2011
Note: ID3v2 TRCK frame of size 4
Note: Storing text from Latin 1 encoding
Note: ID3v2 TRCK text frame: 1/1
Note: ID3v2 TPOS frame of size 4
Note: Storing text from Latin 1 encoding
Note: ID3v2 TPOS text frame: 1/1
Note: Xing/Lame/Info header detected
Note: Xing: 17820 frames
Note: Xing stream size 18621125 differs by 0.000072% from determined/given file size!
Note: Xing: 18621125 bytes
Note: Xing: quality = 57
Note: Info: Encoder: LAME3.98r
Note: Info: rev 0
Note: Info: vbr mode 1
Note: Info: peak = 0.000000 (I won't use this)
Note: Info: Radio Gain = -2.7dB
Note: Info: Audiophile Gain = 0.0dB
Note: Encoder delay = 576; padding = 1518
Note: New output format 44100Hz 2ch, format 208
Title:   Falling Away (armin van buuren remix)
Artist:  Hannah
Comment: www.club-team.net               Album:  www.club-team.net
Year:    2011                            Genre:  DANCE
MPEG 1.0, Layer: III, Freq: 44100, mode: Joint-Stereo, modext: 2, BPF : 1044
Channels: 2, copyright: No, original: Yes, CRC: No, emphasis: 0.
Bitrate: 320 kbit/s Extension value: 0
Frame#     6 [17814], Time: 00:00.15 [07:45.34], RVA:   off, Vol: 100(100)[2] + Stopped                    mpg123 -vvvvv -o pulse /afc/tmp/armin.mp3


--------------090007030505090905000309
Content-Type: text/x-log;
 name="paplay.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="paplay.log"

# paplay -p -v -d bluetooth_output /afc/tmp/test.wav 
Opening a playback stream with sample specification 's16be 1ch 8000Hz' and channel map 'mono'.
Connection established.
Stream successfully created.
Buffer metrics: maxlength=4194304, tlength=32000, prebuf=31682, minreq=320
Using sample spec 's16be 1ch 8000Hz', channel map 'mono'.
Connected to device bluetooth_output (2, not suspended).
Got signal, exiting.ency: 2000000 usec.


--------------090007030505090905000309
Content-Type: application/octet-stream;
 name="bluetooth-audio.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bluetooth-audio.conf"

W0dlbmVyYWxdCk1hc3Rlcj10cnVlClNDT1JvdXRpbmc9UENNCkF1dG9Db25uZWN0PXRydWUK
CltIZWFkc2V0XQpIRlA9dHJ1ZQpNYXhDb25uZWN0ZWQ9MQoK
--------------090007030505090905000309
Content-Type: application/octet-stream;
 name="bluetooth-main.conf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bluetooth-main.conf"

W0dlbmVyYWxdCgojIExpc3Qgb2YgcGx1Z2lucyB0aGF0IHNob3VsZCBub3QgYmUgbG9hZGVk
IG9uIGJsdWV0b290aGQgc3RhcnR1cAojRGlzYWJsZVBsdWdpbnMgPSBuZXR3b3JrLGlucHV0
CgojIERlZmF1bHQgYWRhcGVyIG5hbWUKIyAlaCAtIHN1YnN0aXR1dGVkIGZvciBob3N0bmFt
ZQojICVkIC0gc3Vic3RpdHV0ZWQgZm9yIGFkYXB0ZXIgaWQKTmFtZSA9ICVoLSVkCgojIERl
ZmF1bHQgZGV2aWNlIGNsYXNzLiBPbmx5IHRoZSBtYWpvciBhbmQgbWlub3IgZGV2aWNlIGNs
YXNzIGJpdHMgYXJlCiMgY29uc2lkZXJlZC4KQ2xhc3MgPSAweDAwMDEwMAoKIyBIb3cgbG9u
ZyB0byBzdGF5IGluIGRpc2NvdmVyYWJsZSBtb2RlIGJlZm9yZSBnb2luZyBiYWNrIHRvIG5v
bi1kaXNjb3ZlcmFibGUKIyBUaGUgdmFsdWUgaXMgaW4gc2Vjb25kcy4gRGVmYXVsdCBpcyAx
ODAsIGkuZS4gMyBtaW51dGVzLgojIDAgPSBkaXNhYmxlIHRpbWVyLCBpLmUuIHN0YXkgZGlz
Y292ZXJhYmxlIGZvcmV2ZXIKRGlzY292ZXJhYmxlVGltZW91dCA9IDAKCiMgSG93IGxvbmcg
dG8gc3RheSBpbiBwYWlyYWJsZSBtb2RlIGJlZm9yZSBnb2luZyBiYWNrIHRvIG5vbi1kaXNj
b3ZlcmFibGUKIyBUaGUgdmFsdWUgaXMgaW4gc2Vjb25kcy4gRGVmYXVsdCBpcyAwLgojIDAg
PSBkaXNhYmxlIHRpbWVyLCBpLmUuIHN0YXkgcGFpcmFibGUgZm9yZXZlcgpQYWlyYWJsZVRp
bWVvdXQgPSAwCgojIFVzZSBzb21lIG90aGVyIHBhZ2UgdGltZW91dCB0aGFuIHRoZSBjb250
cm9sbGVyIGRlZmF1bHQgb25lCiMgd2hpY2ggaXMgMTYzODQgKDEwIHNlY29uZHMpLgpQYWdl
VGltZW91dCA9IDgxOTIKCiMgRGlzY292ZXIgc2NoZWR1bGVyIGludGVydmFsIHVzZWQgaW4g
QWRhcHRlci5EaXNjb3ZlckRldmljZXMKIyBUaGUgdmFsdWUgaXMgaW4gc2Vjb25kcy4gRGVm
YXVsdHMgaXMgMzAuCkRpc2NvdmVyU2NoZWR1bGVySW50ZXJ2YWwgPSAzMAoKIyBXaGF0IHZh
bHVlIHNob3VsZCBiZSBhc3N1bWVkIGZvciB0aGUgYWRhcHRlciBQb3dlcmVkIHByb3BlcnR5
IHdoZW4KIyBTZXRQcm9wZXJ0eShQb3dlcmVkLCAuLi4pIGhhc24ndCBiZWVuIGNhbGxlZCB5
ZXQuIERlZmF1bHRzIHRvIHRydWUKSW5pdGlhbGx5UG93ZXJlZCA9IHRydWUKCiMgUmVtZW1i
ZXIgdGhlIHByZXZpb3VzbHkgc3RvcmVkIFBvd2VyZWQgc3RhdGUgd2hlbiBpbml0aWFsaXpp
bmcgYWRhcHRlcnMKUmVtZW1iZXJQb3dlcmVkID0gdHJ1ZQoKIyBVc2UgdmVuZG9yLCBwcm9k
dWN0IGFuZCB2ZXJzaW9uIGluZm9ybWF0aW9uIGZvciBESUQgcHJvZmlsZSBzdXBwb3J0Lgoj
IFRoZSB2YWx1ZXMgYXJlIHNlcGFyYXRlZCBieSAiOiIgYW5kIFZJRCwgUElEIGFuZCB2ZXJz
aW9uLgojRGV2aWNlSUQgPSAxMjM0OjU2Nzg6YWJjZAoKIyBEbyByZXZlcnNlIHNlcnZpY2Ug
ZGlzY292ZXJ5IGZvciBwcmV2aW91c2x5IHVua25vd24gZGV2aWNlcyB0aGF0IGNvbm5lY3Qg
dG8KIyB1cy4gVGhpcyBvcHRpb24gaXMgcmVhbGx5IG9ubHkgbmVlZGVkIGZvciBxdWFsaWZp
Y2F0aW9uIHNpbmNlIHRoZSBCSVRFIHRlc3RlcgojIGRvZXNuJ3QgbGlrZSB1cyBkb2luZyBy
ZXZlcnNlIFNEUCBmb3Igc29tZSB0ZXN0IGNhc2VzICh0aG91Z2ggdGhlcmUgY291bGQgaW4K
IyB0aGVvcnkgYmUgb3RoZXIgdXNlZnVsIHB1cnBvc2VzIGZvciB0aGlzIHRvbykuIERlZmF1
bHRzIHRvIHRydWUuClJldmVyc2VTZXJ2aWNlRGlzY292ZXJ5ID0gdHJ1ZQoKIyBFbmFibGUg
bmFtZSByZXNvbHZpbmcgYWZ0ZXIgaW5xdWlyeS4gU2V0IGl0IHRvICdmYWxzZScgaWYgeW91
IGRvbid0IG5lZWQKIyByZW1vdGUgZGV2aWNlcyBuYW1lIGFuZCB3YW50IHNob3J0ZXIgZGlz
Y292ZXJ5IGN5Y2xlLiBEZWZhdWx0cyB0byAndHJ1ZScuCk5hbWVSZXNvbHZpbmcgPSB0cnVl
CgojIEVuYWJsZSBydW50aW1lIHBlcnNpc3RlbmN5IG9mIGRlYnVnIGxpbmsga2V5cy4gRGVm
YXVsdCBpcyBmYWxzZSB3aGljaAojIG1ha2VzIGRlYnVnIGxpbmsga2V5cyB2YWxpZCBvbmx5
IGZvciB0aGUgZHVyYXRpb24gb2YgdGhlIGNvbm5lY3Rpb24KIyB0aGF0IHRoZXkgd2VyZSBj
cmVhdGVkIGZvci4KRGVidWdLZXlzID0gZmFsc2UKCiMgRW5hYmxlIExvdyBFbmVyZ3kgc3Vw
cG9ydCBpZiB0aGUgZG9uZ2xlIHN1cHBvcnRzLiBEZWZhdWx0IGlzIGZhbHNlLgojIEVuYWJs
ZS9EaXNhYmxlIGludGVybGVhdmUgZGlzY292ZXJ5IGFuZCBhdHRyaWJ1dGUgc2VydmVyIG92
ZXIgTEUuCkVuYWJsZUxFID0gZmFsc2UKCiMgRW5hYmxlIHRoZSBHQVRUIEF0dHJpYnV0ZSBT
ZXJ2ZXIuIERlZmF1bHQgaXMgZmFsc2UsIGJlY2F1c2UgaXQgaXMgb25seQojIHVzZWZ1bCBm
b3IgdGVzdGluZy4gQXR0cmlidXRlIHNlcnZlciBpcyBub3QgZW5hYmxlZCBvdmVyIExFIGlm
IEVuYWJsZUxFCiMgaXMgZmFsc2UuCkF0dHJpYnV0ZVNlcnZlciA9IGZhbHNlCg==
--------------090007030505090905000309
Content-Type: application/octet-stream;
 name="pulse-system.pa"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="pulse-system.pa"

IyEvYWZjL2Jpbi9wdWxzZWF1ZGlvIC1uRgoKIyBQdWxzZUF1ZGlvIFN5c3RlbSBDb25maWd1
cmF0aW9uIEZpbGUKCmxvYWQtbW9kdWxlIG1vZHVsZS1udWxsLXNpbmsKbG9hZC1tb2R1bGUg
bW9kdWxlLW9zcyBzaW5rX25hbWU9b3V0cHV0IHNvdXJjZV9uYW1lPWlucHV0IG1tYXA9MAps
b2FkLW1vZHVsZSBtb2R1bGUtbmF0aXZlLXByb3RvY29sLXVuaXgKbG9hZC1tb2R1bGUgbW9k
dWxlLW5hdGl2ZS1wcm90b2NvbC10Y3AKI2xvYWQtbW9kdWxlIG1vZHVsZS1zdHJlYW0tcmVz
dG9yZQojbG9hZC1tb2R1bGUgbW9kdWxlLXJlc2N1ZS1zdHJlYW1zCiNsb2FkLW1vZHVsZSBt
b2R1bGUtYWx3YXlzLXNpbmsKI2xvYWQtbW9kdWxlIG1vZHVsZS1zdXNwZW5kLW9uLWlkbGUK
CmxvYWQtbW9kdWxlIG1vZHVsZS1ibHVldG9vdGgtZGV2aWNlIHNpbmtfbmFtZT1ibHVldG9v
dGhfb3V0cHV0IHNvdXJjZV9uYW1lPWJsdWV0b290aF9pbnB1dCBwcm9maWxlPWhzcCBhZGRy
ZXNzPTAwOjA3OkE0OkVFOjhGOjAzCiMgbG9hZC1tb2R1bGUgbW9kdWxlLWJsdWV0b290aC1k
aXNjb3ZlcgojIGxvYWQtbW9kdWxlIG1vZHVsZS1lY2hvLWNhbmNlbCBzb3VyY2VfbmFtZT1i
bHVldG9vdGhfaW5wdXQgc2lua19uYW1lPWJsdWV0b290aF9vdXRwdXQKIyBsb2FkLW1vZHVs
ZSBtb2R1bGUtY29tYmluZSBzaW5rX25hbWU9b3V0cHV0IHNsYXZlcz1vc3Nfb3V0cHV0LGJs
dWV0b290aF9vdXRwdXQKCnNldC1kZWZhdWx0LXNpbmsgYmx1ZXRvb3RoX291dHB1dApzZXQt
ZGVmYXVsdC1zb3VyY2UgYmx1ZXRvb3RoX2lucHV0Cg==
--------------090007030505090905000309
Content-Type: text/plain;
 name="Attached Message Part"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Attached Message Part"

_______________________________________________
pulseaudio-discuss mailing list
pulseaudio-discuss@lists.freedesktop.org
http://lists.freedesktop.org/mailman/listinfo/pulseaudio-discuss


--------------090007030505090905000309--
