Return-Path: <cyrus@holtmann.org>
Message-ID: <55D596A9.5090303@intel.com>
Date: Thu, 20 Aug 2015 10:58:17 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Ilya Faenson <ifaenson@broadcom.com>,
	"marcel@holtmann.org" <marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH] Bluetooth: hci_intel: Add platform driver
References: <1440004303-27509-1-git-send-email-loic.poulain@intel.com> <55D4B948.8030400@intel.com> <E0D3336E15B58B4294723AC879BA5E94282DE5@IRVEXCHMB15.corp.ad.broadcom.com>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E94282DE5@IRVEXCHMB15.corp.ad.broadcom.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks Ilya,

> Is there a patch with the DT documentation? It would be interesting to see what DT maintainers think of this approach.
I don't have any documentation for now.

> That allows you to run with a single device per platform only. Meanwhile, you could have something in the DT parameters identifying the UART. You would then be able to retrieve that parameter and match it against the tty in the BT protocol. Multiple devices per platform would then be supported.
Actually It supports multiple chips but takes them in the registered order.
But, I agree, it's not a correct way to do that.
I'm not a DT expert but I think we can do this match in the same way as 
acpi.
It just requires to make the Bluetooth entry a child of the serial port 
entry.

for example:

In dtsi you could have the usual uart description:
uart1: serial@1 {
         compatible = "vendor,vendor-uart";
         reg = <0x4806a000 0x100>;
         interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
         clock-frequency = <48000000>;
         ...
};

And in the dts overlay, just add the device as a child node:
uart1: serial@1 {
         bt-vendor {
                 compatible = "vendor,bt-vendor";
                 reset-gpio = <&pmx_gpio 77 0 >;
                 interrupts = < 2 VENDOR_IRQ_TYPE_EDGE_FALLING >;
                 ...
         }
}

I think it's a good way to link the tty with the pdev and there is no
specific label to add and document.

What do you think about this?

I'm not specially against adding a parameter (vendor,tty = "ttys1").
But it means that you need to be sure that your serial will be always
named "ttys1", if someone remove/disable/add a serial port in a dts/dtsi, it
can shift the tty number assigned by the driver.

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

