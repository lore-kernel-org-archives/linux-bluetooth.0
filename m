Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v1 2/2] Bluetooth: btmrvl: Re-use kstrtol_from_user()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180529133349.19814-2-andriy.shevchenko@linux.intel.com>
Date: Wed, 30 May 2018 08:16:23 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <EE541983-21F2-470E-90E1-82067F76FD31@holtmann.org>
References: <20180529133349.19814-1-andriy.shevchenko@linux.intel.com>
 <20180529133349.19814-2-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> Re-use kstrtol_from_user() instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> drivers/bluetooth/btmrvl_debugfs.c | 24 +++---------------------
> 1 file changed, 3 insertions(+), 21 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

