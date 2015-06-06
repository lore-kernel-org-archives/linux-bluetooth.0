Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: find out why the same usb bluetooth dongle that works on i686 x86_64, does not work on ppc (ibook g4)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAKrOiPRTfCWz+C3Z0BsD92PcgV1A3kGxw3xLMCXuBvOap+6-UQ@mail.gmail.com>
Date: Sat, 6 Jun 2015 06:26:56 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <4174905F-4A66-45CD-B135-640881D480C3@holtmann.org>
References: <CAKrOiPRTfCWz+C3Z0BsD92PcgV1A3kGxw3xLMCXuBvOap+6-UQ@mail.gmail.com>
To: naruto canada <narutocanada@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

> If anyone like to offer suggestion or help with finding out why the
> same usb bluetooth dongle (cheap EDR 2.0) that works on i686 x86_64,
> does not work on ppc (ibook g4). The three machines all run the same
> software stack, same kernel version, gcc, bluez, dbus, python etc--
> all the same version. kernel:3.4.107 gcc:4.9.2 bluez:5.23 dbus:1.8.16
> python:2.7.10 I will give more details if needed. I have btmon log for
> failed pairing on ppc with nokia phone and good pairing logs as well.
> also python trace log (does not help much). it seems, on ppc, the
> dongle always "omit" to send second "connect request", compared with
> good pairings on x86_64 and i686. the ibook g4 internal usb bluetooth
> dongle (which I manage to bring to hci mode) also failed with the same
> sympton (same python error, but not sure about the exact reason).
> buying another bt dongle may or may not solve the problem. I have
> attached good pairing and bad pairing log from btmon.

how are you trying to pair this device? My first guess is the it is some endian bug in the tool that retrieves the RFCOMM channel and number and can not see that the SDP records are present.

Regards

Marcel

