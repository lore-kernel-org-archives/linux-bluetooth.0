Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK5yFoR9nGjU8=U4g+VkLc281Hh9QhYT5m9hTxoZLFoaw@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCThwZxQQoKHfEszX3sZPpE_cp5+XS_fEBYiAmnR1n0d9Sg@mail.gmail.com>
	<CAB7rCTjUL2_Kae186QgXa2csf-p-cuGH2US38a7S436uBY93Pw@mail.gmail.com>
	<CABBYNZK5yFoR9nGjU8=U4g+VkLc281Hh9QhYT5m9hTxoZLFoaw@mail.gmail.com>
Date: Fri, 23 Mar 2012 10:30:39 -0500
Message-ID: <CAB7rCTiJZqPCYGZo+rJ+dnxmR6y6hnksRrzqnbyPv8i72=qq8g@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Mike <puffy.taco@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Mar 23, 2012 at 9:25 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mike,
>
> On Thu, Mar 22, 2012 at 6:21 PM, Mike <puffy.taco@gmail.com> wrote:
>>> I do reply right away.  This is on an embedded device and it seems
>>> like BlueZ needs just a bit of time to get the interface ready or else
>>> I get 'Method "Acquire" with signature "s" on interface
>>> "org.bluez.MediaTransport" doesn't exist'.
>>>
>>>>> bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
>>>>> bluetoothd[751]: audio/a2dp.c:open_ind() Sink 0x2a0d40a8: Open_Ind
>>>>> bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
>>>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock acquired
>>>>> bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
>>>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock acquired
>>>>> bluetoothd[751]: audio/transport.c:media_owner_create() Owner created:
>>>>> sender=:1.40 accesstype=rw
>>>>> bluetoothd[751]: audio/avdtp.c:avdtp_ref() 0x2a0d2a00: ref=3
>>>>> bluetoothd[751]: audio/transport.c:media_transport_release() Transport
>>>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock released
>>>>> bluetoothd[751]: audio/transport.c:media_transport_release() Transport
>>>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock released
>>>>> bluetoothd[751]: audio/transport.c:media_owner_free() Owner :1.40
>>>>> getting the reply from the cb failed
>>>>> GDBus.Error:org.bluez.Error.NotAuthorized: Operation Not Authorized
>>>>
>>>> Strange, if what you said is true why there is no "SEP in bad state
>>>> for resume" error? Anyway I think we can fix this by checking the
>>>> current state of the SEP and waiting it to go OPEN to resume, so the
>>>> client don't have to keep tracking of Audio.Connected.
>>>
>>> I just tried it again, as I'd seen that message before, and this time
>>> it was happy enough to provide that error.
>>>
>>> bluetoothd[734]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
>>> bluetoothd[734]: audio/a2dp.c:open_ind() Sink 0x2a0f1ff8: Open_Ind
>>> bluetoothd[734]: audio/transport.c:media_transport_acquire() Transport
>>> /org/bluez/734/hci0/dev_00_17_E3_3B_4F_DD/fd0: read lock acquired
>>> bluetoothd[734]: audio/transport.c:media_transport_acquire() Transport
>>> /org/bluez/734/hci0/dev_00_17_E3_3B_4F_DD/fd0: write lock acquired
>>> bluetoothd[734]: audio/transport.c:media_owner_create() Owner created:
>>> sender=:1.12 accesstype=rw
>>> bluetoothd[734]: audio/avdtp.c:avdtp_ref() 0x2a11d980: ref=3
>>> bluetoothd[734]: audio/a2dp.c:a2dp_sep_lock() SEP 0x2a0f1ff8 locked
>>> bluetoothd[734]: audio/avdtp.c:avdtp_ref() 0x2a11d980: ref=4
>>> bluetoothd[734]: audio/a2dp.c:setup_ref() 0x2a0efb68: ref=1
>>> bluetoothd[734]: SEP in bad state for resume
>>>
>>> In this case, the OPEN_CMD is sent to my phone, but BlueZ and my phone
>>> are in a pairing process and the phone won't reply to this until the
>>> two are paired.  Incidentally, after fixing a bug in avdtp.c,
>
> Why the pairing is being triggered only on OPEN? It should have been
> triggered for the signalling channel, this is probably why is taking
> so long to connect the transport channel.

