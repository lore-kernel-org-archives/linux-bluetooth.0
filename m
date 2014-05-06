Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 7.2 \(1874\))
Subject: Re: BLE Passive scan & Bonding quest (dbus vs mgmt-api vs plugins)
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <6FFA5235-4897-4AF9-AF0D-10258F2E056B@me.com>
Date: Mon, 5 May 2014 18:40:07 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <48778ECB-83A1-48BC-97B7-81020E098C20@holtmann.org>
References: <6FFA5235-4897-4AF9-AF0D-10258F2E056B@me.com>
To: d.eriksson@me.com
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

> I'm on Kernel v3.13 & BlueZ 5.18 and been testing around to find the cleanest approach for a fully automatic discovery and headless pairing/bonding of BLE peripherals (in my case HOGP / HID).
> 
> Basically, today a "scan and pair (bond)" could today be done using either "bluetoothctl", "hcitool", "dbus/python-agents", "C plugins", or the "C Management API". (please correct me if I'm wrong here).
> 
> As we have many many options to achieve this, I'd like some guidance on how to re-use as much mechanisms that already exists in BlueZ and/or kernel/user-space, preferably involving as few building blocks as possible.
> 
> 
> In short, I continuously need to run a passive scan for LE-devices only and bond to specific hid-devices based on suitable vendor info in the advertise data or the device information service.
> 
> I'm sharing the radio with a wifi using co-ex so "BT-classic" must be off and I assume active scan will eat too much air-time.
> Once paired (or bonded as SIG and the IC-manuf. calls it), it should be a persistent and identifiable /dev/input device 
> 
> Any existing bluez or linux ways to do this I'd prefer to re-use, like utilising 'udev rules', bluetoothd patches or configs to optimise for LE-only and in general keep things light as I want to run the discovery/scan at all times. I'm ok with pure C or mix with shell and python, whatever works best and would be considered bluez future-proof.

with mgmt version 1.4 starting from kernel 3.13 you can take a dual-mode controller and actually disable BR/EDR features. So for all intense and purposes it will look and behave like a LE only controller. Check btmgmt bredr command.

Within bluetoothd we do not have support for forcefully turning a dual-mode controller into a single mode LE controller. You would need to add a config option for that. By default we will be a dual-mode controller and use dual-mode host operations.

When you pair a HoG device using D-Bus APIs of bluetoothd, it will become bonded and we will auto-reconnect it. This currently uses active scanning to re-connect the HID device, but we are in the process of adding passive scanning + auto-connect feature to the kernel to optimize this.

The initial discovery and pairing phase is not included here. That is what normally external programs like the UI are doing. So you would just need to write a program that behaves like the UI and discovers your device. The D-Bus APIs to do so are fully documented. You can do that in C or Python or any other language with D-Bus bindings.

If you are very custom and not running bluetoothd, then you need to implement GATT + HoG by yourself and driver the mgmt API all by yourself. This is possible as well, but I only recommend that if you have a really specific custom use case. It is also a bit of work.

Regards

Marcel

