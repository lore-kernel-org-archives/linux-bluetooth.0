Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <56015B46.90505@steev.me.uk>
References: <56006696.3030200@steev.me.uk>
	<CAASrBQmWuCvyi6-DNAVvaaV2eFSeEVCy2Sr8QzPyy0Ckt0TQbg@mail.gmail.com>
	<560108E5.1010701@steev.me.uk>
	<CABBYNZJJo0YoiHkONvNer=4W=cmFbRZ23qR1kw3GdMLoAd=Lrg@mail.gmail.com>
	<56015B46.90505@steev.me.uk>
Date: Wed, 23 Sep 2015 10:22:01 +0300
Message-ID: <CABBYNZJb5cETazND4Oo5oaKs-aF5e1cXgYtjF7dLyUk_pQWWUw@mail.gmail.com>
Subject: Re: BLE: dbus doesn't show GATT characteristics
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steven Davies <linux-bluetooth-list@steev.me.uk>
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

On Tue, Sep 22, 2015 at 4:44 PM, Steven Davies
<linux-bluetooth-list@steev.me.uk> wrote:
>>>>> I'm having a problem using BLE through dbus where the GATT services
>>>>> don't appear after a BLE device has been found during a scan. What is
>>>>> available through dbus is a Device1 node with the correct address and a
>>>>> Name property of the name which was sent in the advertising beacons -
>>>>> however that's the only node available in the tree.
>>>> Are you running bluetoothd with the experimental (-E) flag?
>>> Yes:
>>> ~$ ps aux | grep bluetooth
>>> root      8277  0.0  0.1   4320  2628 ?        Ss   Sep21   0:00
>>> /usr/libexec/bluetooth/bluetoothd -E
>> First and most important gatttool shall not be used along with
>> bluetoothd, it is a stand alone tool for testing. That being said you
>> need to connect in order to discover the attribute the remote device
>> has, without that we only know about the UUIDs advertised nothing
>> else.
> Yes - I was using gatttool to prove I could still connect without going
> through bluetoothd. Should I expect the GATT UUIDs, services and so on
> to be available through dbus once I've called Connect on the device?

If you connect using gatttool it will prevent bluetoothd to discover
the attributes.

> What I was seeing yesterday was that after calling Connect the nodes in
> dbus don't change so I still can't see the GATT bits. Is there a code
> path I could look through to see why this is?

Start bluetoothd with -d option for printing the debugs, then start
btmon and finally use bluetoothctl to connect, if all goes fine
bluetoothctl will print the attributes found.

> Thanks
> Steven Davies
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
