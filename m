Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BAY176-W322C4D8EC226A93AC4A2E8D30A0@phx.gbl>
References: <BAY176-W41ED82C7CFED32B2A1FB0CD30D0@phx.gbl>
	<CABBYNZL01nxa2rsGUXZPtbL6Y0QmF7ri=DiV77JxfoJiS0MzBA@mail.gmail.com>
	<BAY176-W322C4D8EC226A93AC4A2E8D30A0@phx.gbl>
Date: Tue, 24 Mar 2015 14:04:04 +0200
Message-ID: <CABBYNZ+EXPGMqf+TFHLg6cKGbgizH=jNgoC0O2k0OikqqUX0LA@mail.gmail.com>
Subject: Re: Bluez5 Device interface
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Ssagarr Patil <hugarsagar@outlook.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Sagar,

On Tue, Mar 24, 2015 at 1:55 PM, Ssagarr Patil <hugarsagar@outlook.com> wrote:
> Hi Luiz,
>
>>
>> On Mon, Mar 23, 2015 at 5:57 PM, Ssagarr Patil <hugarsagar@outlook.com> wrote:
>>> Hi,
>>>
>>> I am working on 3.14 kernel and using bluez5, My device supports ble devices, I havent found how can I write a C application which will pair devices and transfer data.
>>>
>>> Can any one please point me in right direction.
>>
>> Have you looked at bluetoothctl? It is written in C, the source code
>> is under client/:
>>
>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/client
>>
> Thanks for the pointers, that really helped.
>
> Just another quick thing, I dont have BT_RFCOMM_TTY support are there any other alternatives for it ?

We normally don't recommend using TTY, instead use socket API directly
or even better use org.bluez.Profile API:

https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt

-- 
Luiz Augusto von Dentz
