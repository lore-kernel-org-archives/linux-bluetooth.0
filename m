Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: FW: Can no longer connect to audio stream with bluez > 0.96 and
 pulseaudio-2
Date: Sat, 21 Jul 2012 06:57:23 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF8598D39E@NL0230MBX08N1.DIR.slb.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Forgot bluetoothd output - added below

-----Original Message-----
From: John Frankish 
Sent: Friday, 20 July, 2012 21:19
To: linux-bluetooth@vger.kernel.org
Subject: Can no longer connect to audio stream with bluez > 0.96 and pulseaudio-2

Using bluez-0.96 and pulseaudio-1.xx I could use bluetooth headphones without problems using blueman-1.23 to connect to an a2dp sink.

With bluez-0.99/0.101 and pulseaudio-2 I can no longer connect and blueman gives the following error:

Stream setup failed

I see that bluez has moved to the MediaEndpoint format and that I need a /usr/local/etc/bluetooth/audio.conf for the first time, but things still don't work (details below), there are no error messages to speak of, am I doing something wrong?

Regards
John
-----------------------------
audio.conf

[General]
Enable=Source,Sink,Headset,Gateway,Control,Media

$ echo "0000" | simple-agent hci0 00:1B:66:00:31:88
Release
New device (/org/bluez/8112/hci0/dev_00_1B_66_00_31_88)

$ pulseaudio -vv

D: [pulseaudio] dbus-util.c: Successfully connected to D-Bus system bus f0e34796d5401d46e695407a00000013 as :1.53
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.freedesktop.DBus, path=/org/freedesktop/DBus, member=NameAcquired
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/HFPAG on adapter /org/bluez/8112/hci0.
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/HFPHS on adapter /org/bluez/8112/hci0.
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/A2DPSource on adapter /org/bluez/8112/hci0.
D: [pulseaudio] bluetooth-util.c: Registering /MediaEndpoint/A2DPSink on adapter /org/bluez/8112/hci0.
I: [pulseaudio] module.c: Loaded "module-bluetooth-discover" (index: #6; argument: "").

$ dbus-send --print-reply --system --dest=org.bluez /org/bluez/8112/hci0/dev_00_1B_66_00_31_88 org.bluez.AudioSink.Connect Error org.bluez.Error.Failed: Stream setup failed

D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'connecting'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'connecting'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Device, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'disconnected'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Audio, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'disconnected'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.AudioSink, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged
D: [pulseaudio] bluetooth-util.c: dbus: property 'State' changed to value 'disconnected'
D: [pulseaudio] bluetooth-util.c: dbus: interface=org.bluez.Device, path=/org/bluez/8112/hci0/dev_00_1B_66_00_31_88, member=PropertyChanged

$ sudo bluethood -nd

bluetoothd[8112]: audio/sink.c:sink_set_state() State changed /org/bluez/8112/hci0/dev_00_1B_66_00_31_88: SINK_STATE_DISCONNECTED -> SINK_STATE_CONNECTING
bluetoothd[8112]: audio/sink.c:sink_connect() stream creation in progress
bluetoothd[8112]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[8112]: src/adapter.c:adapter_get_device() 00:1B:66:00:31:88
bluetoothd[8112]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[8112]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[8112]: plugins/hciops.c:link_key_request() hci0 dba 00:1B:66:00:31:88
bluetoothd[8112]: plugins/hciops.c:get_auth_info() hci0 dba 00:1B:66:00:31:88
bluetoothd[8112]: plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
bluetoothd[8112]: plugins/hciops.c:link_key_request() Matching key found
bluetoothd[8112]: plugins/hciops.c:link_key_request() link key type 0x04
bluetoothd[8112]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[8112]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[8112]: src/adapter.c:adapter_get_device() 00:1B:66:00:31:88
bluetoothd[8112]: src/device.c:device_bonding_complete() bonding (nil) status 0x00
bluetoothd[8112]: Connection timed out (110)
bluetoothd[8112]: audio/avdtp.c:connection_lost() Disconnected from 00:1B:66:00:31:88
bluetoothd[8112]: audio/avdtp.c:avdtp_unref() 0xf79175a8: ref=1
bluetoothd[8112]: audio/sink.c:sink_set_state() State changed /org/bluez/8112/hci0/dev_00_1B_66_00_31_88: SINK_STATE_CONNECTING -> SINK_STATE_DISCONNECTED
bluetoothd[8112]: audio/sink.c:discovery_complete() connect:connect XCASE detected
bluetoothd[8112]: audio/sink.c:sink_set_state() State changed /org/bluez/8112/hci0/dev_00_1B_66_00_31_88: SINK_STATE_DISCONNECTED -> SINK_STATE_DISCONNECTED
bluetoothd[8112]: audio/device.c:device_set_state() state change attempted from disconnected to disconnected
bluetoothd[8112]: audio/avdtp.c:avdtp_unref() 0xf79175a8: ref=0
bluetoothd[8112]: audio/avdtp.c:avdtp_unref() 0xf79175a8: freeing session and removing from list
bluetoothd[8112]: plugins/hciops.c:disconn_complete() handle 12 status 0x00
bluetoothd[8112]: src/event.c:btd_event_disconn_complete() 
bluetoothd[8112]: src/adapter.c:adapter_remove_connection() 
bluetoothd[8112]: audio/sink.c:stream_setup_retry() Stream setup failed, after XCASE connect:connect


