Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com>
References: <CABx3TkUE_qFJggDNw8wUCcQzrdo6L5p3Ag3djpiUewwk_uJu5Q@mail.gmail.com>
	<CABBYNZLhONv81vAN8OAFX1dK5UCm44AYb2sZLyUp2gRQ4CywcA@mail.gmail.com>
	<CABx3TkVgs6J1UR8Z5Rbyd2e90p74RfggpzsvnxzgWGgN9c2Epg@mail.gmail.com>
	<CABx3TkUbD+svVpNW+0vjWS3pujZsECTOO0XxJmUQY6wOEkkZQw@mail.gmail.com>
	<CABBYNZKyd_jgSO-NpzbMhVo=Y1ZzWC29bX4q1YBQd73Mm4HWaQ@mail.gmail.com>
	<CABx3TkW-PhVeD2=Nr2pj5iL2uUm8T0B+w+WFB2EwaeW7OtChtQ@mail.gmail.com>
	<CABBYNZK2v-US-kOh6v28EKnqsLyjXrDUGpNJE6Wcfqv3YBwm9A@mail.gmail.com>
Date: Sat, 28 Jun 2014 13:07:12 -0700
Message-ID: <CABx3TkU+JvmekRYBS1iYuriJaprMznH=g6vw2MVYi+2Vqc7Y5w@mail.gmail.com>
Subject: Re: LE mouse reconnect problem
From: Ryan Press <ryan@presslab.us>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 28, 2014 at 12:22 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> On Sat, Jun 28, 2014 at 6:50 PM, Ryan Press <ryan@presslab.us> wrote:
>> On Fri, Jun 27, 2014 at 1:32 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Ryan,
>>>
>>> On Wed, Jun 25, 2014 at 4:23 PM, Ryan Press <ryan@presslab.us> wrote:
>>>> Hi Luiz,
>>>>
>>>> Yes it will repeat the scan every few seconds.
>>>>
>>>> I paired the device in the Gnome applet.  In the bluetoothctl I could
>>>> see the pair and trust messages like so:
>>>>
>>>> [NEW] Device C5:8C:97:E6:9C:81 Arc Touch Mouse SE
>>>> [CHG] Device C5:8C:97:E6:9C:81 Connected: yes
>>>> [CHG] Device C5:8C:97:E6:9C:81 UUIDs:
>>>>     00001800-0000-1000-8000-00805f9b34fb
>>>>     00001801-0000-1000-8000-00805f9b34fb
>>>>     0000180a-0000-1000-8000-00805f9b34fb
>>>>     0000180f-0000-1000-8000-00805f9b34fb
>>>>     00001812-0000-1000-8000-00805f9b34fb
>>>> [CHG] Device C5:8C:97:E6:9C:81 Paired: yes
>>>> [CHG] Device C5:8C:97:E6:9C:81 Trusted: yes
>>>> [CHG] Device C5:8C:97:E6:9C:81 Modalias: usb:v045Ep07F3d0001
>>>>
>>>> Thanks,
>>>>
>>>> Ryan
>>>>
>>>>
>>>> On Jun 25, 2014 12:08 AM, "Luiz Augusto von Dentz" <luiz.dentz@gmail.com> wrote:
>>>>>
>>>>> Hi Ryan,
>>>>>
>>>>> On Wed, Jun 25, 2014 at 5:27 AM, Ryan Press <ryan@presslab.us> wrote:
>>>>> > I have a Microsoft Arc mouse, Surface edition.  This uses Bluetooth
>>>>> > Low Energy.  Under dual boot Windows 8.1 I can connect this mouse, and
>>>>> > it will reconnect just fine if I turn the mouse off/on or Bluetooth
>>>>> > off/on.
>>>>> >
>>>>> > In Fedora rawhide I have Bluez 5.18-2.  I can pair this mouse just
>>>>> > fine, and it will continue to work until I turn the mouse off/on or
>>>>> > turn the computer off/on.  Then it won't reconnect automatically.  If
>>>>> > I go into bluetoothctl I can connect it again and it will then work.
>>>>> >
>>>>> > I looked at bluetoothd and it seems to be doing the LE scan with:
>>>>> > bluetoothd[2356]: src/adapter.c:trigger_passive_scanning()
>>>>> > bluetoothd[2356]: src/adapter.c:passive_scanning_complete() status 0x00
>>>>> > bluetoothd[2356]: src/adapter.c:discovering_callback() hci0 type 6 discovering 1
>>>>> >
>>>>> > I look also at hcidump and I see:
>>>>> > < HCI Command: LE Set Random Address (0x08|0x0005) plen 6
>>>>> >     bdaddr 39:6D:E2:EC:17:37
>>>>> >> HCI Event: Command Complete (0x0e) plen 4
>>>>> >     LE Set Random Address (0x08|0x0005) ncmd 1
>>>>> >     status 0x00
>>>>> > < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>>>> >     type 0x01 (active)
>>>>> >     interval 11.250ms window 11.250ms
>>>>> >     own address: 0x01 (Random) policy: All
>>>>> >> HCI Event: Command Complete (0x0e) plen 4
>>>>> >     LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>>>> >     status 0x00
>>>>> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>> >     value 0x01 (scanning enabled)
>>>>> >     filter duplicates 0x01 (enabled)
>>>>> >> HCI Event: Command Complete (0x0e) plen 4
>>>>> >     LE Set Scan Enable (0x08|0x000c) ncmd 2
>>>>> >     status 0x00
>>>>> > < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>>>> >     value 0x00 (scanning disabled)
>>>>> >     filter duplicates 0x00 (disabled)
>>>>> >
>>>>> >
>>>>> > It doesn't seem to be finding anything?  Is there something else I should try?
>>>>>
>>>>> Does it continue to scan or it scan a single time and stops, and have
>>>>> you paired or just connect?
>>>
>>> Can you try with current master, we have applied a few patches for reconnection.
>>>
>>>
>>> --
>>> Luiz Augusto von Dentz
>> Hi Luiz,
>>
>> I have compiled and install the git Bluez.
>>
>> It's the same as before, I can pair it and it will work, but it won't
>> automatically reconnect.  Using bluetoothctl and "connect" command I
>> can manually reconnect.
>>
>
> No top posting please. Im running out of ideas, are you sure the mouse
> is advertising using the same address?

