Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <4174905F-4A66-45CD-B135-640881D480C3@holtmann.org>
References: <CAKrOiPRTfCWz+C3Z0BsD92PcgV1A3kGxw3xLMCXuBvOap+6-UQ@mail.gmail.com>
	<4174905F-4A66-45CD-B135-640881D480C3@holtmann.org>
Date: Sun, 7 Jun 2015 11:40:20 +0000
Message-ID: <CAKrOiPRSUyWZ+Kx22=+PhU0VC+Kr2bDuB7TSpJchg+uQvGE2kQ@mail.gmail.com>
Subject: Re: find out why the same usb bluetooth dongle that works on i686
 x86_64, does not work on ppc (ibook g4)
From: naruto canada <narutocanada@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-bluetooth.vger.kernel.org>

On Sat, Jun 6, 2015 at 4:26 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> Hi,
>
>> If anyone like to offer suggestion or help with finding out why the
>> same usb bluetooth dongle (cheap EDR 2.0) that works on i686 x86_64,
>> does not work on ppc (ibook g4). The three machines all run the same
>> software stack, same kernel version, gcc, bluez, dbus, python etc--
>> all the same version. kernel:3.4.107 gcc:4.9.2 bluez:5.23 dbus:1.8.16
>> python:2.7.10 I will give more details if needed. I have btmon log for
>> failed pairing on ppc with nokia phone and good pairing logs as well.
>> also python trace log (does not help much). it seems, on ppc, the
>> dongle always "omit" to send second "connect request", compared with
>> good pairings on x86_64 and i686. the ibook g4 internal usb bluetooth
>> dongle (which I manage to bring to hci mode) also failed with the same
>> sympton (same python error, but not sure about the exact reason).
>> buying another bt dongle may or may not solve the problem. I have
>> attached good pairing and bad pairing log from btmon.
>
> how are you trying to pair this device? My first guess is the it is some endian bug in the tool that retrieves the RFCOMM channel and number and can not see that the SDP records are present.

hi

I managed to get the dongle paired with nokia phone, after changing
port number to big endian in python. I am not sure which package is
responsible (kernel, libc, bluez, python, dbus ?) for converting back
and forth between network and host. In any case, here is the python
code that works with ppc:

#!/usr/bin/env python
from PyOBEX.client import BrowserClient
import sys
address = sys.argv[1]
channel=10 # OBEX File Transfer
# client = BrowserClient(address, channel) # this works with
little-endian machines
client = BrowserClient(address, int("0x0a000000", 0)) # works with
big-endian machine
client.connect()
client.put('test.txt', sys.argv[2])
client.disconnect()

> Regards
>
> Marcel
>
