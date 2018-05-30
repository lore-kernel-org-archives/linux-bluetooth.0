Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH v1 1/2] Bluetooth: Re-use kstrtobool_from_user()
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20180529133349.19814-1-andriy.shevchenko@linux.intel.com>
Date: Wed, 30 May 2018 08:16:24 +0200
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Message-Id: <1585C0C5-A3C2-4950-92FB-323BDE3FAE50@holtmann.org>
References: <20180529133349.19814-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> Re-use kstrtobool_from_user() instead of open coded variant.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> net/bluetooth/hci_core.c    | 23 +++++++----------------
> net/bluetooth/hci_debugfs.c | 24 ++++++++----------------
> net/bluetooth/smp.c         | 12 ++++--------
> 3 files changed, 19 insertions(+), 40 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

