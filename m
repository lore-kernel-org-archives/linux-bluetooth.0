Return-Path: <cyrus@holtmann.org>
Subject: Re: [bluetooth] btusb duplicate filtering
Mime-Version: 1.0 (Mac OS X Mail 8.0 \(1990.1\))
Content-Type: text/plain; charset=us-ascii
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <58517.86.105.94.79.1414160561.squirrel@boosthardware.com>
Date: Tue, 28 Oct 2014 10:20:01 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <90788656-5735-477F-BDAD-005F7D35A241@holtmann.org>
References: <58517.86.105.94.79.1414160561.squirrel@boosthardware.com>
To: Patrick Shirkey <pshirkey@boosthardware.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Patrick,

> I am seeing the following behaviour with an android device running the
> 8723au chipset with bluez + backports + btusb.c (new branch).
> 
> Step 1:
> 
> 1: enable BT via settings UI
> 2: open BLE scanner app
> 3: app finds all BLE devices
> 
> Step 2:
> 
> 4: close BLE scanner app
> 5: open BLE scanner app
> 6: app cannot find any BLE device
> 
> 
> - Szymon has suggested it is related to duplicate filtering and may be
> handled at the driver or chipset firmware level.
> 
> - I found this post which might provide some useful background info.
> 
> http://stackoverflow.com/questions/19502853/android-4-3-ble-filtering-behaviour-of-startlescan
> 
> - My question is can I do anything at the driver/kernel/bluez level so
> that BLE devices always show up?

so we are always using the duplicate filtering of the controller. Not using it will cause an overflow of advertising reports in a busy environment.

The difference between certain manufactures is that some filter strictly only on address, other filter on address + RSSI. Meaning that if the RSSI changes you get another event. What I know is that Broadcom is in the first camp and CSR/TI are in the second camp.

This means that if you care about devices found on a constant basis and depend on the RSSI changing, you need to stop and restart the LE scan for at least Broadcom based controllers. I have no idea in what camp the Realtek one falls since I yet have to get one of these.

On an independent thread we are talking about adding a quirk to our internal discovery handling to automatically restart scan for the controllers that do the strict filtering based on address only.

Regards

Marcel

