Return-Path: <cyrus@holtmann.org>
Message-ID: <560108E5.1010701@steev.me.uk>
Date: Tue, 22 Sep 2015 08:53:09 +0100
From: Steven Davies <linux-bluetooth-list@steev.me.uk>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: BLE: dbus doesn't show GATT characteristics
References: <56006696.3030200@steev.me.uk> <CAASrBQmWuCvyi6-DNAVvaaV2eFSeEVCy2Sr8QzPyy0Ckt0TQbg@mail.gmail.com>
In-Reply-To: <CAASrBQmWuCvyi6-DNAVvaaV2eFSeEVCy2Sr8QzPyy0Ckt0TQbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


>> I'm having a problem using BLE through dbus where the GATT services
>> don't appear after a BLE device has been found during a scan. What is
>> available through dbus is a Device1 node with the correct address and a
>> Name property of the name which was sent in the advertising beacons -
>> however that's the only node available in the tree.
> Are you running bluetoothd with the experimental (-E) flag?
Yes:
~$ ps aux | grep bluetooth
root      8277  0.0  0.1   4320  2628 ?        Ss   Sep21   0:00
/usr/libexec/bluetooth/bluetoothd -E
