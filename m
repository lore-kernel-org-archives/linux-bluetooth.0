Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <560108E5.1010701@steev.me.uk>
References: <56006696.3030200@steev.me.uk>
	<CAASrBQmWuCvyi6-DNAVvaaV2eFSeEVCy2Sr8QzPyy0Ckt0TQbg@mail.gmail.com>
	<560108E5.1010701@steev.me.uk>
Date: Tue, 22 Sep 2015 13:12:40 +0300
Message-ID: <CABBYNZJJo0YoiHkONvNer=4W=cmFbRZ23qR1kw3GdMLoAd=Lrg@mail.gmail.com>
Subject: Re: BLE: dbus doesn't show GATT characteristics
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Steven Davies <linux-bluetooth-list@steev.me.uk>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Steven,

On Tue, Sep 22, 2015 at 10:53 AM, Steven Davies
<linux-bluetooth-list@steev.me.uk> wrote:
>
>>> I'm having a problem using BLE through dbus where the GATT services
>>> don't appear after a BLE device has been found during a scan. What is
>>> available through dbus is a Device1 node with the correct address and a
>>> Name property of the name which was sent in the advertising beacons -
>>> however that's the only node available in the tree.
>> Are you running bluetoothd with the experimental (-E) flag?
> Yes:
> ~$ ps aux | grep bluetooth
> root      8277  0.0  0.1   4320  2628 ?        Ss   Sep21   0:00
> /usr/libexec/bluetooth/bluetoothd -E

First and most important gatttool shall not be used along with
bluetoothd, it is a stand alone tool for testing. That being said you
need to connect in order to discover the attribute the remote device
has, without that we only know about the UUIDs advertised nothing
else.


-- 
Luiz Augusto von Dentz
