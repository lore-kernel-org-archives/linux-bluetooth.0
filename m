Return-Path: <cyrus@holtmann.org>
From: Ilya Faenson <ifaenson@broadcom.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Loic Poulain <loic.poulain@intel.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: RE: [PATCH v2] Bluetooth: hci_intel: Add support for platform driver
Date: Thu, 27 Aug 2015 18:09:54 +0000
Message-ID: <E0D3336E15B58B4294723AC879BA5E94286DBA@IRVEXCHMB15.corp.ad.broadcom.com>
References: <1440652911-39717-1-git-send-email-marcel@holtmann.org>
 <55DECF9E.9040302@intel.com>
 <95579268-3455-4C1E-96E6-89C6D93A05D3@holtmann.org>
In-Reply-To: <95579268-3455-4C1E-96E6-89C6D93A05D3@holtmann.org>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Marcel Holtmann
Sent: Thursday, August 27, 2015 11:20 AM
To: Loic Poulain
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Add support for platform driver

Hi Loic,

>> A platform device can be used to provide some specific resources in
>> order to manage the controller. In this first patch we retrieve the
>> reset gpio which is used to power on/off the controller.
>> 
>> The main issue is to match the current tty with the correct pdev.
>> In case of ACPI, we can easily find the right tty/pdev pair because
>> they are both child of the same UART port.
>> 
>> If controller is powered-on from the driver, we need to wait for a
>> HCI boot event before being able to send any command.
>> 
>> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>> ---
>>  drivers/bluetooth/hci_intel.c | 203 +++++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 190 insertions(+), 13 deletions(-)
> 
> ACK, It Works on my hardware.

okay then, this patch has been applied to bluetooth-next now.

IF: Just out of curiosity... How come you've accepted the Intel platform device implementation yourself while you've previously referred the similar Broadcom implementation to the Device Tree folks?

Regards

Marcel

--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