I just tested with "hcitool lescan" and it connected okay.  So I
looked at a "hcidump" for the hcitool scan and for the Bluez scan and
they are a bit different.

Here is the one from "hcitool lescan":

HCI sniffer - Bluetooth packet analyzer ver 5.20
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
2014-06-28 12:54:01.421267 < HCI Command: LE Set Scan Parameters
(0x08|0x000b) plen 7
    type 0x01 (active)
    interval 10.000ms window 10.000ms
    own address: 0x00 (Public) policy: All
2014-06-28 12:54:01.422140 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
2014-06-28 12:54:01.422238 < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
2014-06-28 12:54:01.423144 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
2014-06-28 12:54:01.425141 > HCI Event: LE Meta Event (0x3e) plen 12
    LE Advertising Report
      ADV_DIRECT_IND - Connectable directed advertising (1)
      bdaddr C5:8C:97:E9:9C:81 (Random)
      RSSI: -35
2014-06-28 12:54:01.425333 < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
2014-06-28 12:54:01.429161 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
2014-06-28 12:54:01.429409 < HCI Command: LE Create Connection
(0x08|0x000d) plen 25
    bdaddr C5:8C:97:E9:9C:81 type 1
    interval 96 window 48 initiator_filter 0
    own_bdaddr_type 0 min_interval 40 max_interval 56
    latency 0 supervision_to 42 min_ce 0 max_ce 0
2014-06-28 12:54:01.430157 > HCI Event: Command Status (0x0f) plen 4
    LE Create Connection (0x08|0x000d) status 0x00 ncmd 2
2014-06-28 12:54:01.433220 > HCI Event: LE Meta Event (0x3e) plen 19
    LE Connection Complete
      status 0x00 handle 3585, role master
      bdaddr C5:8C:97:E9:9C:81 (Random)
