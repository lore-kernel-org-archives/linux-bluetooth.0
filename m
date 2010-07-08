Return-Path: <cyrus@holtmann.org>
From: Shanmugamkamatchi Balashanmugam
	<Shanmugamkamatchi.Balashanmugam@Atheros.com>
To: "Perelet, Oleg" <operelet@quicinc.com>,
	Marcel Holtmann <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 8 Jul 2010 17:55:23 +0530
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT devices
Message-ID: <44EE5C37ADC36343B0625A05DD408C4850DB2A787C@CHEXMB-01.global.atheros.com>
In-Reply-To: <BCDE476F204B134B8B235FB275BC3AD80FC355337C@NALASEXMB01.na.qualcomm.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Perelet, Oleg
Sent: Wednesday, July 07, 2010 2:00 AM
To: Marcel Holtmann; Shanmugamkamatchi Balashanmugam
Cc: linux-bluetooth@vger.kernel.org
Subject: RE: [RFC] Bluetooth: Add firmware load infrastructure for BT devices

>> Added support to load firmware to target RAM from Bluetooth USB transport
>> driver. 

>we have discussed this a long time ago and the better approach would be
>to create a setup stage for all HCI drivers. For example for special HCI
>commands to set BD_ADDR and other details. Maybe also a firmware loading
>stage should be used. Making this USB specific sounds pretty much wrong
>to me at this point. At least SDIO might have similar issues.

>>The current approach looks more hackish than actually nicely integrated.

>Thanks for bringing up old topic. We discussed this few years ago and >things been somehow stalled. Besides, USB, SDIO there's UART which is used >in a lot of embedded platforms and everybody hacks custom code around.

>Overall Marcel suggests to have intermediate stage between DOWN and UP >states for hci device aka - SETUP (call it any name).


>Here are low level BT setup states that I "think" are common for majority >of embedded implementations:

>1. low level GPIO, CLC etc setup - can not talk to chip before that.

>2. Initial firmware/patch download - at this state one can talk HCI to >chip, but chip is barely functional, firmware, patches etc are downloaded >at this stage.

>3. "Run time config download" (often combined with #2, but I suggest to >separate) this is when BDADDR is programmed and chip run time parameters >for given platform are set up. For majority of chips this stage also >defines Sleep algorithm to be used. There are few ways of doing BT sleep - >HCI, UART signaling or usage of extra WAKE GPIO's to determine sleep >condition. Most of them require initial HCI setup.

>4. Enable Sleep and low power mode. Currently everybody hardcodes this >step, some platforms have programmatic ifaces (aka sysfs)

>5. WiFI coex setup if needed.

>Feel free to add more here ....

>At this stage hci can be brought to UP stage and be functional.


>All of that is tight with RFKILL of course and also suspend/resume entries >in transport driver. I'm also not doing in to details of sleep mode >implementation in this thread but welcome to discuss it in separate thread.

>Oleg.

Thanks for the comments.
Firmware loading to target RAM needs to be done once when the device is inserted.  Firmware loading will not be required every time 
the device goes from DOWN to UP. I think each HCI driver requires
a separate firmware loading code as firmware loading is 
different for different interfaces.  Please advice if my understanding is wrong.

I initially thought of registration 
mechanism with btusb transport driver to load firmware, but before
the device is inserted btusb will not be loaded and registering the 
firmware load function with btusb was not possible.

Please advice alternate solution to load firmware from transport driver.

Regards,
Bala.
