Return-Path: <cyrus@holtmann.org>
From: John Frankish <j-frankish@slb.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "Mikel Astiz (mikel.astiz.oss@gmail.com)" <mikel.astiz.oss@gmail.com>
Subject: FW: FW: Can no longer connect to audio stream with bluez > 0.96 and
 pulseaudio-2
Date: Sat, 21 Jul 2012 10:55:19 +0000
Message-ID: <654DF80AD31A344E93DBCC6280BD6DEF8598D3FA@NL0230MBX08N1.DIR.slb.com>
References: <654DF80AD31A344E93DBCC6280BD6DEF8598D39E@NL0230MBX08N1.DIR.slb.com>
 <CANT-zCUvCc9EY6_MdjWg4qLUR90vzggPqER4=4vNBLoKzVsrQA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

> -----Original Message-----
> From: Mikel Astiz [mailto:mikel.astiz.oss@gmail.com]
> Sent: Saturday, 21 July, 2012 11:15
> To: John Frankish
> Cc: linux-bluetooth@vger.kernel.org
> Subject: Re: FW: Can no longer connect to audio stream with bluez > 
> 0.96 and
> pulseaudio-2
> 
> Hi John,
> 
> I can't tell for sure but I can reproduce similar problem with a2dp 
> sources. I actually fails with some devices only, so chances are that 
> it's due to some race condition.
> 
> This seems to be a regression introduced recently, which I didn't have 
> time to check further.

I tried on different hardware, but with the same versions of software and it seems you're right.
Things work on a dell, but not the mac mini.

I've posted the output from the successful bluetoothd log and the failed bluetoothd log below.

It seems the problem occurs before attempting to connect from the audio stream:

bluetoothd[827]: audio/media.c:release_endpoint() sender=:1.215 path=/MediaEndpoint/A2DPSink
bluetoothd[827]: Endpoint unregistered: sender=:1.215 path=/MediaEndpoint/A2DPSink

Though I've no idea why this should happen on the mac and not the dell...

Using a dell latitude e6220
$ lsusb

Bus 001 Device 003: ID 413c:8187 Dell Computer Corp. DW375 Bluetooth Module

$ echo "0000" | simple-agent hci0 00:1B:66:00:31:88
Release
New device (/org/bluez/11538/hci0/dev_00_1B_66_00_31_88)

$ dbus-send --print-reply --system --dest=org.bluez /org/bluez/11538/hci0/dev_00_1B_66_00_31_88 org.bluez.AudioSink.Connect

method return sender=:1.1 -> dest=:1.17 reply_serial=2

$ cat /usr/local/etc/bluetooth/audio.conf
...
[General]
Enable=Source
Enable=Sink
Enable=Headset
Enable=Control
Enable=Media

AutoConnect=true [but didn't]
-------
Success (Dell)
...
bluetoothd[11538]: Endpoint registered: sender=:1.15 path=/MediaEndpoint/HFPAG
bluetoothd[11538]: Endpoint registered: sender=:1.15 path=/MediaEndpoint/HFPHS
bluetoothd[11538]: audio/avdtp.c:avdtp_register_sep() SEP 0xb86c2318 registered: type:0 codec:0 seid:1
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[11538]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11538]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[11538]: plugins/hciops.c:update_service_classes() Changing service classes to 0x480100
bluetoothd[11538]: plugins/hciops.c:write_class() hci0 class 0x480100
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[11538]: Endpoint registered: sender=:1.15 path=/MediaEndpoint/A2DPSource
bluetoothd[11538]: audio/avdtp.c:avdtp_register_sep() SEP 0xb86c2268 registered: type:1 codec:0 seid:2
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
bluetoothd[11538]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[11538]: plugins/hciops.c:update_service_classes() hci0 value 76
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[11538]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[11538]: Endpoint registered: sender=:1.15 path=/MediaEndpoint/A2DPSink
bluetoothd[11538]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11538]: plugins/hciops.c:write_class() hci0 class 0x4c0100
bluetoothd[11538]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[11538]: audio/avdtp.c:avdtp_ref() 0xb86c3ed8: ref=2
bluetoothd[11538]: audio/sink.c:sink_set_state() State changed /org/bluez/11538/hci0/dev_00_1B_66_00_31_88: SINK_STATE_DISCONNECTED -> SINK_STATE_CONNECTING

