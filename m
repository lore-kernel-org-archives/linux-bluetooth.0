Return-Path: <cyrus@holtmann.org>
Subject: Re: [RFC] Bluetooth: Add firmware load infrastructure for BT
 devices
From: Marcel Holtmann <marcel@holtmann.org>
To: Bala Shanmugam <sbalashanmugam@atheros.com>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1278333422-10368-1-git-send-email-sbalashanmugam@atheros.com>
References: <1278333422-10368-1-git-send-email-sbalashanmugam@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Jul 2010 14:24:21 -0300
Message-ID: <1278437061.2789.62.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bala,

> Added support to load firmware to target RAM from Bluetooth USB transport
> driver. Each BT device vendor need to specify the product ID, firmware file,
> load and unload function. When the device is inserted, btusb will call
> appropriate firmware load function to load firmware to target RAM.
> 
> This framework is needed for devices that are detected as BT devices when
> powered on and still require firmware to be downaloded.

we have discussed this a long time ago and the better approach would be
to create a setup stage for all HCI drivers. For example for special HCI
commands to set BD_ADDR and other details. Maybe also a firmware loading
stage should be used. Making this USB specific sounds pretty much wrong
to me at this point. At least SDIO might have similar issues.

The current approach looks more hackish than actually nicely integrated.

Regards

Marcel


