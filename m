Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CACUGKYN0S8aBPL4Q81sFabcJQk8FgdPwMsPEK089QgM3oV_KjQ@mail.gmail.com>
References: <CACUGKYPaqcyKxv9zmiRraDsV1=ErsTCP5rUqguEdh6aEZshZKA@mail.gmail.com>
	<3004548.VX6QZ5TmgY@leonov>
	<CACUGKYNnZbco5xQAP=6c1W_Xk5Fbizw7AM35zsRzU6K9J96XCg@mail.gmail.com>
	<CACUGKYOFwkFxe+jO0AeLdUySo4=uPi+gPyM6Dvbm8TECLvDM0A@mail.gmail.com>
	<CACUGKYN0S8aBPL4Q81sFabcJQk8FgdPwMsPEK089QgM3oV_KjQ@mail.gmail.com>
Date: Wed, 17 Sep 2014 17:38:26 -0700
Message-ID: <CACUGKYPQJjY+p215wqp6Gp1qtKC_WghsHYoQk5+BvifdOF++=w@mail.gmail.com>
Subject: Re: Create an AVDTP signaling channel
From: John Tobias <john.tobias.ph@gmail.com>
To: Szymon Janc <szymon.janc@tieto.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I really apologize for a bit confusion... after running the bluetooth
daemon without the -EC, I am still seeing bluetoothd got SEGV.

The pts seems get stuck.... a2dp-sink profile connect failed for
00:1B:DC:07:32:D3: Device or resource busy

Any idea?.

Regards,

john

