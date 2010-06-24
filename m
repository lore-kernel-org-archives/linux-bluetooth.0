Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <AANLkTini1WctunEp2H6bjod1BKdDgLaTsJGreb0JSwC6@mail.gmail.com>
References: <AANLkTin25xCMcVDCzbeXO-ZZfxhS4O0foXU8wl4h3tds@mail.gmail.com>
	<20100618184911.GA14514@vigoh>
	<AANLkTimqxFFOM097G55yebL1VV7ZNOqmeeiEC7kyCu7A@mail.gmail.com>
	<AANLkTini1WctunEp2H6bjod1BKdDgLaTsJGreb0JSwC6@mail.gmail.com>
Date: Thu, 24 Jun 2010 12:28:46 +0300
Message-ID: <AANLkTim6WM_Zti-Y-jBeB0VTqigsBW_p9bhuENYCpkvg@mail.gmail.com>
Subject: Re: hci_scodata_packet: hci1 SCO packet for unknown connection handle
	42
From: Andrei Moraru <andrei.moraru.n@gmail.com>
To: "Gustavo F. Padovan" <gustavo@padovan.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hello

On Wed, Jun 23, 2010 at 8:36 PM, Andrei Moraru
<andrei.moraru.n@gmail.com> wrote:
> On Tue, Jun 22, 2010 at 1:24 PM, Andrei Moraru
> <andrei.moraru.n@gmail.com> wrote:
>> On Fri, Jun 18, 2010 at 9:49 PM, Gustavo F. Padovan <gustavo@padovan.org> wrote:
>>> Hi Andrei,
>>>
>>> * Andrei Moraru <andrei.moraru.n@gmail.com> [2010-06-18 15:29:41 +0300]:
>>>
>>>> Hello,
>>>>
>>>> the machine is running CentOS and Asterisk 1.4.32
>>>>
>>>> there are installed bluez-4.66 and asterisk module chan_mobile
>>>>
>>>> The Asterisk crashes sometimes when is using FXO over the bluetooth
>>>> connection via chan_mobile
>>>>
>>>> uname -a:
>>>> 2.6.18-164.el5 #1 SMP Thu Sep 3 03:33:56 EDT 2009 i686 athlon i386 GNU/Linux
>>>
>>> Update your kernel to a 2.6.34 at least and see if you still have this
>>> issue.
>>>
>>> --
>>> Gustavo F. Padovan
>>> http://padovan.org
>>>
>>
>> updated the kernel version
>> #uname -a
>> Linux 2.6.34-default #2 SMP Mon Jun 21 17:55:19 EEST 2010 i686 i686
>> i386 GNU/Linux
>>
>> for building latest kernel, i used the old config of working 2.6.18 kernel.
>>
>> now, the system doesn't recognize any bluetooth adapter. The output of the
>> #hciconfig -a
>> is empty. Also:
>> # hcitool dev
>> Devices:
>> is empty.
>>
>> The output of the lsusb:
>> #lsusb
>> Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
>> Bus 002 Device 003: ID 0a12:0001 Cambridge Silicon Radio, Ltd
>> Bluetooth Dongle (HCI mode)
>> Bus 002 Device 002: ID 0a12:0001 Cambridge Silicon Radio, Ltd
>> Bluetooth Dongle (HCI mode)
>> Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
>>
>> the dbus-daemon is running:
>> # ps ax | grep dbus
>> 22252 ?        Ss     0:00 dbus-daemon --system
>>
>> the version of bluez is 4.66, the latest.
>>
>> The problem is regarding the kernel config?
>>
>> - - - - - - - - - -
>> Andrei Moraru
>>
>
> The problem solved this way:
>
> 1) the kernel was rebuilt with HCI USB support, and the problem is
> gone; the command   hciconfig -a    shows connected BT dongles;
> 2) also, the 2.6.3x +   kernel has compat-wireless stack  available.
> I've built it, and i've rebuilt the Bluez-4.66
> 3) when started compat-wireless, got a lot of
>
> Jun 23 17:16:13 voip kernel: l2cap: Unknown symbol hci_conn_check_link_mode
> Jun 23 17:16:13 voip kernel: l2cap: disagrees about version of symbol
> bt_sock_link
>
> that means on my system some process used the old libbluetooth.so
> with lsof | grep blue* found that process, killed it, and reloaded the
> compat-wireless
>
> Hope it will be usefull for others.
>
> Andrei Moraru.
>

the /var/log/messages are filled with

hci_scodata_packet: hci1 SCO packet for unknown connection handle 0
hci_scodata_packet: hci1 SCO packet for unknown connection handle 43
btusb_isoc_complete: hci1 corrupted SCO packet
btusb_isoc_complete: hci1 corrupted SCO packet
hci_scodata_packet: hci1 SCO packet for unknown connection handle 42



Andrei Moraru.
