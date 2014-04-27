Return-Path: <cyrus@holtmann.org>
Message-ID: <535D1E82.2080809@gmail.com>
Date: Sun, 27 Apr 2014 19:13:06 +0400
From: Dmitry Grebennikov <dmitry.ew@gmail.com>
MIME-Version: 1.0
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: minipcie bluetooth card not detected
References: <535D03F5.5040100@gmail.com> <878uqqdg1p.fsf@nemi.mork.no>
In-Reply-To: <878uqqdg1p.fsf@nemi.mork.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On 27.04.2014 18:04, Bjørn Mork wrote:
> Dmitry Grebennikov <dmitry.ew@gmail.com> writes:
>
>> Hello,
>> I bought new Intel Wireless 7260 ac + BT card recently and installed
>> to my laptop.
>> Wifi works out of box with iwlwifi module + firmware.
>> But the bluetooth adapter isn't recognized at all.
>> What could be the problem with it?
>>
>> The driver for this card is available and installed (btusb with intel
>> bt firmware).
>> lsusb shows no bluetooth adapter (see attachment).
>> Hcitool scan reports that "Device is not available: No such device"
>> Dmesg and lspci outputs are also attached.
> Yes, doesn't look like there is any USB device is detected at all, so
> drivers don't really matter.
>
>> BIOS is upgraded to the last available update.
> Are you 100% sure that the mini-PCIe slot has USB properly wired up?
> Did the previous module include any USB functions, or do you have some
> other USB mini-PCIe module (e.g. a 3G modem) to test it with?
>
> Does the laptop have any other mini-PCIe slots where you can test the
> 7260 module?
>
> My impression is that laptop vendors don't necessarily wire up and test
> stuff they don't use in their own hardware configurations, like USB
> support in a mini-PCIe slot for intended for PCIe-only wlan cards.
>
> I have installed the same 7260 module in two older laptops with mixed
> results regarding the BT function. In both cases, the 7260 module
> replaced an older PCIe-only wlan module. I had to put a piece of tape
> over the D- and D+ pins to avoid the USB part being detected when
> installing in an Acer 3810tz.  Otherwise the USB device was detected,
> but reading the device descripor failed - resulting in annoying timeouts
> both when the BIOS ran and later when Linux booted.  I have similar
> issues with my Thinkpad X301, but only occasionally on resume.  So I
> haven't yet disabled the USB part... I am hoping to fix the annoying
> serialized probing on resume instead, but haven't gotten around to doing
> that yet.
>
> I am pretty sure that both cases are caused by platform issues specific
> to those laptop models, which were never intended to support any USB
> module in those slots.
>
> But based on these results, I would not be surprised if there are
> laptops out there with mini-PCIe slots completely without USB support.
> That's actually better than the Acer variant IMHO, because you don't
> have to figure out how to physically disable the USB pins yourself.
>
>
> Bjørn
Bjørn,
Thanks for your answer.

My previous wireless card was Broadcom BCM94313HMGB, also with both wifi 
& bt support.
Bluetooth adapter was always detected.
But there were more pins on BCM card than on Intel (some Intel 7260 pins 
have ho wire).

May be the reason is more up-to-date mini-PCIe standard of Intel card, 
which is not supported by the PCIe slot of the motherboard ??
Intel have some information about the PCIe standard requirements here:
http://www.intel.com/support/wireless/wlan/sb/CS-031167.htm

If so, what could be the workarounds?
I now there are some adapters from mini-PCIe to SATA or USB.
But I'm not sure if the speed of connection would be the same as via 
mini-PCIe...

Dmitry Grebennikov
