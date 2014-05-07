Return-Path: <cyrus@holtmann.org>
MIME-version: 1.0
Content-type: text/plain; CHARSET=US-ASCII
Subject: Re: BLE Passive scan & Bonding quest (dbus vs mgmt-api vs plugins)
From: d.eriksson@me.com
In-reply-to: <48778ECB-83A1-48BC-97B7-81020E098C20@holtmann.org>
Date: Thu, 08 May 2014 01:24:12 +0200
Cc: linux-bluetooth@vger.kernel.org
Message-id: <9E1E42D8-A76F-4174-89BE-106D2A3AA966@me.com>
References: <6FFA5235-4897-4AF9-AF0D-10258F2E056B@me.com>
 <48778ECB-83A1-48BC-97B7-81020E098C20@holtmann.org>
To: Marcel Holtmann <marcel@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

pls see my reply in-line below:


On 06 May 2014, at 03:40, Marcel Holtmann <marcel@holtmann.org> wrote:

> Hi David,
> 
>> I'm on Kernel v3.13 & BlueZ 5.18 and been testing around to find the cleanest approach for a fully automatic discovery and headless pairing/bonding of BLE peripherals (in my case HOGP / HID).
>> 
>> Basically, today a "scan and pair (bond)" could today be done using either "bluetoothctl", "hcitool", "dbus/python-agents", "C plugins", or the "C Management API". (please correct me if I'm wrong here).
>> 
>> As we have many many options to achieve this, I'd like some guidance on how to re-use as much mechanisms that already exists in BlueZ and/or kernel/user-space, preferably involving as few building blocks as possible.
>> 
>> 
>> In short, I continuously need to run a passive scan for LE-devices only and bond to specific hid-devices based on suitable vendor info in the advertise data or the device information service.
>> 
>> I'm sharing the radio with a wifi using co-ex so "BT-classic" must be off and I assume active scan will eat too much air-time.
>> Once paired (or bonded as SIG and the IC-manuf. calls it), it should be a persistent and identifiable /dev/input device 
>> 
>> Any existing bluez or linux ways to do this I'd prefer to re-use, like utilising 'udev rules', bluetoothd patches or configs to optimise for LE-only and in general keep things light as I want to run the discovery/scan at all times. I'm ok with pure C or mix with shell and python, whatever works best and would be considered bluez future-proof.
> 
> with mgmt version 1.4 starting from kernel 3.13 you can take a dual-mode controller and actually disable BR/EDR features. So for all intense and purposes it will look and behave like a LE only controller. Check btmgmt bredr command.

Seems like "scan" is behaving a bit different when running it interactively in bluetoothctl vs. mgmt. Didn't figure out how to best scan, match and connect the hid device. Are there some good examples written?  

we have mgmt, py-agents, plugins/autopair.c. To me I'd prefer to consolidate the part initiating and sequencing the scanning part with the filtering and hid creation. I also need a good way to distinguish and lookup BT-UUID to and from /dev/input/eventX, Y, etc.

Would be great to hear some opinions on pros/cons doing this via python+dbus vs pure hci via hcitool, mgmt etc. 


> Within bluetoothd we do not have support for forcefully turning a dual-mode controller into a single mode LE controller. You would need to add a config option for that. By default we will be a dual-mode controller and use dual-mode host operations.

Great, the config options to explicitly disable BR/EDR, you mean this exists already? Honestly I'm not so fluent in the exact structure of the bluez configuration tree, what's mandatory, could be stripped out to ensure we're passive only and minimize air-time.


> When you pair a HoG device using D-Bus APIs of bluetoothd, it will become bonded and we will auto-reconnect it.
for HoG, can you explain the order/feature of the pair vs trust commands ?


> This currently uses active scanning to re-connect the HID device, but we are in the process of adding passive scanning + auto-connect feature to the kernel to optimize this.

Sounds great, looking forward to this feature, any planned ETA ? 

Will this require the peripheral to use direct advertise -> central (bluez)?

Any other ways to achieve passive scan today by (I guess) bypassing d-bus/bluetoothd to perform the scan/discovery?

I'm also curious if you or someone here have worked with linux sleep-modes and via a BLE peripheral wake the system. I believe it's called "Sniff Mode" right?


> The initial discovery and pairing phase is not included here. That is what normally external programs like the UI are doing. So you would just need to write a program that behaves like the UI and discovers your device. The D-Bus APIs to do so are fully documented. You can do that in C or Python or any other language with D-Bus bindings.

Any hidden gems on how to setup some scan & pair rules with minimal complexity and max re-use of existing tools?



Best David
