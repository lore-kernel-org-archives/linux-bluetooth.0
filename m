Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4D7FC0D2.5080509@codeaurora.org>
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>
	<20110315170124.GA15712@jh-x301>
	<AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
	<4D7FC0D2.5080509@codeaurora.org>
Date: Tue, 15 Mar 2011 17:21:38 -0300
Message-ID: <AANLkTikGF8NVO5bmZkkKX1pVFMzQD5ip6FRW3bOhiZAe@mail.gmail.com>
Subject: Re: Switching between SBC and MPEG audio on headsets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Brian Gix <bgix@codeaurora.org>
Cc: Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Tue, Mar 15, 2011 at 4:41 PM, Brian Gix <bgix@codeaurora.org> wrote:
> On 3/15/2011 12:29 PM, Luiz Augusto von Dentz wrote:
>>
>> Hi,
>>
>> On Tue, Mar 15, 2011 at 2:01 PM, Johan Hedberg<johan.hedberg@gmail.com>
>>  wrote:
>>>
>>> Hi Arun,
>>>
>>> On Tue, Mar 15, 2011, Arun Raghavan wrote:
>>>>
>>>> I've been trying to set up PulseAudio to be able to switch the A2DP sink
>>>> dynamically between SBC and MPEG modes. I've got this working now [1],
>>>> but I
>>>> did face one problem on the bluez side. When sending a reconfigure
>>>> request, the
>>>> request always goes to the SEID that was used previously (=>  always to
>>>> the SBC
>>>> SEID). Trying to reconfigure for MPEG therefore results the headset
>>>> returning
>>>> an error. I'm not very familiar with how this is supposed to work, but
>>>> the
>>>> patch following this mail seems to work (I can now switch back and forth
>>>> between SBC and MPEG modes). It basically forces figuring out what
>>>> remote SEP
>>>> to talk to while reconfiguring.
>>>>
>>>> Is this the right approach?
>>>
>>> I'm not sure about the places where you set the value to NULL, but the
>>> place in close_cfm which you remove isn't acceptable as such. It was
>>> originally created to fix the issue reported in this thread:
>>> http://marc.info/?l=linux-bluetooth&m=129190286303247&w=2
>>>
>>> Only a fix which doesn't break the use-case reported there can be
>>> accepted upstream. FWIW, the commit that introduced the fix is de96fcd8.
>>
>> Also the solution should consider a transition and not dropping the
>> stream completely before configuring the other, otherwise errors may
>> cause a complete disconnect just to switch between endpoints. Actually
>> I would suggest configuring both endpoint since the beginning so that
>> we only need to suspend/resume to switch between them, but I don't
>> think many headsets would be able to handle this situation.
>>
>
> I think most headsets will not support this because it would require an
> extra L2CAP connection to be maintained.
>
> I don't think there is much of a big deal with closing the first endpoint
> relationship prior to configuring the next, becuase the AVDTP signaling
> channel will keep the underlying ACL connection open. Headsets I have worked
> on in the past would reject a SET_CONFIG if an existing local/remote SEID
> relationship already existed, not only for the extra resources required to
> maintain the extra L2CAP channel, but also because the SET_CONFIG is when
> the hw resources are reserved and configured for the actual PCM data stream.
>
> And assuming that the ACL doesn't get dropped, the critical re-setup time is
> probably most bounded by the underlying hw reconfiguration, and not so much
> by the few extra small ACL pkts that need to be exchanged.

The problem is that the audio routing is broken if the new stream
configuration fails, and even if sbc stream is configured latter it
may not be recovered and some audio maybe lost of rerouted to the
speakers which I believe is not the best experience for users.

Also we only need another connection in case of AVDTP_Open is sent,
this sound more a limitation of some implementation than a avdtp/a2dp
problem, the problem with disconnect is that if the stream setup fails
the session reference is dropped and the session is released (avdtp
signalling) so right now we have no means to hold the ACL link if
nothing else is connected e.g. hfp, we could in theory fix this by
having a setup which revert to the last configuration if the new one
fails but I fear this would required a special API to applications be
able to tells us when this is necessary.

-- 
Luiz Augusto von Dentz
Computer Engineer
