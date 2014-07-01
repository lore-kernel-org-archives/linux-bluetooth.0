Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.2\))
Subject: Re: [RFC] doc: Add EIR to device properties
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CA+bD78j4RfvZdMoKLcfDdtsy1g_bgZ-vnbAOY80W_JcZDNuEyA@mail.gmail.com>
Date: Tue, 1 Jul 2014 17:30:02 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <E324D0BB-4042-4E4F-8F14-16B09C34B259@holtmann.org>
References: <1403897492-6233-1-git-send-email-scott@netsplit.com> <B3B3E392-D840-4924-86B6-951649CD7B79@holtmann.org> <CA+bD78j4bSfqvn7MHnsV7PKp_dGXN4dLApW2G5p4oN-Tsu+h1Q@mail.gmail.com> <F49C47A1-077C-41E2-A36B-3DE9EF1A9E19@holtmann.org> <CA+bD78j4RfvZdMoKLcfDdtsy1g_bgZ-vnbAOY80W_JcZDNuEyA@mail.gmail.com>
To: Scott James Remnant <scott@netsplit.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Scott,

>>>>> This patch proposes an extension to the D-Bus Device API to allow
>>>>> an application access to the last EIR data received from a device
>>>>> in inquiry or advertising mode.
>>>>> 
>> 
>> I think this looks pretty along the lines what I am looking for. However I was thinking in a bit more detail likes this:
>> 
>>        <- Search method call
>>        -> New Device object / Updated device object
>>        -> New Device object / Updated device object
>>        -> Search method return -> array of objects with properties
>> 
>> So you can treat the search dead simple and just display the results. However that way you can not monitor progress. If you want to monitor progress while search is running, you need to monitor changes to the device objects.
>> 
> 
> Sounds reasonable, would make it very easy from an application point of view.
> 
> This would place the EIR/AD/SR data in the device objects as a property then?

we could do that, but I would like to discuss this a bit more. For example we might not duplicate the information that we have properties for. For example device name or appearance.

The information would also become invalid once the discovery gets aborted. Similar to the RSSI value where we actually declare the property invalid once discovery is over.

I think we have to see how this works out. We might need a prototype implementation to play with it a little bit.

Regards

Marcel

