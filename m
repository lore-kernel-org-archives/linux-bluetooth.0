Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAAAJ3CL-WRRXr0cofDCeRM46H-jNf7L=dcZ5Uo7C6xp=K2QFyw@mail.gmail.com>
References: <CAAAJ3CJEXf+mYvst26fHasYsAvrXffhXFkEAO0a2Di=BLrxGOg@mail.gmail.com>
	<CABBYNZJA1hjO4chzFffYHRKsTJHKaGca+5O8U493kbTq=9CRPg@mail.gmail.com>
	<CAAAJ3C+JOP6rABtsfi274bKfe_Y9FB4uh-K7zs6Hmi30JB+TRQ@mail.gmail.com>
	<CAAAJ3C+MfihmVWyaR3EgY3YvF0AV2HeX+7MAi7jDUu1m=NXf2A@mail.gmail.com>
	<CABBYNZ+aPxS4p_LFDtS-eDDBMjTCvLnqUOCD5u_SXKQ46tO9Ug@mail.gmail.com>
	<CAAAJ3CL-WRRXr0cofDCeRM46H-jNf7L=dcZ5Uo7C6xp=K2QFyw@mail.gmail.com>
Date: Tue, 17 Mar 2015 12:51:05 +0200
Message-ID: <CABBYNZLAFKWQB8EYtSt-S49rcqw-TdX_vLjvXU7LSWaxq_xq2g@mail.gmail.com>
Subject: Re: Bluetoothd crash/segfault when Chrombook creates connection with
 Samsung gear circle
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ethan <ethancsge@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ethan,

