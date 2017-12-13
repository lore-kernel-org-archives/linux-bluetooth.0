Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [RFC 4/4] client: Print LEAddress type in show and info commands
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <3027942.EkYWvo1UAH@ix>
Date: Wed, 13 Dec 2017 09:50:53 +0100
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <36FCBB0F-0017-4A81-85FE-C0E9AEC565C8@holtmann.org>
References: <20171211103837.25150-1-szymon.janc@codecoup.pl>
 <20171211103837.25150-4-szymon.janc@codecoup.pl>
 <CABBYNZK+5JGmazDyGM771=RZhkYKbnDMFupZWk+23k4u6z06LQ@mail.gmail.com>
 <3027942.EkYWvo1UAH@ix>
To: Szymon Janc <szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

>>> ---
>>> 
>>> client/main.c | 2 ++
>>> 1 file changed, 2 insertions(+)
>>> 
>>> diff --git a/client/main.c b/client/main.c
>>> index f3369e89a..a1d941e30 100644
>>> --- a/client/main.c
>>> +++ b/client/main.c
>>> @@ -872,6 +872,7 @@ static void cmd_show(int argc, char *argv[])
>>> 
>>>        print_property(proxy, "Powered");
>>>        print_property(proxy, "Discoverable");
>>>        print_property(proxy, "Pairable");
>>> 
>>> +       print_property(proxy, "LEAddressType");
>>> 
>>>        print_uuids(proxy);
>>>        print_property(proxy, "Modalias");
>>>        print_property(proxy, "Discovering");
>>> 
>>> @@ -1447,6 +1448,7 @@ static void cmd_info(int argc, char *argv[])
>>> 
>>>        print_property(proxy, "Blocked");
>>>        print_property(proxy, "Connected");
>>>        print_property(proxy, "LegacyPairing");
>>> 
>>> +       print_property(proxy, "LEAddressType");
>>> 
>>>        print_uuids(proxy);
>>>        print_property(proxy, "Modalias");
>>>        print_property(proxy, "ManufacturerData");
>>> 
>>> --
>>> 2.14.3
>> 
>> Another alternative to adding the LE specific type would be to add it
>> as Manufacturer string so we can add the information of OUI if public
>> or add the information of "Static Random", "Resolvable Random", etc.
> 
> I'd keep it simple - this should simply match to address type that needs to be 
> passed when connecting L2CAP socket.

frankly, I prefer the capability to establish the L2CAP connection via D-Bus and return the socket fd that way as well. The D-Bus object types for devices do not really match any L2CAP socket address anyway. So if people want to establish a L2CAP connection oriented channel, they should be able to do that right from the D-Bus object manager they already in. We did the same for BR/EDR with the profile-api.txt and that should be a similar approach here.

Regards

Marcel

