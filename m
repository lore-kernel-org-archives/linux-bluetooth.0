Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLK3w+feOuikzWrG4VhsAR7Ky+S7WZpnBOsHJGR_kE+gA@mail.gmail.com>
References: <CACUGKYPh7MZ7gLgnBWm=rtAbkRSis-qy3UwcCmKiLdyg9aop6w@mail.gmail.com>
	<CABBYNZLK3w+feOuikzWrG4VhsAR7Ky+S7WZpnBOsHJGR_kE+gA@mail.gmail.com>
Date: Tue, 14 Oct 2014 15:27:51 -0700
Message-ID: <CACUGKYP50c-yZU2HxGD6CuD5EBf1s_Gqm0Po2szpSikV4hn4Mw@mail.gmail.com>
Subject: Re: Not getting an AVDTP: incoming connect
From: John Tobias <john.tobias.ph@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

I was able to reproduce again and here are the logs.

HCI LOGS:

HCI Event: Connect Request (0x04) plen 10
    bdaddr 00:1B:DC:07:32:D3 class 0x080418 type ACL
< HCI Command: Accept Connection Request (0x01|0x0009) plen 7
    bdaddr 00:1B:DC:07:32:D3 role 0x00
    Role: Master
> HCI Event: Command Status (0x0f) plen 4
    Accept Connection Request (0x01|0x0009) status 0x00 ncmd 1
> HCI Event: Connect Complete (0x03) plen 11
    status 0x00 handle 1 bdaddr 00:1B:DC:07:32:D3 type ACL encrypt 0x00
< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2
    handle 1
> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7
    bdaddr 00:1B:DC:07:32:D3 mode 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Supported Features (0x01|0x001b) status 0x00 ncmd 1
> HCI Event: Read Remote Supported Features (0x0b) plen 11
    status 0x00 handle 1
    Features: 0xff 0xff 0x8f 0x7e 0xd8 0x1f 0x5b 0x87
< HCI Command: Read Remote Extended Features (0x01|0x001c) plen 3
    handle 1 page 1
> HCI Event: Command Status (0x0f) plen 4
    Read Remote Extended Features (0x01|0x001c) status 0x00 ncmd 1
> HCI Event: Max Slots Change (0x1b) plen 3
    handle 1 slots 5
> HCI Event: Read Remote Extended Features (0x23) plen 13
    status 0x00 handle 1 page 1 max 1
    Features: 0x01 0x00 0x00 0x00 0x00 0x00 0x00 0x00
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
    bdaddr 00:1B:DC:07:32:D3 mode 2 clkoffset 0x0000
> HCI Event: Command Status (0x0f) plen 4
    Remote Name Request (0x01|0x0019) status 0x00 ncmd 1
> HCI Event: Remote Name Req Complete (0x07) plen 255
    status 0x00 bdaddr 00:1B:DC:07:32:D3 name 'PTS-A2DP-WIN-4MP7G5VHB2U'
< HCI Command: Disconnect (0x01|0x0006) plen 3
    handle 1 reason 0x13
    Reason: Remote User Terminated Connection
> HCI Event: Command Status (0x0f) plen 4
    Disconnect (0x01|0x0006) status 0x00 ncmd 1
> HCI Event: Disconn Complete (0x05) plen 4
    status 0x00 handle 1 reason 0x16
    Reason: Connection Terminated by Local Host
< HCI Command: Read BD ADDR (0x04|0x0009) plen 0
> HCI Event: Command Complete (0x0e) plen 10
    Read BD ADDR (0x04|0x0009) ncmd 1
    status 0x00 bdaddr D0:E7:82:ED:B0:1A


Additionally, I've encounter a scenario where I was able to respond to
the prompt (Confirm passkey 773535 (yes/no):), after entering yes and
enter, the hcidump did not logs any event.

Regards,

john

