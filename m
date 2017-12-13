Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v1] Bluetooth: introduce DEFINE_SHOW_ATTRIBUTE() macro
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171122211546.5682-1-andriy.shevchenko@linux.intel.com>
Date: Wed, 13 Dec 2017 20:21:07 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-Id: <6B41E55E-5F67-4BE8-A69B-D82740080D40@holtmann.org>
References: <20171122211546.5682-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> This macro deduplicates a lot of similar code across the hci_debugfs.c
> module. Targeting to be moved to seq_file.h eventually.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> net/bluetooth/hci_debugfs.c | 184 +++++---------------------------------------
> 1 file changed, 18 insertions(+), 166 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
