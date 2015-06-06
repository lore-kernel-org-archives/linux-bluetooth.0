Return-Path: <cyrus@holtmann.org>
Message-ID: <5572D8E0.4010408@broadcom.com>
Date: Sat, 6 Jun 2015 13:26:24 +0200
From: Arend van Spriel <arend@broadcom.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: Ilya Faenson <ifaenson@broadcom.com>, <linux-bluetooth@vger.kernel.org>,
	Jiri Slaby <jslaby@suse.cz>
Subject: Re: [PATCH 1/5] Broadcom Bluetooth UART Device Tree bindings
References: <1433365304-16707-1-git-send-email-ifaenson@broadcom.com> <1433365304-16707-2-git-send-email-ifaenson@broadcom.com> <FC211E48-68D8-4C2E-9A1A-E89EDAA1B23F@holtmann.org> <5572A40F.9090206@broadcom.com> <2D4B4815-717F-4B21-A265-171D07E309B8@holtmann.org>
In-Reply-To: <2D4B4815-717F-4B21-A265-171D07E309B8@holtmann.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

On 06/06/15 10:33, Marcel Holtmann wrote:
> Hi Arend,
>
>>>> Device Tree bindings to configure the Broadcom Bluetooth UART device.
>>>> Updated not to use CamelCase and to use Intel style "oper-speed".
>>>>
>>>> Signed-off-by: Ilya Faenson<ifaenson@broadcom.com>
>>>> ---
>>>> .../devicetree/bindings/net/bluetooth/btbcm.txt    | 82 ++++++++++++++++++++++
>>>> 1 file changed, 82 insertions(+)
>>>> create mode 100644 Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>>>> new file mode 100644
>>>> index 0000000..2679819
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/net/bluetooth/btbcm.txt
>>>> @@ -0,0 +1,82 @@
>>>> +btbcm
>>>> +------
>>>> +
>>>> +Required properties:
>>>> +
>>>> +	- compatible : must be "brcm,brcm-bt-uart".
>>>> +	- tty : tty device connected to this Bluetooth device.
>>>> +
>>>> +Optional properties:
>>>> +
>>>> +  - bt-host-wake-gpios : bt-host-wake input GPIO to be used as an interrupt.
>>>> +
>>>> +  - bt-wake-gpios : bt-wake output GPIO to be used to suspend / resume device.
>>>> +
>>>> +  - bt-reg-on-gpios : reg-on output GPIO to be used to power device on/off.
>>>> +
>>>> +  - oper-speed : Bluetooth device operational baud rate.
>>>> +    Default: 3000000.
>>>> +
>>>> +  - manual-fc : flow control UART in suspend / resume scenarios.
>>>> +    Default: 0.
>>>> +
>>>> +  - configure-sleep : configure suspend / resume flag.
>>>> +    Default: false.
>>>> +
>>>> +  - configure-audio : configure platform PCM SCO flag.
>>>> +    Default: false.
>>>> +
>>>> +  - pcm-clockmode : PCM clock mode. 0-slave, 1-master.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcm-fillmethod : PCM fill method. 0 to 3.
>>>> +    Default: 2.
>>>> +
>>>> +  - pcm-fillnum : PCM number of fill bits. 0 to 3.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcm-fillvalue : PCM fill value. 0 to 7.
>>>> +    Default: 3.
>>>> +
>>>> +  - pcm-incallbitclock : PCM interface rate. 0-128Kbps, 1-256Kbps, 2-512Kbps,
>>>> +    3-1024Kbps, 4-2048Kbps.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcm-lsbfirst : PCM LSB first. 0 or 1.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcm-rightjustify : PCM Justify. 0-left, 1-right.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcm-routing : PCM routing. 0-PCM, 1-SCO over HCI.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcm-shortframesync : PCM sync. 0-short, 1-long.
>>>> +    Default: 0.
>>>> +
>>>> +  - pcmsyncmode : PCM sync mode. 0-slave, 1-master.
>>>> +    Default: 0.
>>>> +
>>>> +
>>>> +Example:
>>>> +
>>>> +	brcm4354_bt_uart: brcm4354-bt-uart {
>>>
>>> at some point you have to explain to me if Broadcom prefers BCM or BRCM. I can not make heads or tail out of it. My current explanation is the it is BCM for the Bluetooth guys and BRCM for the WiFi guys ;)
>>
>> That's a nice explanation ;-) Maybe I can give it a shot. First, two facts: 1) BRCM is our stock symbol, and 2) our device names are prefixed by BCM. So in devicetree specifications we specified the vendor prefix as BRCM and (try to) stick to that. The above clearly refers to a device so it would probably be better to use bcm4354... there.
>>
>>>> +		compatible = "brcm,brcm-bt-uart";
>>
>> The compatible string indeed starts with vendor prefix "brcm,".
>>
>>>> +		bt-wake-gpios =<&gpio4 30 GPIO_ACTIVE_HIGH>;
>>>> +		bt-host-wake-gpios =<&gpio4 31 GPIO_ACTIVE_HIGH>;
>>>> +		tty = "ttyS0”;
>>>
>>> This tty one is the one we need to figure out. Could we reference by some node information instead of the assigned device name. If we can reference something in struct device that we know is more consistent, that would be perfect. I mean if the kernel for reason decides to enumerate things in a different order then this might be ttyS1 out of a sudden.
>>
>> I see your point, but not sure what to do here either. In devicetree you could reference the uart node, but I don't know if there is an api in the kernel to obtain tty associated with a uart port. I could not find it doing quick glance in include/linux/tty.h although the linkage is obviously there in the data types.
>
> I wonder if we get this done via ACPI in the first place. However that is something for Fred to figure out.
>
> For device tree, I bet we need to extend either the TTY subsystem or really start pushing towards the tty-slave idea that has been floating around.

The tty-slave idea popped up already in review comments. We are 
wondering if it is still floating or whether things are starting to 
settle in that area. Specially for the devicetree spec, which is 
supposed to be a stable ABI, we probably need to take that into account 
if that is indeed the way things are moving.

Ilya, this is the most recent thing I found:

http://thread.gmane.org/gmane.linux.kernel/1949724

The uart-slave idea seems to sit between tty and uart dealing with 
powering the device. Not sure how that fits our need. It mentions 
something about being able to intervene in any tty-uart interaction so 
there could bt stuff that could be done in those hooks.

Regards,
Arend

> Regards
>
> Marcel
>
