Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <B9453039-6E2D-483F-9B1A-716531B94FD6@holtmann.org>
References: <CAKrOiPRTfCWz+C3Z0BsD92PcgV1A3kGxw3xLMCXuBvOap+6-UQ@mail.gmail.com>
	<4174905F-4A66-45CD-B135-640881D480C3@holtmann.org>
	<CAKrOiPRSUyWZ+Kx22=+PhU0VC+Kr2bDuB7TSpJchg+uQvGE2kQ@mail.gmail.com>
	<B9453039-6E2D-483F-9B1A-716531B94FD6@holtmann.org>
Date: Tue, 9 Jun 2015 08:39:21 +0000
Message-ID: <CAKrOiPTfuydNNJhjtvS3CudV3dp6Ofic11qj4wjGFjjTbA40Ag@mail.gmail.com>
Subject: Re: find out why the same usb bluetooth dongle that works on i686
 x86_64, does not work on ppc (ibook g4)
From: naruto canada <narutocanada@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Jun 9, 2015 at 7:37 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi Naruto,
>
>>>> If anyone like to offer suggestion or help with finding out why the
>>>> same usb bluetooth dongle (cheap EDR 2.0) that works on i686 x86_64,
>>>> does not work on ppc (ibook g4). The three machines all run the same
>>>> software stack, same kernel version, gcc, bluez, dbus, python etc--
>>>> all the same version. kernel:3.4.107 gcc:4.9.2 bluez:5.23 dbus:1.8.16
>>>> python:2.7.10 I will give more details if needed. I have btmon log for
>>>> failed pairing on ppc with nokia phone and good pairing logs as well.
>>>> also python trace log (does not help much). it seems, on ppc, the
>>>> dongle always "omit" to send second "connect request", compared with
>>>> good pairings on x86_64 and i686. the ibook g4 internal usb bluetooth
>>>> dongle (which I manage to bring to hci mode) also failed with the same
>>>> sympton (same python error, but not sure about the exact reason).
>>>> buying another bt dongle may or may not solve the problem. I have
>>>> attached good pairing and bad pairing log from btmon.
>>>
>>> how are you trying to pair this device? My first guess is the it is some endian bug in the tool that retrieves the RFCOMM channel and number and can not see that the SDP records are present.
>>
>> hi
>>
>> I managed to get the dongle paired with nokia phone, after changing
>> port number to big endian in python. I am not sure which package is
>> responsible (kernel, libc, bluez, python, dbus ?) for converting back
>> and forth between network and host. In any case, here is the python
>> code that works with ppc:
>>
>> #!/usr/bin/env python
>> from PyOBEX.client import BrowserClient
>> import sys
>> address = sys.argv[1]
>> channel=10 # OBEX File Transfer
>> # client = BrowserClient(address, channel) # this works with
>> little-endian machines
>> client = BrowserClient(address, int("0x0a000000", 0)) # works with
>> big-endian machine
>> client.connect()
>> client.put('test.txt', sys.argv[2])
>> client.disconnect()
>
> the RFCOMM channels are single byte. So there should be no issue. So this sounds like a bug in the Python code of BrowserClient.
>
> Unless there is an endian bug in our obexd D-Bus code. Luiz could look into that.

BTW, I get both pcc and x86 working after updating kernel to 3.10.79
(for both), just in case you guys need this info.

>
> Regards
>
> Marcel
>
