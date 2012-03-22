Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAB7rCThwZxQQoKHfEszX3sZPpE_cp5+XS_fEBYiAmnR1n0d9Sg@mail.gmail.com>
References: <CAB7rCTiQiaFRqDOj6OGZPfTtBWSnR60ADAZimEZJ=F0Tf0-R4Q@mail.gmail.com>
	<CABBYNZLp3U9sHqiaW9xcH1f8qfrkM7t181y8NVK5L+Rwxet5jw@mail.gmail.com>
	<CAB7rCThwZxQQoKHfEszX3sZPpE_cp5+XS_fEBYiAmnR1n0d9Sg@mail.gmail.com>
Date: Thu, 22 Mar 2012 16:21:36 -0500
Message-ID: <CAB7rCTjUL2_Kae186QgXa2csf-p-cuGH2US38a7S436uBY93Pw@mail.gmail.com>
Subject: Re: media transport -- when is acquire ok to call?
From: Mike <puffy.taco@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, Mar 22, 2012 at 3:53 PM, Mike <puffy.taco@gmail.com> wrote:
> Hi Luiz,
>
> On Thu, Mar 22, 2012 at 12:18 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Mike,
>>
>> On Wed, Mar 21, 2012 at 4:02 PM, Mike <puffy.taco@gmail.com> wrote:
>>> I'm having some trouble with MediaEndpoint/MediaTransport and A2DP.
>>> When I get the "SetConfiguration" call, I wait 2 seconds and then call
>>> "Acquire", generally giving BlueZ enough time get the D-Bus interface
>>> ready to go.  However, the delay isn't always long enough.  Shown
>>> below is a time when my phone is attempting to pair with BlueZ.  The
>>> error "org.bluez.Error.NotAuthorized" is output from my application.
>>> In this case, the problem is that the audio source is still in the
>>> CONFIGURED state, not in the OPEN state.  Is there a recommended
>>> method of how long to wait before calling acquire?  Or should I rely
>>> on the AudioSource "State" property to become connected (or playing)?
>>> Is there any reason I can't get the transport when in the Configured
>>> state (does the fd not exist yet?)?  Or why is "a2dp_resume" being
>>> called on open (which is what is rejecting my acquire call)?
>>
>> In case of PA we do wait for Audio.Connected property before loading
>> the module which does call MediaTransport.Acquire, but 2 seconds is
>> too much there might be something else holding the setup, do you reply
>> right away the SetConfiguration, if you do try to Acquire while
>> bluetoothd is waiting you to reply it might fail.
>
> I do reply right away.  This is on an embedded device and it seems
> like BlueZ needs just a bit of time to get the interface ready or else
> I get 'Method "Acquire" with signature "s" on interface
> "org.bluez.MediaTransport" doesn't exist'.
>
>>> bluetoothd[751]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
>>> bluetoothd[751]: audio/a2dp.c:open_ind() Sink 0x2a0d40a8: Open_Ind
>>> bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock acquired
>>> bluetoothd[751]: audio/transport.c:media_transport_acquire() Transport
>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock acquired
>>> bluetoothd[751]: audio/transport.c:media_owner_create() Owner created:
>>> sender=:1.40 accesstype=rw
>>> bluetoothd[751]: audio/avdtp.c:avdtp_ref() 0x2a0d2a00: ref=3
>>> bluetoothd[751]: audio/transport.c:media_transport_release() Transport
>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: read lock released
>>> bluetoothd[751]: audio/transport.c:media_transport_release() Transport
>>> /org/bluez/751/hci0/dev_00_17_E3_3B_4F_DD/fd1: write lock released
>>> bluetoothd[751]: audio/transport.c:media_owner_free() Owner :1.40
>>> getting the reply from the cb failed
>>> GDBus.Error:org.bluez.Error.NotAuthorized: Operation Not Authorized
>>
>> Strange, if what you said is true why there is no "SEP in bad state
>> for resume" error? Anyway I think we can fix this by checking the
>> current state of the SEP and waiting it to go OPEN to resume, so the
>> client don't have to keep tracking of Audio.Connected.
>
> I just tried it again, as I'd seen that message before, and this time
> it was happy enough to provide that error.
>
> bluetoothd[734]: audio/avdtp.c:avdtp_parse_cmd() Received OPEN_CMD
> bluetoothd[734]: audio/a2dp.c:open_ind() Sink 0x2a0f1ff8: Open_Ind
> bluetoothd[734]: audio/transport.c:media_transport_acquire() Transport
> /org/bluez/734/hci0/dev_00_17_E3_3B_4F_DD/fd0: read lock acquired
> bluetoothd[734]: audio/transport.c:media_transport_acquire() Transport
> /org/bluez/734/hci0/dev_00_17_E3_3B_4F_DD/fd0: write lock acquired
> bluetoothd[734]: audio/transport.c:media_owner_create() Owner created:
> sender=:1.12 accesstype=rw
> bluetoothd[734]: audio/avdtp.c:avdtp_ref() 0x2a11d980: ref=3
> bluetoothd[734]: audio/a2dp.c:a2dp_sep_lock() SEP 0x2a0f1ff8 locked
> bluetoothd[734]: audio/avdtp.c:avdtp_ref() 0x2a11d980: ref=4
> bluetoothd[734]: audio/a2dp.c:setup_ref() 0x2a0efb68: ref=1
> bluetoothd[734]: SEP in bad state for resume
>
> In this case, the OPEN_CMD is sent to my phone, but BlueZ and my phone
> are in a pairing process and the phone won't reply to this until the
> two are paired.  Incidentally, after fixing a bug in avdtp.c,
>
> @@ -1520,7 +1520,7 @@ static gboolean avdtp_setconf_cmd(struct avdtp
> *session, uint8_t transaction,
>        case AVDTP_SEP_TYPE_SINK:
>                if (!dev->source) {
>                        btd_device_add_uuid(dev->btd_dev, A2DP_SOURCE_UUID);
> -                       if (!dev->sink) {
> +                       if (!dev->source) {
>
> my phone will reboot itself after pairing.  I relaxed the REQ_TIMEOUT
> to 60 seconds, and with this change, my phone no longer reboots after
> pairing.  I assume that my phone gets confused that the A2DP link was
> disconnected during the pairing operation.

I think I've figured out why I didn't see the SEP error print out.
The function resume_a2dp calls a2dp_sep_lock.  The only place this
ever gets unlocked is in a suspend call.  If a2dp_resume returns an
error code, the sep remains forever locked.  And it seems, the SEP
will no longer let acquire happen on future A2DP connections,
requiring bluetoothd to be restarted for this to work.
