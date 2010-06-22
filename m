Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20100618184911.GA14514@vigoh>
References: <AANLkTin25xCMcVDCzbeXO-ZZfxhS4O0foXU8wl4h3tds@mail.gmail.com>
	<20100618184911.GA14514@vigoh>
Date: Tue, 22 Jun 2010 13:24:27 +0300
Message-ID: <AANLkTimqxFFOM097G55yebL1VV7ZNOqmeeiEC7kyCu7A@mail.gmail.com>
Subject: Re: hci_scodata_packet: hci1 SCO packet for unknown connection handle
	42
From: Andrei Moraru <andrei.moraru.n@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Fri, Jun 18, 2010 at 9:49 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
> Hi Andrei,
>
> * Andrei Moraru <andrei.moraru.n@gmail.com> [2010-06-18 15:29:41 +0300]:
>
>> Hello,
>>
>> the machine is running CentOS and Asterisk 1.4.32
>>
>> there are installed bluez-4.66 and asterisk module chan_mobile
>>
>> The Asterisk crashes sometimes when is using FXO over the bluetooth
>> connection via chan_mobile
>>
>> uname -a:
>> 2.6.18-164.el5 #1 SMP Thu Sep 3 03:33:56 EDT 2009 i686 athlon i386 GNU/Linux
>
> Update your kernel to a 2.6.34 at least and see if you still have this
> issue.
>
> --
> Gustavo F. Padovan
> http://padovan.org
>

updated the kernel version
#uname -a
Linux 2.6.34-default #2 SMP Mon Jun 21 17:55:19 EEST 2010 i686 i686
i386 GNU/Linux

for building latest kernel, i used the old config of working 2.6.18 kernel.

now, the system doesn't recognize any bluetooth adapter. The output of the
#hciconfig -a
is empty. Also:
# hcitool dev
Devices:
is empty.

The output of the lsusb:
#lsusb
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 002 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
Bluetooth Dongle (HCI mode)
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

the dbus-daemon is running:
# ps ax | grep dbus
22252 ?        Ss     0:00 dbus-daemon --system

the version of bluez is 4.66, the latest.

The problem is regarding the kernel config?

- - - - - - - - - -
Andrei Moraru
