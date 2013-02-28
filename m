Return-Path: <cyrus@holtmann.org>
Message-ID: <512F62E0.1030706@tieto.com>
Date: Thu, 28 Feb 2013 15:00:00 +0100
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20130220075725.GA14731@x220>
In-Reply-To: <20130220075725.GA14731@x220>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>
> Please provide a proper commit message.

Sure. Change ID will be removed in v2.

>> +Methods		RegisterWatcher(object agent)
>> +
>> +			Registers a watcher to monitor blood pressure
>> +			measurements. This agent will be notified about
>> +			final pressure measurements.
>> +
> I'm a bit confused, what's the difference between "watcher" and "agent"?
> If they're the same thing just pick one term and stick to it.

Both mean the same, I guess. I've followed the description of existing 
profiles thermometer, cscp, hrp.

All of them use 'agent' term for parameter and 'watcher' in description. 
I will go for watcher it seems to be more relevant.

Methods		RegisterWatcher(object watcher)

			Registers a watcher to monitor blood pressure
			measurements. This watcher will be notified about
			final pressure measurements.

Is this ok?

>
>> +Blood Pressure Profile hierarchy
>> +================================
>> +
>> +Service		org.bluez
>> +Interface	org.bluez.BloodPressure1
>> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>> +
>> +Properties	boolean Intermediate [readonly]
>> +
>> +			True if the device supports intermediate
>> +			measurement notifications.


> What's the use of this property (and the interface)? I don't see how it
> relates to any other APIs in this specification.

The device may support notifications of intermediate cuff pressure. That 
means during measurement it notifies the Collector what is  current 
pressure in cuff (my device sends 5 notifications per sec) until it is 
ready to send final measurements (diastolic, systolic and MAP pressure).

Based on this property an app can decide if it wants to 
EnableIntermediateMeasurement (CCC of right characteristic in configured 
then) or not.

Similarly as in thermometer api.

Thanks,
/Waldek

