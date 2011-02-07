Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTim_XfH9jTQLhCVtf4BJd8BJ9pV_2FQzqfOJO6kR@mail.gmail.com>
References: <AANLkTim_XfH9jTQLhCVtf4BJd8BJ9pV_2FQzqfOJO6kR@mail.gmail.com>
Date: Mon, 7 Feb 2011 13:27:29 -0200
Message-ID: <AANLkTik0vPSbwA5G2u7u_c+aZ_3BZaggVyjMftQ-5Cgp@mail.gmail.com>
Subject: Re: Problems trying to connecf HFP device
From: Franz Glauber <franzec05@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I've talked this through with Padovan, but had no success on setting
up a new HFP device.

I can pair it, it recognizes the services Audio and Headset. I am also
able to connect the Headset service using D-Feet. When it does,
Pulseaudio is notified and attempt to configure it for use. The
revelant part seems to be this negotiation:

On bluetoothd:

bluetoothd[9596]: audio/unix.c:server_cb() Accepted new client
connection on unix socket (fd=24)
bluetoothd[9596]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_GET_CAPABILITIES
bluetoothd[9596]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[9596]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_GET_CAPABILITIES
bluetoothd[9596]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_GET_CAPABILITIES
bluetoothd[9596]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[9596]: audio/unix.c:handle_sco_open() open sco -
object=/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD source=ANY
destination=ANY lock=readwrite
bluetoothd[9596]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_OPEN
bluetoothd[9596]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_SET_CONFIGURATION
bluetoothd[9596]: audio/unix.c:unix_ipc_sendmsg() Audio API:
BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[9596]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
BT_START_STREAM
bluetoothd[9596]: audio/headset.c:headset_set_state() State changed
/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD: HEADSET_STATE_CONNECTED ->
HEADSET_STATE_PLAY_IN_PROGRESS
bluetoothd[9596]: audio/headset.c:handle_event() Received AT+CLIP=1

On pulseaudio:

D: module-bluetooth-discover.c: Loading module-bluetooth-device
address="88:88:00:B9:CC:DD"
path="/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD"
I: card.c: Created 1 "bluez_card.88_88_00_B9_CC_DD"
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
I: sink.c: Created sink 1 "bluez_sink.88_88_00_B9_CC_DD" with sample
spec s16le 1ch 8000Hz and channel map mono
I: sink.c:     bluetooth.protocol = "sco"
I: sink.c:     device.intended_roles = "phone"
I: sink.c:     device.description = "G688"
I: sink.c:     device.string = "88:88:00:B9:CC:DD"
I: sink.c:     device.api = "bluez"
I: sink.c:     device.class = "sound"
I: sink.c:     device.bus = "bluetooth"
I: sink.c:     device.form_factor = "headset"
I: sink.c:     bluez.path = "/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD"
I: sink.c:     bluez.class = "0x200404"
I: sink.c:     bluez.name = "G688"
I: sink.c:     device.icon_name = "audio-headset-bluetooth"
I: source.c: Created source 2 "bluez_sink.88_88_00_B9_CC_DD.monitor"
with sample spec s16le 1ch 8000Hz and channel map mono
I: source.c:     device.description = "Monitor of G688"
I: source.c:     device.class = "monitor"
I: source.c:     device.string = "88:88:00:B9:CC:DD"
I: source.c:     device.api = "bluez"
I: source.c:     device.bus = "bluetooth"
I: source.c:     device.form_factor = "headset"
I: source.c:     bluez.path = "/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD"
I: source.c:     bluez.class = "0x200404"
I: source.c:     bluez.name = "G688"
I: source.c:     device.icon_name = "audio-headset-bluetooth"
I: source.c:     device.intended_roles = "phone"
I: source.c: Created source 3 "bluez_source.88_88_00_B9_CC_DD" with
sample spec s16le 1ch 8000Hz and channel map mono
I: source.c:     bluetooth.protocol = "hsp"
I: source.c:     device.intended_roles = "phone"
I: source.c:     device.description = "G688"
I: source.c:     device.string = "88:88:00:B9:CC:DD"
I: source.c:     device.api = "bluez"
I: source.c:     device.class = "sound"
I: source.c:     device.bus = "bluetooth"
I: source.c:     device.form_factor = "headset"
I: source.c:     bluez.path = "/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD"
I: source.c:     bluez.class = "0x200404"
I: source.c:     bluez.name = "G688"
I: source.c:     device.icon_name = "audio-headset-bluetooth"
D: module-bluetooth-device.c: IO Thread starting up
I: core-util.c: Successfully enabled SCHED_RR scheduling for thread,
with priority 4, which is lower than the requested 5.
D: module-bluetooth-device.c: Sending BT_REQUEST -> BT_START_STREAM
D: module-bluetooth-device.c: Trying to receive message from audio service...


After this, pulseaudio keeps waiting, but nothing is sent from the
device/bluez except thta AT+CLIP=1 signal, so it gives up and die.

bluetoothd[9596]: HUP or ERR on socket
bluetoothd[9596]: headset_resume_complete: resume failed
bluetoothd[9596]: audio/unix.c:unix_ipc_error() sending error
Input/output error(5)
bluetoothd[9596]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_ERROR
-> BT_START_STREAM

on pulseaudio:

D: module-bluetooth-device.c: Received BT_ERROR <- BT_START_STREAM
E: module-bluetooth-device.c: Received error condition: Input/output
error *translated back to english
D: module-bluetooth-device.c: IO thread failed
D: module-suspend-on-idle.c: Sink bluez_sink.88_88_00_B9_CC_DD becomes
idle, timeout in 5 seconds.
D: module-suspend-on-idle.c: Source bluez_source.88_88_00_B9_CC_DD
becomes idle, timeout in 5 seconds.
I: module.c: Loaded "module-bluetooth-device" (index: #18; argument:
"address="88:88:00:B9:CC:DD"
path="/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD"").
D: module-console-kit.c: dbus: interface=org.bluez.Audio,
path=/org/bluez/9596/hci0/dev_88_88_00_B9_CC_DD,
member=PropertyChanged
I: module-device-restore.c: Storing volume/mute/port for device
sink:bluez_sink.88_88_00_B9_CC_DD.
I: module-device-restore.c: Storing volume/mute/port for device
source:bluez_sink.88_88_00_B9_CC_DD.monitor.
I: module-device-restore.c: Storing volume/mute/port for device
source:bluez_source.88_88_00_B9_CC_DD.
I: module.c: Unloading "module-bluetooth-device" (index: #18).
D: module-rescue-streams.c: No sink inputs to move away.
D: module-rescue-streams.c: No source outputs to move away.
D: module-rescue-streams.c: No source outputs to move away.
D: module-bluetooth-device.c: IO thread shutting down
I: sink.c: Freeing sink 1 "bluez_sink.88_88_00_B9_CC_DD"
I: source.c: Freeing source 2 "bluez_sink.88_88_00_B9_CC_DD.monitor"
I: source.c: Freeing source 3 "bluez_source.88_88_00_B9_CC_DD"
I: card.c: Freed 1 "bluez_card.88_88_00_B9_CC_DD"
I: module.c: Unloaded "module-bluetooth-device" (index: #18).
D: bluetooth-util.c: dbus: interface=(null), path=(null), member=(null)
D: module-console-kit.c: dbus: interface=(null), path=(null), member=(null)
D: bluetooth-util.c: dbus: interface=(null), path=(null), member=(null)
D: module-console-kit.c: dbus: interface=(null), path=(null), member=(null)
I: module-device-restore.c: Synced.


Any ideas?


--
Franz

http://ciudaddelpico.com
