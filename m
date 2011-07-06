Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAKT1EBeNMDh4CYigJM4tfF=7V80EtZg4BjPPCVg4C+TcQtuN_A@mail.gmail.com>
References: <1309772865-5083-1-git-send-email-sancane@gmail.com>
	<CAKT1EBeNMDh4CYigJM4tfF=7V80EtZg4BjPPCVg4C+TcQtuN_A@mail.gmail.com>
Date: Wed, 6 Jul 2011 15:29:10 +0200
Message-ID: <CACLukzLnRLGXqQnYFxU+b4QW_nCxfcmZHyu9Gu1rsh=2Z1Nucw@mail.gmail.com>
Subject: Re: [PATCH] Health Thermometer Profile API
From: Santiago Carot <sancane@gmail.com>
To: Claudio Takahasi <claudio.takahasi@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Claudio,


2011/7/6 Claudio Takahasi <claudio.takahasi@openbossa.org>:
> Hi Santiago,
>
> <snip>
>
>> +               RegisterWatcher(object agent)
>> +
>> +                       Registers a watcher to monitor scanned measurements.
>> +                       This agent will be notified about final temperature
>> +                       measurements.
>> +
>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>> +
>> +               UnregisterWatcher(object agent)
>> +
>> +                       Unregisters a watcher.
>> +
>> +                       Final and intermediate temperatures won't be notified to
>> +                       this agent any more.
>> +
>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>> +                                       org.bluez.Error.NotFound
>> +
>> +               EnableIntermediateMeasurement(object agent)
>
> It'd be good to try hide from the apps notifications and indications.
> My opinion is: watchers doesn't need to know if the characteristic
> value is a notification or indication.

The Notification word in the API refers to way that the plugin will
report to applications about measures received. Nothing related with
the property of the characteristic. The idea is that applications does
not worried about that. Always a measurement (notification or
indication) is received the callback in the watcher gets called.

> The thermometer implementation could enable automatically
> notifications if there is at least one watcher registered.
>
> Is it important to know if the characteristic value is intermediate or not?

Yes, for example there may be watchers that want to feed a display
with intermediate values until the final measurement arrives, in
opposite, EEE11073-20601 watchers dont need get intermediate ones to
work so we dont need to bother them with intermediate measurements.

>
>> +
>> +                       Enables intermediate measurement notifications for this
>> +                       agent if the thermometer supports it.
>> +
>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>> +                                       org.bluez.Error.NotSupported
>> +
>> +               DisableIntermediateMeasurement(object agent)
>> +
>> +                       Disables intermediate measurement notifications for this
>> +                       agent. It will disable notifications in the thermometer
>> +                       when the last agent removes the watcher for intermediate
>> +                       measurements.
>> +
>> +                       Possible Errors: org.bluez.Error.InvalidArguments
>> +                                       org.bluez.Error.NotFound
>> +
>> +Signals                PropertyChanged(string name, variant value)
>> +
>> +                       This signal indicates a changed value of the given
>> +                       property.
>> +
>> +Properties     boolean Intermediate [readonly]
>> +
>> +                       True if the thermometer supports intermediate measurement
>> +                       notifications.
>> +
>> +               uint16 Interval (optional) [readwrite]
>> +
>> +                       The Measurement Interval defines the time (in seconds)
>> +                       between measurements. This interval is not related to
>> +                       the intermediate measurements and must be defined into
>> +                       a valid range. Setting it to zero means that no periodic
>> +                       measurements will be taken.
>> +
>> +               uint16 Maximum (optional) [readonly]
>> +
>> +                       Defines the maximum value allowed for the interval
>> +                       between periodic measurements.
>> +
>> +               uint16 Minimum (optional) [readonly]
>> +
>> +                       Defines the minimum value allowed for the interval
>> +                       between periodic measurements.
>> +
>
> Intervals could be a config option. It can be extended later if
> necessary, move the config option to the API(Property) is easier than
> remove a property.
>

Do you mean to move it to the bluetoothd configuration file?
I think that it's not a good a idea because this value should be in a
determinated range imposed by the device. Each device can have it own
range and it may differ among all those kind of devices.

Regards.
