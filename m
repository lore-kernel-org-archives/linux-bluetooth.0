Return-Path: <ag@new-media-artists.de>
Reply-To: <ag@new-media-artists.de>
From: "Andreas Gaufer" <ag@new-media-artists.de>
To: "Marcel Holtmann" <marcel@holtmann.org>
Cc: "Bluez Devel" <bluez-devel@lists.sourceforge.net>
Subject: AW: [Bluez-devel] Master, Slave and Maximal Peers Questions
Date: Wed, 21 Jan 2004 10:07:40 +0100
Message-ID: <FJENILNPNAGPJMMDOKDCEEGEDMAA.ag@new-media-artists.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <1074353316.2629.148.camel@pegasus>
List-ID: <bluez-devel.lists.sourceforge.net>

>> >I don't see any reason why you can't connect a third device into this
>> >piconet. Run "hcidump -w <file>" for the third connection, so we can see
>> >what happens on the HCI layer.
>>
>> you where right, there is no problem with connecting more than two with
>> rfcomm. I just saw "device or resource busy" from rfcomm often in my logs
so
>> i assumed it would be that reason but it wasnt. Now i have to find out
what
>> was the reason for this. Any what would be the most obvious reasons for
>> this, if any?

>what is the correct errno that would be returned? Run hcidump as I told
>you.

>Regards

>Marcel

I cant reproduce the problem at the moment, i´ll come back to you if I have
useable information.

Greetings

Andy
