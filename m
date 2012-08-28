Return-Path: <cyrus@holtmann.org>
Message-ID: <503CE72D.2030501@tieto.com>
Date: Tue, 28 Aug 2012 17:43:41 +0200
From: Garbat Rafal <rafal.garbat@tieto.com>
MIME-Version: 1.0
To: <linux-bluetooth@vger.kernel.org>,
	Santiago Carot-Nemesio <sancane@gmail.com>
Subject: Re: [PATCH v2 01/13] Heart Rate Profile API
References: <1344870497-6929-1-git-send-email-rafal.garbat@tieto.com> <1344870497-6929-2-git-send-email-rafal.garbat@tieto.com> <20120814095636.GA7055@x220> <20120828152058.GA18913@x220.sheraton.com>
In-Reply-To: <20120828152058.GA18913@x220.sheraton.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On 08/28/2012 05:20 PM, Johan Hedberg wrote:
> Hi,
>
> On Tue, Aug 14, 2012, Johan Hedberg wrote:
>> Hi,
>>
>> On Mon, Aug 13, 2012, Rafal Garbat wrote:
>>> +Heart Rate Profile hierarchy
>>> +============================
>>> +
>>> +Service		org.bluez
>>> +Interface	org.bluez.HeartRate
>>> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>>> +
>>> +Methods		dict GetProperties()
>>> +
>>> +			Returns all properties for the interface. See the
>>> +			Properties section for the available properties.
>>> +
>>> +		RegisterWatcher(object agent)
>>> +
>>> +			Registers a watcher to monitor heart rate measurements.
>>> +
>>> +			Possible Errors: org.bluez.Error.InvalidArguments
>> I'm wondering if it wouldn't make more sense to have these
>> RegisterWatcher APIs (thermometer, heart rate, others?) per-adapter
>> instead of per-device. That would be much friendlier to applications in
>> that they wouldn't need to separately search for paired/configured
>> devices supporting a specific service. Moving this to be per-adapter
>> would also mean that the first parameter of the Watcher methods would be
>> the object path of which device is in question.
> So any comments on this? I'd like to get this moving forward and finally
> merged upstream.
>
> Johan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Sorry for a late reply.
I guess that moving RegisterWatcher methods to the adapter iface sounds 
reasonable, but we need to think how to do it i.e. to properly handle 
devices that support several profiles based on registering watchers (do 
we want to register watcher for all the profiles or have a parameter for 
Watcher methods to specify the target), etc.
Correct me if I'm wrong or missing something.
I'd suggest merging heartrate as this profile is quite similar to the 
thermometer and it works (and no one have any objections to the code) 
and re-factor this later on.
Unfortunately I'll be off for the next three weeks, but I can get back 
to this when I'm back.

BR,
Rafal
