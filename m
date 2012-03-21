Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 21 Mar 2012 14:02:12 -0500
Message-ID: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
Subject: media transport -- when is acquire ok to call?
From: Mike <puffy.taco@gmail.com>
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I'm having some trouble with MediaEndpoint/MediaTransport and A2DP.
When I get the "SetConfiguration" call, I wait 2 seconds and then call
"Acquire", generally giving BlueZ enough time get the D-Bus interface
ready to go.  However, the delay isn't always long enough.  Shown
below is a time when my phone is attempting to pair with BlueZ.  The
error "org.bluez.Error.NotAuthorized" is output from my application.
In this case, the problem is that the audio source is still in the
CONFIGURED state, not in the OPEN state.  Is there a recommended
method of how long to wait before calling acquire?  Or should I rely
on the AudioSource "State" property to become connected (or playing)?
Is there any reason I can't get the transport when in the Configured
state (does the fd not exist yet?)?  Or why is "a2dp_resume" being
called on open (which is what is rejecting my acquire call)?

Thanks,
Mike

bluetoothd[751]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/adapter.c:adapter_create_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/device.c:device_create() Creating device
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[751]: src/device.c:btd_device_ref() 0x2a0d4ef0: ref=1
bluetoothd[751]: src/device.c:device_set_temporary() temporary 1
bluetoothd[751]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[751]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[751]: audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming
connect from 00:17:E3:3B:4F:DD
bluetoothd[751]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/device.c:btd_device_ref() 0x2a0d4ef0: ref=2
bluetoothd[751]: audio/device.c:audio_device_register() Registered
interface org.bluez.Audio on path
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[751]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[751]: audio/manager.c:handle_uuid() server not enabled for
0000110d-0000-1000-8000-00805f9b34fb (0x110d)
bluetoothd[751]: src/agent.c:agent_authorize() authorize request was
sent for /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[751]: plugins/hciops.c:link_key_request() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[751]: plugins/hciops.c:get_auth_info() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[751]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[751]: plugins/hciops.c:link_key_request() Matching key not found
bluetoothd[751]: plugins/hciops.c:pin_code_request() hci0 PIN request
for 00:17:E3:3B:4F:DD
bluetoothd[751]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/device.c:device_request_authentication()
Requesting agent authentication for 00:17:E3:3B:4F:DD
bluetoothd[751]: plugins/hciops.c:hciops_pincode_reply() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[751]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected
signaling channel to 00:17:E3:3B:4F:DD
bluetoothd[751]: audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=1024
bluetoothd[751]: audio/avdtp.c:session_cb()
bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received DISCOVER_CMD
bluetoothd[751]: audio/avdtp.c:session_cb()
bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received  GET_CAPABILITIES_CMD
bluetoothd[751]: audio/a2dp.c:endpoint_getcap_ind() Sink 0x2a0d40a8:
Get_Capability_Ind
bluetoothd[751]: audio/avdtp.c:session_cb()
bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received SET_CONFIGURATION_CMD
bluetoothd[751]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[751]: audio/manager.c:handle_uuid() Found Audio Source
bluetoothd[751]: audio/source.c:source_init() Registered interface
org.bluez.AudioSource on path
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[751]: audio/a2dp.c:endpoint_setconf_ind() Sink 0x2a0d40a8:
Set_Configuration_Ind
bluetoothd[751]: audio/avdtp.c:avdtp_ref() 0x2a0d2a00: ref=2
bluetoothd[751]: audio/a2dp.c:setup_ref() 0x2a0a6e00: ref=1
bluetoothd[751]: audio/media.c:media_endpoint_async_call() Calling
SetConfiguration: name = :1.40 path = /com/starkey/a2dp/endpoint
bluetoothd[751]: audio/avdtp.c:avdtp_ref() 0x2a0d2a00: ref=3
bluetoothd[751]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: IDLE -> CONFIGURED
bluetoothd[751]: audio/a2dp.c:setup_unref() 0x2a0a6e00: ref=0
bluetoothd[751]: audio/a2dp.c:setup_free() 0x2a0a6e00
bluetoothd[751]: audio/avdtp.c:avdtp_unref() 0x2a0d2a00: ref=2
bluetoothd[751]: audio/avdtp.c:session_cb()
bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
bluetoothd[751]: audio/a2dp.c:open_ind() Sink 0x2a0d40a8: Open_Ind
bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock acquired
bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock acquired
bluetoothd[751]: audio/transport.c:media_owner_create() Owner created:
sender=:1.40 accesstype=rw
bluetoothd[751]: audio/avdtp.c:avdtp_ref() 0x2a0d2a00: ref=3
bluetoothd[751]: audio/transport.c:media_transport_release() Transport
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock released
bluetoothd[751]: audio/transport.c:media_transport_release() Transport
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock released
bluetoothd[751]: audio/transport.c:media_owner_free() Owner :1.40
getting the reply from the cb failed
GDBus.Error:org.bluez.Error.NotAuthorized: Operation Not Authorized
bluetoothd[751]: plugins/hciops.c:link_key_notify() hci0 dba
00:17:E3:3B:4F:DD type 0
bluetoothd[751]: plugins/hciops.c:link_key_notify() key type 0x00 old
key type 0xff
bluetoothd[751]: plugins/hciops.c:link_key_notify() local auth 0x04
and remote auth 0xff
bluetoothd[751]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/event.c:btd_event_link_key_notify() storing link
key of type 0x00
bluetoothd[751]: src/device.c:device_set_bonded() bonded 1
bluetoothd[751]: src/device.c:device_set_temporary() temporary 0
bluetoothd[751]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[751]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[751]: src/device.c:device_bonding_complete() setting timer
for reverse service discovery
bluetoothd[751]: plugins/hciops.c:auth_complete() hci0 status 0
bluetoothd[751]: plugins/hciops.c:bonding_complete() status 0x00
bluetoothd[751]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[751]: src/device.c:device_bonding_complete() bonding (nil)
status 0x00
bluetoothd[751]: audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming
connect from 00:17:E3:3B:4F:DD
bluetoothd[751]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[751]: audio/manager.c:handle_uuid() Found Handsfree AG record
bluetoothd[751]: audio/manager.c:gateway_auth_cb() Accepted AG
connection from 00:17:E3:3B:4F:DD for
/org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[751]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected
transport channel to 00:17:E3:3B:4F:DD
bluetoothd[751]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: CONFIGURED -> OPEN
