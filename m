Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1393955100.16179.0.camel@melech-server.localdomain>
References: <1393903271.6313.3.camel@melech-server.localdomain>
	<1393955100.16179.0.camel@melech-server.localdomain>
Date: Tue, 4 Mar 2014 19:46:48 +0100
Message-ID: <CANq1E4QSkW_0w+89HkstXTu62tLx7A+p1pGW-swKQEdTbHrxeA@mail.gmail.com>
Subject: Re: cannot connect Rock Candy Gesture Controller (wiimote) on Arch Linux
From: David Herrmann <dh.herrmann@gmail.com>
To: "Mark E. Lee" <mark@markelee.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi

On Tue, Mar 4, 2014 at 6:45 PM, Mark E. Lee <mark@markelee.com> wrote:
> On Mon, 2014-03-03 at 22:21 -0500, Mark E. Lee wrote:
>> Salutations,
>>
>> I recently purchased an off-brand wiimote from Target (USA). It is the
>> Rock Candy Gesture Controller (w/o motion plus). I have been unable to
>> connect to it via bluetooth on Arch Linux 64-bit (bluez 5.15-1). This
>> issue has been reported on GitHub
>> <https://github.com/dvdhrm/xwiimote/issues/43#issuecomment-36577704>.
>> I've reiterated my tests with the device below :
>>
>> --OUTPUT of $ hcitool inq --iac=liac
>> Inquiring ...
>>
>> 00:17:AB:39:1C:70 clock offset: 0x5574 class: 0x002504
>>
>> ---OUTPUT of # hcitool info 00:17:AB:39:1C:70---
>> Inquiring ...
>> Requesting information ...
>> BD Address: 00:17:AB:39:1C:70
>> OUI Company: Nintendo Co., Ltd. (00-17-AB)
>> Device Name: Nintendo RVL-CNT-01
>> LMP Version: 3.0 (0x5) LMP Subversion: 0xc
>> Manufacturer: not assigned (771)
>> Features: 0xbc 0x02 0x04 0x38 0x08 0x00 0x00 0x00
>>
>>
>> ---OUTPUT of $ hcitool inq---
>>
>> Inquiring ...
>>
>> ---OUTPUT of $ hcitool scan---
>>
>> Scanning ...
>>
>> ---OUTPUT of $ sdptool browse 00:17:AB:39:1C:70---
>> Browsing 00:17:AB:39:1C:70 ...
>>
>> Service Search failed: Connection timed out
>>
>> ---OUTPUT of $ bluetoothctl; connect 00:17:AB:39:1C:70---
>>
>> Device 00:17:AB:39:1C:70 not available
>>
>> ---OUTPUT of $ sdptool search 00:17:AB:39:1C:70---
>>
>> Unknown service 00:17:AB:39:1C:70
>> ----
>>
>> Any help towards getting this device to work?
>>
>
> Salutations,
>
> I don't have much experience in coding for the wiimote, I was wondering
> if this is simply a wii_id issue in plugins/wiimote.c. How do I find the
> wii_id of the remote?

Thats reported via SDP... but your device seems to not report any such
data ("sdptool browse" times out). No idea whether these devices
provide other ways to get the data. The original Wii-Remotes report
SDP data correctly.

Thanks
David
