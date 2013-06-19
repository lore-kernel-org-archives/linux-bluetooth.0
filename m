Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [RFC BlueZ v2 00/13] Add experimental org.bluez.Service1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANT-zCXX=_yLBO6FrS=apKbNRRW1JapTdYb5ZxXJPXpDuZ0rPQ@mail.gmail.com>
Date: Wed, 19 Jun 2013 23:13:30 +0200
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Message-Id: <5F39B162-EA03-4E3C-A3C6-0B4C291BB47C@holtmann.org>
References: <1371020815-22330-1-git-send-email-mikel.astiz.oss@gmail.com> <83E493B1-AE4F-4EE1-8111-4CD2AA71B9AD@holtmann.org> <CANT-zCUXE0vb69+qrhG3M5viH-kK2z9pWdOpQTa-ECgPXM=xNg@mail.gmail.com> <D272DE8B-0B15-41AE-9B8D-457642CF9763@holtmann.org> <CANT-zCXX=_yLBO6FrS=apKbNRRW1JapTdYb5ZxXJPXpDuZ0rPQ@mail.gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

>>>>> Beyond the desktop use-cases, some users (e.g. GENIVI) are interested in having profile-specific information and control interfaces exposed in D-Bus. Such APIs did exist in BlueZ 4 but were dropped for BlueZ 5 in favor of simpler API simplicity. This service-specific interfaces had a fairly low priority for BlueZ 5 and therefore the discussion was postponed.
>>>>> 
>>>>> This patchset proposes org.bluez.Service1 as an attempt to cover these needs. As compared to the former Device.ConnectProfile()/DisconnectProfile(), the approach has the following advantages:
>>>>> - Multiple instances of the same UUID can be exposed.
>>>> 
>>>> how is this going to help anyone. I you do not know what your service object is, what are you planning to do with it.
>>> 
>>> See list below for a summary of real use-cases.
>>> 
>>>> 
>>>>> - The state of each service can be exposed, without hackish lists like Device.ConnectedProfiles.
>>>> 
>>>> Again, here I want to see clear example on why you want all these states. Everybody takes about wanting all the crazy interim states and then never ever uses any of them.
>>> 
>>> Many well-known UIs show this information (i.e. which profiles are
>>> connected), including IVI examples or even the Android UI. A new
>>> property such as "Device1.ConnectedProfiles" could be introduced but
>>> see below for arguments against this approach.
>> 
>> and many well-known UIs do not show this information. So what is the point exactly here. Maybe some UIs need to be brought into 2013 and being stuck in what we did 6 years ago.
> 
> This should be a UI decision IMO, not something BlueZ should impose
> unless it's widely accepted.

I am pretty much against displaying pointless information that nobody can use anyway. If my parents can not make sense out of it, they should not be there. If a non-tech person has no idea what all this crazy profile talk means, then it should not be there. This is my simplicity approach here.

The goal should be to provide a solution that just works and not 100 knobs to tweak it around like a crazy monkey.

>> My question however was not about if a profile is connected or not, my question was why we always end up with stupid interim states like "connecting".
> 
> I'm completely fine dropping the 'connecting' state, which I already
> suggested to Johan.
> 
>> 
>>>>> - It's ObjectManager-centric.
>>>>> - The design should scale better if new properties are required in the future (supported features, service handle, etc.)
>>>> 
>>>> I don't think this actually will scale that nicely. There are limited set of common properties for all these profiles. I am really curious to see how this is going to be used and how it would improve things for applications.
>>> 
>>> The currently existing API hits its limits very soon, even if a
>>> property such as "Device1.ConnectedProfiles" was introduced. Besides
>>> the multiple-UUID-instances case, assume the following potential
>>> scenarios:
>>> 
>>> 1. That a user-setting (enabled/disabled) needs to be exposed per
>>> service (or UUID), just like Android does. And I don't think you want
>>> to have a Device1.EnabledProfiles property.
>> 
>> I still do not agree with the fact that we need to disable profiles. However first order of business before I even consider allowing something like this is that we interop with ourselves on profiles (SDP record) updates and I have not seen anybody trying to handle this.
> 
> We're not talking about changing the SDP record here, just about
> disconnecting profiles (and rejecting incoming connections). This is
> what Android does and also our cars (generally speaking).

