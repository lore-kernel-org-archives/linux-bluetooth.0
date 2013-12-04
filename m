Return-Path: <cyrus@holtmann.org>
Message-ID: <529F4CB6.6010008@timomueller.eu>
Date: Wed, 04 Dec 2013 16:39:34 +0100
From: =?ISO-8859-1?Q?Timo_M=FCller?= <mail@timomueller.eu>
MIME-Version: 1.0
To: Szymon Janc <szymon.janc@tieto.com>
CC: linux-bluetooth@vger.kernel.org,
	Timo Mueller <timo.mueller@bmw-carit.de>
Subject: Re: [PATCHv1 0/2] Introduce default adapter property
References: <cover.1386078490.git.timo.mueller@bmw-carit.de> <3146259.c398076Ovj@uw000953>
In-Reply-To: <3146259.c398076Ovj@uw000953>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

Szymon Janc wrote, On 04.12.2013 09:32:
> Hi Timo,
>
>> From: Timo Mueller <timo.mueller@bmw-carit.de>
>>
>> Hi,
>>
>> the information about the default adapter is currently not available
>> through the D-Bus API of BlueZ. But as plugins can use this
>> information to choose the adapter they act upon it would be helpful
>> for users to be able to retrieve this information as well.
>>
>> For example the neard plugin uses this information to decide for which
>> adapter oob data is generated. Users could use the same information to
>> power the adapter before actually sending the oob data.
>
> I think this property is bluetoothd internal detail and should not be needed
> to be exported to user.

Alright. Is the default information needed at all? I might be missing 
something but the default information seems to only be used by the 
hostname, sixaxis and neard plugins. I don't know about sixaxis, but the 
hostname plugin could also do without this information. If the neard 
plugin would handle multiple adapters, then the default adapter property 
could be dropped completely.

> If reason for this is scenario where multiple BT and
> NFC adapters are present and you need to match them in pairs, then proper
> solution would probably require extending neard agent interface. Neard plugin
> could be also made 'smarter' about multiple adapters eg. try to choose other
> controller if default one is not powered etc. Regarding changing power state
> of bt controller, I think this could be done by neard plugin itself (possible
> based on some static configuration or even runtime dbus setting...). It is on
> my 'TODO when have some spare time' list :)

Automatic powering, if enabled by 'configuration', sounds good to me. 
Regarding the adapter selection, how about a runtime dbus setting to set 
the adapter that the neard plugin is using? It could then behave as 
bluetoothctl does right now. Choosing the first adapter on start and use 
the selected adapter afterwards.

>
> It would be good if you could outline usecases you are trying to address with
> this change.

The use case was to only send the oob data when the device has not yet 
been paired with the adapter that is used. On Android this wouldn't 
interrupt the regular Android Beam behaviour (when sending an URL from 
the browser for example). Of course this requires a unique ID that could 
be requested via NFC and mapped to a BD_ADDR. Unfortunately this ID, as 
just discussed in IRC, does not exist. So, admittedly this use case is 
broken.

Best regards,
Timo