It does appear to trigger based on the signalling channel, however it
appears that the connection process continues on regardless.  I pasted
below a log, everything in the log occurs while my phone is still
asking me if I want to pair with the BlueZ device.  We don't get
beyond the OPEN_CMD into an actual OPEN state until the pairing
process completes.

bluetoothd[498]: plugins/hciops.c:conn_complete() status 0x00
bluetoothd[498]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[498]: src/adapter.c:adapter_create_device() 00:17:E3:3B:4F:DD
bluetoothd[498]: src/device.c:device_create() Creating device
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[498]: src/device.c:btd_device_ref() 0x2a0f53c0: ref=1
bluetoothd[498]: src/device.c:device_set_temporary() temporary 1
bluetoothd[498]: plugins/hciops.c:remote_features_information() hci0 status 0
bluetoothd[498]: plugins/hciops.c:remote_name_information() hci0 status 0
bluetoothd[498]: audio/avdtp.c:avdtp_confirm_cb() AVDTP: incoming
connect from 00:17:E3:3B:4F:DD
bluetoothd[498]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[498]: src/device.c:btd_device_ref() 0x2a0f53c0: ref=2
bluetoothd[498]: audio/device.c:audio_device_register() Registered
interface org.bluez.Audio on path
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[498]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[498]: audio/manager.c:handle_uuid() server not enabled for
0000110d-0000-1000-8000-00805f9b34fb (0x110d)
bluetoothd[498]: src/agent.c:agent_authorize() authorize request was
sent for /org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[498]: plugins/hciops.c:link_key_request() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[498]: plugins/hciops.c:get_auth_info() hci0 dba 00:17:E3:3B:4F:DD
bluetoothd[498]: plugins/hciops.c:link_key_request() kernel auth
requirements = 0x04
bluetoothd[498]: plugins/hciops.c:link_key_request() Matching key not found
bluetoothd[498]: plugins/hciops.c:pin_code_request() hci0 PIN request
for 00:17:E3:3B:4F:DD
bluetoothd[498]: src/adapter.c:adapter_get_device() 00:17:E3:3B:4F:DD
bluetoothd[498]: src/device.c:device_request_authentication()
Requesting agent authentication for 00:17:E3:3B:4F:DD
bluetoothd[498]: plugins/hciops.c:hciops_pincode_reply() hci0 dba
00:17:E3:3B:4F:DD
bluetoothd[498]: audio/avdtp.c:avdtp_connect_cb() AVDTP: connected
signaling channel to 00:17:E3:3B:4F:DD
bluetoothd[498]: audio/avdtp.c:avdtp_connect_cb() AVDTP imtu=672, omtu=1024
bluetoothd[498]: audio/avdtp.c:session_cb()
bluetoothd[498]: audio/avdtp.c:avdtp_parse_cmd() Received DISCOVER_CMD
bluetoothd[498]: audio/avdtp.c:session_cb()
bluetoothd[498]: audio/avdtp.c:avdtp_parse_cmd() Received  GET_CAPABILITIES_CMD
bluetoothd[498]: audio/a2dp.c:endpoint_getcap_ind() Sink 0x2a0efb60:
Get_Capability_Ind
bluetoothd[498]: audio/avdtp.c:session_cb()
bluetoothd[498]: audio/avdtp.c:avdtp_parse_cmd() Received SET_CONFIGURATION_CMD
bluetoothd[498]: src/device.c:device_probe_drivers() Probing drivers
for 00:17:E3:3B:4F:DD
bluetoothd[498]: audio/manager.c:handle_uuid() Found Audio Source
bluetoothd[498]: audio/source.c:source_init() Registered interface
org.bluez.AudioSource on path
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD
bluetoothd[498]: audio/a2dp.c:endpoint_setconf_ind() Sink 0x2a0efb60:
Set_Configuration_Ind
bluetoothd[498]: audio/avdtp.c:avdtp_ref() 0x2a0f5558: ref=2
bluetoothd[498]: audio/a2dp.c:setup_ref() 0x2a0f5da8: ref=1
bluetoothd[498]: audio/media.c:media_endpoint_async_call() Calling
SetConfiguration: name = :1.1 path = /a2dp/endpoint
bluetoothd[498]: audio/avdtp.c:avdtp_ref() 0x2a0f5558: ref=3
bluetoothd[498]: audio/avdtp.c:avdtp_sep_set_state() stream state
changed: IDLE -> CONFIGURED
bluetoothd[498]: audio/a2dp.c:setup_unref() 0x2a0f5da8: ref=0
bluetoothd[498]: audio/a2dp.c:setup_free() 0x2a0f5da8
bluetoothd[498]: audio/avdtp.c:avdtp_unref() 0x2a0f5558: ref=2
bluetoothd[498]: audio/avdtp.c:session_cb()
bluetoothd[498]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
bluetoothd[498]: audio/a2dp.c:open_ind() Sink 0x2a0efb60: Open_Ind
bluetoothd[498]: audio/transport.c:media_transport_acquire() Transport
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD/fd0: read lock acquired
bluetoothd[498]: audio/transport.c:media_transport_acquire() Transport
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD/fd0: write lock acquired
bluetoothd[498]: audio/transport.c:media_owner_create() Owner created:
sender=:1.1 accesstype=rw
bluetoothd[498]: audio/avdtp.c:avdtp_ref() 0x2a0f5558: ref=3
bluetoothd[498]: audio/a2dp.c:a2dp_sep_lock() SEP 0x2a0efb60 locked
bluetoothd[498]: audio/avdtp.c:avdtp_ref() 0x2a0f5558: ref=4
bluetoothd[498]: audio/a2dp.c:setup_ref() 0x2a0f5da8: ref=1
bluetoothd[498]: SEP in bad state for resume
bluetoothd[498]: audio/a2dp.c:setup_unref() 0x2a0f5da8: ref=0
bluetoothd[498]: audio/a2dp.c:setup_free() 0x2a0f5da8
bluetoothd[498]: audio/avdtp.c:avdtp_unref() 0x2a0f5558: ref=3
bluetoothd[498]: audio/transport.c:media_transport_release() Transport
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD/fd0: read lock released
bluetoothd[498]: audio/transport.c:media_transport_release() Transport
/org/bluez/498/hci0/dev_00_17_E3_3B_4F_DD/fd0: write lock released
bluetoothd[498]: audio/transport.c:media_owner_free() Owner :1.1