On Tue, Oct 14, 2014 at 2:51 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi John,
>
> On Tue, Oct 14, 2014 at 3:09 AM, John Tobias <john.tobias.ph@gmail.com> wrote:
>> Hi Marcell / Bluez Team:
>>
>> I was running the PTS 5.2 and there were an occurrences that the bluez
>> did not show a similar message below:
>>
>> [agent] Authorize service 0000110d-0000-1000-8000-00805f9b34fb (yes/no):
>>
>>
>> 1. I logs below are the traces of the bluetoothd not prompting the
>> Authorize service message:
>>
>> t 13 23:27:22 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/adapter.c:connected_callback() hci0 device 00:1B:DC:07:32:D3
>> connected eir_len 31
>> Oct 13 23:27:22 DEV9MRCNERGAAAQYDKGP bluetoothd[152]: on_connected
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/adapter.c:dev_disconnected() Device 00:1B:DC:07:32:D3
>> disconnected, reason 2
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/adapter.c:adapter_remove_connection()
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> plugins/policy.c:disconnect_cb() reason 2
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/adapter.c:bonding_attempt_complete() hci0 bdaddr 00:1B:DC:07:32:D3
>> type 0 status 0xe
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/device.c:device_bonding_complete() bonding (nil) status 0x0e
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/device.c:device_bonding_failed() status 14
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/adapter.c:resume_discovery()
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]: on_disconnected
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]: setting adv
>> params failed: Operation not permitted
>> Oct 13 23:27:26 DEV9MRCNERGAAAQYDKGP bluetoothd[152]: failed to enable
>> advertising
>>
>>
>> 2. These messages are the traces of the bluetoothd showing the
>> Authorize service message:
>>
>> Oct 13 23:29:48 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/adapter.c:connected_callback() hci0 device 00:1B:DC:07:32:D3
>> connected eir_len 31
>> Oct 13 23:29:48 DEV9MRCNERGAAAQYDKGP bluetoothd[152]: on_connected
>> Oct 13 23:29:48 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming connect from
>> 00:1B:DC:07:32:D3
>> Oct 13 23:29:48 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/source.c:source_set_state() State changed
>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3: SOURCE_STATE_DISCONNECTED ->
>> SOURCE_STATE_CONNECTING
>> Oct 13 23:29:48 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/agent.c:agent_ref() 0x77a601d0: ref=2
>> Oct 13 23:29:48 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/agent.c:agent_authorize_service() authorize service request was
>> sent for /org/bluez/hci0/dev_00_1B_DC_07_32_D3
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/agent.c:agent_ref() 0x77a601d0: ref=3
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/agent.c:agent_unref() 0x77a601d0: ref=2
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/agent.c:agent_unref() 0x77a601d0: ref=1
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected signaling
>> channel to 00:1B:DC:07:32:D3
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=672
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:session_cb()
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received DISCOVER_CMD
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:session_cb()
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received
>> GET_CAPABILITIES_CMD
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/a2dp.c:endpoint_getcap_ind() Sink 0x77a69bd8:
>> Get_Capability_Ind
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:session_cb()
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received
>> SET_CONFIGURATION_CMD
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/a2dp.c:endpoint_setconf_ind() Sink 0x77a69bd8:
>> Set_Configuration_Ind
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_ref() 0x77a6afa8: ref=1
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/a2dp.c:setup_ref() 0x77a5d040: ref=1
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/media.c:media_endpoint_async_call() Calling
>> SetConfiguration: name = :1.6 path = /MediaEndpoint/A2DPSink
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_ref() 0x77a6afa8: ref=2
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
>> IDLE -> CONFIGURED
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/a2dp.c:setup_unref() 0x77a5d040: ref=0
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/a2dp.c:setup_free() 0x77a5d040
>> Oct 13 23:29:52 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_unref() 0x77a6afa8: ref=1
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:session_cb()
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/a2dp.c:open_ind() Sink 0x77a69bd8: Open_Ind
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming connect from
>> 00:1B:DC:07:32:D3
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_connect_cb() AVDTP: connected transport
>> channel to 00:1B:DC:07:32:D3
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/avdtp.c:avdtp_sep_set_state() stream state changed:
>> CONFIGURED -> OPEN
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> src/service.c:change_state() 0x77a70eb8: device 00:1B:DC:07:32:D3
>> profile a2dp-source state changed: disconnected -> connected (0)
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> plugins/policy.c:service_cb() Added a2dp-source reconnect 1
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/source.c:source_set_state() State changed
>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3: SOURCE_STATE_CONNECTING ->
>> SOURCE_STATE_CONNECTED
>> Oct 13 23:29:53 DEV9MRCNERGAAAQYDKGP bluetoothd[152]:
>> profiles/audio/transport.c:transport_update_playing()
>> /org/bluez/hci0/dev_00_1B_DC_07_32_D3/fd19 State=TRANSPORT_STATE_IDLE
>>
>>
>> It seems the avdtp_server_socket did not received the signals and
>> that's the reason why the avdtp_confirm_cb function did not execute. I
>> would like to know what are the possible scenario why the bluetoothd
>> did not receive the event?.
>> Because, if I re-run the PTS with the same test case, the bluez could
>> received the event.
>
> It would probably help if you have the HCI logs as well, perhaps there
> is something wrong with authentication or we are rejecting the L2CAP
> connection for some reason. Also note that the server socket is only
> initialized if once a endpoint is registered so perhaps in case 1 you
> did not have any endpoint available.
>
>
> --
> Luiz Augusto von Dentz
