Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+-dMtZ+EnzFQZcPBBTh91nMA7WUdTTmfeRKDxcagwgww@mail.gmail.com>
References: <1361284436-4584-1-git-send-email-luiz.dentz@gmail.com>
	<CANT-zCUNV3cdEd6FR0psubCYn25nUO8on0bTmV=+ZVgCSiSMAA@mail.gmail.com>
	<CABBYNZ+-dMtZ+EnzFQZcPBBTh91nMA7WUdTTmfeRKDxcagwgww@mail.gmail.com>
Date: Wed, 20 Feb 2013 14:37:51 +0100
Message-ID: <CANT-zCVPDBd2EETq-q4Zok+XO--ZyRY-kdWoynYYszwB7vKBLw@mail.gmail.com>
Subject: Re: [RFC BlueZ 1/2] A2DP: Mark start flag if resume happen while in
 configured state
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Tue, Feb 19, 2013 at 4:30 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Tue, Feb 19, 2013 at 5:06 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> Hi Luiz,
>>
>> On Tue, Feb 19, 2013 at 3:33 PM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>
>>> If SEP is in configured state that means OPEN is about to happen so just
>>> mark start flag and send START once OPEN completes.
>>> ---
>>>  profiles/audio/a2dp.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>>  1 file changed, 54 insertions(+)
>>>
>>> diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
>>> index f1646ee..d9680a7 100644
>>> --- a/profiles/audio/a2dp.c
>>> +++ b/profiles/audio/a2dp.c
>>> @@ -336,6 +336,20 @@ static struct a2dp_setup *find_setup_by_dev(struct audio_device *dev)
>>>         return NULL;
>>>  }
>>>
>>> +static struct a2dp_setup *find_setup_by_stream(struct avdtp_stream *stream)
>>> +{
>>> +       GSList *l;
>>> +
>>> +       for (l = setups; l != NULL; l = l->next) {
>>> +               struct a2dp_setup *setup = l->data;
>>> +
>>> +               if (setup->stream == stream)
>>> +                       return setup;
>>> +       }
>>> +
>>> +       return NULL;
>>> +}
>>> +
>>>  static void stream_state_changed(struct avdtp_stream *stream,
>>>                                         avdtp_state_t old_state,
>>>                                         avdtp_state_t new_state,
>>> @@ -344,6 +358,29 @@ static void stream_state_changed(struct avdtp_stream *stream,
>>>  {
>>>         struct a2dp_sep *sep = user_data;
>>>
>>> +       if (new_state == AVDTP_STATE_OPEN) {
>>> +               struct a2dp_setup *setup;
>>> +               int err;
>>> +
>>> +               setup = find_setup_by_stream(stream);
>>> +               if (!setup || !setup->start)
>>> +                       return;
>>> +
>>> +               setup->start = FALSE;
>>> +
>>> +               err = avdtp_start(setup->session, stream);
>>> +               if (err < 0 && err != -EINPROGRESS) {
>>> +                       error("avdtp_start: %s (%d)", strerror(-err), -err);
>>> +                       finalize_setup_errno(setup, err, finalize_resume,
>>> +                                                                       NULL);
>>> +                       return;
>>> +               }
>>> +
>>> +               sep->starting = TRUE;
>>> +
>>> +               return;
>>> +       }
>>> +
>>
>> Shouldn't you handle the error case here? Any other transition from
>> AVDTP_STATE_CONFIGURED should probably be considered a failure.
>
> The failure case is where OPEN fails, which is handled by open_ind and
> open_cfm, or if stream connection timeout which will generate an ABORT
> that takes care of terminating the setup.
>
>>>         if (new_state != AVDTP_STATE_IDLE)
>>>                 return;
>>>
>>> @@ -661,6 +698,12 @@ static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
>>>
>>>         finalize_config(setup);
>>>
>>> +       if (!setup->start || !err)
>>> +               return TRUE;
>>> +
>>> +       setup->start = FALSE;
>>> +       finalize_resume(setup);
>>> +
>>>         return TRUE;
>>>  }
>>>
>>> @@ -689,6 +732,14 @@ static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
>>>         }
>>>
>>>         finalize_config(setup);
>>> +
>>> +       if (!setup->start || !err)
>>> +               return;
>>> +
>>> +       setup->start = FALSE;
>>> +       finalize_resume(setup);
>>> +
>>> +       return;
>>>  }
>>>
>>>  static gboolean suspend_timeout(struct a2dp_sep *sep)
>>> @@ -1718,6 +1769,9 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
>>>         case AVDTP_STATE_IDLE:
>>>                 goto failed;
>>>                 break;
>>> +       case AVDTP_STATE_CONFIGURED:
>>> +               setup->start = TRUE;
>>> +               break;
>>>         case AVDTP_STATE_OPEN:
>>>                 if (avdtp_start(session, sep->stream) < 0) {
>>>                         error("avdtp_start failed");
>>> --
>>
>> This alternative has the obvious advantage of not introducing an
>> additional state to the transport and simpler APIs are generally good.
>>
>> However, I see little benefit in the client's side and the
>> implementation gets a bit tricky in the server's side (BlueZ and
>> oFono).
>>
>> I'd personally prefer to go simple and make this state explicit,
>> instead of trying to internally defer the operation.
>
> I don't see this as being so complicated, in fact it is probably less
> code than having to deal with another state because nothing has to be
> changed in the clients, start flag is actually already there in case
> the client resume while we are waiting for suspend to complete and for
> HFP there is probably no  mapping to configuring state since the SCO
> configuration is managed by the kernel.

Ack from my side.

Cheers,
Mikel
