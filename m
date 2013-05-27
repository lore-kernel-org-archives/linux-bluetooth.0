Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CANT-zCX-f8+cnhGLCPgVcRV3B5shLmaS=pQyRs8AJR0Y41dYBg@mail.gmail.com>
References: <1369301309-25189-1-git-send-email-mikel.astiz.oss@gmail.com>
	<CABBYNZ+1baqBJRNgY9a_4soZ5o3oWK_jfSv=7RqMAkJtz=BP7w@mail.gmail.com>
	<CABBYNZJA0C2r-4Y=fd6V_g115ZHyDxmN=9vUCE=HYepMncWKVQ@mail.gmail.com>
	<CANT-zCV-3LYVWnsCz+wfaAKqQVj3Fx-Dq0i3zXMiojV2Cyzzrw@mail.gmail.com>
	<CABBYNZLL4T-+=aX_47R-BnuC+gO5MYoUJUD4keYt+XrC1kG-WQ@mail.gmail.com>
	<CANT-zCX-f8+cnhGLCPgVcRV3B5shLmaS=pQyRs8AJR0Y41dYBg@mail.gmail.com>
Date: Mon, 27 May 2013 06:07:00 -0700
Message-ID: <CABBYNZJjXedjx1Qjn_QDSO-szcCkj=QAVGC4eaKBbWv+Fw5Pcg@mail.gmail.com>
Subject: Re: [PATCH BlueZ v0 0/4] AVRCP connection-tracking issues
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Alex Deymo <deymo@chromium.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Sun, May 26, 2013 at 2:30 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> Hi Luiz,
>
> On Sat, May 25, 2013 at 2:56 AM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi Mikel,
>>
>> On Fri, May 24, 2013 at 12:05 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>> Hi Luis,
>>>
>>> On Thu, May 23, 2013 at 6:45 PM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> Hi Mikel,
>>>>
>>>> On Thu, May 23, 2013 at 9:21 AM, Luiz Augusto von Dentz
>>>> <luiz.dentz@gmail.com> wrote:
>>>>> Hi Mikel,
>>>>>
>>>>> On Thu, May 23, 2013 at 2:28 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>>>>>> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>>>>>>
>>>>>> This patchset addresses the issues reported by Alex Deymo in the thread "audio: Connect doesn't return when audio device is off". Extracted from his message:
>>>>>>
>>>>>> "There are two ways to hit this problem:
>>>>>> * One is to attempt a connection when the device is off,
>>>>>> * the other one is to attempt a connection from the host right after
>>>>>> you short press the button with the bluetooth logo on the speakers.
>>>>>> This button normally reconnects the speakers to the host, but if you
>>>>>> attempt a connection while the device is also doing that, you end up
>>>>>> in the same situation."
>>>>>>
>>>>>> I have been able to reproduce the first issue, which should be fixed with patch 1/4. The second issue is addressed in patch 3/4 but I couldn't actually test it.
>>>>>>
>>>>>> Patch 4/4 tries to improve the AVRCP role heuristic, which could alone fix Alex's issues, but I think the core cannot rely on this heuristic nevertheless.
>>>>>>
>>>>>> Mikel Astiz (4):
>>>>>>   avrcp: Fix missing reply to profile connect
>>>>>>   control: Remove unused parameter
>>>>>>   avrcp: Fix service connections not reported to core
>>>>>>   avrcp: Don't require active sink in role heuristic
>>>>>>
>>>>>>  profiles/audio/avrcp.c   | 17 ++++-------------
>>>>>>  profiles/audio/control.c | 37 +++++++++++++++++++++++++++----------
>>>>>>  profiles/audio/control.h |  7 +++----
>>>>>>  3 files changed, 34 insertions(+), 27 deletions(-)
>>>>>>
>>>>>> --
>>>>>> 1.8.1.4
>>>>>
>>>>> By looking at your patch 2/4 it seems we are not able to really tell
>>>>> if a connection attempt has failed anymore, so I think there is
>>>>> probably something wrong. The host down error should probably stop
>>>>> continuing connection whenever it fails the first time, the issue with
>>>>> the connection clash is probably different though and perhaps we
>>>>> should go ahead with the heuristic fix and see if that fixes all the
>>>>> problems.
>>>>>
>>>>> @Alex: Can you test the last patch from Mikel for the second issue
>>>>> with the remote device connecting to us while we are connecting to it?
>>>>> The host down I think Johan has been working on that and we should
>>>>> have a patch soon.
>>>>
>>>> Actually let me take it back, the heuristic fix actually doesn't do
>>>> anything since we already have the same check four line above this
>>>> should never happen. A potential fix is to remove auto_connect from
>>>> avrcp_target_profile so if sink fails to connect it won't connect
>>>> automatically, anyway when the sink connects device.c will make sure
>>>> to connect avrcp as well.
>>>>
>>>> --
>>>> Luiz Augusto von Dentz
>>>
>>> You're right, the last patch doesn't help at all. What about the first
>>> three? Even if the originally reported issue seems to be fixed now, I
>>> think the change still makes sense.
>>>
>>> The issue might now be hidden because Device.Connect() doesn't connect
>>> AVRCP, but I believe you could still hit the issue with
>>> Device.ConnectProfile() assuming that the role heuristic makes a wrong
>>> guess.
>>
>> In that case I would like to remove the heuristic for outgoing
>> connections using the service when it attempt to connect, so I would
>> like to wait you to complete the service code so I can remove a lot of
>> code in the audio including the audio_dev and perhaps deprecate
>> MediaControl interface in favor of Service, this would leave the
>> heuristic only for incoming connections where the heuristic is
>> necessary to figure out which role the remote device is expecting.
>
> I consider the core service infrastructure finished, with the
> exception of the D-Bus part which I already submitted as RFC. There
> might still be issues to fix (as recently reported by Vinicius and
> Christian) but this is more about profile-specific adoption of
> btd_service.
>
> Regarding the audio part, there's definitely room for simplification
> by exploiting new features of the core. Some ideas I have in mind are:
>
> 1. Register btd_profile (and therefore btd_service) instances for
> UUIDs like AVDTP and AVCTP. This would presumably simplify the
> connection logic a lot, but it might also require some additional core
> support in order to handle disconnections properly (i.e. disconnect
> AVDTP when all users have finished, in this case with a delay).

It could be a good idea, but Im not sure it would work because we are
only using the service classes, but perhaps internally we can add
those UUIDs but they should probably not be exposed to the
applications.

> 2. Exploit btd_service's userdata to avoid maintaining internal lists
> and associations. This should be fairly easy and specially interesting
> after (1), making for example avdtp_get_internal() trivial.

This should be fine provided with can do (1).

> 3. Extend btd_service_state_t with BTD_SERVICE_STATE_ACTIVE (i.e.
> "Service is using a considerable bandwidth"), which would map to
> PLAYING for many audio profiles. I don't have a strong opinion on this
> one since the concept might not be generic enough to be adopted in the
> core. For example, it might make sense for networking profiles (i.e.
> an active connection exists) but on the contrary the HID profile would
> make little use of this state.

I would't have this extra state in the service, it is too profile
specific, what we really want is that the core takes care of
connection logic but the underlining signalling/data stream is profile
specif so it is better to leave the plugins/external profiles to
handle.

> 4. Assuming (1) and (3) are acceptable, remove all internal
> audio-specific states and their callbacks (e.g. source_state_t,
> sink_state_t, avdtp_session_state_t...) and replace them with the core
> btd_service states.

Sink and Source state will probably remain due to A2DP design of
Suspend/Start, but the other can probably be removed in favor of
service states.

> 5. Extend the core with something like btd_server, which is analogous
> to btd_service but representing local profile implementations. This is
> an orthogonal discussion but I believe the audio profiles could
> benefit a lot from this infrastructure as well.

Well ultimately I would like to have the core doing the connection
management for plugins as it does for external profiles, perhaps this
is your idea with btd_server as well, but for that to happen we would
need a bit more logic for handling records that have several PSMs to
be listen or those that can receive multiple connections such as A2DP.


--
Luiz Augusto von Dentz
