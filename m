Return-Path: <cyrus@holtmann.org>
Message-ID: <4D7FC0D2.5080509@codeaurora.org>
Date: Tue, 15 Mar 2011 12:41:06 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Arun Raghavan <arun.raghavan@collabora.co.uk>,
	linux-bluetooth@vger.kernel.org,
	Johan Hedberg <johan.hedberg@gmail.com>
Subject: Re: Switching between SBC and MPEG audio on headsets
References: <1300199261-27481-1-git-send-email-arun.raghavan@collabora.co.uk>	<20110315170124.GA15712@jh-x301> <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
In-Reply-To: <AANLkTimF0Ux=-uQiWaWH14r3_YAuyp2o=QrmyeLkWWeT@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 3/15/2011 12:29 PM, Luiz Augusto von Dentz wrote:
> Hi,
>
> On Tue, Mar 15, 2011 at 2:01 PM, Johan Hedberg<johan.hedberg@gmail.com>  wrote:
>> Hi Arun,
>>
>> On Tue, Mar 15, 2011, Arun Raghavan wrote:
>>> I've been trying to set up PulseAudio to be able to switch the A2DP sink
>>> dynamically between SBC and MPEG modes. I've got this working now [1], but I
>>> did face one problem on the bluez side. When sending a reconfigure request, the
>>> request always goes to the SEID that was used previously (=>  always to the SBC
>>> SEID). Trying to reconfigure for MPEG therefore results the headset returning
>>> an error. I'm not very familiar with how this is supposed to work, but the
>>> patch following this mail seems to work (I can now switch back and forth
>>> between SBC and MPEG modes). It basically forces figuring out what remote SEP
>>> to talk to while reconfiguring.
>>>
>>> Is this the right approach?
>>
>> I'm not sure about the places where you set the value to NULL, but the
>> place in close_cfm which you remove isn't acceptable as such. It was
>> originally created to fix the issue reported in this thread:
>> http://marc.info/?l=linux-bluetooth&m=129190286303247&w=2
>>
>> Only a fix which doesn't break the use-case reported there can be
>> accepted upstream. FWIW, the commit that introduced the fix is de96fcd8.
>
> Also the solution should consider a transition and not dropping the
> stream completely before configuring the other, otherwise errors may
> cause a complete disconnect just to switch between endpoints. Actually
> I would suggest configuring both endpoint since the beginning so that
> we only need to suspend/resume to switch between them, but I don't
> think many headsets would be able to handle this situation.
>

I think most headsets will not support this because it would require an 
extra L2CAP connection to be maintained.

I don't think there is much of a big deal with closing the first 
endpoint relationship prior to configuring the next, becuase the AVDTP 
signaling channel will keep the underlying ACL connection open. Headsets 
I have worked on in the past would reject a SET_CONFIG if an existing 
local/remote SEID relationship already existed, not only for the extra 
resources required to maintain the extra L2CAP channel, but also because 
the SET_CONFIG is when the hw resources are reserved and configured for 
the actual PCM data stream.

And assuming that the ACL doesn't get dropped, the critical re-setup 
time is probably most bounded by the underlying hw reconfiguration, and 
not so much by the few extra small ACL pkts that need to be exchanged.

-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
