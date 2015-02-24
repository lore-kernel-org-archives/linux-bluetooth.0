Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <D54A2499-C0C9-4EC6-8550-DBACD6210842@holtmann.org>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
	<CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
	<20150223130923.GA28722@t440s.lan>
	<CAD0=r8zStMB6WVf0iGW59rS_x_+c-gmNUmG1OhhdXOatSj_amw@mail.gmail.com>
	<20150224103753.GA6088@t440s.lan>
	<CAD0=r8zzT5snvn4aa5N4FBPi1LaG8nKU47=YhHeq=4sTcKoc2Q@mail.gmail.com>
	<D54A2499-C0C9-4EC6-8550-DBACD6210842@holtmann.org>
Date: Tue, 24 Feb 2015 15:12:08 -0800
Message-ID: <CAD0=r8yw=6bNJDK1YcK4=MpBpQ=mYKpaxKKJHSFeyajAuZ_Cjw@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery method.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Feb 24, 2015 at 2:50 PM, Marcel Holtmann <marcel@holtmann.org> wrot=
e:
> Hi Jakub,
>
>>>>> Since we can't any more track multiple different discoveries within t=
he
>>>>> same application (D-Bus connection) the StopDiscovery behavior is now
>>>>> quite broken. The simplest way around that would be to add a discover=
y
>>>>> instance return parameter to StartServiceDiscovery and to have a new
>>>>> StopServiceDiscovery D-Bus method that'd take this as an input
>>>>> parameter.
>>>>
>>>> Right now each application can call StartDiscovery only once, I want
>>>> each application to be able to call StartDiscovery OR
>>>> StartFilteredDiscovery only once. This way we are completly fine with
>>>> one StopDiscovery method. If some application needs to change filter,
>>>> it can always stop and restart it's scan.
>>>
>>> Actually I remembered wrong how the current code works. I thought it wa=
s
>>> allowing multiple StartDiscovery() per app, but there's indeed a
>>> hard-coded limit of just one. Keeping this policy around would allow
>>> StopDiscovery to be used for StartDiscovery and StartServiceDiscovery
>>> alike, and each app would then only be allowed to call one of those at =
a
>>> time.
>>>
>>
>> So I want to keep the limit of one session per app, but I think that
>> app should be able to call StartServiceDiscovery multiple times, in
>> order to update it's filter without calling StopDiscovery to first
>> stop it's discovery. That would simplify filter updating for apps that
>> would have such need, and make their logic simpler.
>
> we have never done such an API design before. I am a bit reluctant to all=
ow that now. The whole API design is falling into one simple approach that =
the name of method calls and properties is pretty self explanatory. That St=
artServiceDiscovery means also additionally UpdateServiceDiscovery is not s=
omething I would consider intuitive.
>
>> Example: App wants to update it's filter. If It can't call
>> StartServiceDiscovery more than once, here are steps:
>> 1. app call StopDiscovery.
>> 2. Discovering property changed to false.
>> 3. It calls StartFilteredDiscovery with updated filter.
>> 4. Discovering property changed to true
>>
>> If calling StartFilteredDiscovery more than once is possible:
>> 1. app call StartServiceDiscovery with updated filter, filter is
>> updated internally and "Discovering" property is not updated at all.
>>
>>
>> I think I argree with all other comments from other emails. I'll
>> update documentation accordingly.
>> I'll say in doc, that StartServiceDiscovery might be called multiple
>> times, and keep only one session. If anyone doesn't argree with that
>> I'll remove that, as that's only for convinience, and doesn't really
>> affect functionality.
>
> While I just looked at this for only a few minutes, the double execution =
of StartServiceDiscovery is something that does not fell right. Why not int=
roduce UpdateServiceDiscovery or ChangeServiceDiscovery.

Ok, I'll make it so you can call StartFilteredDiscovery only once. If
you want to change filter just stop and start the filtered scan again.

>
> Regards
>
> Marcel
>
