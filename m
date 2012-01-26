Return-Path: <cyrus@holtmann.org>
Message-ID: <4F217DE3.4020104@babioch.de>
Date: Thu, 26 Jan 2012 17:22:59 +0100
From: Karol Babioch <karol@babioch.de>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Subject: Re: Changed default configuration in bluez 4.97 and higher?
References: <4F204BDC.1010007@babioch.de> <CABBYNZJk+n2Rh4K2J_fc8A_WXjyBwck4qhYcfe6wCmK7vK7t-Q@mail.gmail.com> <4F2145AF.4050401@babioch.de> <4F2159DC.4090408@babioch.de> <CABBYNZJ09fo8X69Hqs+d_NiHmq9f2a1JHcSZnot4RXy0fk-u+g@mail.gmail.com>
In-Reply-To: <CABBYNZJ09fo8X69Hqs+d_NiHmq9f2a1JHcSZnot4RXy0fk-u+g@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig57B170DF9E089BF46C9D08CE"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig57B170DF9E089BF46C9D08CE
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

Am 26.01.2012 16:17, schrieb Luiz Augusto von Dentz:
> can you check if you get
> anything on bluetoothd logs like this:

I'm attaching my logs (with -d enabled) here. Hopefully they are not too
long. As you can see, the discovery works just fine, but I can't see any
registration of an endpoint, like you proposed.


Jan 26 17:15:23 localhost bluetoothd[21970]:
plugins/hciops.c:hciops_start_discovery() hci0
Jan 26 17:15:23 localhost bluetoothd[21970]:
plugins/hciops.c:start_inquiry() hci0 length 8
Jan 26 17:15:23 localhost bluetoothd[21970]: Discovery session
0x7f83904256c0 with :1.65 activated
Jan 26 17:15:23 localhost bluetoothd[21970]: src/adapter.c:session_ref()
0x7f83904256c0: ref=3D1
Jan 26 17:15:23 localhost bluetoothd[21970]:
plugins/hciops.c:set_state() hci0: new state 1
Jan 26 17:15:23 localhost bluetoothd[21970]:
plugins/hciops.c:hciops_confirm_name() hci0 00:16:94:0B:XX:XX name_known =
1
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/adapter.c:session_unref() 0x7f83904256c0: ref=3D0
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/adapter.c:session_remove() Discovery session 0x7f83904256c0 with
:1.65 deactivated
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/adapter.c:session_remove() Stopping discovery
Jan 26 17:15:25 localhost bluetoothd[21970]:
plugins/hciops.c:hciops_stop_discovery() index 0
Jan 26 17:15:25 localhost bluetoothd[21970]:
plugins/hciops.c:hciops_stop_inquiry() hci0
Jan 26 17:15:25 localhost bluetoothd[21970]: Stopping discovery
Jan 26 17:15:25 localhost bluetoothd[21970]:
plugins/hciops.c:set_state() hci0: new state 0
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/adapter.c:adapter_create_device() 00:16:94:0B:XX:XX
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/device.c:device_create() Creating device
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/device.c:btd_device_ref() 0x7f8390425340: ref=3D1
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/device.c:device_set_temporary() temporary 1
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/device.c:bonding_request_new() Requesting bonding for 00:16:94:0B:XX:=
XX
Jan 26 17:15:25 localhost bluetoothd[21970]:
src/device.c:bonding_request_new() Temporary agent registered for
00:16:94:0B:XX:XX at :1.65:/org/bluez/agent/wizard
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:conn_complete() status 0x00
Jan 26 17:15:26 localhost bluetoothd[21970]:
src/adapter.c:adapter_get_device() 00:16:94:0B:XX:XX
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:remote_features_information() hci0 status 0
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:remote_name_information() hci0 status 0
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:link_key_request() hci0 dba 00:16:94:0B:XX:XX
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:get_auth_info() hci0 dba 00:16:94:0B:XX:XX
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:link_key_request() kernel auth requirements =3D 0x03
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:link_key_request() Matching key not found
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:io_capa_request() hci0 IO capability request for
00:16:94:0B:XX:XX
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:get_auth_info() hci0 dba 00:16:94:0B:XX:XX
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:get_io_cap() initial authentication requirement is 0x03
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:get_io_cap() final authentication requirement is 0x03
Jan 26 17:15:26 localhost bluetoothd[21970]:
plugins/hciops.c:io_capa_response() hci0 IO capability response from
00:16:94:0B:XX:XX
Jan 26 17:15:29 localhost bluetoothd[21970]:
plugins/hciops.c:user_confirm_request() hci0
Jan 26 17:15:29 localhost bluetoothd[21970]:
plugins/hciops.c:user_confirm_request() auto accept of confirmation
Jan 26 17:15:29 localhost bluetoothd[21970]:
plugins/hciops.c:hciops_confirm_reply() hci0 dba 00:16:94:0B:XX:XX succes=
s 1
Jan 26 17:15:32 localhost bluetoothd[21970]:
plugins/hciops.c:simple_pairing_complete() hci0 status 0
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/event.c:btd_event_simple_pairing_complete() status=3D00
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/adapter.c:adapter_get_device() 00:16:94:0B:XX:XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
plugins/hciops.c:link_key_notify() hci0 dba 00:16:94:0B:XX:XX type 4
Jan 26 17:15:32 localhost bluetoothd[21970]:
plugins/hciops.c:link_key_notify() key type 0x04 old key type 0xff
Jan 26 17:15:32 localhost bluetoothd[21970]:
plugins/hciops.c:link_key_notify() local auth 0x03 and remote auth 0x02
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/adapter.c:adapter_get_device() 00:16:94:0B:XX:XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/event.c:btd_event_link_key_notify() storing link key of type 0x04
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:device_set_bonded() bonded 1
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:device_set_temporary() temporary 0
Jan 26 17:15:32 localhost bluetoothd[21970]:
plugins/hciops.c:auth_complete() hci0 status 0
Jan 26 17:15:32 localhost bluetoothd[21970]:
plugins/hciops.c:bonding_complete() status 0x00
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/adapter.c:adapter_get_device() 00:16:94:0B:XX:XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:device_bonding_complete() bonding 0x7f8390456ba0 status 0x00=

Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:device_bonding_complete() Proceeding with service discovery
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:btd_device_ref() 0x7f8390425340: ref=3D2
Jan 26 17:15:32 localhost bluetoothd[21970]: src/agent.c:agent_release()
Releasing agent :1.65, /org/bluez/agent/wizard
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:device_probe_drivers() Probing drivers for 00:16:94:0B:XX:XX=

Jan 26 17:15:32 localhost bluetoothd[21970]:
serial/manager.c:serial_probe() path
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX:
0000111e-0000-1000-8000-00805f9b34fb
Jan 26 17:15:32 localhost bluetoothd[21970]:
serial/port.c:create_serial_device() Registered interface
org.bluez.Serial on path /org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
serial/manager.c:serial_probe() path
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX:
00001108-0000-1000-8000-00805f9b34fb
Jan 26 17:15:32 localhost bluetoothd[21970]:
input/manager.c:headset_probe() path
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:btd_device_ref() 0x7f8390425340: ref=3D3
Jan 26 17:15:32 localhost bluetoothd[21970]:
input/device.c:input_device_new() Registered interface org.bluez.Input
on path /org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/adapter.c:adapter_get_device() 00:16:94:0B:XX:XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:btd_device_ref() 0x7f8390425340: ref=3D4
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/device.c:audio_device_register() Registered interface
org.bluez.Audio on path /org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/manager.c:handle_uuid() Found Headset record
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/headset.c:headset_init() Registered interface org.bluez.Headset on
path /org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/manager.c:handle_uuid() Found Handsfree record
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/manager.c:handle_uuid() Found Audio Sink
Jan 26 17:15:32 localhost bluetoothd[21970]: audio/sink.c:sink_init()
Registered interface org.bluez.AudioSink on path
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/manager.c:handle_uuid() Found AV Remote
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/control.c:control_init() Registered interface org.bluez.Control on
path /org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX
Jan 26 17:15:32 localhost bluetoothd[21970]:
src/device.c:btd_device_unref() 0x7f8390425340: ref=3D3
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/headset.c:headset_set_state() State changed
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX: HEADSET_STATE_DISCONNECTED
-> HEADSET_STATE_CONNECTING
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/media.c:headset_state_changed()
Jan 26 17:15:32 localhost bluetoothd[21970]:
audio/media.c:media_endpoint_async_call() Calling SetConfiguration: name
=3D :1.59 path =3D /MediaEndpoint/HFPAG
Jan 26 17:15:33 localhost bluetoothd[21970]:
audio/headset.c:headset_set_channel() Discovered Handsfree service on
channel 1
Jan 26 17:15:33 localhost bluetoothd[21970]:
audio/headset.c:rfcomm_connect()
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX: Connecting to
00:16:94:0B:XX:XX channel 1
Jan 26 17:15:33 localhost bluetoothd[21970]:
audio/headset.c:headset_connect_cb()
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX: Connected to 00:16:94:0B:XX:=
XX
Jan 26 17:15:33 localhost bluetoothd[21970]:
audio/headset.c:handle_event() Received AT+BRSF=3D25
Jan 26 17:15:33 localhost bluetoothd[21970]:
audio/headset.c:print_hf_features() HFP HF features: "EC and/or NR
function" "Voice recognition activation" "Remote volume control"
Jan 26 17:15:33 localhost bluetoothd[21970]:
audio/headset.c:handle_event() Received AT+CIND=3D?
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:handle_event() Received AT+CIND?
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:handle_event() Received AT+CMER=3D3, 0, 0, 1
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:event_reporting() Event reporting (CMER): mode=3D3, ind=3D=
1
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:hfp_slc_complete() HFP Service Level Connection establish=
ed
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/telephony.c:telephony_device_connected() telephony-dummy: device
0x7f839046caf0 connected
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:headset_set_state() State changed
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX: HEADSET_STATE_CONNECTING ->
HEADSET_STATE_CONNECTED
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/media.c:headset_state_changed()
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:handle_event() Received AT+VGS=3D15
Jan 26 17:15:34 localhost bluetoothd[21970]:
audio/headset.c:headset_set_gain() Ignoring no-change in speaker gain
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:avdtp_ref()
0x7f8390453b60: ref=3D2
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:avdtp_ref()
0x7f8390453b60: ref=3D3
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/sink.c:sink_set_state() State changed
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX: SINK_STATE_DISCONNECTED ->
SINK_STATE_CONNECTING
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:avdtp_unref()
0x7f8390453b60: ref=3D2
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling channel to
00:16:94:0B:XX:XX
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=3D672, omtu=3D895
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avctp.c:avctp_set_state() AVCTP Connecting
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:session_cb()
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_parse_resp() DISCOVER request succeeded
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_discover_resp() seid 1 type 1 media 0 in use 0
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:session_cb()
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES request succeeded
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_get_capabilities_resp() seid 1 type 1 media 0
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/sink.c:discovery_complete() Discovery complete
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:avdtp_ref()
0x7f8390453b60: ref=3D3
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/a2dp.c:setup_ref()
0x7f8390457980: ref=3D1
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/a2dp.c:a2dp_config()
a2dp_config: selected SEP 0x7f8390429bb0
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/a2dp.c:setup_ref()
0x7f8390457980: ref=3D2
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_set_configuration() 0x7f8390453b60: int_seid=3D1,
acp_seid=3D1
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/a2dp.c:setup_unref()
0x7f8390457980: ref=3D1
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:session_cb()
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION request succeeded
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/a2dp.c:setconf_cfm()
Source 0x7f8390429bb0: Set_Configuration_Cfm
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_sep_set_state() stream state changed: IDLE -> CONFIGU=
RED
Jan 26 17:15:35 localhost bluetoothd[21970]: audio/avdtp.c:session_cb()
Jan 26 17:15:35 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_parse_resp() OPEN request succeeded
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/avctp.c:avctp_connect_cb() AVCTP: connected to 00:16:94:0B:XX:XX
Jan 26 17:15:36 localhost bluetoothd[21970]: audio/avctp.c:init_uinput()
AVRCP: uinput initialized for 00:16:94:0B:XX:XX
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/avctp.c:avctp_set_state() AVCTP Connected
Jan 26 17:15:36 localhost kernel: [10376.086611] input:
00:16:94:0B:XX:XX as /devices/virtual/input/input21
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_connect_cb() AVDTP: connected transport channel to
00:16:94:0B:XX:XX
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/avdtp.c:handle_transport_connect() Flushable packets enabled
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/avdtp.c:handle_transport_connect() sk 28, omtu 895, send buffer
size 114688
Jan 26 17:15:36 localhost bluetoothd[21970]: audio/a2dp.c:open_cfm()
Source 0x7f8390429bb0: Open_Cfm
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/sink.c:stream_setup_complete() Stream successfully created
Jan 26 17:15:36 localhost bluetoothd[21970]: audio/a2dp.c:setup_unref()
0x7f8390457980: ref=3D0
Jan 26 17:15:36 localhost bluetoothd[21970]: audio/a2dp.c:setup_free()
0x7f8390457980
Jan 26 17:15:36 localhost bluetoothd[21970]: audio/avdtp.c:avdtp_unref()
0x7f8390453b60: ref=3D2
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/avdtp.c:avdtp_sep_set_state() stream state changed: CONFIGURED -> O=
PEN
Jan 26 17:15:36 localhost bluetoothd[21970]:
audio/sink.c:sink_set_state() State changed
/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX: SINK_STATE_CONNECTING ->
SINK_STATE_CONNECTED
Jan 26 17:15:36 localhost pulseaudio[20926]: [pulseaudio]
module-bluetooth-device.c: Bluetooth audio service not available
Jan 26 17:15:36 localhost pulseaudio[20926]: [pulseaudio]
module-bluetooth-device.c: Service not connected
Jan 26 17:15:36 localhost pulseaudio[20926]: [pulseaudio] module.c:
Failed to load module "module-bluetooth-device" (argument:
"address=3D"00:16:94:0B:XX:XX"
path=3D"/org/bluez/21970/hci0/dev_00_16_94_0B_XX_XX""): initialization fa=
iled.

Does it tell you anything useful?

Best regards,
Karol Babioch


--------------enig57B170DF9E089BF46C9D08CE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQIcBAEBAgAGBQJPIX3jAAoJEHSaZc1HnzIVKf8P/jDoEuMFjoVIsHHfrxpqGjRx
Aue8uBSu+euML9V5l5YKEe50PYfwErGYHfUd4nalMLEypkg6NdKMFb9mf3INrJCm
ApizNTgViMjUdLiKJU1piVJgev0w/0g50tGugt/xmKWL5phEjjJcVmBDUtRh9sOI
SgtCmZGmd3PUGvJKDguS5chbcvnFftVGbvSqPHibVC9jEhcv96Ok34lREJ4YSulp
aGVHntzltcttmvfgbv1hYvkz8pBT5B5IH9mMh/+GxePCvSM1defs738EJtNBXxTj
UpidbZJAdc/cQmfjMpgtK1uanJu2GizOfBRywWuwFPyDpVHdUXtwB7Byp/dSj5/x
Jxq716bN9BaadB6uTjyGyYG4e6ZLFHq7M0CIsTW4ZSR64/UeT3L9renq8Z67r97b
kNoY9wzRp9ONqyVLM8AMsAXBQENzqZNF86/iLHW4DHh9OOHGMWLE6zdJeVnHm1BA
LkK6HDAKxg4h9ldAzFmdztdAQmj5CEffnxEl7dgx6oBoskXLYJO91Ce1aUlfT+Ce
k8dPZBBVQksAbkow8ieL8E3+pLnwRabS3rarzyxYulGBcuCauqoNUiVYCOYwV0oR
p6Nry3Tr8qjh8lgwJ0+SJ2YWJAABR7i4R5ZVtUZblVBfJrIwtJnk4MqInw8OkR7I
G2a4sp/g4tgAkqe0s6/f
=oudv
-----END PGP SIGNATURE-----

--------------enig57B170DF9E089BF46C9D08CE--
