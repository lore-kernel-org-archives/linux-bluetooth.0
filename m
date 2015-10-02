Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
References: <CAHmfHqTrHGpwyxaP6rsBNk5FamFxJMFBy547UY21vQLdLSDc4Q@mail.gmail.com>
Date: Fri, 2 Oct 2015 10:15:19 +0300
Message-ID: <CABBYNZLjPt_vCcW5JswbK+utJvVm8SbEAus7dw0jt+fW3Q8Fug@mail.gmail.com>
Subject: Re: Cannot write to BLE thermal printer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Leon Nicholls <lnicholls@google.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Leon,

On Fri, Oct 2, 2015 at 9:33 AM, Leon Nicholls <lnicholls@google.com> wrote:
> Hi
> I'm trying to write a value to a BLE thermal printer using the Web
> Bluetooth API on ChromeOS (using Bluez 5.33). I can connect to the
> device and find the service and characteristic. But when I try and
> write to the characteristic an error is thrown (although it looks like
> it disconnects before the write happens). Please find attached
> log.

> < ACL Data TX: Handle 32 flags 0x00 dlen 9
>                                                     [hci0] 18.030692
>       ATT: Read Blob Request (0x0c) len 4
>         Handle: 0x0003
>         Offset: 0x0000

So this seems to be the last command in the sent but right after that
we disconnect:

> < HCI Command: Disconnect (0x01|0x0006) plen 3
>                                                     [hci0] 50.049295
>         Handle: 32
>         Reason: Remote User Terminated Connection (0x13)
>> HCI Event: Command Status (0x0f) plen 4                                                                                  [hci0] 50.050594
>       Disconnect (0x01|0x0006) ncmd 1
>         Status: Success (0x00)
>> HCI Event: Vendor (0xff) plen 7                                                                                          [hci0] 50.055689
>         82 70 90 80 10 36 59                             .p...6Y
>> HCI Event: Disconnect Complete (0x05) plen 4                                                                             [hci0] 50.056491
>         Status: Success (0x00)
>         Handle: 32
>         Reason: Connection Terminated By Local Host (0x16)
> @ Device Disconnected: 0F:04:E0:51:44:8B (2) reason 2l

I recall something similar was fixed in upstream so you might want to
try with 5.35, this is probably caused by not registering any driver
for the profile (see
RegisterProfile:https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/gatt-api.txt)
which should be used if you want to auto connect as soon the device
start advertising.

-- 
Luiz Augusto von Dentz
