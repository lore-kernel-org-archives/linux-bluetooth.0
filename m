Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1816\))
Subject: Re: Wireshark and new BlueZ BTSNOOP format
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CALkxMhHvbgaS4cxbrrQFGk59W9LoR-R47D-iTDBkrw3TG7sofA@mail.gmail.com>
Date: Tue, 5 Nov 2013 13:25:21 +0100
Cc: "linux-bluetooth@vger.kernel.org development"
	<linux-bluetooth@vger.kernel.org>
Message-Id: <66980755-B25D-4EE6-A443-5A60AD75351D@holtmann.org>
References: <CALkxMhFHWv7kxfRKrN3kq8NVRgVyk0vNpiR8ryKTm8s2b_exKQ@mail.gmail.com> <AF259BFC-2022-4280-9F98-D4679A280A84@holtmann.org> <CALkxMhHvbgaS4cxbrrQFGk59W9LoR-R47D-iTDBkrw3TG7sofA@mail.gmail.com>
To: Michal Labedzki <michal.labedzki@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Michal,

>>> There is a need to add support for latest BTSNOOP format currently
>>> used in BlueZ (5). I have two questions:
>>> 
>>> 1. Is BlueZ btsnoop format official and stable? Or invented by BlueZ
>>> team? (stable? safe?)
>> 
>> the original btsnoop format was done by Symbian and adopted by Frontline. We started using that as well since it was better than what we had before. These are the ones with 1xxx link types.
>> With BlueZ 5 and kernels 3.5 and newer we introduced a Bluetooth monitor to the kernel that can catch all controllers and can catch early messages as well. Previous hcidump could only read one interface at a time and was not able to catch early init frames.
>> 
>> The link type 2001 is stable.
> 
> Regarding "all controllers and catch early messages" - if you use
> Bluetooth USB dongle than this is not a problem, because
> Wireshark/libpcap can live capture USB stream. There is ready HCI USB
> transport described in Bluetooth Core specification. Try Wireshark >=
> 1.10 and filter by "hci_usb" . Only non-standard Bluetooth USB dongles
> cannot work with it (however I have non-standard dongle "Broadcom
> Corp. BCM20702A0 Bluetooth 4.0", but it seems to be standard dongle -
> only it present itself as "vendor specific").
> 
> Quick Howto:
> 1. [Recommended] Latest Wireshark
> 2. [Recommended] Latest libpcap.
> 3. lsusb # to detect on which "Bus" Bluetooth dongle is connected
> 4. wireshark and select usbmonN, where N is "Bus" ID.
> 5. Filter "hci_usb" (useful if more devices connected to this Bus)

as long as you are on USB. But we do support UART, SDIO, virtual controllers etc. Not everything is on USB. Especially embedded devices do not use USB.

>>> 2. Is there any documentation describes this format?
>> 
>> It is documented inside the kernel as include/net/bluetooth/hci_mon.h and that is as close as it gets to documentation. btsnoop v2 takes the BTSnoop header and uses the 2001 link type and then encodes the opcode and index into the flags field. The frame data is always a raw HCI message similar to link type 1001.
> 
> Ok, I assume there is no real specification. This is not a problem for me.
> 
>>> In code I saw two new magic numbers:
>>> 2001                   Bluetooth monitor
>>> 2002                   Bluetooth simulator
>>> Is Bluetooth simulator completed now?
>> 
>> The simulator is a low-level Low Energy Link Layer simulator. And it is not completed and not stable yet.
> 
> Please let me know if will be completed or dropped. Or please create
> feature request on Wireshark Bugzilla:
> https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=---&query_format=advanced&list_id=11093

It will be completed eventually. However it will take a while since we might extend the format to also handle BR/EDR simulated traffic. All still work on progress. I would not focus on link type 2002 at this point.

>>> For now Wireshark (>= 1.10, trunk is recommended) provide probably
>>> full Bluetooth support, all protocols, colours, filtering,
>>> reassembling. If you find a bug or need new feature please create a
>>> bug at https://bugs.wireshark.org/bugzilla/buglist.cgi?resolution=---&query_format=advanced&list_id=11093
>> 
>> What also would be interesting is an integration of Bluetooth monitor socket with libpcap so Wireshark can do live capture.
> 
> For now Wireshark can support live capture on old kernel interface (if
> you do not see Bluetooth interfaces than you need newer libpcap). Also
> you can choose more than one interface to capture: for example
> Bluetooth0, Bluetooth1 and usbmon1 (nice duplicated streams do you
> see)

Problem with the old HCI raw format is that it can not catch early traffic. And it does not properly interleave traffic from multiple controllers. You have a few subtle races there. Most of the times they do not matter, except when they do. For example when using Bluetooth high speed where the systems consists of two controllers. One for BR/EDR and one for AMP traffic. Both are HCI. We also fixed the timestamping with the monitor interface to use kernel standard interfaces.

> I will try to add support for new BTSNOOP format and libpcap support
> for new kernel. I think Wireshark can be useful for BlueZ and Android
> developers.

That would be great. As I mentioned on IRC, would I also like to see is if we can export the Bluetooth monitor traces over an ADB channel. So you can start Wireshark on the host and it talks to the Android Debug Bridge channel for Bluetooth traces.

Regards

Marcel

