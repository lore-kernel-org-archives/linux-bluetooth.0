Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAOnmHE9V9iJjbtTLvfS+pFYCaZGmSj4Z6ZK28-ER0K=CZH4TLQ@mail.gmail.com>
References: <CAOnmHE9V9iJjbtTLvfS+pFYCaZGmSj4Z6ZK28-ER0K=CZH4TLQ@mail.gmail.com>
Date: Thu, 30 Jul 2015 10:06:15 +0200
Message-ID: <CAD0=r8xirf3TOwgbZAyVG6oU1W-cWoxLMhojjqBg38Di4Z19bQ@mail.gmail.com>
Subject: Re: Enabling continuous LE Active scan in 5.32?
From: Jakub Pawlowski <jpawlowski@google.com>
To: "Arun K. Singh" <arunkat@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Arun,

On Thu, Jul 30, 2015 at 8:29 AM, Arun K. Singh <arunkat@gmail.com> wrote:
> Hi all,
>
> I am trying to enable continuous LE active scan in Bluez 5.32.
> Platform is Raspberry Pi with kernel 3.18.7+. I find no param in
> adapter-api.txt, to set LE scan interval/window. btmgmt offers some
> respite but setting scan window and interval to same value(via
> scan-params) it still it takes around ~2 sec to trigger next scan.
> Thoughr BT specs says that if scan interval and scan window are same,
> it should trigger continuous scan.
>
> Checking adapter.c, adapter->no_scan_restart_delay parameter looks
> promising if set to true. Still same result - next scan delay ~ 2 sec.
> Not sure if such delay is intentional or platform performance related
> My question is :- Is there a neat way to trigger continuous active LE
> scan even though it may sound power-wise inefficient. Tried to grep
> archives but couldn't find much help.
>
> Any cues would be helpful.

So there is something like that, but you'll probably have to update
your kernel (I think this feature is all in 4.0, or 4.1)

Recently kernel patch landed that enables simultaneous discovery, but
that works only for some controllers, you'll have to check wether your
controller have this quirk set: HCI_QUIRK_SIMULTANEOUS_DISCOVERY
http://git.kernel.org/cgit/linux/kernel/git/bluetooth/bluetooth-next.git/tree/include/net/bluetooth/hci.h#n164

What this does is: previously there was 5s le scan, then 5s classic
scan, then 5s break, now it's simulteanous le and br/edr scan.


Other thing that might interest you is
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/adapter-api.txt
, read SetDiscoveryFilter description.
If you set filter to "le" transport only, you should get what you
want, or even more.
You can play with it calling tools/bluetoothctl when bluetoothd is
running on your device, call "set-scan-filter-transport le" and then
"scan on".
If you don't use bluetoothd on your device, you can still use that
through kernel mgmt api, call "Start Service Discovery Command"
(0x003a)
http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/mgmt-api.txt#n2248
, or try something like tools/btmgmt find-service

Regards,
Jakub



>
> Thanks,
> -Arun
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