On Tue, Mar 17, 2015 at 12:13 PM, Ethan <ethancsge@gmail.com> wrote:
> Hi Luiz,
>
> OK, I will follow the rule.
> And actually, there have three crashes in function as
> "avrcp_player_value_rsp", "avrcp_get_play_status_rsp" and
> "avrcp_get_element_attributes_rsp". I tried to mark all code of function
> "avrcp_get_play_status_rsp" and return FALSE while finding first crash.
> Then I built bluetoothd, and it crashed again in avrcp_get_play_status_rsp.
> The same way, next crash is in avrcp_get_element_attributes_rsp.
>
> I traced code and check issue log as attached message file, it seems that
> code "struct avrcp *session = user_data;" get invalid address in function
> avrcp_get_capabilities_resp. Also, I tried to create a same type structure
> and assign to session as below, and issue can not be reproduced. Hope these
> information can help you to find root cause. Thanks.
>
> --- a/profiles/audio/avrcp.c
> +++ b/profiles/audio/avrcp.c
> @@ -3222,10 +3222,12 @@ static gboolean avrcp_get_capabilities_resp(struct
> avctp *conn,
>                      uint8_t *operands, size_t operand_count,
>                      void *user_data)
>  {
> -    struct avrcp *session = user_data;
> +        struct avrcp  test;
> +    struct avrcp *session = &test;
>
>
> The attached file is backtrace for three crash by GDB
>
>
> static gboolean avrcp_get_play_status_rsp(struct avctp *conn,
>                     uint8_t code, uint8_t subunit,
>                     uint8_t *operands, size_t operand_count,
>                     void *user_data)
> {
>     struct avrcp *session = user_data;
>     struct avrcp_player *player = session->controller->player;
>     struct media_player *mp = player->user_data;                  /*
> --->crash */
>
>
>
> static gboolean avrcp_get_element_attributes_rsp(struct avctp *conn,
>                         uint8_t code, uint8_t subunit,
>                         uint8_t *operands,
>                         size_t operand_count,
>                         void *user_data)
> {
>     struct avrcp *session = user_data;
>     struct avrcp_player *player = session->controller->player;   /*
> --->crash */
>
> static gboolean avrcp_player_value_rsp(struct avctp *conn,
>                     uint8_t code, uint8_t subunit,
>                     uint8_t *operands, size_t operand_count,
>                     void *user_data)
> {
>     struct avrcp *session = user_data;
>     struct avrcp_player *player = session->controller->player;
>     struct media_player *mp = player->user_data;                   /*
> --->crash */
>
>
> 2015-03-17T20:52:23.347640+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to
> A0:B4:A5:1F:56:B9
> 2015-03-17T20:52:23.348292+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avctp.c:init_uinput() AVRCP: uinput initialized for
> A0:B4:A5:1F:56:B9
> 2015-03-17T20:52:23.348337+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avrcp.c:target_init() 0x7f601c964a20 version 0x0105

Here seems to be the problem, it seems we only are initiating the
target not the controller, which should be fine except that the remote
will not be able to qualify with support of absolute volume control
since that requires both records. Anyway there is no reason for us to
crash even if the remote device is doing some strange stuff, we might
need to check if controller is not initialized just volume control
should be enabled.

> 2015-03-17T20:52:23.348352+11:00 DEBUG bluetoothd[21717]:
> src/service.c:change_state() 0x7f601c978bd0: device A0:B4:A5:1F:56:B9
> profile avrcp-controller state changed: connecting -> connected (0)
> 2015-03-17T20:52:23.348368+11:00 DEBUG bluetoothd[21717]:
> src/device.c:device_profile_connected() avrcp-controller Success (0)
> 2015-03-17T20:52:23.348382+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
> 2015-03-17T20:52:23.349248+11:00 INFO kernel: [  465.298168] input:
> A0:B4:A5:1F:56:B9 as /devices/virtual/input/input13
> 2015-03-17T20:52:23.373188+11:00 NOTICE logger[22283]:
> /opt/google/input/inputcontrol --type=mouse --list
> 2015-03-17T20:52:23.376462+11:00 NOTICE logger[22286]:
> /opt/google/input/inputcontrol --type=touchpad --list
> 2015-03-17T20:52:23.512509+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP PDU 0x10, company
> 0x001958 len 0x0001
> 2015-03-17T20:52:23.512546+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avrcp.c:avrcp_handle_get_capabilities() id=3
> 2015-03-17T20:52:25.463945+11:00 DEBUG bluetoothd[21717]:
> profiles/audio/avctp.c:req_timeout() transaction 3
> 2015-03-17T20:52:25.464832+11:00 INFO kernel: [  467.415946]
> bluetoothd[21717]: segfault at 0 ip 00007f601c127849 sp 00007fffc87d9200
> error 4 in bluetoothd[7f601c0fa000+b2000]
> 2015-03-17T20:52:25.525692+11:00 WARNING crash_reporter[22848]: Could not
> load the device policy file.
> 2015-03-17T20:52:25.525998+11:00 WARNING crash_reporter[22848]: Received
> crash notification for bluetoothd[21717] sig 11, user 218 (developer build -
> not testing - always dumping)
>
>
> 2015-03-16 20:22 GMT+08:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>>
>> Hi Ethan,
>>
>>
>> On Mon, Mar 16, 2015 at 2:14 PM, Ethan <ethancsge@gmail.com> wrote:
>> >
>> > Hi Luiz,
>> >
>> > I used gdb to dump crash file, and found it caused from invalid address
>> > access. In below function, it tried to access address that seems is invalid
>> > and crash. is it possible add protection?
>> >
>> > avrcp_player_value_rsp
>> > avrcp_get_play_status_rsp
>> > avrcp_get_element_attributes_rsp
>> >
>> > [GDB dump]
>> >
>> > Program terminated with signal SIGSEGV, Segmentation fault.
>> > #0  avrcp_get_play_status_rsp (conn=0x7f515c8febb0, code=10 '\n',
>> > subunit=9 '\t', operands=0x7f515c8e8ce6 "", operand_count=8,
>> >     user_data=0x7f515c8ff3b0) at profiles/audio/avrcp.c:1805
>> > 1805    profiles/audio/avrcp.c: No such file or directory.
>> >
>> > Program terminated with signal SIGSEGV, Segmentation fault.
>> > #0  avrcp_player_value_rsp (conn=0x7f35056a15d0, code=8 '\b', subunit=9
>> > '\t', operands=0x7f3505690936 "", operand_count=7,
>> >     user_data=0x7f35056a2b30) at profiles/audio/avrcp.c:1873
>> > 1873    profiles/audio/avrcp.c: No such file or directory.
>>
>> No top-posting in the mailing list please, reply inline, on topic are
>> these 2 different crashes? I wonder if you could try running with
>> valgrind, it should generate a backtrace when the crash happen.
>>
>> >
>> >
>> >
>> >
>> > 2015-03-12 18:28 GMT+08:00 Ethan <ethancsge@gmail.com>:
>> >>
>> >> Hi Luiz,
>> >>
>> >> is it better to provide GDB for this issue?
>> >>
>> >> Regards,
>> >> Ethan
>> >>
>> >> 2015-03-12 16:34 GMT+08:00 Luiz Augusto von Dentz
>> >> <luiz.dentz@gmail.com>:
>> >>>
>> >>> Hi Ethan,
>> >>>
>> >>> On Thu, Mar 12, 2015 at 10:04 AM, Ethan <ethancsge@gmail.com> wrote:
>> >>> >
>> >>> >
>> >>> > Hi,
>> >>> >
>> >>> > There has an issue about bluetoothd crash/segfault when Chrombook
>> >>> > creates connection with Samsung gear circle.
>> >>> > The bluez version is 5.28. From sniffer, it shows get capabilities
>> >>> > response error due to capability count is less than 2.
>> >>> > so I modified the code in function avrcp_get_capabilities_resp as
>> >>> > below and issue can not be reproduced. I am not sure it's good for fixing,
>> >>> > please help to check.
>> >>> > Attached file is sniffer log and patch.
>> >>> > Thanks
>> >>> >
>> >>> > diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
>> >>> > index 11de6ee..f19d26b 100644
>> >>> > --- a/profiles/audio/avrcp.c
>> >>> > +++ b/profiles/audio/avrcp.c
>> >>> > @@ -3228,7 +3228,7 @@ static gboolean
>> >>> > avrcp_get_capabilities_resp(struct avctp *conn,
>> >>> >         uint8_t count;
>> >>> >
>> >>> >         if (code == AVC_CTYPE_REJECTED || code ==
>> >>> > AVC_CTYPE_NOT_IMPLEMENTED ||
>> >>> > -                       pdu == NULL || pdu->params[0] !=
>> >>> > CAP_EVENTS_SUPPORTED)
>> >>> > +                       pdu == NULL || pdu->params[0] !=
>> >>> > CAP_EVENTS_SUPPORTED || pdu->params[1] < 2 )
>> >>> >                 return FALSE;
>> >>> >
>> >>> >         /* Connect browsing if pending */
>> >>> >
>> >>> > 015-03-11T09:16:03.462714+02:00 DEBUG bluetoothd[3304]:
>> >>> > src/service.c:change_state() 0x7fdba9a0a7d0: device A0:B4:A5:1F:56:B9
>> >>> > profile avrcp-controller state changed: disconnected -> connecting (0)
>> >>> > 2015-03-11T09:16:03.462746+02:00 DEBUG bluetoothd[3304]:
>> >>> > src/service.c:btd_service_ref() 0x7fdba9a0a8a0: ref=3
>> >>> > 2015-03-11T09:16:03.462760+02:00 DEBUG bluetoothd[3304]:
>> >>> > plugins/policy.c:service_cb() Added a2dp-sink reconnect 0
>> >>> > 2015-03-11T09:16:03.462772+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/sink.c:sink_set_state() State changed
>> >>> > /org/bluez/hci0/dev_A0_B4_A5_1F_56_B9: SINK_STATE_CONNECTING ->
>> >>> > SINK_STATE_CONNECTED
>> >>> > 2015-03-11T09:16:03.462784+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/transport.c:transport_update_playing()
>> >>> > /org/bluez/hci0/dev_A0_B4_A5_1F_56_B9/fd0 State=TRANSPORT_STATE_IDLE
>> >>> > Playing=0
>> >>> > 2015-03-11T09:16:03.520141+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/avctp.c:avctp_connect_cb() AVCTP: connected to
>> >>> > A0:B4:A5:1F:56:B9
>> >>> > 2015-03-11T09:16:03.520189+02:00 ERR bluetoothd[3304]: Can't open
>> >>> > input device: No such file or directory (2)
>> >>> > 2015-03-11T09:16:03.520205+02:00 ERR bluetoothd[3304]: AVRCP: failed
>> >>> > to init uinput for A0:B4:A5:1F:56:B9
>> >>> > 2015-03-11T09:16:03.520216+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/avrcp.c:target_init() 0x7fdba9a09bd0 version 0x0105
>> >>> > 2015-03-11T09:16:03.520227+02:00 DEBUG bluetoothd[3304]:
>> >>> > src/service.c:change_state() 0x7fdba9a0a7d0: device A0:B4:A5:1F:56:B9
>> >>> > profile avrcp-controller state changed: connecting -> connected (0)
>> >>> > 2015-03-11T09:16:03.520239+02:00 DEBUG bluetoothd[3304]:
>> >>> > src/device.c:device_profile_connected() avrcp-controller Success (0)
>> >>> > 2015-03-11T09:16:03.520250+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/avctp.c:avctp_set_state() AVCTP Connected
>> >>> > 2015-03-11T09:16:03.613393+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/avrcp.c:handle_vendordep_pdu() AVRCP PDU 0x10, company
>> >>> > 0x001958 len 0x0001
>> >>> > 2015-03-11T09:16:03.613423+02:00 DEBUG bluetoothd[3304]:
>> >>> > profiles/audio/avrcp.c:avrcp_handle_get_capabilities() id=3
>> >>> > 2015-03-11T09:16:03.719326+02:00 DEBUG bluetoothd[3304]:
>> >>> > src/device.c:search_cb() A0:B4:A5:1F:56:B9: No service update
>> >>> > 2015-03-11T09:16:03.719358+02:00 DEBUG bluetoothd[3304]:
>> >>> > src/device.c:device_svc_resolved() /org/bluez/hci0/dev_A0_B4_A5_1F_56_B9 err
>> >>> > 0
>> >>> > 2015-03-11T09:16:05.597080+02:00 INFO kernel: [  232.700006]
>> >>> > bluetoothd[3304]: segfault at 0 ip 00007fdba8143369 sp 00007fff95799110
>> >>> > error 4 in bluetoothd[7fdba8115000+b4000]
>> >>> > 2015-03-11T09:16:05.675496+02:00 WARNING crash_reporter[16211]:
>> >>> > Received crash notification for bluetoothd[3304] sig 11, user 218 (handling)
>> >>> > 2015-03-11T09:16:05.678077+02:00 INFO crash_reporter[16211]: State
>> >>> > of crashed process [3304]: S (sleeping)
>> >>> > 2015-03-11T09:16:05.696673+02:00 INFO crash_reporter[16211]: Stored
>> >>> > minidump to /var/spool/crash/bluetoothd.20150311.091605.3304.dmp
>> >>> > 2015-03-11T09:16:05.702634+02:00 WARNING minijail0[3298]:
>> >>> > libminijail: child process 3304 received signal 11
>> >>> > 2015-03-11T09:16:05.703799+02:00 WARNING kernel: [  232.806836]
>> >>> > init: bluetoothd main process (3298) terminated with status 139
>> >>> > 2015-03-11T09:16:05.703823+02:00 WARNING kernel: [  232.806914]
>> >>> > init: bluetoothd main process ended, respawning
>> >>>
>> >>> This does not match the picture since I can see List Player Settings
>> >>> packet so I afraid it is crashing in some other place, also your
>> >>> sniffer got this wrong it is allowed to send 1 as capability counter
>> >>> if you are the controller you usually only have Volume Changed event.
>> >>>
>> >>> --
>> >>> Luiz Augusto von Dentz
>> >>
>> >>
>> >
>>
>>
>>
>> --
>> Luiz Augusto von Dentz
>
>



-- 
Luiz Augusto von Dentz
