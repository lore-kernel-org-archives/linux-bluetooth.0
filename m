Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: Query on how to use btmon/hcidump regarding FM packets on TI WiLink7 Driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <55817325.8070100@samsung.com>
Date: Fri, 19 Jun 2015 02:56:02 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>
Message-Id: <177C9158-C9E3-4D00-9081-732BB72D9402@holtmann.org>
References: <55817325.8070100@samsung.com>
To: Chan-yeol Park <chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Chan-yeol,

> May I ask how to use btmon/hcidump when FM packet is over HCI uart in
> Texas Instruments WiLink7 driver?
> 
> As far as I understand FM command and events are not captured in btmon/hcidump.
> 
> I think RX is simple because FM packet could be copied to hci_core.c. but I am not clear about TX.

that is because of this crappy "shared transport" design. It is a design that should have never gotten upstream since it hacks things together. Instead of addressing the problem of FM over HCI, the guys from TI hacked around it.

Fundamentally they put a layer in between instead of making FM a slave platform device of the Bluetooth controller as it is suppose to be. Which means they require to stack line disciplines and implement another HCI processing engine for no apparent reasons.

Feel free to fix this for the WiLink7 driver. I am accepting patches for this since we will do exactly the same for the Intel chips as well. The FM side of things will be platform devices exposed by the Bluetooth driver.

Regards

Marcel

