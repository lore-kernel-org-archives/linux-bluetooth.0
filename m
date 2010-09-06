Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1283767613.7529.6.camel@localhost.localdomain>
References: <1283767613.7529.6.camel@localhost.localdomain>
Date: Mon, 6 Sep 2010 14:51:04 +0300
Message-ID: <AANLkTim3SSZhhJOB0DfaOsxMEzsaNKe-dkEf59p-7UQv@mail.gmail.com>
Subject: Re: Running "putkey" for keyboards and mice
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bastien Nocera <hadess@hadess.net>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 6, 2010 at 1:06 PM, Bastien Nocera <hadess@hadess.net> wrote:
> Heya,
>
> Did a small test this week-end on my Macbook, and running "hciconfig"
> with putkey works, adding the just paired keyboards' linkkey into the
> Bluetooth adapter.
>
> This meant that even though I paired the device in Linux, it was still
> available in MacOS X, without any more pairing.
>
> My question is whether we should, for all the adapters listed in the
> hid2hci rules, copy the linkkeys for keyboards and (paired) mice[1] to
> the adapter itself.
>
> How would you like to see this implemented? Would a device plugin be
> good enough to track newly paired devices?

Im not sure this is going to work the other way round, when you pair
in some other SO and than save the key in the chip we would need to
load this device as it is already paired. If that can be done than
IMOH this should be integrated directly in core, perhaps adding
.putkey/.delkey/.getkeys to hciops so we can properly use the keys
stored on chip, but I guess we need to maintain our own storage too
since chips normally have very limited space for storing keys.

-- 
Luiz Augusto von Dentz
Computer Engineer