You brought up enabling and disabling profiles. And even if you just reject new connections, it is the same discussion. Actually having the record and the profile not available is even worse. There is also a attribute for showing profile availability details.

My major point is that we need to improve the way we deal with the situations when SDP databases change or single attributes of a record change. It seems something that everybody wants to swipe under the rug.

What I am saying is that if you want to do anything like this in this area, then there are 2 things that need to be done.

a) We need to update BlueZ to handle this gracefully since we want to interop with ourselves at least.

b) Check what other major Bluetooth stack from major OSes are doing in this area. And more important document their behavior. So how does iOS deal with PAN, PBAP and MAP rejections. Are they indicating them in the SDP record. How about Android, how about Windows, how about OS X.

We do a lot of handwaving and wanting to add new APIs, but we do not have enough data to judge what is really needed as a configuration option and what can just be done automatically. The lazy way out by just adding a new property or option is never something that I agree to likely. Feel free to proof me wrong. You have all the tools in your hand to document the behavior of other stacks.

>>> 2. That the 'connecting' state needs to be exposed in D-Bus. You'd
>>> otherwise need something like Device1.ConnectingProfiles.
>> 
>> My point is that we do not need the connecting state at all. What is it good for?
> 
> This is an advanced topic and as I said, I would be fine dropping this
> right now.
> 
>> 
>>> 3. That a D-Bus clients needs to know if a UUID is connectable,
>>> meaning not only supported but also probed (e.g. for "hfp", to
>>> distinguish whether oFono is running). You'd otherwise need something
>>> like Device1.ProbedProfiles.
>> 
>> Has this really been thought through. What happens if a Device1.Connect is triggered and then oFono starts later on. What is the expected behavior here?
> 
> Your questions needs to be answered regardless of org.bluez.Service1.
> In a similar way, crashes in oFono could be handled by reconnecting
> the profile automatically. I don't see this coupled in any way to this
> proposal.
> 
> My point here was that the proposed D-Bus interface could express this
> information nicely, in case the caller of ConnectProfile() knows it
> will surely fail.

We never intended for ConnectProfile to be used that much. I assumed we just have Device1.Connect and then let BlueZ handle the rest. Individual profile connections were just for profiles without auto-connect.

>>> 4. That a human-friendly name needs to be exposed in D-Bus per service
>>> (this seemed to be an argument in favor of the Network1 interface).
>> 
>> And what name is that exactly? How do you handle translation?
> 
> A translation is also needed for profile-specific D-Bus interfaces.
> You need to know that the UUID of PAN translates to
> "org.bluez.Network1".
> 
> Having said this, I'm not particularly in favor of doing this. D-Bus
> interfaces should be compact and without redundancies.

Of course you need to know which UUID translate to which interface. However that is not what I am talking about. You mention a human-friendly name. That name needs to be translatable if it represents something in a human language.

>>> 5. That additional remote information needs to be exposed, such as
>>> profile version or supported features.
>> 
>> For what usage?
> 
> To show this in the UI, in some advanced tab, or as part of a debugging tool.

The D-Bus API we have is not really a debug tool API. It is a main consumer UI.

Why would be an advanced tab a good idea. Who would be using such an advanced tab.

>>> Having an object-oriented Service1 API is IMO much cleaner as opposed
>>> to a sparse interface consisting of methods like
>>> ConnectProfile()/DisconnectProfile() along with properties like
>>> "ConnectedProfiles"/"ConnectingProfiles"/"EnabledProfiles"/"ProbedProfiles"
>>> which btw are string lists, therefore not very client-friendly.
>>> 
>>> All these needs would be nicely addressed by a generic service D-Bus
>>> interface as proposed here. Note that some of the points above are
>>> real IVI requirements, and we're in fact having trouble to upgrade to
>>> BlueZ 5 due to API limitations. Some others might not be required
>>> after all or might have different workarounds, but I think it's fair
>>> enough to claim that the approach can scale better.
>> 
>> If you need special interfaces, there is always the possibility of a vendor plugin using com.bmw or org.genivi interfaces.
> 
> Generally speaking, I don't think it's a good idea to encourage
> plugins to expose custom D-Bus API extensions. Unless it's a very
> specific feature which nobody else could ever benefit from, which I
> don't think is the case.
> 
> Regarding genivi specifically, there's no way a consortium will pick
> up an API that is not part of the official release.

