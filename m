Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.1 \(1993\))
Subject: Re: [PATCH] Bluetooth: Fix reporting invalid RSSI for LE devices
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1421942225-6787-1-git-send-email-szymon.janc@tieto.com>
Date: Thu, 22 Jan 2015 09:08:40 -0800
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <2A576066-405D-4670-B02B-B7A747241A64@holtmann.org>
References: <1421942225-6787-1-git-send-email-szymon.janc@tieto.com>
To: Szymon Janc <szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

> Start Discovery was reporting 0 RSSI for invalid RSSI only for
> BR/EDR devices. LE devices were reported with RSSI 127.
> 
> Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
> ---
> net/bluetooth/mgmt.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

