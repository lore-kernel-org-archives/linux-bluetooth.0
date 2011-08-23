Return-Path: <cyrus@holtmann.org>
Message-ID: <4E53949C.7050804@invoxia.com>
Date: Tue, 23 Aug 2011 13:53:00 +0200
From: Arnaud Mouiche <arnaud.mouiche@invoxia.com>
MIME-Version: 1.0
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: HFP gateway and new incoming connection
References: <4E528879.5080103@invoxia.com>	<20110822174912.GA21949@joana>	<CABBYNZLEkc8FWmJm9hU_n-KL2mhWeWPcUfxqX1jskH8ubU-aMw@mail.gmail.com>	<4E536DFF.8050205@invoxia.com> <CABBYNZKyb=SFcaT-MvBLCTyZiENt=8W5xdpah6jiy8JX+8=Hfg@mail.gmail.com>
In-Reply-To: <CABBYNZKyb=SFcaT-MvBLCTyZiENt=8W5xdpah6jiy8JX+8=Hfg@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 08/23/2011 01:14 PM, Luiz Augusto von Dentz wrote:
> Hi Arnaud,
>
> On Tue, Aug 23, 2011 at 12:08 PM, Arnaud Mouiche
> <arnaud.mouiche@invoxia.com>  wrote:
>> Hi,
>>
>> On 08/22/2011 09:58 PM, Luiz Augusto von Dentz wrote:
>>> [...]
>>> Yep, we have some plans to move the Agent registration to adapter
>>> path, so it gonna be per adapter. This is necessary to set the
>>> features bit properly in the record and probably gonna support both
>>> roles (with different agents). My initial idea was to use Media API,
>>> but perhaps is confusing since HFP is not entirely about audio but
>>> call control too (mostly) so perhaps we gonna have a different
>>> interface for it e.g. org.bluez.Telephony, in addition to that we are
>>> planning to pass the endpoint bus and path together in the
>>> NewConnection so the telephony agent (oFono) can communicate directly
>>> to endpoint in use (PulseAudio).
>>>
>>> Those are my plans, but none of this is set in stone and Im pretty
>>> open for ideas
>>>
>> what about using the org.bluez.Adapter / RegisterAgent API, and add:
>> - the possibility to setup multiple agents (maintain a list of agents)
>> - use the "capability" field as a filter definition to find the good agent
>> for the particular request
>> ex:
>>     audio/gateway.c::agent_sendfd() will look for a agent in the list, with a
>> "HFP" capability to send the "NewConnection" request
> I guess it would be confusing since with the same method we would have
> different types of agents which implements different interfaces, there
> is also the problem that by using Adapter interface it would have to
> be implemented in the core daemon but my intention is to maintain this
> inside the audio plugin to hook with Media API.
>
You are right. I didn't see how the core was compartmentalized from plugins.
I need took more closely to the Media API...

arnaud

