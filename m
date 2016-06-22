Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: AVRCP 1.6
References: <a5d52a61-9c2e-b0d8-3e64-06a6e03cc411@gmail.com>
 <CABBYNZ+fo2FY2rvFkz9mkTGf5guCCQgczEK+5TSrqhS-hHEmVA@mail.gmail.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: Niek Vlessert <niekvlessert@gmail.com>
Message-ID: <70154da5-5a09-28a8-c527-695a6bf499a2@gmail.com>
Date: Wed, 22 Jun 2016 23:15:57 +0200
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+fo2FY2rvFkz9mkTGf5guCCQgczEK+5TSrqhS-hHEmVA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> - Bluez supports AVRCP up to 1.5
>
> Actually we can do up to 1.6 but just the mandatory commands which
> don't include the ones necessary for cover art, etc.

Ok, great!

>
> Android has support only to 1.3, there are vendors that extend to
> 1.4/1.5 like samsung but they have to change all the way from HAL to
> java to interface this to the application.
>
Interesting, do you know any reasons why Google won't incorperate a 
newer version ?

>
> You can use tools/bluetooth-player if you want to control it from the
> command line, another alternative is to use tools/mpris-proxy and then
> control it using a MPRIS controller.

Great, I've been looking into those. It seems to me bluetooth-player as 
the CT and mprix-proxy as the TG can provide a test setup for future 
AVRCP 1.6 testing. It's interesting to see that the mpris spec supports 
an artUrl already: 
https://www.freedesktop.org/wiki/Specifications/mpris-spec/metadata/#index3h4. 
I'm thinking bluetooth-player sends the image through AVRCP 1.6 to the 
mpris-proxy. mpris-proxy puts it in /tmp/ and provides a url like 
file:///tmp/<randomstring>.bmp to the mediaplayer through the Art URL. 
What do you think of this approach?

>
>> - Would you consider it possible to put the right hex into my Android app
>> and transmit that to my Bluetooth connection so I can implement it without
>> the Android Bluez stack supporting it? If target devices will ever support
>> it... Since it's serial communication, I thought why not? I never did
>> anything like this with Bluetooth programming so forgive my ignorance. :)
>> Something like this: create L2CAP channel with the Cover Art UUID. Wait for
>> response; encode picture in the right data packages, and here we go. Leave
>> other Bluetooth communication requirements to Android.
>
> You can do whatever you want, but since it would be non-standard this
> would limit a lot the usage.

Well, I was hoping I could keep it standard compliant using this method. 
However since you responded like this; do you think it's not possible to 
create the correct hex strings in my own program for some reason?

>
>> - Or maybe I could use the cddb support? Maybe it's possible to redirect
>> traffic to cddb to somewhere else, provide the cddb interface and offer the
>> image like that? I know, it's horrible... ;)
>
> Also non-standard, perhaps investing time in doing a AVRCP 1.6 would be better.

That would be awesome. I'm not that good at c but maybe I can try to 
implement it in the player and the proxy with tips from you, adding it 
to BlueZ however is another story I guess. :)
