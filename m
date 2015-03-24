Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY176-W316CEF2A32E1C1806692BAD30A0@phx.gbl>
From: Ssagarr Patil <hugarsagar@outlook.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: Bluez5 Device interface
Date: Tue, 24 Mar 2015 18:23:56 +0530
In-Reply-To: <CABBYNZ+EXPGMqf+TFHLg6cKGbgizH=jNgoC0O2k0OikqqUX0LA@mail.gmail.com>
References: <BAY176-W41ED82C7CFED32B2A1FB0CD30D0@phx.gbl>,<CABBYNZL01nxa2rsGUXZPtbL6Y0QmF7ri=DiV77JxfoJiS0MzBA@mail.gmail.com>,<BAY176-W322C4D8EC226A93AC4A2E8D30A0@phx.gbl>,<CABBYNZ+EXPGMqf+TFHLg6cKGbgizH=jNgoC0O2k0OikqqUX0LA@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

>
> On Tue, Mar 24, 2015 at 1:55 PM, Ssagarr Patil <hugarsagar@outlook.com> wrote:
>> Hi Luiz,
>>
>>>
>>> On Mon, Mar 23, 2015 at 5:57 PM, Ssagarr Patil <hugarsagar@outlook.com> wrote:
>>>> Hi,
>>>>
>>>> I am working on 3.14 kernel and using bluez5, My device supports ble devices, I havent found how can I write a C application which will pair devices and transfer data.
>>>>
>>>> Can any one please point me in right direction.
>>>
>>> Have you looked at bluetoothctl? It is written in C, the source code
>>> is under client/:
>>>
>>> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/client
>>>
>> Thanks for the pointers, that really helped.
>>
>> Just another quick thing, I dont have BT_RFCOMM_TTY support are there any other alternatives for it ?
>
> We normally don't recommend using TTY, instead use socket API directly
> or even better use org.bluez.Profile API:
>
> https://git.kernel.org/cgit/bluetooth/bluez.git/tree/doc/profile-api.txt

Thank you very much, are there any sample apps demonstrating socket usage  for heart rate/ tty profile ?
All I see is python scripts as I need to write C apps.

Regards,
Sagar
 		 	   		  