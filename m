Return-Path: <cyrus@holtmann.org>
Message-ID: <51309AE3.7070909@tieto.com>
Date: Fri, 1 Mar 2013 13:11:15 +0100
From: Rymarkiewicz Waldemar <waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
To: <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>
Subject: Re: [RFC] bloodpressure: Add Blood Pressure API
References: <1360668097-28906-1-git-send-email-waldemar.rymarkiewicz@tieto.com> <20130220075725.GA14731@x220> <512F62E0.1030706@tieto.com> <20130228141847.GA24103@x220>
In-Reply-To: <20130228141847.GA24103@x220>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

>>>> +Blood Pressure Profile hierarchy
>>>> +================================
>>>> +
>>>> +Service		org.bluez
>>>> +Interface	org.bluez.BloodPressure1
>>>> +Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
>>>> +
>>>> +Properties	boolean Intermediate [readonly]
>>>> +
>>>> +			True if the device supports intermediate
>>>> +			measurement notifications.
>>
> Couldn't you just return a "NotSupported" error to
> EnableIntermediateMeasurement?


I've just confronted this with the code and this make no sens because 
the watcher passed to EnableIntermediateMeasurement is registered on the 
adapter not for a device. So, it's not possible to check if the device 
supports this feature.

Thus, I will keep Intermediate property for that reason.

/Waldek

