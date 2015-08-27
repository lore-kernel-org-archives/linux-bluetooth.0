Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2] Bluetooth: hci_intel: Add support for platform driver
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <E0D3336E15B58B4294723AC879BA5E94286DBA@IRVEXCHMB15.corp.ad.broadcom.com>
Date: Thu, 27 Aug 2015 11:28:05 -0700
Cc: Loic Poulain <loic.poulain@intel.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <8A9FC576-0B81-4AC0-8BA5-9042A29AB088@holtmann.org>
References: <1440652911-39717-1-git-send-email-marcel@holtmann.org> <55DECF9E.9040302@intel.com> <95579268-3455-4C1E-96E6-89C6D93A05D3@holtmann.org> <E0D3336E15B58B4294723AC879BA5E94286DBA@IRVEXCHMB15.corp.ad.broadcom.com>
To: Ilya Faenson <ifaenson@broadcom.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Ilya,

>>> A platform device can be used to provide some specific resources in
>>> order to manage the controller. In this first patch we retrieve the
>>> reset gpio which is used to power on/off the controller.
>>> 
>>> The main issue is to match the current tty with the correct pdev.
>>> In case of ACPI, we can easily find the right tty/pdev pair because
>>> they are both child of the same UART port.
>>> 
>>> If controller is powered-on from the driver, we need to wait for a
>>> HCI boot event before being able to send any command.
>>> 
>>> Signed-off-by: Loic Poulain <loic.poulain@intel.com>
>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
>>> ---
>>> drivers/bluetooth/hci_intel.c | 203 +++++++++++++++++++++++++++++++++++++++---
>>> 1 file changed, 190 insertions(+), 13 deletions(-)
>> 
>> ACK, It Works on my hardware.
> 
> okay then, this patch has been applied to bluetooth-next now.
> 
> IF: Just out of curiosity... How come you've accepted the Intel platform device implementation yourself while you've previously referred the similar Broadcom implementation to the Device Tree folks?

these are ACPI devices where we have a clear tree of parent devices. I accepted also the Broadcom version for ACPI. Within ACPI the relationship between TTY and its GPIO etc. is expressed.

That is the part that is missing within DT. And the DT folks should be signing off on that. In that case DT is defining the standard on how to express these relations. For ACPI based devices this is already expressed in shipping devices.

Regards

Marcel

