Return-Path: <cyrus@holtmann.org>
Message-ID: <55D4B948.8030400@intel.com>
Date: Wed, 19 Aug 2015 19:13:44 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: marcel@holtmann.org
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_intel: Add platform driver
References: <1440004303-27509-1-git-send-email-loic.poulain@intel.com>
In-Reply-To: <1440004303-27509-1-git-send-email-loic.poulain@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


On 19/08/2015 19:11, Loic Poulain wrote:
> A platform device can be used to provide some specific resources in
> order to manage the controller. In this first patch we retrieve the
> reset gpio which is used to power on/off the controller.
>
> The main issue is to match the current tty with the correct pdev.
> In case of ACPI, we can easily find the right tty/pdev pair because
> they are both child of the same UART port.
> In case of device tree, there is currently nothing to link the pdev
> with its tty. So, we just match the first available pdev.
>
> If controller is powered-on from the driver, we need to wait for a
> HCI boot event before being able to send any command.
>
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> ---
>   drivers/bluetooth/hci_intel.c | 275 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 255 insertions(+), 20 deletions(-)
Apply over: Bluetooth: hci_uart: Add Intel baudrate configuration support

Regards,
Loic

-- 
Intel Open Source Technology Center
http://oss.intel.com/