Failure (mac mini)
bluetoothd[827]: Endpoint registered: sender=:1.215 path=/MediaEndpoint/HFPAG
bluetoothd[827]: Endpoint registered: sender=:1.215 path=/MediaEndpoint/HFPHS
bluetoothd[827]: audio/avdtp.c:avdtp_register_sep() SEP 0xf957aef0 registered: type:0 codec:0 seid:1
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10004
bluetoothd[827]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[827]: plugins/hciops.c:update_service_classes() hci0 value 72
bluetoothd[827]: plugins/hciops.c:update_service_classes() Changing service classes to 0x480100
bluetoothd[827]: plugins/hciops.c:write_class() hci0 class 0x480100
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110a-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[827]: Endpoint registered: sender=:1.215 path=/MediaEndpoint/A2DPSource
bluetoothd[827]: audio/avdtp.c:avdtp_register_sep() SEP 0xf9554d20 registered: type:1 codec:0 seid:2
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Adding record with handle 0x10005
bluetoothd[827]: plugins/hciops.c:hciops_add_uuid() hci0
bluetoothd[827]: plugins/hciops.c:update_service_classes() hci0 value 76
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000019-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00000100-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 00001002-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110b-0000-1000-8000-00805f9
bluetoothd[827]: src/sdpd-service.c:add_record_to_server() Record pattern UUID 0000110d-0000-1000-8000-00805f9
bluetoothd[827]: Endpoint registered: sender=:1.215 path=/MediaEndpoint/A2DPSink
bluetoothd[827]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[827]: plugins/hciops.c:write_class() hci0 class 0x4c0100
bluetoothd[827]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[827]: Endpoint unregistered: sender=:1.215 path=/MediaEndpoint/HFPAG
bluetoothd[827]: audio/media.c:media_endpoint_destroy() sender=:1.215 path=/MediaEndpoint/HFPAG
bluetoothd[827]: Endpoint unregistered: sender=:1.215 path=/MediaEndpoint/HFPHS
bluetoothd[827]: audio/media.c:media_endpoint_destroy() sender=:1.215 path=/MediaEndpoint/HFPHS
bluetoothd[827]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10004
bluetoothd[827]: plugins/hciops.c:hciops_remove_uuid() hci0
bluetoothd[827]: plugins/hciops.c:update_service_classes() hci0 value 68
bluetoothd[827]: plugins/hciops.c:update_service_classes() Changing service classes to 0x440100
bluetoothd[827]: plugins/hciops.c:write_class() hci0 class 0x440100
bluetoothd[827]: audio/media.c:release_endpoint() sender=:1.215 path=/MediaEndpoint/A2DPSource
bluetoothd[827]: Endpoint unregistered: sender=:1.215 path=/MediaEndpoint/A2DPSource
bluetoothd[827]: audio/media.c:media_endpoint_destroy() sender=:1.215 path=/MediaEndpoint/A2DPSource
bluetoothd[827]: audio/avdtp.c:avdtp_unregister_sep() SEP 0xf957aef0 unregistered: type:0 codec:0 seid:1
bluetoothd[827]: src/sdpd-service.c:remove_record_from_server() Removing record with handle 0x10005
bluetoothd[827]: plugins/hciops.c:hciops_remove_uuid() hci0
bluetoothd[827]: plugins/hciops.c:update_service_classes() hci0 value 64
bluetoothd[827]: audio/media.c:release_endpoint() sender=:1.215 path=/MediaEndpoint/A2DPSink
bluetoothd[827]: Endpoint unregistered: sender=:1.215 path=/MediaEndpoint/A2DPSink
bluetoothd[827]: audio/media.c:media_endpoint_destroy() sender=:1.215 path=/MediaEndpoint/A2DPSink
bluetoothd[827]: audio/avdtp.c:avdtp_unregister_sep() SEP 0xf9554d20 unregistered: type:1 codec:0 seid:2
bluetoothd[827]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[827]: plugins/hciops.c:write_class() hci0 class 0x400100
bluetoothd[827]: plugins/hciops.c:update_ext_inquiry_response() hci0
bluetoothd[827]: audio/avdtp.c:avdtp_ref() 0xf95710a8: ref=2
bluetoothd[827]: audio/sink.c:sink_set_state() State changed /org/bluez/827/hci0/dev_00_1B_66_00_31_88: SINK_STATE_DISCONNECTED -> SINK_STATE_CONNECTING
