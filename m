Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Change LE advertising interval via D-Bus API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com>
Date: Tue, 9 Aug 2016 15:50:54 +0200
Cc: "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>
Message-Id: <581A4CCB-9778-4C48-9075-7CFCC1C95884@holtmann.org>
References: <1DAD8581-6B6C-4973-A284-C8B1F210C4AD@starleaf.com> <14FF3F29-1C6E-41F9-B41D-850772B758B3@holtmann.org> <FB35544E-8D8B-48B1-825A-E0A5BC8D92C3@starleaf.com>
To: Alex Coplan <alex.coplan@starleaf.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alex,

>>> There doesn’t currently appear to be an obvious way to change the advertising interval via the D-Bus API.
>>> 
>>> Are there plans to add this as an option to the RegisterAdvertisement method, or perhaps a property of the LEAdvertisement1 interface?
>> 
>> what do you want to change it to? There are certain limits that make sense. For example fine control over the advertising interval from an application makes no sense. It might however make sense to have some low, medium, high interval adjectives so that bluetoothd can pick the right options. Even the mgmt API into the kernel for setting advertising has no control over advertising internal at the moment.
> 
> Currently it’s using the default value of 0x0800 (= 1.28 seconds), as set in net/bluetooth/hci_core.c:2950. This is too infrequent for e.g. iBeacons on iOS to be able to perform the “ranging” function which does distance estimation etc. Perhaps 0x0200 (around 250ms) would be sensible as a more frequent option?

for me this sounds like we should be adding a "low latency" flag to the Add Advertising flags parameters that picks a short advertising interval. In general this is similar to what we have done with "fast connectable" option that we have. However in this case it is not just fast connectable since we also have non-connectable advertising.

I also have the feeling that for the general Set Advertising, the setting of Set Fast Connectable should be honored and results in using the other advertising interval. That would also mean that the Set Fast Connectable setting becomes available for LE controllers.

Does iOS beacon guide give some advise on what is the best advertising interval for the iBeacons?

Regards

Marcel