>
>>> @@ -1520,7 +1520,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp
>>> *session, uint8_t transaction,
>>>        case AVDTP_SEP_TYPE_SINK:
>>>                if (!dev->source) {
>>>                        btd_device_add_uuid(dev->btd_dev, A2DP_SOURCE_UUID);
>>> -                       if (!dev->sink) {
>>> +                       if (!dev->source) {
>
> Yep, this seems to be a copy/paste bug from the lines right above it,
> care to send a patch?

Done.

>>> my phone will reboot itself after pairing.  I relaxed the REQ_TIMEOUT
>>> to 60 seconds, and with this change, my phone no longer reboots after
>>> pairing.  I assume that my phone gets confused that the A2DP link was
>>> disconnected during the pairing operation.
>
> 60 seconds is way too long, it should be at least smaller than D-Bus
> default timeout which is 25 sec.

What exactly is this timeout waiting for?  I haven't figured that out
yet.  I assume it's waiting on something from my phone (the a2dp
source) and not D-Bus?

>> I think I've figured out why I didn't see the SEP error print out.
>> The function resume_a2dp calls a2dp_sep_lock.  The only place this
>> ever gets unlocked is in a suspend call.  If a2dp_resume returns an
>> error code, the sep remains forever locked.  And it seems, the SEP
>> will no longer let acquire happen on future A2DP connections,
>> requiring bluetoothd to be restarted for this to work.
>
> Yep, we should be able to fix this by checking the return of
> a2dp_resume and unlock in case it does fail (return 0).
>
> --
> Luiz Augusto von Dentz
