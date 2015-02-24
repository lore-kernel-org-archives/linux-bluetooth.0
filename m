Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150224103753.GA6088@t440s.lan>
References: <1423528495-13173-1-git-send-email-jpawlowski@google.com>
	<CABBYNZLaFta8897Xr91UQ-sUy-COviXxRP84GKTyYSUQDfDjyg@mail.gmail.com>
	<20150223130923.GA28722@t440s.lan>
	<CAD0=r8zStMB6WVf0iGW59rS_x_+c-gmNUmG1OhhdXOatSj_amw@mail.gmail.com>
	<20150224103753.GA6088@t440s.lan>
Date: Tue, 24 Feb 2015 12:23:55 -0800
Message-ID: <CAD0=r8zzT5snvn4aa5N4FBPi1LaG8nKU47=YhHeq=4sTcKoc2Q@mail.gmail.com>
Subject: Re: [PATCH BlueZ v5] doc/adapter-api.txt: StartFilteredDiscovery method.
From: Jakub Pawlowski <jpawlowski@google.com>
To: Jakub Pawlowski <jpawlowski@google.com>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
	Arman Uguray <armansito@chromium.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

On Tue, Feb 24, 2015 at 2:37 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> Hi Jakub,
>
> On Mon, Feb 23, 2015, Jakub Pawlowski wrote:
>> > Since we can't any more track multiple different discoveries within the
>> > same application (D-Bus connection) the StopDiscovery behavior is now
>> > quite broken. The simplest way around that would be to add a discovery
>> > instance return parameter to StartServiceDiscovery and to have a new
>> > StopServiceDiscovery D-Bus method that'd take this as an input
>> > parameter.
>>
>> Right now each application can call StartDiscovery only once, I want
>> each application to be able to call StartDiscovery OR
>> StartFilteredDiscovery only once. This way we are completly fine with
>> one StopDiscovery method. If some application needs to change filter,
>> it can always stop and restart it's scan.
>
> Actually I remembered wrong how the current code works. I thought it was
> allowing multiple StartDiscovery() per app, but there's indeed a
> hard-coded limit of just one. Keeping this policy around would allow
> StopDiscovery to be used for StartDiscovery and StartServiceDiscovery
> alike, and each app would then only be allowed to call one of those at a
> time.
>

So I want to keep the limit of one session per app, but I think that
app should be able to call StartServiceDiscovery multiple times, in
order to update it's filter without calling StopDiscovery to first
stop it's discovery. That would simplify filter updating for apps that
would have such need, and make their logic simpler.

Example: App wants to update it's filter. If It can't call
StartServiceDiscovery more than once, here are steps:
1. app call StopDiscovery.
2. Discovering property changed to false.
3. It calls StartFilteredDiscovery with updated filter.
4. Discovering property changed to true

If calling StartFilteredDiscovery more than once is possible:
1. app call StartServiceDiscovery with updated filter, filter is
updated internally and "Discovering" property is not updated at all.


I think I argree with all other comments from other emails. I'll
update documentation accordingly.
I'll say in doc, that StartServiceDiscovery might be called multiple
times, and keep only one session. If anyone doesn't argree with that
I'll remove that, as that's only for convinience, and doesn't really
affect functionality.


> Johan
