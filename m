Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=US-ASCII
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Subject: Re: [PATCH v3 5/8] obexd: Add RegisterNotifications function
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <51407D38.2080600@oss.bmw-carit.de>
Date: Wed, 13 Mar 2013 09:27:49 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <440C26C3-24C4-4A9B-8527-C94C75F850E5@holtmann.org>
References: <1363014350-16114-1-git-send-email-christian.fetzer@oss.bmw-carit.de> <1363014350-16114-6-git-send-email-christian.fetzer@oss.bmw-carit.de> <72B23061-16D8-4949-AAB4-9537F6726FCB@holtmann.org> <51407D38.2080600@oss.bmw-carit.de>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

>>> This allows applications to register for all different types
>>> of MAP event reports.
>>> 
>>> In response to this call, the MSE should connect to the local MNS
>>> instance.
>>> ---
>>> doc/obex-api.txt   |  6 ++++
>>> obexd/client/map.c | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>> 2 files changed, 92 insertions(+)
>> never ever intermix doc/ changes with actual code. You really need to learn on how to split patches properly. There is no reason at all that this are not two patches.
>> 
>> 
>>> diff --git a/doc/obex-api.txt b/doc/obex-api.txt
>>> index 759c4d8..ef5d85e 100644
>>> --- a/doc/obex-api.txt
>>> +++ b/doc/obex-api.txt
>>> @@ -651,6 +651,12 @@ Methods		void SetFolder(string name)
>>> 			Possible errors: org.bluez.obex.Error.InvalidArguments
>>> 					 org.bluez.obex.Error.Failed
>>> 
>>> +		void RegisterNotifications(boolean)
>>> +
>>> +			Register / unregister reception of notifications.
>>> +
>>> +			Possible errors: org.bluez.obex.Error.InvalidArguments
>>> +					 org.bluez.obex.Error.Failed
>> Why don't you describe the boolean variable and what it does. If this is an on/off switch, then we are not doing this stupid thing here.
>> 
>> Simple things like EnableNotifications and DisableNotifications would be better. Also this needs a bit detailed explanations why you thing this is the right API for handling this. I am not even convinced we should be doing it like this.
>> 
>> Regards
>> 
>> Marcel
> Thanks for your comments. I'll split the patches and send an updated patch set.
> 
> Yes, RegisterNotification simply enables / disabled receiving event reports. I can change it as suggested.
> The reason for having an API function instead of enabling it implicitly is that the application can control
> for which device it wants to receive event reports.
> 
> Event reports can be received for multiple MAP sessions on the same device.
> This is used for example when the phone exposes different E-Mail accounts as different MAP instances.
> But according to the specification, we need to have one MNS (obex server) instance for each remote device.
> 
> The current code is limited to exactly one static MNS instance, and you can receive notifications only for one device.
> In the future we could eventually work around that limitation by dynamically instantiating MNS instances when
> needed.

maybe it would a good idea to write this up in an email that just proposes the API changes and additions and we can discuss based on that. However you have to explain on how this API is supposed to be used.

Regards

Marcel

