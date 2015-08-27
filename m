Return-Path: <cyrus@holtmann.org>
Message-ID: <55DECF9E.9040302@intel.com>
Date: Thu, 27 Aug 2015 10:51:42 +0200
From: Loic Poulain <loic.poulain@intel.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>,
 linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Add support for platform driver
References: <1440652911-39717-1-git-send-email-marcel@holtmann.org>
In-Reply-To: <1440652911-39717-1-git-send-email-marcel@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On 27/08/2015 07:21, Marcel Holtmann wrote:
> From: Loic Poulain <loic.poulain@intel.com>
>
> A platform device can be used to provide some specific resources in
> order to manage the controller. In this first patch we retrieve the
> reset gpio which is used to power on/off the controller.
>
> The main issue is to match the current tty with the correct pdev.
> In case of ACPI, we can easily find the right tty/pdev pair because
> they are both child of the same UART port.
>
> If controller is powered-on from the driver, we need to wait for a
> HCI boot event before being able to send any command.
>
> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> ---
>   drivers/bluetooth/hci_intel.c | 203 +++++++++++++++++++++++++++++++++++++++---
>   1 file changed, 190 insertions(+), 13 deletions(-)

ACK, It Works on my hardware.

Regards,
Loic
-- 
Intel Open Source Technology Center
http://oss.intel.com/
