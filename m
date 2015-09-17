Return-Path: <cyrus@holtmann.org>
Message-ID: <55FAC5F0.4060001@intel.com>
Date: Thu, 17 Sep 2015 15:53:52 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: btattach: Add auto attach/detach
References: <55F82461.6000805@intel.com> <9BF6835F-CCFF-40BF-9E6C-895FFA14D85B@holtmann.org> <55FA9501.3010009@intel.com> <B5236238-FEFB-46F8-92D2-52326F1C31BD@holtmann.org>
In-Reply-To: <B5236238-FEFB-46F8-92D2-52326F1C31BD@holtmann.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

Thanks for this response.

>>>> I wonder if adding a dynamic attach/detach to btattach could be a good idea.
>>>>
>>>> Since most HCI UART drivers power on/off the Bluetooth controller on proto/ldisc open/close.
>>>> It could be interesting to attach/detach the line discipline depending Bluetooth usage.
>>>>
>>>> A way to do that could be to track rfkill events via the /dev/rfkill device.
>>>> I can propose two solutions:
>>>>
>>>> - btattach monitors a specific rfkill node whose index is a passed as argument
>>>> and ldisc is attached/detached accordingly.
>>>>
>>>> - An other solution could be to create a rfkill node from btattach so that if
>>>> something blocks/unblocks the node, HCI ldisc is detached/attached automatically.
>>>> Problem is that we can't create a rfkill node from user-space, but I think we can
>>>> easily add this support to the rfkill device driver.
>>>>
>>>> On my laptop, the Thinkpad acpi driver exports a rfkill nodes which disconnects/reconnects
>>>> the USB embedded Bluetooth controller. This is what I would like to reproduce for UART here.
>>> I do not think this is a good behavior to duplicated. The laptops that kill the USB lines are actually a pain to support properly. That is the reason why RFKILL_CHANGE_ALL exists. Since you can never map the platform rfkill switch to the actual device it kills. It is a real mess.
>>>
>>> Bluetooth subsystem has currently the concept of a soft rfkill switch that gets exposed every time you register a new device (so attaching the ldisc will create one) and that maps to hdev->close. It allows to force something similar to flight mode that kills all radios.
>>>
>>> For a hard rfkill switch, we would need way more knowledge to facility this correctly. However WiFi has done something like that where each driver can provide a hard rfkill switch callback that gets linked correctly together with the soft rfkill switch. We could do something similar.
>>>
>>> However what you need to asked yourself is if hdev->close is actually any different than detaching ldisc. From where I am standing it should not be. Attaching ldisc is telling the kernel about the UART and nothing else. It is not meant for power control. It is meant to tell the kernel that this UART is actually a BT chip. The power control should happen via hdev->open and hdev->close. Since we introduced the hdev->setup stage keeping the ldisc attached is actually favorable for latency reason. Otherwise you end up loading the firmware over and over again.
>>>
>>> I know that for some ACPI exposed BT devices, we have the generic rfkill-gpio driver to claim them. This needs to be reverted as soon as the kernel supports power control for these within the hci_uart driver. This listening to /dev/rfkill and execute hciattach on it that has been done in Edison is a bad design. It is racy and error prone.
>>>
>>> For the Broadcom support, we have taking the ACPI ID out of the rfkill-gpio driver and now hci_uart owns it. So attaching the ldisc means we are taking over control. Once that happened, you have the soft rfkill switch attached to the hci0 device.
>>>
>>> Do you really need a hard rfkill switch as well. Normally the hard rfkill switch means that there is physical button on the system that does something. None of this is a physical button. And having two soft rfkill switches is not really helpful. It is actually confusing and will not bring you any extra benefit.
>> OK, btattach should stay a minimal attacher.
>>
>> Meaning that in a normal case, The HCI line discipline should stay attached for all system uptime. So, all the power stuff has to be managed by the HCI UART driver.
>>
>> I don't know what is the real gain to power off the chip instead of keep it idle, and maybe it's overkill in many case.
>>
>> In case of mobile platforms (Android+Bluedroid), all vendor implementations tend to power-off the BT controller when bluetooth is disabled (broadcom, rtk...).
>> This is something that bluez 'should' propose as well.
> reality is that if you have USB or any other hotplug bus that enumerates, there is no need for anything different.
>
> Strictly speaking the UART on an embedded systems where they are dedicated and hardwired to Bluetooth should actually enumerate either as bus or platform device.
>
> For the Android system running Bluedroid there are many choices. For Bluedroid via HCI User Channel, it should just open and close the user channel socket. All triggers for power management should be done via that simple case. If the hdev is down, then there is no reason to do anything.
>
> It means that attaching the line discipline can just happen during boot once and stay that way. Powering down the chip and the UART is really not something we should be trying to solve in userspace. The driver should be doing the correct thing in the first place.
>
>> However, I'm OK that powering off/on the bluetooth controller on hdev->open/hdev->close is not a good solution, since we will have to upload the firmware on each hdev->open. We don't want having latency on hci up/down.
> The firmware loading happens via hdev->setup and not hdev->open. The hdev->open and hdev->close are for the HCI transport. They open and close the transport. Meaning HCI commands are possible. This is more important for USB where you have to schedule URBs, but the same applies to UART and other busses.
>
> The hdev->setup is only executed once per lifetime of hdev. So what happens is that on registration of a new device, hdev->open gets called, then hdev->setup and if nothing happens HCI_AUTO_OFF timer triggers and hdev->close gets called. In case the device activated the hdev->close does not happen and the transport stays open.
>
> So power cycling from mgmt interface (or even hciconfig legacy ioctl) handles this all in the background. Next time around only hdev->open is called and hdev->setup is skipped. So as many times as you open and close the transport (meaning power on/off) the firmware does not require to be reloaded. Same applies for the BD_ADDR which is remembered as well.
This is the problem, if we turn-off/on the BT controller in the UART 
driver, firmware is lost and we need to upload firmware (setup()) again.
> Attaching of the line discipline should be viewed as plugging in an USB dongle. Same operation flow happens. The hdev gets registered, hdev->open for opening the transport, hdev->setup for firmware loading and so on.
>
>> Having new callbacks could be a solution. For example hdev->start/hdev->stop triggered by the bluetooth rfkill hw switch or by a management command.
>> A hdev->shutdown callback already exist, but is only used as a pre-close HCI epilog callback (btusb intel).
> New callbacks are not going to help. What do you want to start and stop. There is nothing extra to do. You could try to invent suspend / resume callbacks, but they are not really helping either since the chip itself knows better anyway.
>
> My viewpoint here is pretty simple. Device attached and hdev registered should be the same thing. Attaching happens via enumerateable busses and the probe callback of the driver or via line disciplines.
>
> The hdev->shutdown is similar to the hdev->setup. It just happen to be run on every device shutdown. However it is for executing HCI commands and not for shutting down the transport. These are two independent things.
>
>> An other point is that detaching the ldisc (by closing tty fd) also releases The UART port which in turn can be put in low power state.
>> However it's more a UART driver issue here, and its seems to be partially fixed with the fine grained pm runtime support in the 8250 serial driver (d74d5d1b7288f).
> The problem here is that this is an UART with a /dev/ttyX in the first place. There is no good reason to even expose a device node for such a device.
>
>  From a Bluetooth point of view, when hdev->close is called we can do whatever we need to do bring the device into its lowest possible power state.
>
> I think in the long term UART slave concept might help to abstract things cleanly.
Sure, UART slave is probably the point here. (Seems there are several 
ongoing implementation(s) 
http://thread.gmane.org/gmane.linux.kernel/1949724)

Regards,
Loic


-- 
Intel Open Source Technology Center
http://oss.intel.com/
