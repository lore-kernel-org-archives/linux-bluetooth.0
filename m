Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <BANLkTimbXHrUU8sR6kFwpJ0vdh0ZdbbGaA@mail.gmail.com>
References: <BANLkTimHaJaCjawT2JuW0kH18ihkyVr5Yg@mail.gmail.com>
	<20110511164736.GA22065@joana>
	<BANLkTimFMZ+ohvJsmD9NV7WqFqtX1W4yXw@mail.gmail.com>
	<BANLkTi=t-0QPSV4ZOqCA=OMZaGRhcga+FA@mail.gmail.com>
	<44EE5C37ADC36343B0625A05DD408C48517CE84134@CHEXMB-01.global.atheros.com>
	<4DCCEB4E.7040600@nokia.com>
	<BANLkTikJMKed11aRghia+7as9XGHokOH7w@mail.gmail.com>
	<BANLkTi=H-iEn_oAMb1bwJk6KEAueHRMVtQ@mail.gmail.com>
	<BANLkTi=KK0zUyeBUxWJxUW+EyFvJ_SuALA@mail.gmail.com>
	<BANLkTi=nUb=CxPYMgJQk7HKUF0OCsc7jUw@mail.gmail.com>
	<BANLkTinL=-ODxZa9CGboD0o9443cG-uFkQ@mail.gmail.com>
	<BANLkTi=xgHcwU-2XeKoVweoLGRYQJNUvvg@mail.gmail.com>
	<BANLkTin1wGOa2=_9qHhYmmTbLs_E2xUHXw@mail.gmail.com>
	<BANLkTinCBL_kkwfFH_nu5N7NKktVqxfdsA@mail.gmail.com>
	<BANLkTinj5d0b+Gkz3QAWGCF_Vxc5UTTtrA@mail.gmail.com>
	<BANLkTimbXHrUU8sR6kFwpJ0vdh0ZdbbGaA@mail.gmail.com>
Date: Mon, 30 May 2011 14:57:17 +0100
Message-ID: <BANLkTi=XBig+Kj4e1ywmRLUp2U3fsQdp4w@mail.gmail.com>
Subject: Re: HCI data payload not getting through when using BlueZ
From: Eponymous - <the.epon@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Ok well this has been a complete waste of time. I guess we should just
ignore a potential bug then,...

Is this project dead or something? I can't believe an entire mailing
list can't be bothered to even e-mail back or try and help with this.

On Tue, May 24, 2011 at 9:12 AM, Eponymous - <the.epon@gmail.com> wrote:
> Anyone got any ideas or have we given up on this?
>
> Cheers.
>
> On Tue, May 17, 2011 at 1:45 PM, Eponymous - <the.epon@gmail.com> wrote:
>> lsusb:
>>
>> Bus 001 Device 041: ID 0a12:0001 Cambridge Silicon Radio, Ltd
>> Bluetooth Dongle (HCI mode)
>> Bus 001 Device 040: ID 0a12:0001 Cambridge Silicon Radio, Ltd
>> Bluetooth Dongle (HCI mode)
>>
>> These are definitely plain USB devices. There is no /dev/ttyUSBxx like
>> you would get with the FTDI USB->Serial converters.
>>
>> I've checked over dmesg and the messages (of which there are many
>> since I have eight of these devices) says they are USB.
>>
>> I don't want to become sidetracked from the issue though. Is there
>> anyway to debug this issue without using l2test or any other
>> upperlayers program? The issue I have seen was at the HCI level
>> remember so I'm thinking introducing the upperlayers is going to make
>> things unnecessarily complicated.
>>
>> Cheers.
>>
>>
>> On Tue, May 17, 2011 at 12:50 PM, Anderson Lizardo
>> <anderson.lizardo@openbossa.org> wrote:
>>> Hi,
>>>
>>> On Tue, May 17, 2011 at 3:13 AM, Eponymous - <the.epon@gmail.com> wrote:
>>>> The chips are CSR Bluecores. In order to get upperlayers access rather
>>>>  than HCI over USB you have to configure a key in the firmware.
>>>>
>>>> As soon as I enable upperlayers access the devices disappear from hciconfig.
>>>
>>> As I said, there are various development/prototype devices out there
>>> that use UART (usually CDC ACM or FTDI over USB) transport instead of
>>> "plain" USB. If you post the relevant lines from "dmesg" and "lsusb"
>>> somewhere (after you configure the firmware key), we might be able to
>>> identify the transport.
>>>
>>> For UART, you need to use hciattach on a e.g. /dev/ttyUSBX device
>>> created when plugging the device.
>>>
>>> HTH,
>>> --
>>> Anderson Lizardo
>>> Instituto Nokia de Tecnologia - INdT
>>> Manaus - Brazil
>>>
>>
>
