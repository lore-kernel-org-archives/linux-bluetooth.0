Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
	<CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com>
	<CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com>
	<CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
Date: Fri, 27 Jun 2014 11:32:00 +0300
Message-ID: <CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ryan Press <ryan@presslab.us>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ryan,

On Wed, Jun 25, 2014 at 4:23 PM, Ryan Press <ryan@presslab.us> wrote:
> Hi Luiz,
>
> Yes it will repeat the scan every few seconds.
>
> I paired the device in the Gnome applet.  In the bluetoothctl I could
> see the pair and trust messages like so:
>
> [NEW] Device C5:8C:97:E6:9C:81 Arc Touch Mouse SE
> [CHG] Device C5:8C:97:E6:9C:81 Connected: yes
> [CHG] Device C5:8C:97:E6:9C:81 UUIDs:
>     00001800-0000-1000-8000-00805f9b34fb
>     00001801-0000-1000-8000-00805f9b34fb
>     0000180a-0000-1000-8000-00805f9b34fb
>     0000180f-0000-1000-8000-00805f9b34fb
>     00001812-0000-1000-8000-00805f9b34fb
> [CHG] Device C5:8C:97:E6:9C:81 Paired: yes
> [CHG] Device C5:8C:97:E6:9C:81 Trusted: yes
> [CHG] Device C5:8C:97:E6:9C:81 Modalias: usb:v045Ep07F3d0001
>
> Thanks,
>
> Ryan
>
>
> On Jun 25, 2014 12:08 AM, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> wrote:
>>
>> Hi Ryan,
>>
>> On Wed, Jun 25, 2014 at 5:27 AM, Ryan Press <ryan@presslab.us> wrote:
>> > I have a Microsoft Arc mouse, Surface edition.  This uses Bluetooth
>> > Low Energy.  Under dual boot Windows 8.1 I can connect this mouse, and
>> > it will reconnect just fine if I turn the mouse off/on or Bluetooth
>> > off/on.
>> >
>> > In Fedora rawhide I have Bluez 5.18-2.  I can pair this mouse just
>> > fine, and it will continue to work until I turn the mouse off/on or
>> > turn the computer off/on.  Then it won't reconnect automatically.  If
>> > I go into bluetoothctl I can connect it again and it will then work.
>> >
>> > I looked at bluetoothd and it seems to be doing the LE scan with:
>> > bluetoothd[2356]: src/adapter.c:trigger_passive_scanning()
>> > bluetoothd[2356]: src/adapter.c:passive_scanning_complete() status 0x00
>> > bluetoothd[2356]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
>> >
>> > I look also at hcidump and I see:
>> > < HCI Command: LE Set Random Address (0x08|0x0005) plen 6
>> >     bdaddr 39:6D:E2:EC:17:37
>> >> HCI Event: Command Complete (0x0e) plen 4
>> >     LE Set Random Address (0x08|0x0005) ncmd 1
>> >     status 0x00
>> > < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>> >     type 0x01 (active)
>> >     interval 11.250ms window 11.250ms
>> >     own address: 0x01 (Random) policy: All
>> >> HCI Event: Command Complete (0x0e) plen 4
>> >     LE Set Scan Parameters (0x08|0x000b) ncmd 1
>> >     status 0x00
>> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>> >     value 0x01 (scanning enabled)
>> >     filter duplicates 0x01 (enabled)
>> >> HCI Event: Command Complete (0x0e) plen 4
>> >     LE Set Scan Enable (0x08|0x000c) ncmd 2
>> >     status 0x00
>> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>> >     value 0x00 (scanning disabled)
>> >     filter duplicates 0x00 (disabled)
>> >
>> >
>> > It doesn't seem to be finding anything?  Is there something else I should try?
>>
>> Does it continue to scan or it scan a single time and stops, and have
>> you paired or just connect?

Can you try with current master, we have applied a few patches for reconnection.


-- 
Luiz Augusto von Dentz
