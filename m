Return-Path: <cyrus@holtmann.org>
Message-ID: <513703AA.2090206@tieto.com>
Date: Wed, 6 Mar 2013 09:51:54 +0100
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org> <5135D965.8020604@tieto.com> <F00262C4-3552-438E-AF44-1D088CAB11A8@holtmann.org>
In-Reply-To: <F00262C4-3552-438E-AF44-1D088CAB11A8@holtmann.org>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Marcel,

>> +Interface	org.bluez.BloodPressure1
>> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>> +
>> +Methods		RegisterWatcher(object watcher)
>> +
>> +			Registers a watcher to monitor blood pressure
>> +			measurements. This watcher will be notified about
>> +			final pressure measurements.
>> +
>> +			Possible Errors: org.bluez.Error.InvalidArguments
>> +
>> +		UnregisterWatcher(object watcher)
>> +
>> +			Unregisters a watcher.
>> +
>> +		EnableIntermediateMeasurement(object watcher)
>> +
>> +			Enables intermediate measurement notifications
>> +			for this watcher. Intermediate measurements will
>> +			be enabled only for devices which support it.
>> +
>> +			Possible Errors: org.bluez.Error.InvalidArguments
>> +					org.bluez.Error.NotSupported
>> +
>> +		DisableIntermediateMeasurement(object watcher)
>> +
>> +			Disables intermediate measurement notifications
>> +			for this watcher. It will disable notifications in
>> +			devices when the last watcher is removed for
>> +			intermediate measurements.
>> +
>> +			Possible Errors: org.bluez.Error.InvalidArguments
>> +					org.bluez.Error.NotFound
>
> why don't we make these two methods parts of a dict for RegisterWatcher. Enabling them manually seems rather pointless.

It's been done intentionally to be able to return "not supported" error 
when intermediate measurement is not available.

Having RegisterWatcher(object watcher, boolean intermediate) and 
additionally Intermediate property [read only] is an another option.

In this case app will check intermediate property and set intermediate 
param to RegisterWatcher appropriately.

/Waldek
