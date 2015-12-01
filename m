Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAEZxfGMRs-8Md4YzCqjqb4W1BWYjt7qX8ioU-q2ogrGc5WXsqQ@mail.gmail.com>
References: <CAEZxfGMGixpTkyyc_dyR+NuzGo_wuns9b=y8_A4TWvvve6xFXQ@mail.gmail.com>
 <CAEZxfGNHVkPiJ_PzeQsJ-Xn4sVq3mj1y-OSwZ3c3dGt-zTwNkw@mail.gmail.com>
 <CABBYNZLr588sBy2hyhQnPiV-Gm6n0o7ScmZnH13wz4GTHA-Kgw@mail.gmail.com> <CAEZxfGMRs-8Md4YzCqjqb4W1BWYjt7qX8ioU-q2ogrGc5WXsqQ@mail.gmail.com>
From: =?UTF-8?Q?Fran=C3=A7ois_Beaufort?= <beaufort.francois@gmail.com>
Date: Tue, 1 Dec 2015 13:07:30 +0100
Message-ID: <CAEZxfGM_OPCMOe6kGC0NjyWN6mf1NUnGVzhZ5dp0xaCdq1YL9A@mail.gmail.com>
Subject: Re: Is the GattServices property still updated?
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Could that be related to
https://code.google.com/p/chromium/issues/detail?id=541606 as well?

On Tue, Dec 1, 2015 at 1:04 PM, François Beaufort
<beaufort.francois@gmail.com> wrote:
> On Tue, Dec 1, 2015 at 12:55 PM, Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
>> Hi François,
>>
>> On Tue, Dec 1, 2015 at 12:06 PM, François Beaufort
>> <beaufort.francois@gmail.com> wrote:
>>> For info, here's some background:
>>> https://code.google.com/p/chromium/issues/detail?id=560277
>>>
>>> On Tue, Dec 1, 2015 at 11:03 AM, François Beaufort
>>> <beaufort.francois@gmail.com> wrote:
>>>> I'm not sure to understand what is happening and I'd love your help there.
>>>>
>>>> Is the "GattServices" device property still supposed to be updated
>>>> once all remote GATT services of the device
>>>> have been discovered and exported over D-Bus as mentioned in
>>>> http://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/device-api.txt#n215
>>>>
>>>> If so, does this DBUS messages trace looks good to you:
>>>> http://pastebin.com/emxWB4w1?
>>> --
>>
>> It is a regression caused by restoring the attributes from storage,
>> Ive send a patch for that. Btw, it is not recommended to mess up with
>> the storage manually if someone is doing this please advise to remove
>> the device properly.
>>
>
> What a relief! Thank you Luiz.
>
> For info, I experienced this with Bluez 5.35.
> Will it be part of Bluez 5.37 release?
>
>>
>> --
>> Luiz Augusto von Dentz
