Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Loic Poulain <loic.poulain@intel.com>, "marcel@holtmann.org"
	<marcel@holtmann.org>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH] Bluetooth: hci_intel: Add platform driver
Date: Wed, 19 Aug 2015 21:17:47 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E94282DE5@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1440004303-27509-1-git-send-email-loic.poulain@intel.com>
 <55D4B948.8030400@intel.com>
In-Reply-To: <55D4B948.8030400@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@v=
ger.kernel.org] On Behalf Of Loic Poulain
Sent: Wednesday, August 19, 2015 1:14 PM
To: marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: Add platform driver


On 19/08/2015 19:11, Loic Poulain wrote:
> A platform device can be used to provide some specific resources in
> order to manage the controller. In this first patch we retrieve the
> reset gpio which is used to power on/off the controller.

Is there a patch with the DT documentation? It would be interesting to see =
what DT maintainers think of this approach.

>
> The main issue is to match the current tty with the correct pdev.
> In case of ACPI, we can easily find the right tty/pdev pair because
> they are both child of the same UART port.
> In case of device tree, there is currently nothing to link the pdev
> with its tty. So, we just match the first available pdev.

That allows you to run with a single device per platform only. Meanwhile, y=
ou could have something in the DT parameters identifying the UART. You woul=
d then be able to retrieve that parameter and match it against the tty in t=
he BT protocol. Multiple devices per platform would then be supported.

Thanks,
 -Ilya

>
> If controller is powered-on from the driver, we need to wait for a
> HCI boot event before being able to send any command.
>
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>   drivers/bluetooth/hci_intel.c | 275 +++++++++++++++++++++++++++++++++++=
++++---
>   1 file changed, 255 insertions(+), 20 deletions(-)
Apply over: Bluetooth: hci_uart: Add Intel baudrate configuration support

Regards,
Loic

--=20
Intel Open Source Technology Center
http://oss.intel.com/

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
