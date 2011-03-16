Return-Path: <cyrus@holtmann.org>
Subject: Re: Switching between SBC and MPEG audio on headsets
From: Arun Raghavan <arun.raghavan@collabora.co.uk>
To: Brian Gix <bgix@codeaurora.org>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <4D7FCF71.7080702@codeaurora.org>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
	 <4D7F9237.2080206@codeaurora.org> <1300218670.2192.35.camel@snowflake>
	 <4D7FCF71.7080702@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 16 Mar 2011 23:49:55 +0530
Message-ID: <1300299595.2192.92.camel@snowflake>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 2011-03-15 at 13:43 -0700, Brian Gix wrote:
> Hi Arun,
> 
> On 3/15/2011 12:51 PM, Arun Raghavan wrote:
> > Hey Brian,
> >
> 
> [...]
> 
> >
> > I'm quite unfamiliar with how this works, so please excuse any wild
> > inaccuracies in terminology. I believe that I am doing it this way
> > already (mostly discovered by trial and error). When I want to
> > reconfigure, I do the following:
> >
> > - Send a BT_STOP_STREAM request, get the expected response
> > - Send a BT_CLOSE request, get the expected response
> > - Send a BT_OPEN request with the new seid, get the expected response
> > - Send a BT_SET_CONFIGURATION request with the new caps, get the
> > expected response
> > - Send a BT_START_STREAM, wait for the response
> > - Start streaming
> 
> Well, with full knowledge that I *haven't* examined this part of BlueZ, 
> I can say that from a protocol perspective, the AVDTP_SET_CONFIG must go 
> over the air/be acknowledged  before the AVDTP_OPEN can be 
> sent/acknowledged.  I haven't checked to see if those step are 
> obfuscated at all by the BT_OPEN/BT_SET_CONFIGURATION naming convention, 
> or if it is a simple mapping.
> 
> On a compliant device, an Open directly following a Close should return 
> a NOT_CONFIGURED error. But it may be that a less strict SNK device 
> might assume the last configuration and overlook the protocol error.

You're right - the BT_OPEN doesn't result in an AVDTP_OPEN, this happens
after the SET_CONFIGURATION is done. I'll try to hack up a patch to look
up a new rsep if the media type of the lsep and currently selected rsep
do not match.

Cheers,
Arun

p.s.: FWIW, the debug log looks like this:

