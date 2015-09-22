Return-Path: <cyrus@holtmann.org>
Message-ID: <56015B46.90505@steev.me.uk>
Date: Tue, 22 Sep 2015 14:44:38 +0100
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
MIME-Version: 1.0
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Subject: Re: BLE: dbus doesn't show GATT characteristics
References: <56006696.3030200@steev.me.uk>	<CAASrBQmWuCvyi6-DNAVvaaV2eFSeEVCy2Sr8QzPyy0Ckt0TQbg@mail.gmail.com>	<560108E5.1010701@steev.me.uk> <CABBYNZJJo0YoiHkONvNer=4W=cmFbRZ23qR1kw3GdMLoAd=Lrg@mail.gmail.com>
In-Reply-To: <CABBYNZJJo0YoiHkONvNer=4W=cmFbRZ23qR1kw3GdMLoAd=Lrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

>>>> I'm having a problem using BLE through dbus where the GATT services
>>>> don't appear after a BLE device has been found during a scan. What is
>>>> available through dbus is a Device1 node with the correct address and a
>>>> Name property of the name which was sent in the advertising beacons -
>>>> however that's the only node available in the tree.
>>> Are you running bluetoothd with the experimental (-E) flag?
>> Yes:
>> ~$ ps aux | grep bluetooth
>> root      8277  0.0  0.1   4320  2628 ?        Ss   Sep21   0:00
>> /usr/libexec/bluetooth/bluetoothd -E
> First and most important gatttool shall not be used along with
> bluetoothd, it is a stand alone tool for testing. That being said you
> need to connect in order to discover the attribute the remote device
> has, without that we only know about the UUIDs advertised nothing
> else.
Yes - I was using gatttool to prove I could still connect without going
through bluetoothd. Should I expect the GATT UUIDs, services and so on
to be available through dbus once I've called Connect on the device?

What I was seeing yesterday was that after calling Connect the nodes in
dbus don't change so I still can't see the GATT bits. Is there a code
path I could look through to see why this is?

Thanks
Steven Davies