2014-06-28 12:54:01.433476 < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x01 (enabled)
2014-06-28 12:54:01.434141 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 1
    status 0x0c
    Error: Command Disallowed
2014-06-28 12:54:01.434206 < HCI Command: LE Start Encryption
(0x08|0x0019) plen 28
2014-06-28 12:54:01.435140 > HCI Event: Command Status (0x0f) plen 4
    LE Start Encryption (0x08|0x0019) status 0x00 ncmd 1
2014-06-28 12:54:01.848191 > HCI Event: Encrypt Change (0x08) plen 4
    status 0x00 handle 3585 encrypt 0x01
2014-06-28 12:54:01.848461 < ACL data: handle 3585 flags 0x00 dlen 11
    ATT: Read By Type req (0x08)
      start 0x000c, end 0x0010
      type-uuid 0x2803
2014-06-28 12:54:01.918203 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 3585 packets 1
2014-06-28 12:54:01.988079 > ACL data: handle 3585 flags 0x02 dlen 20
    ATT: Read By Type resp (0x09)
      length: 7
        handle 0x000d, value 0x02 0x0e 0x00 0x29 0x2a
        handle 0x000f, value 0x02 0x10 0x00 0x50 0x2a
2014-06-28 12:54:01.988364 < ACL data: handle 3585 flags 0x00 dlen 7
    ATT: MTU req (0x02)
      client rx mtu 672
2014-06-28 12:54:02.058200 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 3585 packets 1
2014-06-28 12:54:02.127941 > ACL data: handle 3585 flags 0x02 dlen 7
    ATT: MTU resp (0x03)
      server rx mtu 23
2014-06-28 12:54:02.128174 < ACL data: handle 3585 flags 0x00 dlen 7
    ATT: Read req (0x0a)
      handle 0x0010
2014-06-28 12:54:02.198204 > HCI Event: Number of Completed Packets
(0x13) plen 5
    handle 3585 packets 1
2014-06-28 12:54:02.267972 > ACL data: handle 3585 flags 0x02 dlen 12
    ATT: Read resp (0x0b)

And here is the one from the regular bluetoothd:

HCI sniffer - Bluetooth packet analyzer ver 5.20
device: hci0 snap_len: 1500 filter: 0xffffffffffffffff
2014-06-28 12:55:30.229459 < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
2014-06-28 12:55:30.232444 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
2014-06-28 12:55:33.954807 < HCI Command: LE Set Random Address
(0x08|0x0005) plen 6
    bdaddr 00:67:25:80:95:CD
2014-06-28 12:55:33.955419 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Random Address (0x08|0x0005) ncmd 1
    status 0x00
2014-06-28 12:55:33.955494 < HCI Command: LE Set Scan Parameters
(0x08|0x000b) plen 7
    type 0x01 (active)
    interval 11.250ms window 11.250ms
    own address: 0x01 (Random) policy: All
2014-06-28 12:55:33.956440 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Parameters (0x08|0x000b) ncmd 1
    status 0x00
2014-06-28 12:55:33.956509 < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2
    value 0x01 (scanning enabled)
    filter duplicates 0x01 (enabled)
2014-06-28 12:55:33.957440 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00
2014-06-28 12:55:44.213285 < HCI Command: LE Set Scan Enable
(0x08|0x000c) plen 2
    value 0x00 (scanning disabled)
    filter duplicates 0x00 (disabled)
2014-06-28 12:55:44.215502 > HCI Event: Command Complete (0x0e) plen 4
    LE Set Scan Enable (0x08|0x000c) ncmd 2
    status 0x00


It looks like Bluez is using random address and hcitool lescan is
using public address.  I don't know why to use random or public.

hcitool lescan:
    own address: 0x00 (Public) policy: All
bluetoothd:
    own address: 0x01 (Random) policy: All

And the advertise address from the mouse is the same.

hcitool:
    bdaddr C5:8C:97:E9:9C:81 (Random)
bluetoothctl:
[NEW] Device C5:8C:97:E9:9C:81 Arc Touch Mouse SE


Thanks.
Ryan
