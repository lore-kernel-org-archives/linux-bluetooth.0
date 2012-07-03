Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1341080127.3770.6.camel@belkin4>
References: <1341001405.2852.4.camel@belkin4> <1341080127.3770.6.camel@belkin4>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Date: Tue, 3 Jul 2012 10:21:41 -0300
Message-ID: <CAMOw1v6hMcHqWAhHHyJAsQhjo=nrp62bYm9+TCeOehV_ktoKbw@mail.gmail.com>
Subject: Re: About udev rule removal
To: Pacho Ramos <pacho@gentoo.org>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 30, 2012 at 3:15 PM, Pacho Ramos <pacho@gentoo.org> wrote:
> El vie, 29-06-2012 a las 22:23 +0200, Pacho Ramos escribió:
>> I would like to know what distributions not relying on systemd are
>> supposed to get bluetoothd autostarted now that udev rule was dropped:
>> http://git.kernel.org/?p=bluetooth/bluez.git;a=commit;h=2ea98a6a043710ad4958355b62c682b4767f292e
>>
>> Looks like we go back from udev rule to manually starting bluetoothd all
>> the time, even if bluetooth device is not connected? Why are we going
>> back to old behavior?
>>
>> Thanks for the info
>
> Should we revert that change downstream if we are not going to rely on
> systemd and until udev is changed to break that setup (forcing us to go
> to old "always running" behavior)?

Udev rules are not supposed to spawn daemons. It never was. And now if
you do that udev will kill your daemon after a certain timeout. You'd
need to a) maintain that rule by yourself and b) patch udev to not do
that.


Lucas De Marchi
