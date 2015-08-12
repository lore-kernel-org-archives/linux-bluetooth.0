Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH] Bluetooth: hci_bcm: Fix "implicit declaration"
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1439376361-16647-1-git-send-email-frederic.danis@linux.intel.com>
Date: Wed, 12 Aug 2015 07:43:42 -0700
Cc: linux-bluetooth@vger.kernel.org, sfr@canb.auug.org.au,
	"Gustavo F. Padovan" <gustavo@padovan.org>,
	linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <DDBA5F0C-B6C8-440D-B098-F950E887B638@holtmann.org>
References: <1439376361-16647-1-git-send-email-frederic.danis@linux.intel.com>
To: Frederic Danis <frederic.danis@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Fred,

> The kbuild test robot reported implicit declaration of function
> 'acpi_dev_get_resources'.
> 
> Surround ACPI function by CONFIG_ACPI test.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
> ---
> drivers/bluetooth/hci_bcm.c | 7 +++++++
> 1 file changed, 7 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

