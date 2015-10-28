Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CABBYNZLXjY1v2d0w31GBv8Mhdhu7EAeXA04j9XJ5aJgbB1VmHg@mail.gmail.com>
References: <CAD0=r8zi097exhrwL8nJfUeL7wLYSHfpKYvgh33dFGcPYyoedw@mail.gmail.com>
	<CABBYNZ+vA9bXbTj4EY7aw9pGY5gTRaSjLq0zhCVTCryPhCTLJw@mail.gmail.com>
	<CAD0=r8wBqDaHu+3tZR9POSB2MYvU7tVGafYNjufRCgLi7-i14g@mail.gmail.com>
	<CABBYNZLXjY1v2d0w31GBv8Mhdhu7EAeXA04j9XJ5aJgbB1VmHg@mail.gmail.com>
Date: Wed, 28 Oct 2015 14:21:19 -0700
Message-ID: <CAD0=r8z5p3ZhQ_PczVXgsgZ_Me-E6jjHCRN0GiODY77L0gewKw@mail.gmail.com>
Subject: Re: BlueZ: btd_profile callbacks not being triggered properly for LE
 devices ?
From: Jakub Pawlowski <jpawlowski@google.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, Oct 28, 2015 at 1:52 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> Hi Jakub,
>
> On Wed, Oct 28, 2015 at 5:34 PM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>> Hi Johan
>>
>> On Wed, Oct 28, 2015 at 1:13 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> Hi Jakub,
>>>
>>> On Wed, Oct 28, 2015 at 6:10 AM, Jakub Pawlowski <jpawlowski@google.com> wrote:
>>>> Hi,
>>>>
>>>> struct btd_profile contains folowing callbacks:
>>>> .connect
>>>> .disconnect
>>>> .device_probe
>>>> .device_remove
>>>> .accept
>>>>
>>>> I noticed that those callbacks:
>>>> .device_probe
>>>> .device_remove
>>>> .accept
>>>>
>>>> are called properly, but:
>>>> .connect
>>>> .disconnect
>>>>
>>>> callbacks are not being called at all when LE device disconnected
>>>> itself or was connected or autoconnected back. There is no doc, but
>>>> I'm guessing those should be triggered in this cases, right ? Also,
>>>> when I connect first time to a device, only .accept should be
>>>> triggered, but when I connect next time only .connect ?
>>>> Can you please explain what is the intended order of those callbacks ?
>>>> Then I can fix them if I find some discrepencies from intended
>>>> behaviour.
>>>
>>>
>>> Actually it is working as intended since for LE the GATT based drivers
>>> are not responsible for the connection management, unless LE CoC is
>>> used. We actually have an item in the TODO to move the connection
>>> management back to core to simplify the drivers.
>>
>> Ok, so let's say I want to rewrite HoG profile. How do I detect device
>> was connected/disconnected ?
>
> You will get the accept callback which at than you can get access to
> bt_gatt_client, for disconnection the idea is that you register a
> callback directly to bt_att but perhaps we need some other mechanism.
Ok, so here I assumed that .disconnect callback will be called on
disconnections, and that .connect callback will be called on
re-connections, which is not true.

That means that HoG will continue using btd_device_add_attio_callback
to get connected/disconnected ? That is fine for HoG, but what about
profiles that don't want to autoconnect (calling
btd_device_add_attio_callback triggers autoconnect)

> Anyway we first need to move to bt_hog instead.
>
>> Or how do I get current db and client handles that I can use for all operations?
>
> That sound strange, you just have done this for device_info and you
> don't know it? From the accept callback you get the device and with
> that you can access the db that should contain all the details, anyway
> we should probably change bt_hog to use bt_gatt_client and gatt_db
> internally so we can share with android code.

I know how to obtain db and client when .accept is called, but if
device is disconnected and then re-connected those instances will be
no longer valid, right ?
I would have to obtain db and device again, and all I have in
attio_connected_cb is GAttrib, which have no reference to db or
client.

>
>
> --
> Luiz Augusto von Dentz
