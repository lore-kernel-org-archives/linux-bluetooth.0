Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20150824083059.GA504@t440s.lan>
References: <CAOw_LSH1_BjH28+Kn2vwxTrrF+4WBgXCn3FM27rubmCYximR0Q@mail.gmail.com>
 <20150824083059.GA504@t440s.lan>
From: Daniel Lenski <dlenski@gmail.com>
Date: Mon, 24 Aug 2015 10:46:35 -0700
Message-ID: <CAOw_LSH=yftdH7wNAfjOcDdq=76DsxwY544eZRXv0AxRTTaO7g@mail.gmail.com>
Subject: Re: detecting BLE compatibility of an adapter?
To: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Mon, Aug 24, 2015 at 1:30 AM, Johan Hedberg <johan.hedberg@gmail.com> wrote:
> On Sat, Aug 22, 2015, Daniel Lenski wrote:
>> Does Bluez provide a way to detect the compatibility of a Bluetooth
>> adapter with Bluetooth 4.0/Low Energy?
>
> That would be the mgmt settings bit number 9 (see doc/mgmt-api.txt).
> bluetoothd keeps track of this (and enables it automatically if
> available) and you should also be able to see it e.g. with "btmgmt
> info". The mgmt interface tells you both whether it's supported as well
> as whether it's enabled.
>

Thank you!

In the meantime, I found another way to do it, using
hci_read_local_features() and checking for the appropriate bit from
lmp_features_map, specifically features[4]&0x40.

Is there any reason I should prefer one approach over the other?

Dan
