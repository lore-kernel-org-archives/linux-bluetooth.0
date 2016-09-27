Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Subject: Re: [RFC] wilink8-bluetooth: reading uart parametrs and enable pin
 info from device tree
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <8665E2433BC68541A24DFFCA87B70F5B361A3A3E@DFRE01.ent.ti.com>
Date: Tue, 27 Sep 2016 13:16:18 +0200
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Message-Id: <08201AAB-F999-466D-A003-93FFFA5EE517@holtmann.org>
References: <8665E2433BC68541A24DFFCA87B70F5B361A3A3E@DFRE01.ent.ti.com>
To: "Reizer, Eyal" <eyalr@ti.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Eyal,

> The wl18xx family of chips include a Bluetooth subsystem which uses a UART 
> for HCI communication and a gpio as an enable pin.
> 
> See the following architecture diagram:
> http://www.ti.com/general/docs/datasheetdiagram.tsp?genericPartNumber=WL1837MOD&diagramId=SWRS170H
> 
> In case we want to build an image that when it boots up, Bluetooth is enbled 
> out of the box we can pass this info to a user space app/script that would pick 
> the selected gpio, enable it and launch the bleutooth stack (using hciattach).
> 
> The question is what would be the right practice for passing these parameters.
> As there is no kernel driver looking for this info and it is needed mainly 
> By user space, should we use something like the chosen node?
> If yes, would it be right to add a new chosen node entry, or just add additional
> Parameters to bootargs?
> Any other suggestion?

actually that is a job for DT to describe the GPIO and then let the driver handle it. See how we do it with ACPI provided information for Intel and Broadcom UART drivers.

The goal is that btattach just attaches the line discipline. And anything else is done via the driver on hdev->setup or when bringing up the controller. That is how we drive all the other UART chips now.

As a side note, I would also prefer that the TI-ST part gets cleaned up. We have devres and other devices stacked on top of the Bluetooth HCI should be exposed as slaves. See the Intel driver for an example.

At some point we might get the serial / UART bus that has been recently discussed. That would be even better and btattach would not be needed at all. The driver would attach itself. However we still need to drive the GPIO from the driver and not some external user space program. That is not going to fly.

Regards

Marcel

