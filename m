Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] Bluetooth: hci_intel: Cleanup the device probe code
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1443619732-19401-1-git-send-email-jarkko.nikula@linux.intel.com>
Date: Thu, 1 Oct 2015 08:57:29 +0200
Cc: linux-bluetooth <linux-bluetooth@vger.kernel.org>,
	linux-acpi@vger.kernel.org,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Loic Poulain <loic.poulain@intel.com>
Message-Id: <90C2E979-8ED1-4129-8D61-071CD3831E45@holtmann.org>
References: <1443619732-19401-1-git-send-email-jarkko.nikula@linux.intel.com>
To: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jarkko,

> There is some unneeded code in "hci_intel" probing. First
> acpi_match_device() call is needless as driver/platform/acpi core code has
> already done the matching before calling the probe and the driver does not
> use the returned pointer to matching _HID other than checking is it NULL.
> 
> Then tree wide grep for "hci_intel" doesn't reveal that there is any code
> registering this platform device so it looks this device is always backed
> with ACPI companion so also ACPI_HANDLE() test can be removed.
> 
> Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
> ---
> drivers/bluetooth/hci_intel.c | 24 ------------------------
> 1 file changed, 24 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