On Wed, Sep 17, 2014 at 4:47 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
> Hi Szymon,
>
> Seems the problem was the bluetooth daemon.  I ran it with -EC
> parameters(compat and experimental support), after removing it, the
> bluetooth daemon did not fail anymore...
>
> Regards,
>
> john
>
> On Wed, Sep 17, 2014 at 3:14 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Addition to that, when I start again the bluetooth daemon, I got these messages:
>>
>> uetoothd[238]: Can't load plugin description:
>> /usr/lib/bluetooth/plugins/audio.a2dp.default.so: undefined symbol:
>> bluetooth_plugin_desc
>> bluetoothd[238]: Can't load plugin description:
>> /usr/lib/bluetooth/plugins/bluetooth.default.so: undefined symbol:
>> bluetooth_plugin_desc
>> bluetoothd[238]: Can't load plugin description:
>> /usr/lib/bluetooth/plugins/audio.sco.default.so: undefined symbol:
>> bluetooth_plugin_desc
>>
>> bluetoothd[238]: Can't listen at channel 8.
>> bluetoothd[238]: sap-server: Operation not permitted (1)
>> bluetoothd[238]: hci0 Load Connection Parameters failed: Unknown Command (0x01)
>>
>>
>> Regards,
>>
>> john
>>
>>
>> On Wed, Sep 17, 2014 at 3:09 PM, John Tobias <john.tobias.ph@gmail.com> wrote:
>>> Hi Szymon,
>>>
>>> Here's what happening.
>>>
>>> First, I paired my phone and my device just to make sure I could
>>> stream music - (it works, also, I used PulseAudio 5). After I verified
>>> it's playing, I disconnected it, switched to PTS 5.2 and ran AVDTP
>>> profile. I used bluetoothctl to interact with PTS. Then, when the said
>>> message (posted on previous email) pop'd up, I used the command (under
>>> bluetoothctl) connect <pts_bdaddr>, but for some reason the
>>> bluetoothctl doesn't have it in the cache, so I got an message "Device
>>> <pts_bdaddr> not available". I ran 'scan on' then, when the
>>> <pts_bdaddr> have been found, I ran connect <pts_bdaddr>, the PTS got
>>> the message.
>>>
>>> After that, I got the following error messages:
>>>
>>> [bluetooth]# pulseaudio[169]: E: [pulseaudio] bluez5-util.c: Transport
>>> Acquire() failed for transport
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd1 (Input/output error)
>>> systemd[1]: bluetooth.service: main process exited, code=killed, status=11/SEGV
>>> systemd[1]: Unit bluetooth.service entered failed state.
>>> Failed to connect: org.freedesktop.DBus.Error.NoReply
>>>
>>> Below are the logs:
>>>
>>>
>>>
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:btd_adapter_confirm_reply() hci0 addr 00:1B:DC:07:32:D3
>>> success 1
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/agent.c:agent_unref() 0x78d04128: ref=2
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/agent.c:agent_unref() 0x78d04128: ref=1
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:new_link_key_callback() hci0 new key for
>>> 00:1B:DC:07:32:D3 type 4 pin_len 0
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_bonding_complete() bonding (nil) status 0x00
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:resume_discovery()
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:trigger_start_discovery()
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:cancel_passive_scanning()
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:device_found_callback() hci0 addr D0:E7:82:ED:AE:B8,
>>> rssi -61 flags 0x0000 eir_len 46
>>> Sep 17 21:27:14 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_set_legacy() legacy 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_probe_profiles() Probing profiles for device
>>> 00:1B:DC:07:32:D3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:a2dp_sink_probe() path
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/sink.c:sink_init()
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/service.c:btd_service_ref() 0x78d067c0: ref=2
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/service.c:change_state() 0x78d067c0: device 00:1B:DC:07:32:D3
>>> profile a2dp-sink state changed: unavailable -> disconnected (0)
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_svc_resolved()
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3 err 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:connect_profiles() /org/bluez/hci0/dev_00_1B_DC_07_32_D3
>>> (all), client :1.7
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:a2dp_sink_connect() path
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_ref() 0x78cec8d8: ref=1
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/sink.c:sink_set_state() State changed
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3: SINK_STATE_DISCONNECTED ->
>>> SINK_STATE_CONNECTING
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/sink.c:sink_connect() stream creation in progress
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/service.c:change_state() 0x78d067c0: device 00:1B:DC:07:32:D3
>>> profile a2dp-sink state changed: disconnected -> connecting (0)
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling
>>> channel to 00:1B:DC:07:32:D3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=672
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received DISCOVER_CMD
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_parse_resp() DISCOVER request succeeded
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_discover_resp() seid 1 type 1 media 0 in
>>> use 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received
>>> GET_CAPABILITIES_CMD
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:endpoint_getcap_ind() Source 0x78ce0128:
>>> Get_Capability_Ind
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_parse_resp() GET_CAPABILITIES request
>>> succeeded
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_get_capabilities_resp() seid 1 type 1
>>> media 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/sink.c:discovery_complete() Discovery complete
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_ref() 0x78cec8d8: ref=2
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_ref() 0x78ced528: ref=1
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/media.c:media_endpoint_async_call() Calling
>>> SelectConfiguration: name = :1.4 path = /MediaEndpoint/A2DPSource
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:a2dp_config() a2dp_config: selected SEP
>>> 0x78ce0128
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_ref() 0x78ced528: ref=2
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_set_configuration() 0x78cec8d8:
>>> int_seid=1, acp_seid=1
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_unref() 0x78ced528: ref=1
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:device_found_callback() hci0 addr D0:E7:82:ED:AE:B8,
>>> rssi -58 flags 0x0000 eir_len 5
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_set_legacy() legacy 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:device_found_callback() hci0 addr 68:17:29:58:C9:A0,
>>> rssi -60 flags 0x0000 eir_len 37
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_set_legacy() legacy 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received
>>> SET_CONFIGURATION_CMD
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION request
>>> succeeded
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setconf_cfm() Source 0x78ce0128:
>>> Set_Configuration_Cfm
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/media.c:media_endpoint_async_call() Calling
>>> SetConfiguration: name = :1.4 path = /MediaEndpoint/A2DPSource
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
>>> IDLE -> CONFIGURED
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_owner_create() Owner created:
>>> sender=:1.4
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_ref() 0x78cec8d8: ref=3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:a2dp_sep_lock() SEP 0x78ce0128 locked
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_ref() 0x78ced528: ref=2
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:transport_set_state() State changed
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd1: TRANSPORT_STATE_IDLE ->
>>> TRANSPORT_STATE_REQUESTING
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_request_create() Request created:
>>> method=Acquire id=7
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_owner_add() Owner :1.4 Request
>>> Acquire
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_transport_set_owner() Transport
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd1 Owner :1.4
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:device_found_callback() hci0 addr 68:17:29:58:C9:A0,
>>> rssi -64 flags 0x0000 eir_len 37
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_set_legacy() legacy 0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:dev_disconnected() Device 00:1B:DC:07:32:D3
>>> disconnected, reason 3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:adapter_remove_connection()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> plugins/policy.c:disconnect_cb() reason 3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1B:DC:07:32:D3
>>> type 0 status 0xe
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/device.c:device_bonding_failed() status 14
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:resume_discovery()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:trigger_start_discovery()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> src/adapter.c:cancel_passive_scanning()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:session_cb()
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:connection_lost() Disconnected from
>>> 00:1B:DC:07:32:D3
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:abort_cfm() Source 0x78ce0128: Abort_Cfm
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_unref() 0x78ced528: ref=1
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
>>> CONFIGURED -> IDLE
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]: No reply to Open
>>> request
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:open_cfm() Source 0x78ce0128: Open_Cfm
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_transport_remove_owner() Transport
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd1 Owner :1.4
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_request_reply() Request Acquire Reply
>>> Input/output error
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_owner_free() Owner :1.4
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:media_owner_remove() Owner :1.4 Request
>>> Acquire
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/transport.c:transport_set_state() State changed
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd1: TRANSPORT_STATE_REQUESTING
>>> -> TRANSPORT_STATE_IDLE
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:a2dp_sep_unlock() SEP 0x78ce0128 unlocked
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_unref() 0x78ced528: ref=0
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/a2dp.c:setup_free() 0x78ced528
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ bluetoothd[156]:
>>> profiles/audio/avdtp.c:avdtp_unref() 0x78cec8d8: ref=2
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ pulseaudio[169]: E: [pulseaudio]
>>> bluez5-util.c: Transport Acquire() failed for transport
>>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd1 (Input/output error)
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ systemd[1]: bluetooth.service:
>>> main process exited, code=killed, status=11/SEGV
>>> Sep 17 21:27:15 DEVPZZ4CKCFWCY6964WQ systemd[1]: Unit
>>> bluetooth.service entered failed state.
>>>
>>>
>>> Thanks,
>>>
>>> John
>>>
>>> On Wed, Sep 17, 2014 at 12:33 AM, Szymon Janc <szymon.janc@tieto.com> wrote:
>>>> Hi John,
>>>>
>>>> On Tuesday 16 of September 2014 17:04:46 John Tobias wrote:
>>>>> Hello All,
>>>>>
>>>>> I am using Bluez 5.23 and running PTS 5.2. I am trying to test the
>>>>> AVDTP profile and the PTS software prompt me a dialog box "Create an
>>>>> AVDTP signaling channel" (please see the attached image.
>>>>>
>>>>> I would like to know how to make response via bluetoothctl or any
>>>>> command line to continue PTS testing?.
>>>>
>>>> Connecting A2DP profile (AVDTP is a protocol used by A2DP) should do that (for
>>>> that you would also need PulseAudio 5). So if you have all set up 'connect
>>>> <pts_bdaddr>' should do.
>>>>
>>>> Other option would be to use android/avdtptest tool for AVDTP protocol
>>>> testing. But this would test android/avdtp-lib and not the AVDTP code used in
>>>> Linux daemon (those will be unified, eventually).
>>>>
>>>> --
>>>> BR
>>>> Szymon Janc
