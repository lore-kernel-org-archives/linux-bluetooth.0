Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.00.1608011632330.96508@toad.stack.nl>
References: <alpine.BSF.2.00.1608011427420.69212@toad.stack.nl>
 <CABBYNZJMMSrgRO8EsZ78yOv0R5cwfpz65EQ+-zSV67mX2ee4Dw@mail.gmail.com> <alpine.BSF.2.00.1608011632330.96508@toad.stack.nl>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 1 Aug 2016 21:52:55 +0300
Message-ID: <CABBYNZ+jy2gikskaA6rX+ha2nbWn23TNY7dyFQehjFa3bF-_Rg@mail.gmail.com>
Subject: Re: Registering profile or making discoverable resets adapter class
To: Serge van den Boom <serge@vdboom.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Serge,

On Mon, Aug 1, 2016 at 7:12 PM, Serge van den Boom <serge@vdboom.org> wrote:
> Hi Luiz,
>
> Thanks for the reply.
>
> On Mon, 1 Aug 2016, Luiz Augusto von Dentz wrote:
>> This is a classical problem of using hci* tools along with bluetoothd,
>> they both are trying to control the same thing and then you got a
>> conflict, it shall be one or the other but not both. If you are
>> curious to look at the bluetoothd source code you will see that the we
>> derive the class of the device from the registered services so there
>> is no point in doing anything with hcitool.
>
> That is interesting, because if I don't set the class explicitly, it
> always shows up as 0x100000 when I inspect it. And more relevantly,
> if I don't explicitly set the class, the (HID) device that I am
> implementing won't be discovered.
>
> I haven't been able to find the part of the bluetoothd code that you are
> referring to, so far. I would appreciate it if you could point me in the
> right direction.

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/src/adapter.c
(get_uuid_mask)

For more about registering profiles see:
https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt

You may not be able to register HID as an external profile if the
input plugin is active because afaik both roles have to listen to
certain fixed PSMs, I wouldn't oppose to have this functionally in the
input plugin itself though since we can make it generic enough to use
with HoG implementation.


-- 
Luiz Augusto von Dentz
