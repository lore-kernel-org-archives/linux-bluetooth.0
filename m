Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <CAG0bkvJ8QrvdhCQjwOm79KMZWbE7S=keOfdTy7hyUCV-RmLegQ@mail.gmail.com>
References: <Pine.LNX.4.44L0.1410091030580.1372-100000@iolanthe.rowland.org>
	<1413367888.7328.1.camel@linux-0dmf.site>
	<CAG0bkvJ8QrvdhCQjwOm79KMZWbE7S=keOfdTy7hyUCV-RmLegQ@mail.gmail.com>
Date: Wed, 15 Oct 2014 19:16:39 +0530
Message-ID: <CAG0bkvKo0FQh+8_qTUMbttq_ggBnfr8dgeJAopxyozNK6u4=Fw@mail.gmail.com>
Subject: Re: btusb_intr_complete returns -EPIPE
From: Naveen Kumar Parna <pnaveenkos@gmail.com>
To: Oliver Neukum <oneukum@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	linux-usb@vger.kernel.org, acho@suse.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-usb-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Oliver,

I tried this test in two different set of hardware configurations.



i)                    I tried in multiple test systems which has
EHCI-USB host controller on PCI card and internal USB 2.0
hub("rate-matching" hub). All the test systems with this configuration
gives spurious stall packets.

[lowerlayers@banunxcas29 ~]$ lspci | grep -i usb

00:1a.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05)

00:1d.0 USB Controller: Intel Corporation 5 Series/3400 Series Chipset
USB2 Enhanced Host Controller (rev 05)


lsusb:

Bus 001 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching Hub

Bus 002 Device 002: ID 8087:0020 Intel Corp. Integrated Rate Matching Hub

Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub

Bus 002 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub





ii)                   I found different test systems which has
OHCI-USB host controller on PCI card and internal USB 1.1 hub. All the
test systems with this configuration are not producing stall packets.

 [lowerlayers@camunxcas11 ~]$ lspci | grep -i usb

00:02.0 USB Controller: nVidia Corporation CK804 USB Controller (rev a2)

00:02.1 USB Controller: nVidia Corporation CK804 USB Controller (rev a3)


lsusb:

Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

Bus 002 Device 002: ID 0451:2077 Texas Instruments, Inc. TUSB2077 Hub




My device is a full-speed device. So , stall packets are due to buggy
USB 2.0 hub?


Is there a chance of getting stall packets “If the device runs at low
speed or full speed and is connected through a USB-2.0 hub”? If so it
looks like hub driver issue right?


If the hub is the problem… what will be the better solution? Is it
possible to change internal hub?




Thanks,

Naveen

On Wed, Oct 15, 2014 at 6:39 PM, Naveen Kumar Parna
<pnaveenkos@gmail.com> wrote:
> EHCI controller on PCI card and hub("rate-matching" hub) also internal.
>
> Is it possible to change the internal hub?
>
>
>
> Thanks,
> Naveen
>
> On Wed, Oct 15, 2014 at 3:41 PM, Oliver Neukum <oneukum@suse.de> wrote:
>> On Thu, 2014-10-09 at 10:31 -0400, Alan Stern wrote:
>>> On Thu, 9 Oct 2014, Naveen Kumar Parna wrote:
>>>
>>> > Hi Oliver & Alan,
>>> >
>>> >
>>> >
>>> > Thanks for your inputs.
>>> >
>>> >
>>> >
>>> > I enabled the dynamic debugging for USB HC driver. Please correct me
>>> > if I am wrong.
>>>
>>> Debugging the kernel (or doing anything else to the kernel, for that
>>> matter) won't solve the problem if it is caused by a buggy hub.
>>
>> Indeed. Could you just try a different hub?
>>
>>         Regards
>>                 Oliver
>>
>>
>>
