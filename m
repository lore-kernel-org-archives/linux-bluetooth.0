Return-Path: <cyrus@holtmann.org>
Message-ID: <55FA9501.3010009@intel.com>
Date: Thu, 17 Sep 2015 12:25:05 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: btattach: Add auto attach/detach
References: <55F82461.6000805@intel.com> <9BF6835F-CCFF-40BF-9E6C-895FFA14D85B@holtmann.org>
In-Reply-To: <9BF6835F-CCFF-40BF-9E6C-895FFA14D85B@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

>> I wonder if adding a dynamic attach/detach to btattach could be a good idea.
>>
>> Since most HCI UART drivers power on/off the Bluetooth controller on proto/ldisc open/close.
>> It could be interesting to attach/detach the line discipline depending Bluetooth usage.
>>
>> A way to do that could be to track rfkill events via the /dev/rfkill device.
>> I can propose two solutions:
>>
>> - btattach monitors a specific rfkill node whose index is a passed as argument
>> and ldisc is attached/detached accordingly.
>>
>> - An other solution could be to create a rfkill node from btattach so that if
>> something blocks/unblocks the node, HCI ldisc is detached/attached automatically.
>> Problem is that we can't create a rfkill node from user-space, but I think we can
>> easily add this support to the rfkill device driver.
>>
>> On my laptop, the Thinkpad acpi driver exports a rfkill nodes which disconnects/reconnects
>> the USB embedded Bluetooth controller. This is what I would like to reproduce for UART here.
> I do not think this is a good behavior to duplicated. The laptops that kill the USB lines are actually a pain to support properly. That is the reason why RFKILL_CHANGE_ALL exists. Since you can never map the platform rfkill switch to the actual device it kills. It is a real mess.
>
> Bluetooth subsystem has currently the concept of a soft rfkill switch that gets exposed every time you register a new device (so attaching the ldisc will create one) and that maps to hdev->close. It allows to force something similar to flight mode that kills all radios.
>
> For a hard rfkill switch, we would need way more knowledge to facility this correctly. However WiFi has done something like that where each driver can provide a hard rfkill switch callback that gets linked correctly together with the soft rfkill switch. We could do something similar.
>
> However what you need to asked yourself is if hdev->close is actually any different than detaching ldisc. From where I am standing it should not be. Attaching ldisc is telling the kernel about the UART and nothing else. It is not meant for power control. It is meant to tell the kernel that this UART is actually a BT chip. The power control should happen via hdev->open and hdev->close. Since we introduced the hdev->setup stage keeping the ldisc attached is actually favorable for latency reason. Otherwise you end up loading the firmware over and over again.
>
> I know that for some ACPI exposed BT devices, we have the generic rfkill-gpio driver to claim them. This needs to be reverted as soon as the kernel supports power control for these within the hci_uart driver. This listening to /dev/rfkill and execute hciattach on it that has been done in Edison is a bad design. It is racy and error prone.
>
> For the Broadcom support, we have taking the ACPI ID out of the rfkill-gpio driver and now hci_uart owns it. So attaching the ldisc means we are taking over control. Once that happened, you have the soft rfkill switch attached to the hci0 device.
>
> Do you really need a hard rfkill switch as well. Normally the hard rfkill switch means that there is physical button on the system that does something. None of this is a physical button. And having two soft rfkill switches is not really helpful. It is actually confusing and will not bring you any extra benefit.

OK, btattach should stay a minimal attacher.

Meaning that in a normal case, The HCI line discipline should stay 
attached for all system uptime. So, all the power stuff has to be 
managed by the HCI UART driver.

I don't know what is the real gain to power off the chip instead of keep 
it idle, and maybe it's overkill in many case.

In case of mobile platforms (Android+Bluedroid), all vendor 
implementations tend to power-off the BT controller when bluetooth is 
disabled (broadcom, rtk...).
This is something that bluez 'should' propose as well.

However, I'm OK that powering off/on the bluetooth controller on 
hdev->open/hdev->close is not a good solution, since we will have to 
upload the firmware on each hdev->open. We don't want having latency on 
hci up/down.

Having new callbacks could be a solution. For example 
hdev->start/hdev->stop triggered by the bluetooth rfkill hw switch or by 
a management command.
A hdev->shutdown callback already exist, but is only used as a pre-close 
HCI epilog callback (btusb intel).

An other point is that detaching the ldisc (by closing tty fd) also 
releases The UART port which in turn can be put in low power state.
However it's more a UART driver issue here, and its seems to be 
partially fixed with the fine grained pm runtime support in the 8250 
serial driver (d74d5d1b7288f).

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/
