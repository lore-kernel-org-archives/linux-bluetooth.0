Return-Path: <netdev-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.1 \(3445.4.7\))
Subject: Re: [PATCH v1] Bluetooth: Utilize %*ph specifier
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20171211101033.60971-1-andriy.shevchenko@linux.intel.com>
Date: Mon, 11 Dec 2017 13:13:43 +0100
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
        "open list:BLUETOOTH DRIVERS" <linux-bluetooth@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Message-Id: <EFD6CF04-CEB3-4E1C-B511-A8790D501DBE@holtmann.org>
References: <20171211101033.60971-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andy,

> Instead of open coding byte-by-byte printing, re-use %*ph specifier.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> net/bluetooth/hci_debugfs.c | 17 +++--------------
> 1 file changed, 3 insertions(+), 14 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel
