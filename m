Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZKiWUj9GsLhgdAEQodPxvZ9Le2Hn8sGVrT4tW0_ztoSCQ@mail.gmail.com>
References: <1369335511-8874-1-git-send-email-luiz.dentz@gmail.com>
 <CABBYNZJ=9eqwvmcz0xCHYpgzpwsRhjo0ickS8ruZQbUuK7h-aA@mail.gmail.com>
 <CANT-zCUNiwEm2jVn1bw8bbowZukKertp3OPAMUj63S_-9h2QTQ@mail.gmail.com> <CABBYNZKiWUj9GsLhgdAEQodPxvZ9Le2Hn8sGVrT4tW0_ztoSCQ@mail.gmail.com>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Fri, 24 May 2013 12:43:08 -0300
Message-ID: <CAMOw1v7XcE7=w6kzfeLtbBJOmvzemu6Lqn=wYs0zyUiWMod++w@mail.gmail.com>
Subject: Re: [PATCH BlueZ 1/3] audio: Remove auto_connect flag from audio-avrcp-target
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Mikel Astiz <mikel.astiz.oss@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, May 24, 2013 at 11:29 AM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Mikel,
>
> On Thu, May 23, 2013 at 11:54 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
>> Hi Luis,
>>
>> On Fri, May 24, 2013 at 2:21 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi,
>>>
>>> On Thu, May 23, 2013 at 11:58 AM, Luiz Augusto von Dentz
>>> <luiz.dentz@gmail.com> wrote:
>>>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>>>
>>>> By the time the profile is registered it is not really possible to
>>>> tell which role of AVRCP should be connected, currently this cause
>>>> a problem with headsets that normally are controllers/sink but since
>>>> it normally also has target record for features related to things like
>>>> volume control the target profile is also probed and as it currently
>>>> has the auto_connect set it would lead to the wrong profile to start
>>>> connecting.
>>>> ---
>>>>  profiles/audio/manager.c | 1 -
>>>>  1 file changed, 1 deletion(-)
>>>>
>>>> diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
>>>> index 15226e4..1518e5d 100644
>>>> --- a/profiles/audio/manager.c
>>>> +++ b/profiles/audio/manager.c
>>>> @@ -376,7 +376,6 @@ static struct btd_profile avrcp_target_profile = {
>>>>         .device_probe   = avrcp_probe,
>>>>         .device_remove  = audio_remove,
>>>>
>>>> -       .auto_connect   = true,
>>>>         .connect        = avrcp_target_connect,
>>>>         .disconnect     = avrcp_target_disconnect,
>>>>
>>>> --
>>>> 1.8.1.4
>>>
>>> This set is now pushed.
>>
>> What I don't quite get is how exactly BlueZ would ever connect AVRCP.
>> Let's say both ends are BlueZ 5. Would we trigger the connection once
>> A2DP gets connected? I'm not seeing where such a policy is currently
>> implemented.
>
> It is implemented in profiles/audio/device.c:device_avdtp_cb so it
> should connect just fine in BlueZ against BlueZ scenario, it might
> actually connect both sink and source.

I think you meant TG and CT, right?

Lucas De Marchi
