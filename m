Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Change LE advertising interval via D-Bus API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E954B4D5-5952-4935-8B8D-D618C7C693DC@starleaf.com>
Date: Wed, 10 Aug 2016 13:55:51 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4ADDE98F-C561-415B-AFA7-D407B21EFFCD@holtmann.org>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com> <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org> <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com> <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org> <E954B4D5-5952-4935-8B8D-D618C7C693DC@starleaf.com>
To: Alex Coplan <alex.coplan@starleaf.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>>>> There doesn’t currently appear to be an obvious way to change the advertising interval via the D-Bus API.
>>>>> 
>>>>> Are there plans to add this as an option to the RegisterAdvertisement method, or perhaps a property of the LEAdvertisement1 interface?
>>>> 
>>>> what do you want to change it to? There are certain limits that make sense. For example fine control over the advertising interval from an application makes no sense. It might however make sense to have some low, medium, high interval adjectives so that bluetoothd can pick the right options. Even the mgmt API into the kernel for setting advertising has no control over advertising internal at the moment.
>>> 
>>> Currently it’s using the default value of 0x0800 (= 1.28 seconds), as set in net/bluetooth/hci_core.c:2950. This is too infrequent for e.g. iBeacons on iOS to be able to perform the “ranging” function which does distance estimation etc. Perhaps 0x0200 (around 250ms) would be sensible as a more frequent option?
>> 
>> for me this sounds like we should be adding a "low latency" flag to the Add Advertising flags parameters that picks a short advertising interval. In general this is similar to what we have done with "fast connectable" option that we have. However in this case it is not just fast connectable since we also have non-connectable advertising.
> 
> Yes, that sounds reasonable.
> 
>> 
>> I also have the feeling that for the general Set Advertising, the setting of Set Fast Connectable should be honored and results in using the other advertising interval. That would also mean that the Set Fast Connectable setting becomes available for LE controllers.
>> 
>> Does iOS beacon guide give some advise on what is the best advertising interval for the iBeacons?
> 
> The iBeacon specification recommends an advertising interval of 100ms, but that is quite low (the minimum allowed by the spec for ADV_NONCONN_IND packets). In my tests, 200ms works just fine.

and even that 100ms requirement for ADV_NONCONN_IND will be removed soon from the specification. This does not mean we should go with a smaller interval. Mainly since most 4.x controllers will just reject it anyway.

Anyway, we can test a few values and then fine tune it. We can add a debugfs file that allows us to test out different values. And in the long run we can add a Set Fast Connectable Parameters mgmt command to allow changing these via bluetoothd if needed.

Now the question is who works out the patch to doc/mgmt-api.txt and does the implementation for it. So it needs this:

1) Changes to Set Fast Connectable to allow it for LE only devices as well
2) Changes to Set Advertising to honor Set Fast Connectable
3) New flag for Read Advertising Features and Add Advertising

I propose to name the new flag like this:

	7	Use Fast Connectable advertising interval

My reason to stick with name Fast Connectable is that we already used it. The mgmt-api.txt should however reflect that it also applies to non-connectable advertising.

One thing we need to check is that Set Fast Connectable is independent from Set Connectable. I think we already did it that way, but if not, then we need to decouple these two.

Eventually we can rename Fast Connectable to something more appropriate, but lets leave that for some other time. Since I would worry right now to get the feature implemented correctly. It also means to add extra test cases to tools/mgmt-tester to ensure correct behavior in conjunction with Set Connectable etc.

Are you planning to send patches for this? I think the todo items are pretty clear.

Regards

Marcel

