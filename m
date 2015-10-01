Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH 1/5] Bluetooth: hci_bcm: Add missing acpi_dev_free_resource_list()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
Date: Thu, 1 Oct 2015 09:13:08 +0200
Cc: linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Frederic Danis <frederic.danis@linux.intel.com>
Message-Id: <FBA45A9C-2E3D-4D13-BEDE-957647DC173F@holtmann.org>
References: <1443619605-19320-1-git-send-email-jarkko.nikula@linux.intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jarkko,

> Caller of acpi_dev_get_resources() should free the constructed resource
> list by calling the acpi_dev_free_resource_list() in order to avoid memory
> leak.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> Call to acpi_dev_get_resources() was introduced by the commit ae056908862b
> ("Bluetooth: hci_bcm: Retrieve UART speed from ACPI") so fix should go to
> v4.3-rc.

if this should go into 4.3 then you need to send it against bluetooth tree actually and not bluetooth-next. And you might want to include patch 2/5 in there as well. Sending them as combined set with bluetooth-next patches is not really helping.

In case this is not an urgent fix that has to make it into 4.3, then I am just applying all 5 to bluetooth-next tree. Your choice.

Regards

Marcel