bluetoothd[17790]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_STOP_STREAM
bluetoothd[17790]: audio/avdtp.c:avdtp_ref() 0x7fc7f57aa260: ref=4
bluetoothd[17790]: audio/a2dp.c:setup_ref() 0x7fc7f57a86d0: ref=1
bluetoothd[17790]: audio/avdtp.c:session_cb() 
bluetoothd[17790]: audio/avdtp.c:avdtp_parse_resp() SUSPEND request succeeded
bluetoothd[17790]: audio/avdtp.c:avdtp_sep_set_state() stream state changed: STREAMING -> OPEN
bluetoothd[17790]: audio/sink.c:sink_set_state() State changed /org/bluez/17790/hci0/dev_00_0B_E4_91_11_A1: SINK_STATE_PLAYING -> SINK_STATE_CONNECTED
bluetoothd[17790]: audio/a2dp.c:suspend_cfm() Source 0x7fc7f57869d0: Suspend_Cfm
bluetoothd[17790]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_STOP_STREAM
bluetoothd[17790]: audio/a2dp.c:setup_unref() 0x7fc7f57a86d0: ref=0
bluetoothd[17790]: audio/a2dp.c:setup_free() 0x7fc7f57a86d0
bluetoothd[17790]: audio/avdtp.c:avdtp_unref() 0x7fc7f57aa260: ref=3
bluetoothd[17790]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_SUSPEND_STREAM
bluetoothd[17790]: audio/a2dp.c:a2dp_sep_unlock() SEP 0x7fc7f57869d0 unlocked
bluetoothd[17790]: audio/avdtp.c:avdtp_unref() 0x7fc7f57aa260: ref=2
bluetoothd[17790]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_SUSPEND_STREAM
bluetoothd[17790]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_OPEN
bluetoothd[17790]: audio/unix.c:handle_a2dp_open() open a2dp - object=/org/bluez/17790/hci0/dev_00_0B_E4_91_11_A1 source=ANY destination=ANY lock=write
bluetoothd[17790]: audio/avdtp.c:avdtp_ref() 0x7fc7f57aa260: ref=3
bluetoothd[17790]: audio/a2dp.c:a2dp_sep_lock() SEP 0x7fc7f5787250 locked
bluetoothd[17790]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_OPEN
bluetoothd[17790]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_SET_CONFIGURATION
bluetoothd[17790]: audio/unix.c:print_mpeg12() Media Codec: MPEG12 Channel Modes: Stereo  Frequencies: 44.1Khz  Layers: 3  CRC: No
bluetoothd[17790]: audio/a2dp.c:a2dp_config() a2dp_config: selected SEP 0x7fc7f5787250
bluetoothd[17790]: audio/avdtp.c:avdtp_ref() 0x7fc7f57aa260: ref=4
bluetoothd[17790]: audio/a2dp.c:setup_ref() 0x7fc7f57a86d0: ref=1
bluetoothd[17790]: audio/avdtp.c:session_cb() 
bluetoothd[17790]: audio/avdtp.c:avdtp_parse_resp() CLOSE request succeeded
bluetoothd[17790]: audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> CLOSING
bluetoothd[17790]: audio/a2dp.c:close_cfm() Source 0x7fc7f57869d0: Close_Cfm
bluetoothd[17790]: audio/avdtp.c:avdtp_sep_set_state() stream state changed: CLOSING -> IDLE
bluetoothd[17790]: audio/avdtp.c:avdtp_unref() 0x7fc7f57aa260: ref=3
bluetoothd[17790]: audio/avdtp.c:avdtp_set_configuration() 0x7fc7f57aa260: int_seid=2, acp_seid=2
bluetoothd[17790]: audio/avdtp.c:session_cb() 
bluetoothd[17790]: audio/avdtp.c:avdtp_parse_resp() SET_CONFIGURATION request succeeded
bluetoothd[17790]: audio/a2dp.c:setconf_cfm() Source 0x7fc7f5787250: Set_Configuration_Cfm
bluetoothd[17790]: audio/avdtp.c:avdtp_ref() 0x7fc7f57aa260: ref=4
bluetoothd[17790]: audio/avdtp.c:avdtp_sep_set_state() stream state changed: IDLE -> CONFIGURED
bluetoothd[17790]: audio/avdtp.c:session_cb() 
bluetoothd[17790]: audio/avdtp.c:avdtp_parse_resp() OPEN request succeeded
bluetoothd[17790]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected transport channel to 00:0B:E4:91:11:A1
bluetoothd[17790]: audio/avdtp.c:handle_transport_connect() sk 26, omtu 895, send buffer size 61440
bluetoothd[17790]: audio/a2dp.c:open_cfm() Source 0x7fc7f5787250: Open_Cfm
bluetoothd[17790]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_SET_CONFIGURATION
bluetoothd[17790]: audio/a2dp.c:setup_unref() 0x7fc7f57a86d0: ref=0
bluetoothd[17790]: audio/a2dp.c:setup_free() 0x7fc7f57a86d0
bluetoothd[17790]: audio/avdtp.c:avdtp_unref() 0x7fc7f57aa260: ref=3
bluetoothd[17790]: audio/avdtp.c:avdtp_sep_set_state() stream state changed: CONFIGURED -> OPEN
bluetoothd[17790]: audio/sink.c:sink_set_state() State changed /org/bluez/17790/hci0/dev_00_0B_E4_91_11_A1: SINK_STATE_CONNECTED -> SINK_STATE_CONNECTED
bluetoothd[17790]: audio/device.c:device_set_state() state change attempted from connected to connected
bluetoothd[17790]: audio/unix.c:client_cb() Audio API: BT_REQUEST <- BT_START_STREAM
bluetoothd[17790]: audio/avdtp.c:avdtp_ref() 0x7fc7f57aa260: ref=4
bluetoothd[17790]: audio/a2dp.c:setup_ref() 0x7fc7f57a86d0: ref=1
bluetoothd[17790]: audio/avdtp.c:session_cb() 
bluetoothd[17790]: audio/avdtp.c:avdtp_parse_resp() START request succeeded
bluetoothd[17790]: audio/a2dp.c:start_cfm() Source 0x7fc7f5787250: Start_Cfm
bluetoothd[17790]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_START_STREAM
bluetoothd[17790]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_RESPONSE -> BT_NEW_STREAM
bluetoothd[17790]: audio/a2dp.c:setup_unref() 0x7fc7f57a86d0: ref=0
bluetoothd[17790]: audio/a2dp.c:setup_free() 0x7fc7f57a86d0
bluetoothd[17790]: audio/avdtp.c:avdtp_unref() 0x7fc7f57aa260: ref=3
bluetoothd[17790]: audio/avdtp.c:avdtp_sep_set_state() stream state changed: OPEN -> STREAMING
bluetoothd[17790]: audio/sink.c:sink_set_state() State changed /org/bluez/17790/hci0/dev_00_0B_E4_91_11_A1: SINK_STATE_CONNECTED -> SINK_STATE_PLAYING

