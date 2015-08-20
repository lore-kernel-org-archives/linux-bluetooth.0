Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Loic Poulain <loic.poulain@intel.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: hci_intel: Add platform driver
Date: Thu, 20 Aug 2015 12:42:30 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E94282F3E@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1440004303-27509-1-git-send-email-loic.poulain@intel.com>
 <55D4B948.8030400@intel.com>
 <E0D3336E15B58B4294723AC879BA5E94282DE5@IRVEXCHMB15.corp.ad.broadcom.com>
 <55D596A9.5090303@intel.com>
In-Reply-To: <55D596A9.5090303@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

-----Original Message-----
From: Loic Poulain [mailto:loic.poulain@intel.com]=20
Sent: Thursday, August 20, 2015 4:58 AM
To: Ilya Faenson; marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: Add platform driver

Thanks Ilya,

> Is there a patch with the DT documentation? It would be interesting to se=
e what DT maintainers think of this approach.
I don't have any documentation for now.

> That allows you to run with a single device per platform only. Meanwhile,=
 you could have something in the DT parameters identifying the UART. You wo=
uld then be able to retrieve that parameter and match it against the tty in=
 the BT protocol. Multiple devices per platform would then be supported.
Actually It supports multiple chips but takes them in the registered order.
But, I agree, it's not a correct way to do that.
I'm not a DT expert but I think we can do this match in the same way as=20
acpi.
It just requires to make the Bluetooth entry a child of the serial port=20
entry.

for example:

In dtsi you could have the usual uart description:
uart1: serial@1 {
         compatible =3D "vendor,vendor-uart";
         reg =3D <0x4806a000 0x100>;
         interrupts =3D <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
         clock-frequency =3D <48000000>;
         ...
};

And in the dts overlay, just add the device as a child node:
uart1: serial@1 {
         bt-vendor {
                 compatible =3D "vendor,bt-vendor";
                 reset-gpio =3D <&pmx_gpio 77 0 >;
                 interrupts =3D < 2 VENDOR_IRQ_TYPE_EDGE_FALLING >;
                 ...
         }
}

I think it's a good way to link the tty with the pdev and there is no
specific label to add and document.

What do you think about this?

I'm not specially against adding a parameter (vendor,tty =3D "ttys1").
But it means that you need to be sure that your serial will be always
named "ttys1", if someone remove/disable/add a serial port in a dts/dtsi, i=
t
can shift the tty number assigned by the driver.

IF: All good ideas, Loic. I initially wanted BT DT configuration to be "lik=
e ACPI" too. The response from the DT maintainer was "DT's not ACPI". He es=
sentially wanted us to describe the whole combo chip as a device with BT be=
ing one of the sub-devices. The point was that BT/WiFi/GPS/NFC/FM/whatever =
are dependent on each other and on some properties of the whole chip, say o=
n power or clock. There is some truth to that but I believe the BT relation=
ship to the UART is of more relevance to its driver than to the rest of the=
 overall chip. In any case, we were not able to find common ground (no resp=
onse to my last couple of messages) resulting in a customer not using bluet=
ooth-next for that BT device integration. I guess DT has its own interests =
and seems to care little about BlueZ. I hope therefore that the second simi=
lar request from the major hardware vendor (you guys) will make DT more coo=
perative. All hardware vendors will then be able to benefit from whatever s=
cheme gets accepted. To make a long story short, I encourage you to start i=
ncluding DT in your patches. :-)

Regards,
Loic

--=20
Intel Open Source Technology Center
http://oss.intel.com/
