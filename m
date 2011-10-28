Return-Path: <cyrus@holtmann.org>
Message-ID: <4EAAD61B.60600@codeaurora.org>
Date: Fri, 28 Oct 2011 09:19:39 -0700
From: Brian Gix <bgix@codeaurora.org>
MIME-Version: 1.0
To: "Ganir, Chen" <chen.ganir@ti.com>
CC: Anderson Lizardo <anderson.lizardo@openbossa.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Mat Martineau <mathewm@codeaurora.org>,
	Claudio Takahasi <claudio.takahasi@openbossa.org>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	"ingas@codeaurora.org" <ingas@codeaurora.org>
Subject: Re: GATT Dbus API on BlueZ - attirbute-api.txt modifications
References: <1319497579-8859-1-git-send-email-pkrystad@codeaurora.org>	<4EA6143E.4000606@googlemail.com>	<7769C83744F2C34A841232EF77AEA20C01DCAA8D28@dnce01.ent.ti.com>	<CAKT1EBeJB2FDrv6Xp_bGV3eFDEe5ecvnBN0rKniYxw5++Q9NfA@mail.gmail.com>	<7769C83744F2C34A841232EF77AEA20C01DCAA8F85@dnce01.ent.ti.com>	<CAKT1EBcd6dQq3bzOsW3Fuwv=d8J=yDvsJjbp_ELEAQUjfyRx9g@mail.gmail.com>	<7769C83744F2C34A841232EF77AEA20C01DCAA9265@dnce01.ent.ti.com>	<alpine.DEB.2.02.1110270003090.30044@mathewm-linux>	<7769C83744F2C34A841232EF77AEA20C01DCBC3F03@dnce01.ent.ti.com>	<CABBYNZ+Hq4-AAg3TsLi-Vh0eC2p_ZtD2vthBfc3Unww+Km6-Mg@mail.gmail.com> <CAJdJm_Po7iAOoB673XW6D3gTsCn_ME8CHEo0VcWzi5FKX9xghA@mail.gmail.com> <7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
In-Reply-To: <7769C83744F2C34A841232EF77AEA20C01DCBC41E0@dnce01.ent.ti.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chen, Anderson, Luiz,

On 10/27/2011 8:06 AM, Ganir, Chen wrote:
> Anderson,Luiz,
>
>>
>> Regarding caching reads and writes, the way LE works from my POV is
>> that most devices (except ones which rely on Proximity Link Loss) will
>> have Link Supervision Timeout of a few seconds at least. I have
>> already seen devices with 30 seconds LSTO.
>>
>> For these high latency devices (which use conservative connection
>> parameters for saving battery) some caching is good. But we should
>> provide ways to let the D-Bus API user know whether the data has
>> effectively been written, or updated locally. This can be done by
>> means of D-Bus signals. Which point us back to the reason why we have
>> Value as a property in the first place.
>>
>> Also imagine that the API might allow a couple of D-Bus clients
>> talking to the same device, but using different services. In case of
>> temporary link loss (or high latency), the values should be kept by
>> BlueZ, which will then write the value once connection is restored.
>> Otherwise, you would see many D-Bus clients trying to read/write data
>> while the link is not ok.
>>
> Caching seems very wrong to me. A client expects the correct data from the server, and not something that is not correct. Why provide a cached value instead of notifying the client that the link is down ? What if the server changes the value, and the client keeps getting the wrong value ? I believe the client should be notified if the link is down and there is an error reading the correct value.
>
> Regarding the multiple client scenario - Since dbus is still not my expertise, I would be happy to get some ideas here - currently the function is blocking. It means that it will not return until the server replies or the link is down. I assume that the dbus daemon will queue multiple requests to allow bluetoothd to handle each one at it's turn ? If this is not the case, I would be happy if someone could elaborate on this and highlight the correct usage in multiple client scenario.
>

I am also of the opinion that caching is the wrong thing to do in 
bluez/bluetoothd.

Caching should only be done when there is established knowledge by 
entity doing the caching, that the data persists.  There are a few cases 
where this is known to be true, such as device/manufacturer text 
strings, but for the vast majority of characteristics that have already 
been invented, and will be invented in the future bluez should have no 
privledged knowledge of.

Temperature readings of course are the perfect example of why we don't 
want to make caching the default behavior.

As to moving forward towards more characteristic definitions and 
profiles, a do not think that by not caching, we will create the "poll 
fest" situation that Luiz fears. Applications that have been written 
with LE in mind should be the place where characteristic specific 
knowledge, such as persistence of data over time, should be.  An App 
that repeatedly polls a persistent characteristic value would be poorly 
written (the App should do it's own caching). In the unlikely event that 
Multiple Apps are sharing the same remote server (which as a LE Use 
Case, I would consider Rare) you are only increasing the Reads of 
persistent data on a 1 per App basis.

But we should NOT cache values simply as a way to protect ourselves from 
poorly behaving (excessively polling) Apps.

Unless we could convince the BT Sig to add a Persistent Property 
(perhaps to the Extended Property mask) I would not do any caching in 
bluez, with the exception of a few known Characteristrics (such as in 
the GATT and GAP service) that bluez itself directly is the "client".





>>
>> Luiz, while I totally agree with the D-Bus error instead of return
>> value (and you know about this stuff better than me :), how could we
>> pass the "custom"  ATT error codes to the client? Any profile can
>> define their own ATT error codes, and BlueZ cannot know all of them.
>>
> This is why I wanted it to be integer.
>
>
>>>
>>> Create an array of string WriteMethods which represents the methods
>>> supported by the characteristic.
>>
>> Agreed. They are readonly anyway. and makes it easier to extend.
>>
>> I would just go with "SupportedWriteMethods" of something like that :)
>> (but it is a detail).
>>
> I also agree here. This property will be changed to writableMethods string array, with string>Boolean dictionary.
>
> Thanks for your comments so far.
>
> Chen Ganir.
>


-- 
Brian Gix
bgix@codeaurora.org
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum
