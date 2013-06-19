Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Subject: Re: [RFC BlueZ v2 00/13] Add experimental org.bluez.Service1
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CANT-zCUXE0vb69+qrhG3M5viH-kK2z9pWdOpQTa-ECgPXM=xNg@mail.gmail.com>
Date: Wed, 19 Jun 2013 10:02:13 +0200
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Message-Id: <D272DE8B-0B15-41AE-9B8D-457642CF9763@holtmann.org>
References: <1371020815-22330-1-git-send-email-mikel.astiz.oss@gmail.com> <83E493B1-AE4F-4EE1-8111-4CD2AA71B9AD@holtmann.org> <CANT-zCUXE0vb69+qrhG3M5viH-kK2z9pWdOpQTa-ECgPXM=xNg@mail.gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

>>> Beyond the desktop use-cases, some users (e.g. GENIVI) are interested in having profile-specific information and control interfaces exposed in D-Bus. Such APIs did exist in BlueZ 4 but were dropped for BlueZ 5 in favor of simpler API simplicity. This service-specific interfaces had a fairly low priority for BlueZ 5 and therefore the discussion was postponed.
>>> 
>>> This patchset proposes org.bluez.Service1 as an attempt to cover these needs. As compared to the former Device.ConnectProfile()/DisconnectProfile(), the approach has the following advantages:
>>> - Multiple instances of the same UUID can be exposed.
>> 
>> how is this going to help anyone. I you do not know what your service object is, what are you planning to do with it.
> 
> See list below for a summary of real use-cases.
> 
>> 
>>> - The state of each service can be exposed, without hackish lists like Device.ConnectedProfiles.
>> 
>> Again, here I want to see clear example on why you want all these states. Everybody takes about wanting all the crazy interim states and then never ever uses any of them.
> 
> Many well-known UIs show this information (i.e. which profiles are
> connected), including IVI examples or even the Android UI. A new
> property such as "Device1.ConnectedProfiles" could be introduced but
> see below for arguments against this approach.

and many well-known UIs do not show this information. So what is the point exactly here. Maybe some UIs need to be brought into 2013 and being stuck in what we did 6 years ago.

My question however was not about if a profile is connected or not, my question was why we always end up with stupid interim states like "connecting".

>>> - It's ObjectManager-centric.
>>> - The design should scale better if new properties are required in the future (supported features, service handle, etc.)
>> 
>> I don't think this actually will scale that nicely. There are limited set of common properties for all these profiles. I am really curious to see how this is going to be used and how it would improve things for applications.
> 
> The currently existing API hits its limits very soon, even if a
> property such as "Device1.ConnectedProfiles" was introduced. Besides
> the multiple-UUID-instances case, assume the following potential
> scenarios:
> 
> 1. That a user-setting (enabled/disabled) needs to be exposed per
> service (or UUID), just like Android does. And I don't think you want
> to have a Device1.EnabledProfiles property.

I still do not agree with the fact that we need to disable profiles. However first order of business before I even consider allowing something like this is that we interop with ourselves on profiles (SDP record) updates and I have not seen anybody trying to handle this.

> 2. That the 'connecting' state needs to be exposed in D-Bus. You'd
> otherwise need something like Device1.ConnectingProfiles.

My point is that we do not need the connecting state at all. What is it good for?

> 3. That a D-Bus clients needs to know if a UUID is connectable,
> meaning not only supported but also probed (e.g. for "hfp", to
> distinguish whether oFono is running). You'd otherwise need something
> like Device1.ProbedProfiles.

Has this really been thought through. What happens if a Device1.Connect is triggered and then oFono starts later on. What is the expected behavior here?

> 4. That a human-friendly name needs to be exposed in D-Bus per service
> (this seemed to be an argument in favor of the Network1 interface).

And what name is that exactly? How do you handle translation?

> 5. That additional remote information needs to be exposed, such as
> profile version or supported features.

For what usage?

> Having an object-oriented Service1 API is IMO much cleaner as opposed
> to a sparse interface consisting of methods like
> ConnectProfile()/DisconnectProfile() along with properties like
> "ConnectedProfiles"/"ConnectingProfiles"/"EnabledProfiles"/"ProbedProfiles"
> which btw are string lists, therefore not very client-friendly.
> 
> All these needs would be nicely addressed by a generic service D-Bus
> interface as proposed here. Note that some of the points above are
> real IVI requirements, and we're in fact having trouble to upgrade to
> BlueZ 5 due to API limitations. Some others might not be required
> after all or might have different workarounds, but I think it's fair
> enough to claim that the approach can scale better.

If you need special interfaces, there is always the possibility of a vendor plugin using com.bmw or org.genivi interfaces.

>> My initial take is still that just calling a general Device1.Connect or requesting a connect to a UUID is useful. Everything else is pretty much application specific anyway.
>> 
>> You can always add profile specific interfaces. Like we do with Network1. Why are you saying your approach is more object manager centric.
> 
> As argued above, it's presumably more object-oriented and therefore
> more ObjectManager-centric.
> 
> Adding interfaces such as Network1 is IMO a step back in the direction
> to BlueZ 4 APIs, probably biased by the fact that the same developer
> community is involved in Connman. Recent commits
> (0624791ea6e917d6c9ecb8e7e6e5a1327199448d) mention  that the
> Connect/Disconnect interface was brought back "for convenience", which
> should not be the driving factor when designing D-Bus APIs. This very
> same argument was in fact used to drop "convenience" APIs such as
> org.bluez.Manager (commit 86a7b07c22f3a595ba3c48092359287905bf0878).
> 
> The Network1 interface could be easily deprecated in favor of a more
> generic Service1 interface. If we're going to introduce interfaces
> such as Headset1 etc., we should have stayed with BlueZ interfaces and
> avoid breaking the API. A quick look at these old audio interfaces
> (Headset, AudioSource, etc.) shows that Service1 could cover most of
> them if not all.

Network1 can not be deprecated for the simple reason that it is special. It returns a network interface. You saw my comments on why we left it in for BlueZ 5.

> Furthermore, if you consider external profiles, it makes no sense to
> expose a profile-specific interface in BlueZ, since there's no way
> they could have profile-specific methods. org.bluez.Service1 fits
> again nicely in this case as a generic approach.

Not following here. Please explain what this means.

> Last but not least, I've found this interface (along with the test
> scripts) pretty useful while debugging issues reported recently in the
> mailing list. I believe this can be a fairly strong argument to
> support introducing an experimental interface.

Could be also a debugging plugin or just a wakeup call that our unit and end-to-end tests are not good enough in this read.

Regards

Marcel