That is hilarious :)

> Marking the interface as experimental already makes it non-stable and
> non-default so I don't see why it should be so controversial to merge
> it upstream. The code is fairly non-intrusive.

It is not about how intrusive or non-intrusive the code is. The extra interface must make sense for more than one user.

>>>> My initial take is still that just calling a general Device1.Connect or requesting a connect to a UUID is useful. Everything else is pretty much application specific anyway.
>>>> 
>>>> You can always add profile specific interfaces. Like we do with Network1. Why are you saying your approach is more object manager centric.
>>> 
>>> As argued above, it's presumably more object-oriented and therefore
>>> more ObjectManager-centric.
>>> 
>>> Adding interfaces such as Network1 is IMO a step back in the direction
>>> to BlueZ 4 APIs, probably biased by the fact that the same developer
>>> community is involved in Connman. Recent commits
>>> (0624791ea6e917d6c9ecb8e7e6e5a1327199448d) mention  that the
>>> Connect/Disconnect interface was brought back "for convenience", which
>>> should not be the driving factor when designing D-Bus APIs. This very
>>> same argument was in fact used to drop "convenience" APIs such as
>>> org.bluez.Manager (commit 86a7b07c22f3a595ba3c48092359287905bf0878).
>>> 
>>> The Network1 interface could be easily deprecated in favor of a more
>>> generic Service1 interface. If we're going to introduce interfaces
>>> such as Headset1 etc., we should have stayed with BlueZ interfaces and
>>> avoid breaking the API. A quick look at these old audio interfaces
>>> (Headset, AudioSource, etc.) shows that Service1 could cover most of
>>> them if not all.
>> 
>> Network1 can not be deprecated for the simple reason that it is special. It returns a network interface. You saw my comments on why we left it in for BlueZ 5.
> 
> You're right, we couldn't completely remove the interface. You could
> however deprecate the Connect()/Disconnect() methods because they are
> redundant with ConnectProfile()/DisconnectProfile() or
> org.bluez.Service1. There's already a property informing about the
> interface name.

We can not. The return the interface information in a race free way. Feel free to go back and read the discussion between Johan and I on this subject.

>>> Furthermore, if you consider external profiles, it makes no sense to
>>> expose a profile-specific interface in BlueZ, since there's no way
>>> they could have profile-specific methods. org.bluez.Service1 fits
>>> again nicely in this case as a generic approach.
>> 
>> Not following here. Please explain what this means.
> 
> Let's say HSP/HFP. It doesn't make any sense to expose something like
> HandsfreeGateway1 or Headset1, because BlueZ has no knowledge about
> these profiles. They are implemented externally (i.e. oFono) and
> org.bluez.Profile1/ProfileManager1 obviously exposes a generic API.
> There's no way for example BlueZ can expose a property such as
> Headset1.IsPlaying, as BlueZ did in the past. This is an argument
> against expecting profile-specific interfaces in BlueZ.

Why would BlueZ expose these information anyway? I am still not following.

>>> Last but not least, I've found this interface (along with the test
>>> scripts) pretty useful while debugging issues reported recently in the
>>> mailing list. I believe this can be a fairly strong argument to
>>> support introducing an experimental interface.
>> 
>> Could be also a debugging plugin or just a wakeup call that our unit and end-to-end tests are not good enough in this read.
> 
> As argued above, I would discourage plugins exposing D-Bus API extensions.

We would apply the same rule as we did within oFono. org.bluez/org.ofono prefixed interface are generally useful. Specific interfaces can be expose by custom plugins. I have no problem with vendor interfaces if they think they are useful for certain specific users. If there is only one specific user, then making a custom plugin might be actually be better. It clearly indicates what its users are.

Regards

Marcel

