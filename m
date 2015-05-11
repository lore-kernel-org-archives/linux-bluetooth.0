Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <5550AE14.1010202@lampreynetworks.com>
References: <554CC8A9.4090604@lampreynetworks.com>
	<CABBYNZKtYh2pUiyr5sTV31SMDm6sw=_zX3PphqHmn+99LE7wOg@mail.gmail.com>
	<CABBYNZKHvd6ffM1ixRVce6w+wT_=36zqu-VAZdDOmL=wf3Y-fg@mail.gmail.com>
	<5550AE14.1010202@lampreynetworks.com>
Date: Mon, 11 May 2015 18:16:11 +0300
Message-ID: <CABBYNZLXg5ze2pu5G7FJBj_pbz=Bca-W3NRBgGBMYv0jd54TGA@mail.gmail.com>
Subject: Re: LE device automatic pairing
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Tom Harada <tharada@lampreynetworks.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Tom,

On Mon, May 11, 2015 at 4:26 PM, Tom Harada <tharada@lampreynetworks.com> wrote:
> Hi Luiz,
>
>
> On 05/11/15 04:04, Luiz Augusto von Dentz wrote:
>>
>> Hi Tom,
>>
>> On Mon, May 11, 2015 at 11:03 AM, Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>>
>>> Hi Tom,
>>>
>>> On Fri, May 8, 2015 at 5:31 PM, Tom Harada <tharada@lampreynetworks.com>
>>> wrote:
>>>>
>>>> Hi all,
>>>>
>>>> On a system with kernel 4.0.1 and BlueZ 5.22 or newer, I've noticed that
>>>> BlueZ seems to be automatically pairing with LE devices as soon as it
>>>> detects their advertisements. Is this an intended feature? If so, how
>>>> can I
>>>> prevent it from happening?
>>>
>>> It should be pairing, bluetoothd will create objects for devices found
>>
>> I meant it should not be pairing...
>>
>>> during the scan but they are considered temporary as long as you don't
>>> request to connect or pair, if you connect to it will still not be
>>> paired but it will be stored persistently in the storage so you can
>>> access after restarting bluetoothd.
>>>
>>> With this in mind, what had made you believe we were performing
>>> pairing during scanning?
>
> bluetoothctl prints a line like "[CHG] Device 90:59:AF:1D:F4:66 Paired: yes"
> and reports the device as paired. In other words, it behaves exactly as if I
> had explicitly requested to pair with the device, except I did no such
> thing. In btmon, I can see the pairing request taking place, followed by a
> GATT service discovery. I've attached an example to show what I mean.

This sounds like the device was programmed for auto connect, did you
connected to it before? It would explain why it is connecting but not
why it is paring but perhaps it is because the service connecting does
require encryption e.g. HoG. Try removing the device, it should stop
reconnecting every time the device advertises.


-- 
Luiz Augusto von Dentz
