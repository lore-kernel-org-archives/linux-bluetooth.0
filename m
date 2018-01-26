Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+5=LJnyDSC3MH15AQDJbPrP0F+ChitODqcfmfgOG3oxQ@mail.gmail.com>
References: <CACXFvW2fOcYsJA1xV2QctbRUGCv0aLQ=PUbZ7icSq_KPjvaawg@mail.gmail.com>
 <CABBYNZ+5=LJnyDSC3MH15AQDJbPrP0F+ChitODqcfmfgOG3oxQ@mail.gmail.com>
From: David Wiberg <dwiberg@gmail.com>
Date: Fri, 26 Jan 2018 10:20:36 +0100
Message-ID: <CACXFvW3-S-Ko6HLcD4nVaqL+vpMkYEKVHJKaWpje+R66g5RuRQ@mail.gmail.com>
Subject: Re: Potential ATT_MTU problem when changing device
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

2018-01-25 20:28 GMT+01:00 Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> Hi David,
>
> On Thu, Jan 25, 2018 at 3:08 PM, David Wiberg <dwiberg@gmail.com> wrote:
>> Hello all,
>>
>> I'm running a BlueZ based GATT server where I encounter issues when I
>> switch clients. From looking at logs it seems like the issue is
>> related to ATT_MTU value. The scenario looks like this:
>> 1a. Client A connects and sends an Exchange MTU Request which
>> increases ATT_MTU from the default.
>> 1b. Client A reads/writes some data.
>> 1c. Client A disconnects.
>> 2a. Client B connects.
>> 2b. Client B performs a service discovery.
>> 2c. Service discovery reaches a point where BlueZ sends an attribute
>> list of length 8 (frame length 67 bytes)
>
> This is really weird, it means we are not respecting the default MTU
> but usually the bt_gatt_client instance would trigger the MTU exchange
> anyway if the MTU is not 23 which is usually the case as the kernel
> reports MTU of 672 bytes for L2CAP by default:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/tree/src/device.c?id=0da72fee044f96e7e6a4715dc7aab48eb8c1d5cb#n4794
>
>> 3. Communication seem to stop.
>>
>> I have taken a log of this (see below). The bluetoothd version used
>> while taking the log is 5.41. I have tried running 5.48 manually but
>> didn't notice any difference with regards to this.
>>
>> While trying to understand the issue I noticed that BlueZ 5.42
>> Changelog mentioned "Fix issue with setting correct ATT default MTU
>> value" which tracks back to a mailing list post
>> (https://marc.info/?l=linux-bluetooth&m=147346392907270&w=4) which
>> seem similar to my scenario. The main difference I have seen is that
>> Client B doesn't perform the Exchange MTU procedure.
>
> Quite many things have been fixed since 5.42, for instance there is this patch:
>
> https://git.kernel.org/pub/scm/bluetooth/bluez.git/commit/?id=0da72fee044f96e7e6a4715dc7aab48eb8c1d5cb
>

This seem to be the commit related coupled to the mailing list post I
mentioned, and it seemed promising.

> Perhaps you should try with 5.48 first to see if there is any change
> affecting this behavior.
>

I did try building and running 5.48 and got a log which was identical
except for times and changed ordering of a "Number of Completed
Packets" event which I guess is irrelevant.

When testing 5.48 I configured it with: "../bluez-5.48/configure
--prefix=/home/david/bluez --disable-cups
--host=arm-poky-linux-gnueabi
--with-sysroot=/opt/poky/2.2.2/sysroots/cortexa9hf-neon-poky-linux-gnueabi
--disable-systemd --enable-deprecated --enable-debug --enable-static".
I performed the installation manually by copying the "bluetoothd"
binary since I'm cross-compiling for a remote target. It didn't seem
like it, but can you confirm that there are no other BlueZ libraries
which the "bluetoothd" binary uses which I need to update as well?

>> Does the above analysis seem correct or is there something else which
>> I might have missed?
>>
>> I'm a Bluetooth/BlueZ beginner so any pointers are appreciated.
>>
>> Bonus question: How can I enable the DBG prints for all modules when
>> running bluetoothd? It seems like I only get output from some of the
>> modules (e.g. adapter.c and device.c) but not from others (e.g.
>> nothing related to attributes).
>
> bluetoothd -d should enable debug for every plugin if that is what you
> are looking for.

Ok, I've been running "bluetoothd -d -n" and tried adding DBG prints
to the functions which I thought were involved in setting up and
handling GATT communication but I haven't gotten any outputs from
those (which probably indicates I'm looking at the wrong place). As an
example I added a DBG statement when entering device_attach_att in
device.c. Do you know where MTU handling is performed for a new client
connection which can help me debug the issue?
