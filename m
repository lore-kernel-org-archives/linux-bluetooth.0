Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20110822174912.GA21949@joana>
References: <4E528879.5080103@invoxia.com>
	<20110822174912.GA21949@joana>
Date: Mon, 22 Aug 2011 22:58:40 +0300
Message-ID: <CABBYNZLEkc8FWmJm9hU_n-KL2mhWeWPcUfxqX1jskH8ubU-aMw@mail.gmail.com>
Subject: Re: HFP gateway and new incoming connection
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Arnaud Mouiche <arnaud.mouiche@invoxia.com>,
	linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Aug 22, 2011 at 8:49 PM, Gustavo Padovan <padovan@profusion.mobi> wrote:
> * Arnaud Mouiche <arnaud.mouiche@invoxia.com> [2011-08-22 18:48:57 +0200]:
>
>> Hi all.
>>
>> I'm currently playing with the HFP unit role provided by bluez (ie.
>> what is related to audio/gateway.c)
>> No problem concerning the connection to a HFP gateway (ie. GSM most
>> of the time).
>>
>> I have more concern with the reverse side, to accept incoming HFP
>> connection, as, obviously I didn't get time to register a "Handsfree
>> agent" for the particular new connecting device, at the proper time.
>>
>> Today, I'm using bluez v4.95, but no real difference with the
>> upstream for this case.
>> Also, I didn't plan to use oFono.... even if it is great piece of software.
>>
>> I also saw a discussions concerning the initial design in the
>> mailling list :
>> http://marc.info/?l=linux-bluetooth&m=126390401614859&w=2
>>
>> _My questions:_
>> 1) does this design is today "set in stone" ?
>
> Not sure, we just changed it to add HFP version information.
>
>>
>> 2) It seems the only ways to register an agent at the proper time are:
>> - to trace creation of new devices, and try to register an agent at
>> this time.
>>   But what if the device doesn't show HFP SDP record when connection
>> for the first time, and activate it later ?
>>   Any race conditions ?
>
> You should listen to DBus UUID property change for the device in the Agent
> side. Check the bluetooth plugin inside oFono to learn how to implement that.
>
>> or
>> - collect the authorization request in the adapter user agent, when
>> "audio_device_request_authorization" is called.
>> So it means that the user agent must forward request concerning the
>> HFP uuid to the HFP service.
>>
>> True ?
>>
>> 3) What do you think of the possibility to set a "adapter based"
>> Handsfree agent, and use it when there is no "device based" handsfee
>> argent matching ?
>
> I think Luiz also wants that. Luiz?

Yep, we have some plans to move the Agent registration to adapter
path, so it gonna be per adapter. This is necessary to set the
features bit properly in the record and probably gonna support both
roles (with different agents). My initial idea was to use Media API,
but perhaps is confusing since HFP is not entirely about audio but
call control too (mostly) so perhaps we gonna have a different
interface for it e.g. org.bluez.Telephony, in addition to that we are
planning to pass the endpoint bus and path together in the
NewConnection so the telephony agent (oFono) can communicate directly
to endpoint in use (PulseAudio).

Those are my plans, but none of this is set in stone and Im pretty
open for ideas

-- 
Luiz Augusto von Dentz
