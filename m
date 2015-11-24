Return-Path: <beaufort.francois@gmail.com>
MIME-Version: 1.0
In-Reply-To: <2DBBB005-93A7-47ED-8E88-1D6B92ACCC07@holtmann.org>
References: <CAEZxfGPTxwUZzU+3XSV-uiN+DMz+hyOKiiZfgF+oD6pp=-XiOA@mail.gmail.com>
 <AAC95ACC-36E4-4618-8F49-53F78AE93AA6@holtmann.org> <2045332.GytFuFKTvp@ix>
 <CAEZxfGOdyZat1evKm0Jfwg=knuigGdfK_wVqS8NG=zFAY3aRXg@mail.gmail.com> <2DBBB005-93A7-47ED-8E88-1D6B92ACCC07@holtmann.org>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 24 Nov 2015 13:05:06 +0100
Message-ID: <CAEZxfGOTP2hTKx6j3rcK9cwyvzQa-XryG0LTp3wouTQ0CckT7Q@mail.gmail.com>
Subject: Re: Unknown Connection Identifier
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Szymon Janc <szymon.janc@codecoup.pl>, linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 24, 2015 at 12:00 PM, Marcel Holtmann <marcel@holtmann.org> wro=
te:
> Hi Francois,
>
>> Thanks both of you for your input.
>>
>> Here are my 100% reproducible steps:
>> - Restart bluetoothd to start fresh
>> - Remove cached device (remove 88:0F:10:9D:EB:42)
>> - Run basic scan (scan on)
>> - Wait for the device to pop up in results and stop scan (scan off)
>> - Try to connect to it (connect 88:0F:10:9D:EB:42)
>>
>> As you can read below I now have 2 "LE Connection Complete (0x01)" event=
s.
>>
>> Bluetooth monitor ver 5.35
>> =3D New Index: A4:17:31:78:A6:04 (BR/EDR,USB,hci0)
>>                [hci0] 0.624321
>> < HCI Command: LE Add Device To White List (0x08|0x0011) plen 7
>>               [hci0] 11.038826
>>        Address type: Public (0x00)
>>        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
>>> HCI Event: Command Complete (0x0e) plen 4                              =
             [hci0] 11.040084
>>      LE Add Device To White List (0x08|0x0011) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Set Scan Parameters (0x08|0x000b) plen 7
>>               [hci0] 11.040125
>>        Type: Passive (0x00)
>>        Interval: 60.000 msec (0x0060)
>>        Window: 30.000 msec (0x0030)
>>        Own address type: Public (0x00)
>>        Filter policy: Ignore not in white list (0x01)
>>> HCI Event: Command Complete (0x0e) plen 4                              =
             [hci0] 11.041085
>>      LE Set Scan Parameters (0x08|0x000b) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>               [hci0] 11.041134
>>        Scanning: Enabled (0x01)
>>        Filter duplicates: Enabled (0x01)
>>> HCI Event: Command Complete (0x0e) plen 4                              =
             [hci0] 11.042084
>>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>>        Status: Success (0x00)
>>> HCI Event: LE Meta Event (0x3e) plen 43                                =
             [hci0] 15.668141
>>      LE Advertising Report (0x02)
>>        Num reports: 1
>>        Event type: Connectable undirected - ADV_IND (0x00)
>>        Address type: Public (0x00)
>>        Address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
>>        Data length: 31
>>        Flags: 0x06
>>          LE General Discoverable Mode
>>          BR/EDR Not Supported
>>        Company: Anhui Huami Information Technology Co., Ltd. (343)
>>          Data: 00f70b676930f4c909f4a5acd792a299ff02880f109deb42
>>        RSSI: -59 dBm (0xc5)
>> < HCI Command: LE Set Scan Enable (0x08|0x000c) plen 2
>>               [hci0] 15.668289
>>        Scanning: Disabled (0x00)
>>        Filter duplicates: Disabled (0x00)
>>> HCI Event: Command Complete (0x0e) plen 4                              =
             [hci0] 15.669062
>>      LE Set Scan Enable (0x08|0x000c) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Create Connection (0x08|0x000d) plen 25
>>               [hci0] 15.669171
>>        Scan interval: 60.000 msec (0x0060)
>>        Scan window: 30.000 msec (0x0030)
>
> we might should have the LE Create Connection scan with a full duty cycle=
 here. So it does not miss any advertising PDUs.
>
>>        Filter policy: White list is not used (0x00)
>>        Peer address type: Public (0x00)
>>        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
>>        Own address type: Public (0x00)
>>        Min connection interval: 50.00 msec (0x0028)
>>        Max connection interval: 70.00 msec (0x0038)
>>        Connection latency: 0x0000
>>        Supervision timeout: 420 msec (0x002a)
>>        Min connection length: 0.000 msec (0x0000)
>>        Max connection length: 0.000 msec (0x0000)
>>> HCI Event: Command Status (0x0f) plen 4                                =
             [hci0] 15.670065
>>      LE Create Connection (0x08|0x000d) ncmd 1
>>        Status: Success (0x00)
>> < HCI Command: LE Create Connection Cancel (0x08|0x000e) plen 0
>>               [hci0] 17.670566
>
> And I think we need to increase the timeout to something like 4-5 seconds=
 before we give up and try the next device that might have been found.
>
>>> HCI Event: Command Complete (0x0e) plen 4                              =
             [hci0] 17.672048
>>      LE Create Connection Cancel (0x08|0x000e) ncmd 1
>>        Status: Success (0x00)
>>> HCI Event: LE Meta Event (0x3e) plen 19                                =
             [hci0] 17.674036
>>      LE Connection Complete (0x01)
>>        Status: Unknown Connection Identifier (0x02)
>>        Handle: 32
>>        Role: Master (0x00)
>>        Peer address type: Public (0x00)
>>        Peer address: 88:0F:10:9D:EB:42 (OUI 88-0F-10)
>>        Connection interval: 67.50 msec (0x0036)
>>        Connection latency: 0.00 msec (0x0000)
>>        Supervision timeout: 420 msec (0x002a)
>>        Master clock accuracy: 0x00
>> @ Connect Failed: 88:0F:10:9D:EB:42 (1) status 0x02
>
> This one still needs to be fixed. It is a bug. The implementation is too =
naive. The unknown connection identifier is actually the success case for L=
E Create Connection Cancel command. And since we keep trying until the conn=
ection timeout hits, this is not an error at this point.

Where should I file that bug so that I can keep track of it?

>
> Regards
>
> Marcel
>
