Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <5135D965.8020604@tieto.com>
Date: Tue, 5 Mar 2013 08:15:58 -0800
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <F00262C4-3552-438E-AF44-1D088CAB11A8@holtmann.org>
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <C4340FC6-1121-468E-B15D-68E2770AA07E@holtmann.org> <5135D965.8020604@tieto.com>
To: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Waldemar,

>>> +Blood Pressure Manager hierarchy
>>> +================================
>>> +
>>> +Serviceorg.bluez
>>> +Interface	org.bluez.BloodPressureManager1
>>> +Object path	[variable prefix]/{hci0,hci1,...}
>>> +
>>> +Methods		RegisterWatcher(object agent)
>> 
>> I do not really this manager business anymore. Splitting the interface over adapter and device object seems pointless. What I like to see is that we make one interface on the device object. We should have no proper lifetime rules for these.
>> 
>> Basically a client using a specialised interface should have to deal with one entry point and not with multiple. Low Energy clients need to pick a device they want to operate with. So this should focus on device objects and nothing else.
>> 
> 
> Is this what you mean?
> 
> 
> diff --git a/doc/bloodpressure-api.txt b/doc/bloodpressure-api.txt
> new file mode 100644
> index 0000000..be18208
> --- /dev/null
> +++ b/doc/bloodpressure-api.txt
> @@ -0,0 +1,127 @@
> +Blood Pressure API description
> +******************************
> +
> +Blood Pressure Profile hierarchy
> +================================
> +
> +Service		org.bluez
> +Interface	org.bluez.BloodPressure1
> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
> +
> +Methods		RegisterWatcher(object watcher)
> +
> +			Registers a watcher to monitor blood pressure
> +			measurements. This watcher will be notified about
> +			final pressure measurements.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +
> +		UnregisterWatcher(object watcher)
> +
> +			Unregisters a watcher.
> +
> +		EnableIntermediateMeasurement(object watcher)
> +
> +			Enables intermediate measurement notifications
> +			for this watcher. Intermediate measurements will
> +			be enabled only for devices which support it.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotSupported
> +
> +		DisableIntermediateMeasurement(object watcher)
> +
> +			Disables intermediate measurement notifications
> +			for this watcher. It will disable notifications in
> +			devices when the last watcher is removed for
> +			intermediate measurements.
> +
> +			Possible Errors: org.bluez.Error.InvalidArguments
> +					org.bluez.Error.NotFound

why don't we make these two methods parts of a dict for RegisterWatcher. Enabling them manually seems rather pointless.

Regards

Marcel

